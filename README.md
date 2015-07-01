# Browsing History Shell

![alt text][bhistory]

It's very useful, it becomes quickly essential and it takes less than one minute to install.  
See **[Installation](https://github.com/glegoux/browsing-history-shell/blob/master/README.md#installation)** !

## Motivation

Everybody knows the command `history` to show the command bash history. Why is there not a history for browsing ? Personnaly, when I am on a server with SSH connection, I always forget where I was before, in what working directory. I advise you to put the current working directory on your prompt (for instance `PS1="\u@: \w \\$ "`).

This is only for `Bash Shell` (but it's easy to adapt for a Shell Bourne `sh` or others ...).  
See that with `cat /etc/passwd | grep $USER` or `echo $SHELL` to know that.

## Synopsis

The goal is to show your browsing history as a browsing web, but in your shell environment. You can easily go to the previous and next working directory and show your browsing history. 

The history is accesible with an environment variable `$HIST_DIR`.

By default, there are an alias `chistory` to show the traditionnal command bash history. And when you make a `cd`, if the standard output of a `ls` is less than 4 lines, then a `ls` is executed. Pay attention to put a redirection into `/dev/null` if you use `cd` in another context. You can comment the matching lines into `.bashrc_browsing_history`, to have not this behaviour.

/!\ No one file or folder should contain the character `:` in its name to allow the command `cd :<i>`.

## Usage

The different extra commands are :

1) `bhistory` : Show your browsing history.

![alt text][bhistory]

2) `cd -` : Go into the previous working directory in your browsing history.
            (it is no more cyclic, `cd -` + `cd -` = `cd .` by default) 

![alt text][cdprevious]

3) `cd +` : Go into the next working directory in your browsing history.

![alt text][cdnext]

4) `cd :<i>` : Go into the *\<i\>th* directory in your browsing history.

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
# enable browsing history shell
if [ -f ~/.bashrc_browsing_history ]; then
    . ~/.bashrc_browsing_history
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

