#!/bin/bash

#----------------------------help-------------------------------
if [ "$1" = "help" ]; then
    echo "Usage: $0 [task|list|update|delete|list_by_date|complete]"
    echo "  Options:"
    echo "    task           Add a new task"
    echo "    list           List all tasks"
    echo "    update         Update a task"
    echo "    delete         Delete a task"
    echo "    list_by_date   List tasks by date"
    echo "    complete       Mark a task as completed"
    echo "    search_title   Search for a task by title"
fi

#----------------------------add task----------------------------
if [ "$1" = "task" ]; then

    id=$(wc -l < "tasklist.txt")
    id=$((id+1))

    echo "Enter a title:"
    read title

    echo "Enter a description:"
    read description

    echo "Enter a location:"
    read location

    echo "Enter a date (YYYY-MM-DD):"
    read ddate

    echo "Enter a time (HH:MM):"
    read time

    iscomplete="0"

    echo "$id:$title:$description:$location:$ddate:$time:$iscomplete" >> tasklist.txt

#----------------------------list tasks----------------------------
elif [ "$1" = "list" ]; then
    echo "$(cat tasklist.txt)"

#----------------------------update tasks----------------------------
elif [ "$1" = "update" ]; then
    echo "Here are your current tasks:"
    echo "$(cat tasklist.txt)"
    echo "Please enter the ID of the task you want to update:"
    read id
    line=$(grep "^$id:" tasklist.txt)

    if [ -n "$line" ]; then
        old_title=$(echo "$line" | cut -d ':' -f 2)
        old_description=$(echo "$line" | cut -d ':' -f 3)
        old_location=$(echo "$line" | cut -d ':' -f 4)
        old_ddate=$(echo "$line" | cut -d ':' -f 5)
        old_time=$(echo "$line" | cut -d ':' -f 6)
        old_iscomplete=$(echo "$line" | cut -d ':' -f 7)

        echo "Enter a title (current: $old_title):"
        read title
        if [ -z "$title" ]; then
            title="$old_title"
        fi

        echo "Enter a description (current: $old_description):"
        read description
        if [ -z "$description" ]; then
            description="$old_description"
        fi

        echo "Enter a location (current: $old_location):"
        read location
        if [ -z "$location" ]; then
            location="$old_location"
        fi

        echo "Enter a date (current: $old_ddate):"
        read ddate
        if [ -z "$ddate" ]; then
            ddate="$old_ddate"
        fi

        echo "Enter a time (current: $old_time):"
        read time
        if [ -z "$time" ]; then
            time="$old_time"
        fi

        sed -i "s|^$id:.*|$id:$title:$description:$location:$ddate:$time:$old_iscomplete|" tasklist.txt
        echo "Task with ID $id has been modified."
    else
        echo "Task with ID $id not found."
    fi

#----------------------------delete task---------------------------------
elif [ "$1" = "delete" ]; then
    echo "Here are your current tasks:"
    echo "$(cat tasklist.txt)"
    echo "Please enter the ID of the task you want to delete:"
    read id
    line=$(grep "^$id:" tasklist.txt)

    if [ -n "$line" ]; then
        echo "Do you really want to delete this task: $line [y/n]"
        read decision

        if [ "$decision" = "y" ]; then
            sed -i "/^$id:/d" tasklist.txt
            echo "Task with ID $id has been deleted."
        else
            echo "Task has not been deleted."
        fi
    else
        echo "Task with ID $id not found."
    fi

#----------------------------list tasks by date---------------------------------
elif [ "$1" = "list_by_date" ]; then
    echo "Enter the date (YYYY-MM-DD) for which you want to list tasks:"
    read date

    echo "Searching for tasks on date: $date"

    completed_tasks=$(grep ":$date:.*:1$" tasklist.txt)
    uncompleted_tasks=$(grep ":$date:.*:0$" tasklist.txt)

    echo "Tasks for date $date:"
    echo "Completed tasks:"
    if [ -n "$completed_tasks" ]; then
        echo "$completed_tasks"
    else
        echo "No completed tasks."
    fi

    echo "Uncompleted tasks:"
    if [ -n "$uncompleted_tasks" ]; then
        echo "$uncompleted_tasks"
    else
        echo "No uncompleted tasks."
    fi

#----------------------------complete task---------------------------------
elif [ "$1" = "complete" ]; then
    echo "Here are your uncompleted tasks:"
    uncompleted_tasks=$(grep ":.*:.*:.*:.*:.*:0$" tasklist.txt)
    echo "$uncompleted_tasks"
    echo "Please enter the ID of the task you want to mark as completed (or press Enter to quit):"
    read id

    # Check if the user entered nothing and quit if so
    if [ -z "$id" ]; then
        echo "Exiting..."
        exit 0
    fi

    line=$(grep "^$id:.*:.*:.*:.*:.*:0$" tasklist.txt)

    if [ -n "$line" ]; then
        sed -i "s|^$id:\(.*\):0$|$id:\1:1|" tasklist.txt
        echo "Task with ID $id has been marked as completed."
    elif [ -z "$line" ]; then
        echo "Task with ID $id is already completed or not found."

	fi

#----------------------------search---------------------------------
elif [ "$1" = "search" ]; then
    echo "Enter the title of the task you want to search for:"
    read search_title

    # Perform case-insensitive search for the title in the task list
    matching_tasks=$(grep -i ":$search_title:" tasklist.txt)

    if [ -n "$matching_tasks" ]; then
        echo "Tasks with title '$search_title':"
        echo "$matching_tasks"
    else
        echo "No tasks found with title '$search_title'."
    fi
fi


