# Browsing History Shell

![alt text][bhistory]

## Motivation

Everybody knows the command `history` to show the command bash history. Why is there not a history for browsing ? Personnaly, when I am into a server with SSH connection, I always forget where I was before, in what working directory. I advise you to put in your prompt also the current working directory with `\w` or `$PWD`.

## Synopsis

The goal is to show your browsing history like a browsing web, but in your shell environment. You can easily go to the previous and next working directory and show your browsing history. 

The history is accesible with an environment variable `HIST_DIR`.

/!\ No one directory should contain the character `:` in its name.

By default, there are a alias `chistory` to show the traditionnal command bash history. And when you make a `cd`, if the standard output of a `ls` is less than 4 lines, then a `ls` is executed. Pay attention to put a redirection into /dev/null if you use cd in in other context. You can comment the matching lines into `history`, to have not this behaviour.

## Use Example

The different extra commands are :

1) `bhistory` : To show your browsing history.

![alt text][bhistory]

2) `cd -` (is no more cyclic `cd -` + `cd -` = `cd .` by default) : To go into the previous working directory.

![alt text][cdprevious]

3) `cd +` : To go into the next working directory.

![alt text][cdnext]

## Tests

I'm going to write that, because it's important. And I explain here, the particulare cases, if it's ambiguous.

## Installation

1) Download this git repository :

```
git clone https://github.com/glegoux/browsing-history-shell.git
```

/!\ There are hidden files, see that with a `ls -l`.

2) Move `.bashrc_browsing_history` into your home folder.

```
mv .bashrc_browsing_history ~/
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

The MIT License (MIT)

Copyright (c) 2015 Gilles Legoux

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

[bhistory]: https://github.com/glegoux/browsing-history-shell/blob/master/bhistory.png "Browsing history"
[cdprevious]: https://github.com/glegoux/browsing-history-shell/blob/master/cdprevious.png "Browsing history"
[cdnext]: https://github.com/glegoux/browsing-history-shell/blob/master/cdnext.png "Browsing history"
