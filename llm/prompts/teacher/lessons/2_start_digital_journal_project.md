# AGENDA

- Remind Python Standard Library Loops and Functions

  - `Iterator` in Python
    - `for` loop
    - `while` loop
    - `for` loop is like a `while` but with exception
    - Iterator Protocol (show patterns.guru)
  - `function` object in Python
    - positional and keyword arguments
    - type annotations
    - manipulate with function object (passing as argument)
      - implement `caller(func)` function

- DIGITAL JOURNALS project discussion
  - show slides
  - go to details section

## Public

- Python Standard Library
  - `Iterator` in Python
    - `for`, `while`, loops
    - Iterator Protocol
  - `function` object in Python
    - positional and keyword arguments
    - type annotations
    - function object definition
- `DIGITAL JOURNALS` project discussion

---

# HOMEWORK

- Project from the lesson is set up
- `students: list[dict]` global variable exists to simulate the database (_the simulated storage for all the students_)
  - The `Student` data structure has next feilds
    - `id: int` - unique identifier of the student
    - `name: str` - student's name
    - `marks: list[int]` - list of marks
    - `info: str` - detailed information of the student
- Next functions are added to the application:
  - `main()` - application entrypoint
  - `show_students()` - function to represent all students
  - `show_student(id: int)` - function to show student by `id`
  - `add_student(name: str, marks: list[int], details: str | None)` - function to add new student.
    - The `name` is required but the `details` is optional.
    - if `details` is optional - it is saved as empty string to the storage
    - The `marks` is always created as empty list
    - Yes, there is no way to add a mark after user is added (this is left for the next lessons)

---

# DIGITAL JOURNALS

## ITERATION 0. BUSINESS IDEA

У якості нульової точки ми обираємо з вам симулювання процесу, де бізнес має БАЧЕННЯ щодо проблематики в матеріальному світі.

Бізнес наймає розробника для того щоб реалізувати це бачення (тобто розробити систему) в цифровому відображенні.

### ISSUE

create a small application that allows user to manage students digitally.

### BUSINESS VISION

1. Application - on Python
2. User - teacher in school
3. Interface - TUI (Terminal User Interface)

## ITERATION 1. MVP. POC

### ISSUE

create a minimum viable product so we can test the PoC.

### SOLUTION

- what kind of data?
  - ISSUE: how to represent the user in digital system?
  - SOLUTION: data structure
    - the list of dicts could be used as a temporary storage for the applica PoC
- how feature looks like in python project?
  - basic functionaly to start: `show` / `add`
  - student representation
- `command` handling idea

first let's represent the script file

```python
"""
Student Structure:
    name: str
    marks: list[int]


Teacher: no structure since no authentication process
"""

storage = [
    {
        "name": "John Doe",
        "marks": [4, 12, 8, 9, 9, 2, 10, 11],
    },
    {
        "name": "Marry Black",
        "marks": [9, 12, 8, 4, 1, 9, 11, 7],
    },
]

```

now add functions templates

```python
# CRUD operations
def add_student(student: dict):
    raise NotImplementedError

def represent_students():
    raise NotImplementedError

# user input
def ask_student_payload():
    raise NotImplementedError

def handle_command(command):
    raise NotImplementedError

# user commands
handle_command("show")
handle_command("add")
handle_command("show")
```

fill functions (start from the buttom of this code block)

```python
def add_student(student: dict):
    if len(student) != 2:
        return None

    if not student.get("name") or not student.get("marks"):
        return None
    else:
        # action
        storage.append(student)
        return student

def represent_students():
    for student in storage:
        print(f"{student['name']}. Marks: {student['marks']}")

def ask_student_payload() -> dict | None:
    def parse_marks(data):
        last_number_index = 0
        marks = []

        for index, char in enumerate(data):
            if char == ",":
                mark = int(data[last_number_index:index])
                last_number_index = index + 1

                if 1 <= mark <= 12:
                    marks.append(mark)

        return marks

    def parse(data) -> dict | None:
        separator_index = None

        for index, char in enumerate(data):
            if char == ";":
                separator_index = index
                break
        if separator_index is None:
            return None
        else:
            name = data[:separator_index]
            marks = parse_marks(data[separator_index + 1 :])

            return {"name": name, "marks": marks}

    ask_prompt = (
        "Enter student's payload data using text template: "
        "John Doe;1,2,3,4,5\n"
        "where John doe is a full name and [1,2,3,4,5] are marks.\n"
        "The data MUST be separated by `;`!"
    )

    user_data: str = input(ask_prompt)
    student: dict = parse(user_data)

    return student

def handle_command(command):
    if command == "show":
        represent_students()
    elif command == "add":
        if not (data := ask_student_payload()):
            print("The student's data is not correct. Please try again.")
        else:
            add_student(data)

handle_command("show")
handle_command("add")
handle_command("show")
```

