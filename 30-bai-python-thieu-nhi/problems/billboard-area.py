import sys

input = sys.stdin.readline


def rectangle_area(width, height):
    return width * height


def main():
    width, height = map(int, input().split())
    print(rectangle_area(width, height))


if __name__ == "__main__":
    main()
