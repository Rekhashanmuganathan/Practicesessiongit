       IDENTIFICATION DIVISION.
       PROGRAM-ID. STUDENTMARKLIST.

       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT STUDENT-IN ASSIGN TO "student_marks_input.txt"
                  ORGANIZATION IS LINE SEQUENTIAL.
           SELECT STUDENT-OUT ASSIGN TO "student_marklist_output.txt"
                  ORGANIZATION IS LINE SEQUENTIAL.

       DATA DIVISION.
       FILE SECTION.
       FD STUDENT-IN.
       01 IN-REC                 PIC X(80).

       FD STUDENT-OUT.
       01 OUT-REC                PIC X(120).

       WORKING-STORAGE SECTION.
       01 WS-EOF                 PIC X VALUE 'N'.
       01 WS-ROLLNO              PIC 9(3).
       01 WS-NAME                PIC X(20).
       01 WS-MATH                PIC 9(3).
       01 WS-SCIENCE             PIC 9(3).
       01 WS-ENGLISH             PIC 9(3).
       01 WS-COMPUTER            PIC 9(3).
       01 WS-TOTAL               PIC 9(4).
       01 WS-AVG                 PIC 9(3)V99.
       01 WS-GRADE               PIC X(2).
       01 WS-HEADER              PIC X(120).

       PROCEDURE DIVISION.
       MAIN-PARA.
           OPEN INPUT STUDENT-IN
                OUTPUT STUDENT-OUT

           MOVE "ROLLNO NAME                 MATH SCIENCE ENGLISH COMPUTER TOTAL AVERAGE GRADE"
             TO WS-HEADER
           WRITE OUT-REC FROM WS-HEADER

           PERFORM UNTIL WS-EOF = 'Y'
               READ STUDENT-IN
                   AT END MOVE 'Y' TO WS-EOF
                   NOT AT END PERFORM PROCESS-RECORD
               END-READ
           END-PERFORM

           CLOSE STUDENT-IN STUDENT-OUT
           STOP RUN.

       PROCESS-RECORD.
           UNSTRING IN-REC DELIMITED BY ALL SPACES
               INTO WS-ROLLNO,
                    WS-NAME,
                    WS-MATH,
                    WS-SCIENCE,
                    WS-ENGLISH,
                    WS-COMPUTER
           END-UNSTRING

           COMPUTE WS-TOTAL = WS-MATH + WS-SCIENCE + WS-ENGLISH + WS-COMPUTER
           COMPUTE WS-AVG = WS-TOTAL / 4

           EVALUATE TRUE
               WHEN WS-AVG >= 90 MOVE "A+" TO WS-GRADE
               WHEN WS-AVG >= 80 MOVE "A " TO WS-GRADE
               WHEN WS-AVG >= 70 MOVE "B " TO WS-GRADE
               WHEN WS-AVG >= 60 MOVE "C " TO WS-GRADE
               WHEN WS-AVG >= 50 MOVE "D " TO WS-GRADE
               WHEN OTHER MOVE "F " TO WS-GRADE
           END-EVALUATE

           MOVE SPACES TO OUT-REC
           STRING WS-ROLLNO DELIMITED BY SIZE
                  " " DELIMITED BY SIZE
                  WS-NAME DELIMITED BY SPACES
                  " " DELIMITED BY SIZE
                  WS-MATH DELIMITED BY SIZE
                  " " DELIMITED BY SIZE
                  WS-SCIENCE DELIMITED BY SIZE
                  " " DELIMITED BY SIZE
                  WS-ENGLISH DELIMITED BY SIZE
                  " " DELIMITED BY SIZE
                  WS-COMPUTER DELIMITED BY SIZE
                  " " DELIMITED BY SIZE
                  WS-TOTAL DELIMITED BY SIZE
                  " " DELIMITED BY SIZE
                  WS-AVG DELIMITED BY SIZE
                  " " DELIMITED BY SIZE
                  WS-GRADE DELIMITED BY SIZE
              INTO OUT-REC
           END-STRING

           WRITE OUT-REC.
