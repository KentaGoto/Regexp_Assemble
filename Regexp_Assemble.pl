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

##############################################################
### 正規表現を生成する。
### 生成された正規表現はクリップボードにコピーされる。
##############################################################

# クリップボードから対象文字列を得る
my $text_tmp = Win32::Clipboard();
my $text_tmp_decode_paste = $text_tmp->GetAs(CF_UNICODETEXT);
my $text  = decode('UTF16-LE', $text_tmp_decode_paste);
my @text_list = split(/\n/, $text);

my $builder = Regexp::Assemble::Compressed->new;

for ( @text_list ) {
    chomp;
    $builder->add( quotemeta $_ );
}

my $regex = $builder->re;

# 各種エディターでも使えるように正規表現を整形（Perlで使うならいらない）
$regex =~ s{^\(\?\^u?:}{};
$regex =~ s{\)$}{};

my $output = 'output.txt';
open my $out, '>:encoding(utf8)', $output or die $!;
print {$out} $regex;
close $out;

system ("notepad $output");

