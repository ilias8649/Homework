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

### Functionality
- **Help Command**: Provides usage instructions.
  ```bash
  ./script.sh help
