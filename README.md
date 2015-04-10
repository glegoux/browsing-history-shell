# browsing-history-shell


Installation

move .bashrc_browsing_history into your home folder.

```
mv .bashrc_browsing_history ~/
```

Insert the following lines into your ~/.bashrc :

```bash
# Import 
if [ -f ~/.bashrc_browsing_history ]; then
    source ~/.bashrc_browsing_history
fi
```

