#!/usr/bin/env bash
# Dùng: ./run.sh problems/<bai>.py
#   input/<bai>.txt  -> input (tự tạo rỗng nếu chưa có)
#   output/<bai>.txt -> output mong đợi (tự tạo rỗng nếu chưa có); so sánh bỏ qua khoảng trắng cuối dòng
cd "$(dirname "$0")"
f="$1"
[ -z "$f" ] && { echo "usage: ./run.sh problems/<bai>.py"; exit 1; }
name=$(basename "${f%.py}")
mkdir -p input output
[ -f "input/$name.txt" ] || { touch "input/$name.txt"; echo "Đã tạo input/$name.txt - hãy điền input rồi chạy lại"; }
[ -f "output/$name.txt" ] || { touch "output/$name.txt"; echo "Đã tạo output/$name.txt - hãy điền output mong đợi"; }

out=$(.venv/bin/python "$f" < "input/$name.txt") || exit 1
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
