#!/bin/bash

# Check if the number of arguments is less than 3
if [ $# -lt 3 ]; then
echo "Usage: $0 <age> <name> <is_student>"
exit 1
fi

age=$1
name=$2
is_student=$3

if [[ $age -gt 18 && $name == "John" && $is_student == true ]]; then
echo "John is older than 18 and is a student."
else
echo "John does not meet all the specified conditions."
fi