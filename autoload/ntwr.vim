if !exists('g:NERDTreeWindowResizer_RunOnce') | runtime! plugin/*.vim | endif

function! ntwr#IsNERDTreeOpen()
  return exists("t:NERDTreeBufName") && (bufwinnr(t:NERDTreeBufName) != -1)
endfunction

function! ntwr#SyncTree(event)
  "let path = a:event.subject
  if &modifiable && ntwr#IsNERDTreeOpen() && strlen(expand('%')) > 0 && !&diff
      call ntwr#JumpToNERDTreeWindow()
      call ntwr#SetNerdTreeWindowSize()
      wincmd p
  endif
endfunction


function! ntwr#JumpToNERDTreeWindow()
    let windowNr = bufwinnr(t:NERDTreeBufName)
    if windowNr > 0
      execute windowNr 'wincmd w'
    endif
endfunction

function! ntwr#SetNerdTreeWindowSize()
    let lineLength = 0
    let maxLineLength = 0
    let lineCount = line('$')
    for rowNumber in range(1, lineCount)
        let lineLength = strwidth(getline(rowNumber))
        if lineLength > maxLineLength
          let maxLineLength = lineLength
        endif
    endfor
    if g:NERDTreeWindowResizer_CurrentSize != maxLineLength
      execute "vertical resize " . maxLineLength
      let g:NERDTreeWindowResizer_CurrentSize = maxLineLength
    endif
endfunction

function! ntwr#SetNERDTreeWindowResizerEvents()
    if exists("g:NERDTreePathNotifier") && g:NERDTreeWindowResizer_RunOnce
        call g:NERDTreePathNotifier.AddListener('refresh', 'SyncTree')
        call g:NERDTreePathNotifier.AddListener('refreshFlags', 'SyncTree')
        let g:NERDTreeWindowResizer_RunOnce = 0
    endif
endfunction
