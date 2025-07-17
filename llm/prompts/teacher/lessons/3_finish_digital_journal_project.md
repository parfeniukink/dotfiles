# PLAN

# AGENDA

- Continue looking for the next iterations

# HOMEWORK

- "Add Student" feature is updated
  - USER can set `info` along with `name` and `marks`
  - `info` is OPTIONAL
- "Add Mark" must be implemented.
  - Detailed: You have to create User Interface for that feature in existing CLI application. Turn on your imagination
- "Smart Update" feature is implemented.
  - Instead of updating the whole user all the time (`name` and `info` fields) now the UPDATE FEATURE allows user to update only specified fields (`name` of `info` or both)
  - IF USER entered `info` the SYSTEM performs next validation
    - IF USER entered a string that is completely DIFFERENT FROM what we CURRENTLY have in storage - AUGMENT entered information to the existing value in storage
    - IF USER entered a string that INCLUDES the information, that exists in storage - REPLACE (update) it the storage
  - You have to THINK about the BEST UI/UX implementation

# DIGITAL JOURNAL

## ITERATION 6. FEATURE REQUEST

### ISSUE

there is no way to remove

### SOLUTION

- `search` and `del` does not work. deletes only the REFERENCE
- what is actually deleting from the list? -> the drawing is included
  - try to delete the john from the list after another reference is created
- separate `search` form the `retrival`. Update the menu with `retrival`.
- how about Garbage Collector in Python?
  - 3 back references if student is passed from `for` loop into the function

```python
# on first iteration pass student and try
def delete_student(student_id):
    if student_search_result := search_student(name):
        index, student = student_search_result
        del storage[index]
        print(f"{student['name']} is deleted.")
    else:
        print("There is no such student in the database")

def user_management_commands(command):
    if:
        # ...
    elif command == "delete":
        if not (
            student_name := input("What is a name of the student you are looking for? ")
        ):
            print("The student's name is not defined. Please try again.")
        else:
            delete_student(student_name)

    else:
        print(f"Command '{command}' is not available for user management")
```

<br>

## ITERATION 7. FEATURE REQUEST

### ISSUE

- user is not mutable
- adding marks problem. not that easy task if user enters shit...
- partially update the user?

### SOLUTION

- feature placing dilema...

  - updating mark - not that easy question.
  - `Add Mark` is a new feature or just a part of `Student` update?
  - in our case -> update student is fine but in most of the cases
    using concrete naming for your functions is way more better
  - are we going to add the mark or update the whole student all the time?

- on first iteration PASS student instance to the function and talk if it's gonna be updated (YES)

let's define the update command first

```python
def update_student(id_, raw_payload):
    if student_search_result := search_student(id_):
        index, student = student_search_result

        if not (payload := parse(raw_payload)):
            return None
        else:
            name, marks = payload
            storage[index] = student | {"name": name, "marks": marks}

        print(f"{student['id']} is updated.")
    else:
        print("Student not found")


def user_management_commands(command):
    if: ...
    elif command == "update":
        update_id = input("Enter student's id you wanna change: ")

        try:
            id_ = int(update_id)
        except ValueError as error:
            raise Exception(f"ID '{update_id}' is not correct value") from error
        else:
            if data := ask_student_payload():
                update_student(id_, data)
                print(f"✅ Student is updated")
                if student := search_student(id_):
                    student_details(student)
                else:
                    print(f"❌ Can not change user with data {data}")
```

## Iteration 8. HOMEWORK PREVIEW

### ISSUE

adding marks is not implemented

### SOLUTION

HOMEWORK...

## ITERATION 9. OPTIMIZATION

### ISSUE

the code is unreadable and some data structures are not optimal.

### SOLUTION

- what if we update the storate representation? Let's move to the dict of lists and use `storage["students"]`
- remove the id from the user object

## SUMMARY

- after we switched to ids our prompts became pretty similar. How much do you know that less times you will refactor the code.
- Let's move forward to upgrade that code with other approaches. For that we start with a new topic, called `classes` in Python (after files)
