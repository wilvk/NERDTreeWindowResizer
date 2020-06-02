let g:NERDTreeWindowResizer_RunOnce = 1
let g:NERDTreeWindowResizer_CurrentSize = 0

augroup NERDTreeWindowSizer
    autocmd!
    autocmd BufWrite    * call ntwr#SetNERDTreeWindowResizerEvents()
    autocmd BufEnter    * call ntwr#SetNERDTreeWindowResizerEvents()
    autocmd BufReadPost * call ntwr#SyncTree(1)
augroup END
