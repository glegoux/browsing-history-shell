# Browsing History Shell

![alt text][bhistory]

## Motivation

Everybody knows the command `history` to show the command bash history. Why is there not a history for browsing ? Personnaly, when I am into a server with SSH connection, I always forget where I was before, in what working directory. I advise you to put in your prompt also the current working directory with `\w` or `$PWD`.

This is only for `Bash Shell` (but it's easy to adapt for a Shell Bourne `sh` or others ...). See that with `cat /etc/passwd | grep $USER` or `echo $SHELL` to know that.

## Synopsis

The goal is to show your browsing history like a browsing web, but in your shell environment. You can easily go to the previous and next working directory and show your browsing history. 

The history is accesible with an environment variable `HIST_DIR`.

By default, there are an alias `chistory` to show the traditionnal command bash history. And when you make a `cd`, if the standard output of a `ls` is less than 4 lines, then a `ls` is executed. Pay attention to put a redirection into /dev/null if you use cd in in other context. You can comment the matching lines into `history`, to have not this behaviour.

## Use Example

The different extra commands are :

1) `bhistory` : To show your browsing history.

![alt text][bhistory]

2) `cd -` : To go into the previous working directory in your browsing history.
            (is no more cyclic `cd -` + `cd -` = `cd .` by default) 

![alt text][cdprevious]

3) `cd +` : To go into the next working directory in your browsing history.

![alt text][cdnext]

3) `cd :<i>` : To go into the ie directory in your browsing history.

![alt text][cdhistory]

## Tests

I'm going to write that, because it's important. And I explain here, the particular cases, if it's ambiguous.

## Installation

1) Download this git repository :

```
git clone https://github.com/glegoux/browsing-history-shell.git
```

/!\ There are hidden files, see that with a `ls -l`.

2) Move `.bashrc_browsing_history` into your home folder.

```
cp [git_repository].bashrc_browsing_history ~/
```

then delete this local git repository (else use the zip archive), or create a symbolic link :

```
ln -s [git_repository].bashrc_browsing_history ~/.bashrc_browsing_history
```

3) Insert the following lines into your `~/.bashrc` :

```bash
# Import Browsing History Shell
if [ -f ~/.bashrc_browsing_history ]; then
    source ~/.bashrc_browsing_history
fi
```

4) Let's go and enjoy.

Best Regards, don't hesitate to write me, to fix bugs, or improve behaviours.

## License 

Released under the MIT License, see LICENSE.

[bhistory]: https://github.com/glegoux/browsing-history-shell/blob/master/bhistory.png "bhistory"
[cdprevious]: https://github.com/glegoux/browsing-history-shell/blob/master/cdprevious.png "cdprevious"
[cdnext]: https://github.com/glegoux/browsing-history-shell/blob/master/cdnext.png "cdnext"
[cdhistory]: https://github.com/glegoux/browsing-history-shell/blob/master/cdhistory.png "cdhistory"