## ITERATION 2. ADD THE CLI INPUT POLLING

create another function to ask user in a loop

```python
def handle_user_input():
    """Entrypoint function."""

    OPERATIONAL_COMMANDS = ("quit", "help")
    USER_MANAGEMENT_COMMANDS = ("show", "add")

    AVAILABLE_COMMANDS = (*OPERATIONAL_COMMANDS, *USER_MANAGEMENT_COMMANDS)
    # alternatives
    # AVAILABLE_COMMANDS = OPERATIONAL_COMMANDS + USER_MANAGEMENT_COMMANDS
    # AVAILABLE_COMMANDS = ("quit", "help", *USER_MANAGEMENT_COMMANDS)  <- best option?

    help_message = (
        "Hello in the Journal! Use the menu to interact with the application.\n"
        f"Available commands: {AVAILABLE_COMMANDS}\n"
    )
    print(help_message)

    while True:
        command = input("\nSelect COMMAND: ")

        if command == "quit":
            print("\n Thanks for using the Journal application")
            break
        elif command == "help":
            print(help_message)
        else:
            user_management_commands(command)

# aka ``main()``
handle_user_input()
```

## ITERATION 3. FEATURE REQUEST

### ISSUE

we need to stored some detailed about each student in our system

## ITERATION 3. FEATURE REQUEST

### ISSUE

Now student has `info` parameter that include a free text information about the student.

### SOLUTION

- `info` parameter is added

update storage representation

```python
storage = [
    {
        # ...
        "info": "John is 19 y.o. Interests: boxing",  # new
    },
    {
        # ...
        "info": "Marry is 18 y.o. Interests: music",  # new
    },
]
```

## ITERATION 4. FEATURE REQUEST

### ISSUE

too much information on a display

### SOLUTION

- `student_details` is added for the detailed search
- `search` function is created
  - produces bug since no identifier of the user
- another USER COMMAND is added
- talk about UX namings and TECHNICAL functions names

```python
def handle_user_input():
    USER_MANAGEMENT_COMMANDS = ("show", "add", "search")  # updated


def user_management_commands(command):
    elif command == "search":  # new
        if not (
            student_name := input("What is a name of the student you are looking for? ")
        ):
            print("The student's name is not defined. Please try again.")
        else:
            if not (student := search_student(student_name)):
                print(f"Student {student_name} is not found.")
            else:
          ķ     represent_student_detailed(student)

    else:
        print(f"Command '{command}' is not available for user management")


# NEW
def student_details(student):
    """Just print the student into the console."""

    print(f"{student['name']}. Marks: {student['marks']}.\nDetails: {student['info']}")

def search_student(name):
    for student in storage:
        if student["name"] == name:
            return student

    # NOTE: If you expect that the function returns None
	# and it makes sense - return it explicitly
    return None
```

## ITERATION 5. SEARCH BY ID DUE TO DUPLICATION

### ISSUE

- name is not unique in our system
  - we can get multiple results from search
  - business must make a decision which flow to select

### SOLUTION

introduce identifier to the student

### POC

update search and management

```python
def user_management_commands(command):
    elif command == "retrieve":
        if not (id_ := int(input("Enter student id: "))):
            print("The student's name is not defined. Please try again.")
        else:
            retrieve_student(id_)

def search_student(id_):
    for index, student in enumerate(storage):
        if student["id"] == id_:
            return index, student

    return None


def retrieve_student(id_: int):
    if not (student_search_result := search_student(id_)):
        print(f"Student with id={id_} is not found.")
    else:
        student = student_search_result[1]
        print(
            f"[{student['id']}] {student['name']}. Marks: {student['marks']}.\nDetails: {student['info']}"
        )
```

update adding student to increment the ID (ensure uniqueness)

```python
def add_student(student):
    if not student.get("info") or not student.get("name") or not student.get("marks"):  # new
        return None
    else:
        # action
        global storage
        last_id = storage[-1]["id"]
        # problems:
        #   if the last one does not have the latest ID.
        student["id"] = last_id + 1
        storage += [student]
        return student
```
