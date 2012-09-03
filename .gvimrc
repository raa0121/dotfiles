nnoremap <silent> <C-F2> :if &guioptions =~# 'T' <Bar> 
            \set guioptions-=T <Bar> 
            \set guioptions-=m <Bar>
            \else <Bar> 
            \set guioptions+=T <Bar> 
            \set guioptions+=m <Bar>
            \endif<CR>
 

if has('win32') || has('win64')
  set guifont=Ricty:h12
elseif has('unix')
  set guifont=Ricty\ 12
endif
colorscheme evening
if has('multi_byte_ime') || has('xim')
  highlight Cursor guifg=NONE guibg=Green
  highlight CursorIM guifg=NONE guibg=Purple
endif
gui
if has('win32') || has('win64')
  set transparency 220
endif

