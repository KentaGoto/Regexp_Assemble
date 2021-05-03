use strict;
use warnings;
use utf8;
use Encode;
use Regexp::Assemble::Compressed;
use Clipboard;
use Win32::Clipboard;
use Win32;

binmode STDIN,  ':encoding(cp932)';
binmode STDOUT, ':encoding(cp932)';
binmode STDERR, ':encoding(cp932)';

#################################################################
### The generated regular expression is copied to the clipboard.
#################################################################

# Get the target string from the clipboard
my $text_tmp = Win32::Clipboard();
my $text_tmp_decode_paste = $text_tmp->GetAs(CF_UNICODETEXT);
my $text = decode('UTF16-LE', $text_tmp_decode_paste);
my @text_list = split(/\n/, $text);

my $builder = Regexp::Assemble::Compressed->new;

for ( @text_list ) {
    chomp;
    $builder->add( quotemeta $_ );
}

my $regex = $builder->re;

# Formatted regular expressions for use in various 
# text editors (not necessary if you're using Perl)
$regex =~ s{^\(\?\^u?:}{};
$regex =~ s{\)$}{};

my $output = 'output.txt';
open my $out, '>:encoding(utf8)', $output or die $!;
print {$out} $regex;
close $out;

system ("notepad $output");

