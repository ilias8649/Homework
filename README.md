# Task Management Script

This repository contains a simple task management script written in Bash. The script allows users to add, list, update, delete, list tasks by date, mark tasks as complete, and search for tasks by title.

## Design Choices

### Data Storage
- **File-based Storage**: Tasks are stored in a plain text file named `tasklist.txt`. Each line in this file represents a task with the following fields separated by colons (`:`):
  - **ID**: Unique identifier for the task.
  - **Title**: Title of the task.
  - **Description**: Description of the task.
  - **Location**: Location associated with the task.
  - **Date**: Date of the task in `YYYY-MM-DD` format.
  - **Time**: Time of the task in `HH:MM` format.
  - **Completion Status**: `0` indicates the task is not completed, and `1` indicates the task is completed.

### Code Organization
- The script uses a series of `if-elif` blocks to handle different commands provided as the first argument to the script.
- Each command corresponds to a specific functionality:
  - `help`: Displays usage information.
  - `task`: Adds a new task.
  - `list`: Lists all tasks.
  - `update`: Updates an existing task.
  - `delete`: Deletes a task.
  - `list_by_date`: Lists tasks for a specific date.
  - `complete`: Marks a task as completed.
  - `search`: Searches for tasks by title.

### Functionality Details

1. **Help Functionality**:
   - If the user enters "help" as an argument when executing the script, it prints out usage instructions. These instructions detail how to use the script and its available options. It explains each option such as adding a task, listing tasks, updating tasks, deleting tasks, listing tasks by date, marking tasks as completed, and searching for tasks by title:
     ```
     ./todo.sh help
     ```

2. **Adding a Task**:
   - When the user runs the script with the argument "task", it prompts the user to input various details of a task such as title, description, location, date, and time. It assigns a unique ID to the task based on the number of lines in the "tasklist.txt" file and appends the task details along with the ID to the file:
     ```
     ./todo.sh task
     ```

3. **Listing Tasks**:
   - If the user runs the script with the argument "list", it displays all tasks stored in the "tasklist.txt" file. It simply outputs the contents of the file, which includes details of all tasks:
     ```
     ./todo.sh list
     ```

4. **Updating a Task**:
   - When the user selects the "update" option, the script first lists all existing tasks with their IDs. Then it prompts the user to enter the ID of the task they want to update. After retrieving the task details based on the provided ID, it allows the user to update any or all of the task details (title, description, location, date, and time). Once the user finishes updating, it replaces the old task details with the new ones in the "tasklist.txt" file:
     ```
     ./todo.sh update
     ```

5. **Deleting a Task**:
   - If the user chooses the "delete" option, the script displays all existing tasks with their IDs. Then it prompts the user to enter the ID of the task they want to delete. After confirming the deletion with the user, it removes the task with the specified ID from the "tasklist.txt" file:
     ```
     ./todo.sh delete
     ```

6. **Listing Tasks by Date**:
   - When the user selects the "list_by_date" option, the script asks the user to input a date. After receiving the date input, it searches for tasks with that specific date in the "tasklist.txt" file. It separates completed and uncompleted tasks and then displays both categories of tasks for the specified date:
     ```
     ./todo.sh list_by_date
     ```

7. **Completing a Task**:
   - If the user chooses the "complete" option, the script lists all uncompleted tasks along with their IDs. Then it prompts the user to enter the ID of the task they want to mark as completed. After confirming the ID, it marks the selected task as completed by changing the value of the "iscomplete" field from 0 to 1 in the "tasklist.txt" file:
     ```
     ./todo.sh complete
     ```

8. **Searching for a Task by Title**:
   - When the user selects the "search" option, the script prompts the user to enter a title to search for. It performs a case-insensitive search for tasks with matching titles in the "tasklist.txt" file. If any matching tasks are found, it displays them; otherwise, it notifies the user that no tasks were found with the specified title:
     ```
     ./todo.sh search
     ```

