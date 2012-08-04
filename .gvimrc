if has('win32') || has('win64')
  set guifont=Ricty:h12
elseif has('unix')
  set guifont=Ricty\ 12
endif
colorscheme evening
if has('multi_byte_ime')
  highlight Cursor guifg=NONE guibg=Green
  highlight CursorIM guifg=NONE guibg=Purple
endif
gui
set transparency=240
