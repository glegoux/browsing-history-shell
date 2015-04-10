# Browsing History Shell

## Motivation

Everybody knows the command history to show the command bash history with. Why is there not a history for browsing ? Personnaly, when I am into a server with SSH connection, I forgot always where I was before, in what working directory. I advise you to put in your prompt also the current working directory with \w or $PWD.

## Synopsis

The goal is to show your browsing history like a browsing web, but in your shell environment. You can easily go to the previous and next working directory and show your browsing history. 

The history is accesible in environment variable `HIST_DIR`.

/!\ No one directory should contain the character `:` in its name.

By default, there are a alias `chistory` to show the traditionnal command bash history. And when you make a `cd`, if the standard output of a `ls` is less than 4 lines, then a `ls` is executed. Pay attention to put a redirection into /dev/null if you use cd in in other context. You can decomment the matching lines, to have not this behaviour.

## Use Example

The different extra commands are :

1. `bhistory`

2. `cd -` (is no more cyclique `cd -` + `cd -` = `cd .` by default) : To go into the previous working directory.

3. `cd +` : To go into the next working directory.

## Tests

I'm going to write that, because it's important. And I explain here, the particulare cases, if it's ambiguous.

## Installation

1. Download this git repo.

2. Move `.bashrc_browsing_history` into your home folder.

```
mv .bashrc_browsing_history ~/
```

3. Insert the following lines into your `~/.bashrc` :

```bash
# Import 
if [ -f ~/.bashrc_browsing_history ]; then
    source ~/.bashrc_browsing_history
fi
```

4. Let's go and enjoy.

Best Regards, don't hesitate to write me, to fix bugs, or improve behaviours.
