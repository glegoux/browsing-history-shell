# Browsing History Shell

## Synopsis

At the top of the file there should be a short introduction and/ or overview that explains what the project is. This description should match descriptions added for package managers (Gemspec, package.json, etc.)

## Use Example

Show what the library does as concisely as possible, developers should be able to figure out how your project solves their problem by looking at the code example. Make sure the API you are showing off is obvious, and that your code is short and concise.

## Motivation

A short description of the motivation behind the creation and maintenance of the project. This should explain why the project exists.

## Tests

## Installation

move `.bashrc_browsing_history` into your home folder.

```
mv .bashrc_browsing_history ~/
```

Insert the following lines into your `~/.bashrc` :

```bash
# Import 
if [ -f ~/.bashrc_browsing_history ]; then
    source ~/.bashrc_browsing_history
fi
```

