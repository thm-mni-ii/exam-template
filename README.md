# LaTeX Exam Template

This is a *LaTeX template* for creating exams, optimized for use at *THM* but adaptable for other institutions as well.

## Document Class
The class file provides a new document class, `mni-thm-exam`, which supports specifying a language (`german` or `english`). This setting automatically adjusts the class-specific title page information to the selected language.

## Required Exam Information
To generate a properly formatted exam, the following commands must be provided with the necessary details:

| **Command**         | **Description** |
|---------------------|----------------|
| `\logo{}`          | Specifies the path to a logo. |
| `\title{}`         | Defines the document title, typically `"Exam"`. |
| `\subject{}`       | Specifies the exam subject, e.g., `"Mathematics 1"`. |
| `\semester{}`      | Indicates the semester in which the exam takes place. |
| `\examiner{}`      | Provides the full name of the main examiner. |
| `\coExaminer{}`    | Specifies the full name of the co-examiner (leave blank if none). |
| `\date{}`          | Defines the exam date. |
| `\degreeProgram{}` | Indicates the degree program for students taking the exam. Leave blank if students must enter it manually. |
| `\notice{}`        | Allows additional exam information, such as time limits, permitted aids, or legal notices. |

## Structuring the Exam
The exam must be structured using **topics**, each containing the actual tasks.

| Command             | Description |
|-------------------------|----------------|
| `\topic{Name}`         | Starts a new topic (equivalent to a section). |
| `\task[6][5]{Description}` | Defines a task with two optional parameters: <br> - **First parameter**: Specifies the available space (in dotted lines) for student answers. Set to `0` if no space is required. <br> - **Second parameter**: Defines the total points for the task. These points are automatically summed per topic and displayed on the title page. |

This template provides a **structured and automated** approach to formatting exams efficiently using LaTeX.


## Example
```tex
% !TeX encoding = UTF-8
\documentclass[german]{mni-thm-exam}

\logo[height=64pt]{mni-thm-logo.pdf}
\title{Exam}
\subject{Subject Name (Code)}
\semester{WS24/25}
\examiner{Examinus Smith}
\coExaminer{Prof. Dr. Joe White}
\date{\today}
\degreeProgram{} % Leave blank if students have to enter
\notice{
\ifthenelse{\equal{\examLanguage}{german}}
{Schreiben Sie Ihre Antworten nur auf den bereitgestellten Klausurblättern!}
{Write your answers only on the provided exam sheets!}
} % Leave blank if no notices exist

\begin{document}

\TitlePage

\topic{Topic A}

\task[7][3]{Task Description}

\task[3][2]{Task Description}

% Two extra pages for students if their answer did not fit on the provided space below a task description.
\newpage

\foreach \x in {A, B} {
\begin{center}
\textbf{\ifthenelse{\equal{\examLanguage}{german}}{Zusatzblatt}
{Supplementary Sheet} \x}
\end{center}
\writingSpace{19}
}

\end{document}
```