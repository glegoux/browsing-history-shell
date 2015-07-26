# Browsing History Shell

![alt text][demo]

It's very useful, it becomes quickly essential and it takes less than one minute to install.  
See [Installation](https://github.com/glegoux/browsing-history-shell/blob/master/README.md#installation) !

## Usage

The different extra commands are :

* `bhistory` : Show the browsing history of the current bash shell.

* `cd -` : Go into the previous working directory in your browsing history.  
           By default, it is cyclic, `cd -` + `cd -` = `cd .`, no longer.

* `cd +` : Go into the next working directory in your browsing history.

* `cd :<i>` : Go into the *\<i\>th* directory in your browsing history.

## Motivation

Everybody knows the command `history` to show the command bash history. Why is there not a history for browsing ? Personnaly, when I am on a server with SSH connection, I always forget where I was before, in what working directory. I advise you to put the current working directory on your prompt (for instance `PS1="\u@: \w \\$ "` where `\w` is your current working directory).

## Synopsis

The goal is to show your browsing history as a browsing web, but in your shell environment. You can easily go to the previous and next working directory and show your browsing history.   
  
**Files**    

* `~/.bashrc_bhist` : this bashrc extension.
* `~/.bash_aliases_bhist` : aliases of this bashrc extension.  
* `~/.bashrc` : bashrc file where this extension is installed.  
  
**Environment variables**  

* `$BHIST_DIRS` : the browsing history, it's an array.  
* `$BHIST_CUR_INDEX` : Your position is the browsing history, it's an integer.  
* `$BHIST_LEN` : the length of the browsing history, it's an integer.

**Functions**  

* `__bhist_history` : show the browsing history. 
* `__bhist_changedir [$1]` : execute an overlayer of 'cd' allowing to update each time the history.  


**Aliases**  

See  [~/.bash_aliases_bhist](https://github.com/glegoux/browsing-history-shell/blob/master/.bash_aliases_bhist).  

**Notes**  

And when you make a `cd`, if the standard output of a `ls` is less than 4 lines, then a `ls` is executed. Pay attention to put a redirection into `/dev/null` if you use `cd` in another context. 
  
If a foldername is `:<i>`, then this foldername is in conflict with the command `cd :<i>`. If this folder is in the current working directory and you use `cd :<i>`, there is a warning, but `cd ./:<i>` allows to go into this folder.
  
You can comment or delete the matching lines into `.bashrc_bhist`, to have your wanted behaviour (no warning for instance).

Aliases are disabled in shell script by default, you can enable `cd` alias in a shell script with `shopt -s expand_aliases` (see http://www.gnu.org/software/bash/manual/bash.html#The-Shopt-Builtin).
if you activate this shell option, check that with `shopt`, then `type cd` or `alias cd`.

## Coding Style

Try to use https://google-styleguide.googlecode.com/svn/trunk/shell.xml.

## Tests

Use docker container for interactive and unit tests.   

Launch the script `./run`.   

See [test/](https://github.com/glegoux/browsing-history-shell/blob/master/test/).  

*Note*  

Don't use the aliases 'cd' or 'bhistory' in an unit test because it's a bash function, that is a compound (see http://www.gnu.org/software/bash/manual/bash.html#Aliases).

## Installation

This is only for `Bash Shell version 4.3+` (but it's easy to adapt for a `Shell Bourne` or others ...).  

* See your current shell type with `cat /etc/passwd | grep $USER` or `echo $SHELL`.
* See your current version with `bash --version` .  

If you haven't that, you can download bash shell at http://www.gnu.org/software/bash/.

1) Download this git repository :

```
git clone --depth 1 https://github.com/glegoux/browsing-history-shell.git
```

There are hidden files, see that with `ls -a`.

2) Create symbolic links in going to your local git repository :

```
ln -s "$PWD"/.bashrc_bhist ~/.bashrc_bhist
ln -s "$PWD"/.bash_aliases_bhist ~/.bash_aliases_bhist
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

4) You can update your script with an `git pull`.

Of course, you also can just copy the content of each file wihout creating symbolic links, but the automatic updating will be more complicated than 'git pull'. 

Let's go and enjoy.

Best Regards, don't hesitate to write me, to fix bugs, or improve behaviours.

## License 

Released under the MIT License, see [LICENSE](https://github.com/glegoux/browsing-history-shell/blob/master/LICENSE/).

[demo]: https://github.com/glegoux/browsing-history-shell/blob/master/media/demo.gif "demo"

