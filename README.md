# Browsing History Shell

![alt text][bhistory]

It's very useful, it becomes quickly essential and it takes less than one minute to install.  
See **[Installation](https://github.com/glegoux/browsing-history-shell/blob/master/README.md#installation)** !

## Motivation

Everybody knows the command `history` to show the command bash history. Why is there not a history for browsing ? Personnaly, when I am on a server with SSH connection, I always forget where I was before, in what working directory. I advise you to put the current working directory on your prompt (for instance `PS1="\u@: \w \\$ "` where `\w` is yout current working directory).

This is only for `Bash Shell` (but it's easy to adapt for a Shell Bourne `sh` or others ...).  
See that with `cat /etc/passwd | grep $USER` or `echo $SHELL` to know that.

## Synopsis

The goal is to show your browsing history as a browsing web, but in your shell environment. You can easily go to the previous and next working directory and show your browsing history.   
  
**Files**   
  `~/.bashrc` : executed when a interactive bash shell lauchned.  
  `~/.bashrc_browsing_history` : this extension of bashrc.  
  
**Environment variables**  
  `$BHIST_DIRS` : the browsing history, it's an array.  
  `$BHIST_CUR_INDEX` : Your position is the browsing history.  
  `$BHIST_LEN` : the length of the browsing history.
  
**Aliases**  
  `cd [$1]`  : execute an overlayer of 'cd' allowing to update each time the history (see usage).   
  `bhistory` : show the browsing history.  
  `chistory` : show the command bash history (distinguishing the type of history : command or browsing).  
  
And when you make a `cd`, if the standard output of a `ls` is less than 4 lines, then a `ls` is executed. Pay attention to put a redirection into `/dev/null` if you use `cd` in another context. 
  
If a foldername is `:<i>`, then this foldername is in conflict with the command `cd :<i>`. If this folder is in the current working directory and you use a `cd :<i>` a warning, but `cd ./:<i>` allows to go into this folder.
  
You can comment or delete the matching lines into `.bashrc_browsing_history`, to have your wanted behaviour (no warning, or no 'ls' of 'cd').
  
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

## Contribution

### Coding Style

Try to use https://google-styleguide.googlecode.com/svn/trunk/shell.xml.

### Tests

I'm going to write that, because it's important. And I explain here, the particular cases, if it's ambiguous.

## Installation

Follow the following steps, **[local_git_repository]** is the absolute pathname that you chose to download this git repot.

1) Download this git repository :

```
git clone https://github.com/glegoux/browsing-history-shell.git [local_git_repository]
```

There are hidden files, see that with a `ls -a`.

2) Create a symbolic link :

```
ln -s [local_git_repository].bashrc_browsing_history ~/.bashrc_browsing_history
```

3) Insert the following lines into your `~/.bashrc` :

```bash
# enable browsing history shell
if [ -f ~/.bashrc_browsing_history ]; then
    . ~/.bashrc_browsing_history
fi
```

4) You can update your script with an `git pull` into **[local_git_repository]**.

Of course, you also can just copy the content of `.bashrc_browsing_history`, but the automatic updating will be more complicated. 

Let's go and enjoy.

Best Regards, don't hesitate to write me, to fix bugs, or improve behaviours.

## License 

Released under the MIT License, see LICENSE.

[bhistory]: https://github.com/glegoux/browsing-history-shell/blob/master/bhistory.png "bhistory"
[cdprevious]: https://github.com/glegoux/browsing-history-shell/blob/master/cdprevious.png "cdprevious"
[cdnext]: https://github.com/glegoux/browsing-history-shell/blob/master/cdnext.png "cdnext"
[cdhistory]: https://github.com/glegoux/browsing-history-shell/blob/master/cdhistory.png "cdhistory"

