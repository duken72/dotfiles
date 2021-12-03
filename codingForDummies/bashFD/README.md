# Basics
CLI commands:
```bash
alias cdbashFD='cdl ~/github/codingForDummies/bashFD'
alias    bashg='less $(fd bashFD.bash ~)'
alias   bashgg='less $(fd bashFD.bash ~) | grep'

alias  gitg='less $(fd gitFD.bash ~)'
alias gitgg='less $(fd gitFD.bash ~) | grep'

alias vimg='less $(fd vimFD.bash ~)'

alias lessg='less $(fd lessFD.bash ~)'
```

-----

## BASH
To interact with the OS.  
All the commands are actually from folders in {PATH}
```bash
echo $PATH
```
Check bashFD.bash for commands.

-----

## GIT
Check gitFD.bash for commands.

Some guides:
- [Version control git](https://missing.csail.mit.edu/2020/version-control/)
- [Oh Shit, Git!?!](https://ohshitgit.com/#accidental-commit-master)
- [Creating a personal access token](https://docs.github.com/en/github/authenticating-to-github/keeping-your-account-and-data-secure/creating-a-personal-access-token)

Use .gitignore to specify intentionally untracked files to ignore

-----

## VIM
Reference:
- https://missing.csail.mit.edu/2020/editors/
- https://www.codingdomain.com/linux/vim/advanced/
- https://thevaluable.dev/vim-advanced/
- http://www.yolinux.com/TUTORIALS/LinuxTutorialAdvanced_vi.html
- https://gist.github.com/fakemelvynkim/9546331
- https://www.keycdn.com/blog/vim-commands

-----