#!/usr/bin/perl

use strict;
use warnings;
use File::Copy;
use POSIX qw(strftime);

# 检查是否提供了文件名
if (@ARGV != 1) {
    die "Usage: $0 filename\n";
}

# 获取输入文件名
my $input_file = $ARGV[0];

# 检查文件是否存在
unless (-f $input_file) {
    die "File not found!\n";
}

# 获取文件名和扩展名
my ($filename, $extension) = $input_file =~ /^(.*)\.(.*)$/;

# 创建 TSV 文件名
my $tsv_filename = "${filename}.tsv";

# 函数：将 Unix 时间戳转换为 ISO 8601 格式
sub convert_unix_to_iso {
    my $unix_timestamp = shift;
    return strftime "%Y-%m-%d", localtime($unix_timestamp);
}

# 打开输入文件进行读取
open my $in,  '<', $input_file or die "Cannot open $input_file: $!";
my @lines = <$in>;
close $in;

# 替换 Unix 时间戳为 ISO 8601 日期格式，替换 NaN 为 0 并替换逗号为制表符
foreach my $line (@lines) {
    $line =~ s/(\b\d{10}\b)/convert_unix_to_iso($1)/ge;
    $line =~ s/,/\t/g;
}

# 计算每列的最大宽度，并格式化小数
my @formatted_lines;
my @max_widths;
foreach my $line (@lines) {
    my @fields = split /\t/, $line;
    for my $i (0 .. $#fields) {
        # 格式化小数点后两位
        if ($fields[$i] =~ /^-?\d+(\.\d+)?$/) {
            $fields[$i] = sprintf("%.2f", $fields[$i]);
        }
        $max_widths[$i] = length($fields[$i]) if !defined $max_widths[$i] || length($fields[$i]) > $max_widths[$i];
    }
    push @formatted_lines, \@fields;
}

# 写入处理后的内容到 TSV 文件
open my $out, '>', $tsv_filename or die "Cannot open $tsv_filename: $!";
foreach my $fields_ref (@formatted_lines) {
    my @padded_fields;
    for my $i (0 .. $#$fields_ref) {
        push @padded_fields, sprintf("%-*s", $max_widths[$i], $fields_ref->[$i]);
    }
    print $out join("\t", @padded_fields), "\n";
}
close $out;

# 打印新文件名
print "Processed TSV file created: $tsv_filename\n";
