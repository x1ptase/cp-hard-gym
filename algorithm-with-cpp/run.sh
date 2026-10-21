#!/usr/bin/env bash
# Dùng: ./run.sh problems/<bai>.cpp [debug]
#   input/<bai>.txt  -> input (tự tạo rỗng nếu chưa có)
#   output/<bai>.txt -> output mong đợi (tự tạo rỗng nếu chưa có); so sánh bỏ qua khoảng trắng cuối dòng
#   debug            -> build với -g, sanitizer (address, undefined) và -DLOCAL
cd "$(dirname "$0")"
f="$1"
[ -z "$f" ] && { echo "usage: ./run.sh problems/<bai>.cpp [debug]"; exit 1; }
name=$(basename "${f%.cpp}")
mkdir -p input output build
[ -f "input/$name.txt" ] || { touch "input/$name.txt"; echo "Đã tạo input/$name.txt - hãy điền input rồi chạy lại"; }
[ -f "output/$name.txt" ] || { touch "output/$name.txt"; echo "Đã tạo output/$name.txt - hãy điền output mong đợi"; }

flags=(-std=c++17 -Wall -Wextra -Iinclude -DLOCAL)
if [ "$2" == "debug" ]; then
  flags+=(-g -O0 -fsanitize=address,undefined)
else
  flags+=(-O2)
fi
c++ "${flags[@]}" "$f" -o "build/$name" || exit 1

out=$("build/$name" < "input/$name.txt") || exit 1
a=$(echo "$out" | sed 's/[[:space:]]*$//')
b=$(sed 's/[[:space:]]*$//' "output/$name.txt")
if [ "$a" == "$b" ]; then
  echo "OK"
else
  echo "WRONG"
  echo "--- diff (của bạn < > mong đợi) ---"
  diff <(echo "$a") <(echo "$b")
  exit 1
fi
