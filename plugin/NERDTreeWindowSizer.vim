if !exists('g:NERDTreeWindowResizer_RunOnce')
    let g:NERDTreeWindowResizer_RunOnce = 1
endif

if !exists('g:NERDTreeWindowResizer_CurrentSize')
    let g:NERDTreeWindowResizer_CurrentSize = 0
endif

augroup NERDTreeWindowSizer
    autocmd!
    autocmd BufWrite    * call ntwr#SetNERDTreeWindowResizerEvents()
    autocmd BufEnter    * call ntwr#SetNERDTreeWindowResizerEvents()
    autocmd BufReadPost * call ntwr#SyncTree(1)
    autocmd CursorHold  * call ntwr#SyncTree(1)
augroup END
