import csv

INPUT_FILE = "student_marks_input.csv"
OUTPUT_FILE = "student_marklist_output.csv"


def calculate_total(marks):
    return sum(marks)


def calculate_average(marks):
    total = calculate_total(marks)
    return total / len(marks) if marks else 0.0


def calculate_grade(avg):
    if avg >= 90:
        return "A+"
    elif avg >= 80:
        return "A"
    elif avg >= 70:
        return "B"
    elif avg >= 60:
        return "C"
    elif avg >= 50:
        return "D"
    else:
        return "F"


def generate_marklist():
    with open(INPUT_FILE, newline="") as csvfile:
        reader = csv.DictReader(csvfile)
        rows = []

        for row in reader:
            math = int(row["Math"])
            science = int(row["Science"])
            english = int(row["English"])
            computer = int(row["Computer"])

            subjects = [math, science, english, computer]
            total = calculate_total(subjects)
            avg = calculate_average(subjects)
            grade = calculate_grade(avg)

            rows.append({
                "RollNo": row["RollNo"],
                "Name": row["Name"],
                "Math": math,
                "Science": science,
                "English": english,
                "Computer": computer,
                "Total": total,
                "Average": round(avg, 2),
                "Grade": grade
            })

    with open(OUTPUT_FILE, "w", newline="") as csvfile:
        fieldnames = ["RollNo", "Name", "Math", "Science", "English", "Computer", "Total", "Average", "Grade"]
        writer = csv.DictWriter(csvfile, fieldnames=fieldnames)
        writer.writeheader()
        writer.writerows(rows)

    print(f"Marklist generated successfully in {OUTPUT_FILE}")


if __name__ == "__main__":
    generate_marklist()
