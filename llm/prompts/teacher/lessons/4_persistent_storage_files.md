# AGENDA

- Files from the OS perspective
  - [[File System]]
- CPython API
  - Built-in Python library to work with different file formats
- Update project's dict-storage with file-storage

---

# LINKS

- [file object in Python Glossary](https://docs.python.org/3/glossary.html#term-file-object)
- [io classes hierarchy](https://docs.python.org/3/library/io.html#class-hierarchy)
- [Windows API fileapi](https://learn.microsoft.com/en-us/windows/win32/api/fileapi/nf-fileapi-createfilea)
- [rockyou passwords list](https://github.com/zacheller/rockyou)
- [`mmap` Memory-mapped file support](https://docs.python.org/3.11/library/mmap.html#module-mmap)

---

# HOMEWORK

- Persistent storage (as FILE) is added (or plugged) to the project
- All USER OPERATIONS now work with persistent storage instead of in-memory object
- Data must be stored in `.csv` format
- `class Repository` is responsible for the next operations:
  - reading `.csv` file content into local variable `students` to operate in application on startup
  - writing to the `.csv` file the content of `students` that is currently active in the state of this class
  - the `students` variable could be optimized to `dict` representation for optimization (P.S. might be better solution if you don't wanna refactor your existing solution too much)
  - `.add_student(student: dict)` to add student to the storage
  - `.get_student(id_: int)` to add student to the storage
  - `.update_student(id_: int, data: dict)` to partially update student (meaning that `data.keys()` must be appropriate student fields)
  - `.delete_student(id_: int)` to remove student from the storage
  - `.add_mark(id_: int, mark: int)` quickly add mark to specified user
- Repository object could be injected to each place of usage. P.S. If you prefer different way - please, go ahead

---

# DETAILED

## OS perspective

- files are managed by OS
- FS tree (logical structure)
- permissions
  - for security purposes
  - range 000 - 777
  - some files require specific permissions
    - like SSH keys, etc
- can multiple processes read a single file?
  - yes
  - `FILE_SHARE_READ` flag on Windows
- can multiple processes write to a single file?
  - yes
  - currently operatyng systems handle this process pretty much gracefully so we won't get into this very deeply
  - using locks
    - `fcntl.flock` for Unix locks
    - `FILE_SHARE_WRITE` flag on Windows

## Python API. File Descriptor

- file object in python glossary
- `io` module classes hierarchy
- only a single function: `open()`
  - path name. `absolute`, `relative`
  - mode: `r w a`
  - type: text bytes
  - possible permissions issue on OS
    - `chmod` on Unix
    - on Windows just don't create files in `System32` folder
      - use `Desktop` or project folder instead
- `file` object

  - common methods:
  - `file.read()` read all the file
  - `file.read(n)` read `n` chars
  - `file.readlines()` => read all the file
  - `file.tell()` return pointer number
  - `file.seek(n)` move file pointer to `n` index position
  - `file.close()` close the file

- _built-in_ library for common data formats: `json`, `csv`, `xml`, `pickle`

## `json` module

- `json.load()` – reads from a file and converts json into python objects.
- `json.dump()` – writes python objects as json to a file.
- `json.loads()` and json.dumps() – work with json strings (not directly with files).

```python
import json

with open("data.json", "r") as f:
    data = json.load(f)

with open("output.json", "w") as f:
    json.dump(data, f)
```

## `yaml` module

```python
import yaml

with open("config.yaml", "r") as f:
    data = yaml.safe_load(f)

with open("output.yaml", "w") as f:
    yaml.dump(data, f)
```

## `csv` module

- `csv.reader()` – reads rows from a csv file as lists.
- `csv.writer()` – writes rows to a csv file.
- `csv.DictReader()` and csv.DictWriter() – works with csv files as dictionaries.

```python
import csv
with open("data.csv", "r") as f:
    reader = csv.reader(f)
    for row in reader:
        print(row)

with open("output.csv", "w", newline="") as f:
    writer = csv.writer(f)
    writer.writerow(["Name", "Age"])
    writer.writerow(["Alice", "30"])
```

## `configparser` module

- `configparser.ConfigParser()`

```python
import configparser

config = configparser.ConfigParser()
config.read("config.ini")

# Read values
db_host = config["database"]["host"]

# Write values
config["database"]["host"] = "localhost"
with open("config.ini", "w") as configfile:
    config.write(configfile)
```

## `xml` module

- `ElementTree.parse()` – reads and parses an XML file.
- `ElementTree.write()` – writes an XML file.

```python
import xml.etree.ElementTree as ET

tree = ET.parse("data.xml")
root = tree.getroot()

for child in root:
    print(child.tag, child.attrib)

tree.write("output.xml")
```

## `pickle` module

- `pickle.dump()` – saves a Python object to a file.
- `pickle.load()` – loads a Python object from a file.

```python
import pickle

data = {"name": "Alice", "age": 30}

# Save to a file
with open("data.pkl", "wb") as f:
    pickle.dump(data, f)

# Load from a file
with open("data.pkl", "rb") as f:
    loaded_data = pickle.load(f)
```

## `zipfile` module

```python
import zipfile

# Create a zip file
with zipfile.ZipFile("output.zip", "w") as z:
    z.write("file.txt")

# Extract a zip file
with zipfile.ZipFile("output.zip", "r") as z:
    z.extractall("extracted_files")
```

## tarfile (skip this one)

```python
import tarfile

# Create a tar.gz file
with tarfile.open("output.tar.gz", "w:gz") as tar:
    tar.add("file.txt")

# Extract a tar.gz file
with tarfile.open("output.tar.gz", "r:gz") as tar:
    tar.extractall("extracted_files")
```

- using `open()` as a context manager (future reference)

## What about RAM?

- as large file as much RAM is going to be allocated
- using buffering (`open(buffering=-1)`)
  - -1 default
  - 0 off
  - 1 line buffering
  - > 1 to specify bytes
- `rockyou.txt` example:
  - download rockyou txt using `wget`
  - using `input()` to stop on each file and show `btop` with Python RAM allocated
  - using `file.read(n)` to optimize the application
  - using `mm`

## Did we cover everything?

- `pathlib` module implements common operations with file system

```python
from pathlib import Path

# Cross-platform way to handle paths
file_path = Path("data") / "input.txt"
```

## NOT EXISTING file error. Could we handle it in general?

```python
try:
    with open("nonexistent.txt", "r") as f:
        data = f.read()
except FileNotFoundError:
    print("File not found. Please check the file path.")
```

## file locking mechanism (skip)

```python
import fcntl

with open("file.txt", "w") as f:
    fcntl.flock(f, fcntl.LOCK_EX)
    f.write("Locked writing")
    fcntl.flock(f, fcntl.LOCK_UN)
```

## Binary Files

```python
# Reading binary file
with open("image.jpg", "rb") as img:
data = img.read()
```

## Changing File Permissions

```python
import os

# Change file permissions to read-only
os.chmod("file.txt", 0o444)
```

## Temporary Files

```python
import tempfile

with tempfile.NamedTemporaryFile(delete=False) as temp:
    temp.write(b"Temporary data")
```

---

# UPDATE APPLICATION TO USE FILE STORAGE

## ITERATION 1: OS Perspective and Motivation

**Issue:**  
Current project only stores data in memory — everything is lost on program exit.

**Business Motivation:**  
Users expect their data to persist between runs.

**Design Decision:**  
Store data in a file on disk; start with CSV for portability.

**Possible bugs:**

- Attempting to write where you do not have permissions.
- File not found or corrupted.

---

## ITERATION 2: Reading and Writing Files in Python

**Goal:**  
Introduce reading/writing files using Python built-ins and the `csv` module.

```python
import csv

# Reading from a CSV file
with open("data.csv", "r", newline='') as f:
    reader = csv.DictReader(f)
    for row in reader:
        print(row)  # Each row is a dict

# Writing to a CSV file
with open("data.csv", "w", newline='') as f:
    fieldnames = ["name", "age"]
    writer = csv.DictWriter(f, fieldnames=fieldnames)
    writer.writeheader()
    writer.writerow({"name": "Alice", "age": 30})
```

**Pitfalls:**

- Windows: Always specify `newline=''` when opening CSV files.
- Forgetting to call `writeheader()` makes the file unreadable for `DictReader`.
- Not handling file not found (`FileNotFoundError`) for first start.

---

## ITERATION 3: Plug File Storage into the Project

**Issue:**  
Need to abstract file access so the rest of the code doesn’t know/care if data is in memory or file.

**Implementation (pre-OOP):**

```python
import csv
from pathlib import Path

STORAGE_FILE_NAME = Path(__file__).parent / "storage.csv"

def get_storage():
    data = {}
    try:
        with open(STORAGE_FILE_NAME, mode="r", newline='') as f:
            reader = csv.DictReader(f)
            for row in reader:
                data[row["key"]] = row["value"]
    except FileNotFoundError:
        pass  # First run; no data yet.
    return data

def update_storage(storage):
    with open(STORAGE_FILE_NAME, mode="w", newline='') as f:
        writer = csv.DictWriter(f, fieldnames=["key", "value"])
        writer.writeheader()
        for key, value in storage.items():
            writer.writerow({"key": key, "value": value})
```

**Pitfalls:**

- File not found: Handle gracefully.
- Data overwrites: Always save the full dict.
- CSV format: Needs headers.
- All values are strings in CSV — handle type conversion where necessary.

---

## ITERATION 4: OOP — Repository Class

**Goal:**  
Encapsulate storage logic.

```python
class Repository:
    def __init__(self, filename):
        self.filename = filename

    def load(self):
        storage = {}
        try:
            with open(self.filename, "r", newline='') as f:
                reader = csv.DictReader(f)
                for row in reader:
                    storage[row["key"]] = row["value"]
        except FileNotFoundError:
            pass
        return storage

    def save(self, storage):
        with open(self.filename, "w", newline='') as f:
            writer = csv.DictWriter(f, fieldnames=["key", "value"])
            writer.writeheader()
            for key, value in storage.items():
                writer.writerow({"key": key, "value": value})
```

**Usage:**

```python
repo = Repository("storage.csv")
data = repo.load()
data["answer"] = "42"
repo.save(data)
```

**Pitfalls:**

- All keys/values are strings — need to convert if you store ints, lists, etc.
- Not calling `save()` after changes loses data.
- Simultaneous writes (advanced, not covered here).

---

# COMMON PROBLEMS & SOLUTIONS

- **FileNotFoundError:** Use try/except during load.
- **Incorrect file path:** Use `Path` for cross-platform support.
- **Data type issues:** Consider json for complex data, or convert on load/save.
