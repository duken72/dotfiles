#!/bin/bash

mkdir -p ~/WS

cd ~/WS
mkdir -p afs nas nasd nasp
git clone https://github.com/duken72/codingForDummies.git
git clone https://github.com/duken72/learningNotes.git
git clone https://github.com/duken72/phd-rbo.git

cd ~/WS
mkdir GitHub GitLab
cd ~/WS/GitHub
git clone https://github.com/HDuken/parroplots.git
cd ~/WS/GitLab
git clone https://git.tu-berlin.de/rbo/robotics/parrobots.git
git clone https://git.tu-berlin.de/rbo/robotics/parroplots.git
