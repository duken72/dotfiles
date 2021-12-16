# Copyright (c) 2021, Huu Duc Nguyen
# All rights reserved.

# This source code is licensed under the BSD-style license found in the
# LICENSE file in the root directory of this source tree.

# -------------------------------------------------
# bashForDummies


# Navigation
ls -l -a [folder] #-l (long) for details, -a (all) include hidden files
ls -lhrt
tree --du -h
tree -dh
broot # install with brew
# result of ll:
# ---------- 10 character
# drwxrwxrwx : d - implies directory, rwx - read-write-execute
# 3 groups for owner, owning group, and everyone else permission on this file/dir
chown USER[:GROUP] [file] # change ownership of a file
chmod +x [file] # change permission of a file, +/- rwx

pwd # current working directories
cd [dir] / cd .. / cd # or cd ~ = root
cd -  #previous dir
# pushd & popd

file [file_name] # description of file
du -ahd 1 [dir/file] # size of a dir/file
du -hsc * [dir/file]
locate [file_name] # locate file in the entire system, need to be installed
find <in-folder> -type f -name <file_name> -exec rm {} \;
# ex: find . -name abc -type d; type d for dir, f for file
fdfind # install this
grep <what> <file_name> # search for a string in a file
# to search string in a dir
{grep -R, rgrep, rg, ag} <what> <dir>

# Guidance
which [cmd] # or whatis [cmd]
man [cmd] # manual guide for [cmd]
apropos [something] # every command relate with [_]
type [cmd] # also show guide on that command, whether it's an alias
history # Ctrl + R

# Working with files
mkdir [dir]
rmdir [dir] # remove all empty/unnecessary directories
touch [file_name] # create or update
cp -r [files] [dir] # -r: recursive (all the subfolder as well)
mv [files] [dir]
mmv 'name_pattern' 'new_name_pattern' # rename multiple files with desired pattern
for file in *.txt; do mv "$file" "${file%.txt}.sh"; done
rm (-r) (-f)
ln -s [OPTIONS] ORIGINAL_FILE LINKED_FILE #(soft) Symbolic link 

# -------------------------------------------------
# Placeholders
ls *.pdf      # * - any SET of characterS
ls ?uck*      # ? - any SINGLE character
ls [c-e]uck*  # [a-f] - characters in [abcdef]
ls duc[^a-c]* # [^a-c] - any character not in [abc]

less [file_name] || more [file_name] || cat [file_name]
gedit [file] || nano [file] || vim [file]

. .bash_aliases # alias

# Chaining and redirection commands
./[file.name] 1> output_file.txt 2> error_log.txt # use >> to append instead of overwrite
cmd1; cmd2; cmd3 # call cmds one after another, cmd2 runs even if cmd1 fails
cmd1 && cmd2 && cmd3 # same, but fails if any of the cmds return an error code
cmd1 || cmd2 # If cmd1 fails, run cmd2
cmd1 | cmd2 | cmd3 # pipe stdout of cmd1 to stdin of cmd 2, ..
# ex: ls | grep something

sudo su # root user, be careful :)
exit

xdg-open # open stuff with default app

sed 's/[prev_expression]/[new_expression]/g' [file.txt] # just print out the results
sed -i 's/[prev_expression]/[new_expression]/g' [file.txt] # replace a string with another
sed '/searchStr/c\newLine' [file.txt] # replace a line contain a string

awk '/pattern/ {print $2}' file.txt
awk -f awkFD.awk file.txt

# -------------------------------------------------
# Archive
zip -er output.zip file1 file2 # zip with encryption (password)
unzip -o input.zip -d target_dir # unzip to a dir, -x *.h to exclude files .h, -o for overwriting the target_dir, -n for not overwrite, just unzip files that are not yet in target_dir
upzip -l input.zip | less # looking inside zip file
zipcloack file.zip # add password, in case u forgot it before
zipsplit -n [size_in_bytes] file.zip # split to satisfy size restriction
tar cvf [target_file.tar] [files/dirs] # v - verbose (echo out what it does), f - file type tar, c - create
tar tvf [file.tar] # t - list out files in file.tar
gzip [file.tar] # compress the tar file -> .tar.gz file
gunzip [file.tar.gz] # uncompress the .tar.gz file -> .tar file
tar xvf [file.tar] -C [dirs] # extract the tar file
tar xvfz [file.tar.gz] [dirs] # extract the tar.gz file

# -------------------------------------------------
# Symmetric cryptography
openssl aes-256-cbc -salt -pbkdf2 -in <file.name> -out <file.enc.name>
openssl aes-256-cbc -d -pbkdf2 -in <file.enc.name> -out <file.dec.name>
cmp <file1> <file2> | echo $? #compare 2 file, 0 if same, 1 if different

# -------------------------------------------------
# Monitor your system
htop
neofetch # kute :3

sensible-browser $WEBSITE
sensible-editor
sensible-pager

# -------------------------------------------------
# Killing / resuming process
# Ctrl-C - SIGINT
# Ctrl-\ - SIGQUIT
fg || bg # resume task in foreground, background
jobs
kill -l

# -------------------------------------------------
# Shortcut - Action
# Ctrl-S - stop output to screen
# Ctrl-Q - re-enable screen output
# Ctrl-A - beginning of line
# Ctrl-E - end of line
# Ctrl-F - forward one char
# Ctrl-B - backward one char
# Ctrl-H - delete one char (backwards)
# Alt-F - forward one word
# Alt-B - backward one word
# Ctrl-W - delete one word (backwards)
# Ctrl-U - clear to beginning of line
# Ctrl-K - clear to end of the line
# Ctrl-D - exit shell
