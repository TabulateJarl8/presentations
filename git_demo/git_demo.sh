#!/bin/bash

########################
# include the magic
########################
. demo-magic.sh

# cd to tmp
cd /tmp && rm -rf git-demo feature-worktree && mkdir git-demo && cd git-demo && git init

cat >main.c <<EOF
#include <stdio.h>
int main(void) {
  printf("Hello world\n");

  printf("Calculating price...\n");

  double price = 34.99;

  printf("The price is %f\n", price);
}
EOF

git add .
git commit -m "Initial Commit"

# hide the evidence
clear

# Put your stuff here
pei "# Modify the startup message and then the price in seperate commits"
cmd
pe "git status"
pe "git add . -p"
pe "git status"
pe "git diff"
pe 'git commit -m "Changed startup message"'
pe "git add ."
pe 'git commit -m "Edit price"'
pe "git log -p -2"
pei "# Now let's fix the price and amend the commit"
cmd
pe 'git commit -a --amend'
pe 'git log -p -1'

pei "# Let's add two more commits to show off interactive rebase"
cmd
pe 'git commit -am "Change 1"'
cmd
pe 'git commit -am "Change 2"'

pe 'git log --oneline'

pei "# Rebase the last two commits into one"
pe 'git rebase -i HEAD~2'
pe 'git log --oneline'
pe 'git show'

### Git Worktrees
pei "# Now let's make a new worktree for an experimental feature"
pe 'git branch feature'
pe 'git worktree add ../feature-worktree feature'

pei "# Switch to the new worktree directory"
pe 'cd ../feature-worktree'

pe 'git status'
pei "# Make a small change"
cmd # Make a change in main.go in the worktree
pe 'git commit -am "Experimental feature"'

pei "# Back in main, you’ll see the branches diverged"
pe 'cd ../git-demo'
pe 'git log --oneline --graph --all'
