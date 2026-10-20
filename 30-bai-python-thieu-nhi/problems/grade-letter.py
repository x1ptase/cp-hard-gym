import sys

input = sys.stdin.readline


def grade_letter(score):
    if score >= 90:
        return "A"
    elif score >= 80:
        return "B"
    elif score >= 70:
        return "C"
    elif score >= 60:
        return "D"
    else:
        return "F"


def main():
    score = int(input())
    print(grade_letter(score))


if __name__ == "__main__":
    main()
