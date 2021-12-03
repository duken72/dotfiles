# https://missing.csail.mit.edu/2020/shell-tools/

# shebang
#!/bin/sh – Execute the file using the Bourne shell, or a compatible shell
#!/bin/bash – Execute the file using the Bash shell
#!/usr/bin/env python3 – Execute with a Python interpreter, using the env program search path to find

shellcheck file.sh

foo=bar # 'foo = bar' will not run, it interprete foo as command, "=" as 1st argument, "bar" as 2nd argument
echo "$foo" # prints bar
echo '$foo' # prints $foo

mcd()
{
    mkdir -p "$1"
    cd "$1"
}

# $0 - Name of the script
# $1 to $9 - Arguments to the script. $1 is the first argument and so on.
# $@ - All the arguments
# $# - Number of arguments
# $? - Return code of the previous command
# $$ - Process identification number (PID) for the current script
# !! - Entire last command, including arguments, ex: sudo !! if last command fail cause permission
# $_ - Last argument from the last command. If you are in an interactive shell, you can also quickly get this value by typing Esc followed by .

false || echo "Oops, fail" # Oops, fail
true || echo "Will not be printed"
true && echo "Things went well" # Things went well
false && echo "Will not be printed"
true ; echo "This will always run"
false ; echo "This will always run"

# {} as comment substring
convert image.{png,jpg}
# Will expand to
convert image.png image.jpg
