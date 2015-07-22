# Browsing History Shell

![alt text][bhistory]

It's very useful, it becomes quickly essential and it takes less than one minute to install.  
See *[Installation](https://github.com/glegoux/browsing-history-shell/blob/master/README.md#installation)* !

## Usage

The different extra commands are :

* `bhistory` : Show the browsing history of the current bash shell.

* `cd -` : Go into the previous working directory in your browsing history.  
           By default, it is cyclic, `cd -` + `cd -` = `cd .`, no longer.

* `cd +` : Go into the next working directory in your browsing history.

* `cd :<i>` : Go into the *\<i\>th* directory in your browsing history.

## Motivation

Everybody knows the command `history` to show the command bash history. Why is there not a history for browsing ? Personnaly, when I am on a server with SSH connection, I always forget where I was before, in what working directory. I advise you to put the current working directory on your prompt (for instance `PS1="\u@: \w \\$ "` where `\w` is your current working directory).

This is only for `Bash Shell` (but it's easy to adapt for a Shell Bourne `sh` or others ...).  
See that with `cat /etc/passwd | grep $USER` or `echo $SHELL` to know that.

## Synopsis

The goal is to show your browsing history as a browsing web, but in your shell environment. You can easily go to the previous and next working directory and show your browsing history.   
  
**Files**    

* `~/.bashrc` : executed when an interactive bash shell is lauchned, where this extension is installed.  
* `~/.bashrc_bhist` : this bashrc extension.
* `~/.bash_aliases_bhist` : aliases of this bashrc extension.
  
**Environment variables**  

* `$BHIST_DIRS` : the browsing history, it's an array.  
* `$BHIST_CUR_INDEX` : Your position is the browsing history, it's an integer.  
* `$BHIST_LEN` : the length of the browsing history, it's an integer.

**Functions**  

* `__bhist_history` : show the browsing history. 
* `__bhist_changedir [$1]` : execute an overlayer of 'cd' allowing to update each time the history   
*                           ( See *[Usage](https://github.com/glegoux/browsing-history-shell/blob/master/README.md#usage)* with alias `cd`).


**Aliases**  

See  **[~/.bash_aliases_bhist](https://github.com/glegoux/browsing-history-shell/blob/master/.bash_aliases_bhist)**.  

**Notes**  

And when you make a `cd`, if the standard output of a `ls` is less than 4 lines, then a `ls` is executed. Pay attention to put a redirection into `/dev/null` if you use `cd` in another context. 
  
If a foldername is `:<i>`, then this foldername is in conflict with the command `cd :<i>`. If this folder is in the current working directory and you use `cd :<i>`, there is a warning, but `cd ./:<i>` allows to go into this folder.
  
You can comment or delete the matching lines into `.bashrc_bhist`, to have your wanted behaviour (no warning for instance).


## Coding Style

Try to use https://google-styleguide.googlecode.com/svn/trunk/shell.xml.

## Tests

Use container docker with unit tests.  

See  **[test/](https://github.com/glegoux/browsing-history-shell/blob/master/test/)**.

## Installation

Follow the following steps, **[local_git_repository]** is the absolute pathname that you chose to download this git repository.

1) Download this git repository :

```
git clone https://github.com/glegoux/browsing-history-shell.git [local_git_repository]
```

There are hidden files, see that with a `ls -a`.

2) Create symbolic links :

```
ln -s [local_git_repository].bashrc_bhist ~/.bashrc_bhist
ln -s [local_git_repository].bash_aliases_bhist ~/.bash_aliases_bhist
```

3) Insert the following lines into your `~/.bashrc` :

```bash
# enable browsing history
if [ -f ~/.bashrc_bhist ]; then
    . ~/.bashrc_bhist
fi

# enable browsing history aliases
if [ -f ~/.bash_aliases_bhist ]; then
    . ~/.bash_aliases_bhist
fi
```

4) You can update your script with an `git pull` into **[local_git_repository]**.

Of course, you also can just copy the content of each file wihout creating symbolic links, but the automatic updating will be more complicated than 'git pull'. 

Let's go and enjoy.

Best Regards, don't hesitate to write me, to fix bugs, or improve behaviours.

## License 

Released under the MIT License, see LICENSE.

[bhistory]: https://github.com/glegoux/browsing-history-shell/blob/master/media/bhistory.png "bhistory"
[cdprevious]: https://github.com/glegoux/browsing-history-shell/blob/master/media/cdprevious.png "cdprevious"
[cdnext]: https://github.com/glegoux/browsing-history-shell/blob/master/media/cdnext.png "cdnext"
[cdhistory]: https://github.com/glegoux/browsing-history-shell/blob/master/media/cdhistory.png "cdhistory"

