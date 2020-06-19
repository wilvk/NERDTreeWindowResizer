# NERDTreeWindowSizer

A Vim plugin to allow auto resizing of your NERDTree

## Installation:

Vundle:

```
    Plugin 'wilvk/NERDTreeWindowResizer'
````

### Dependencies:

Requires [NERDTree](https://github.com/preservim/nerdtree)

This can be installed using Vundle by:

```
    Plugin 'preservim/nerdtree'
```

### Instructions:

With the cursor in the NERDTree window, press `r` to refresh. The window should resize.

Window resizing occurs on NERDTree refresh events that are also triggered on some directory traversals.
