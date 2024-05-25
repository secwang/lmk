#!/bin/bash

# 使用find命令查找当前目录下的所有文件
find . -maxdepth 1 -type f -name "*.csv" ! -name "fmt*" | while IFS= read -r file; do

  filename=$(basename "$file")
  # ls输出文件信息
  ./f.apl "$filename"
done
