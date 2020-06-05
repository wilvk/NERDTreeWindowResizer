if !exists('g:NERDTreeWindowResizer_RunOnce')
    let g:NERDTreeWindowResizer_RunOnce = 1
endif

if g:NERDTreeWindowResizer_RunOnce == 0
    finish
endif

if !exists('g:NERDTreeWindowResizer_CurrentSize')
    let g:NERDTreeWindowResizer_CurrentSize = 0
endif

if !exists('g:NERDTreeWindowResizer_NTStarted')
    let g:NERDTreeWindowResizer_NTStarted = 0
endif

function! s:IsNERDTreeOpen()
    return exists("t:NERDTreeBufName") && (bufwinnr(t:NERDTreeBufName) != -1)
endfunction

function! s:JumpToNERDTreeWindow()
    if (bufwinnr(t:NERDTreeBufName) != -1)
      let windowNr = bufwinnr(t:NERDTreeBufName)
      if windowNr > 0
          silent! execute windowNr . ' wincmd w'
      endif
    endif
endfunction

function! s:SetNerdTreeWindowSize()
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

function! NERDTreeWindowResizerHandler(event)
  if s:IsNERDTreeOpen()
      call s:JumpToNERDTreeWindow()
      call s:SetNerdTreeWindowSize()
  endif
endfunction

function! ntwr#NERDTreeWindowResizerSetEvents()
  if g:NERDTreeWindowResizer_RunOnce
    call g:NERDTreePathNotifier.AddListener('init', 'NERDTreeWindowResizerHandler')
    call g:NERDTreePathNotifier.AddListener('refresh', 'NERDTreeWindowResizerHandler')
    call g:NERDTreePathNotifier.AddListener('refreshFlags', 'NERDTreeWindowResizerHandler')
    let g:NERDTreeWindowResizer_RunOnce = 0
  endif
endfunction

augroup NERDTreeWindowSizer
    autocmd!
    autocmd BufEnter    * call ntwr#NERDTreeWindowResizerSetEvents()
augroup END
