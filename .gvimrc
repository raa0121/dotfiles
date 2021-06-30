colorscheme evening
nnoremap <silent> <C-F2> :if &guioptions =~# 'T' <Bar> 
            \set guioptions-=T <Bar> 
            \set guioptions-=m <Bar>
            \else <Bar> 
            \set guioptions+=T <Bar> 
            \set guioptions+=m <Bar>
            \endif<CR>
 
source $VIMRUNTIME/delmenu.vim
set langmenu=ja_jp.utf-8
source $VIMRUNTIME/menu.vim
set guioptions-=T
set guioptions-=m
set guioptions-=r
set guioptions-=L
set guioptions+=!
set guioptions+=c

if (has('win32') || has('win64')) && !has('nvim')
  set guifont=Cica:h12:cSHIFTJIS
elseif has('unix')
  set guifont=Cica\ 12
endif
if has('multi_byte_ime') || has('xim')
  highlight Cursor guifg=NONE guibg=Red
  highlight CursorIM guifg=NONE guibg=Green
endif
gui
if (has('win32') || has('win64') || has('win32unix')) && !has('nvim')
  set transparency=220
endif

if has('nvim')
  if exists(':GuiFont')
    GuiFont! Cica:h12
  endif
  if exists(':GuiTabline')
    GuiTabline 0
  endif
  if exists(':GuiPopupmenu')
    GuiPopupmenu 0
  endif
endif

if executable('fcitx')
  set imactivatefunc=ImActivate
  function! ImActivate(active)
    if a:active
      call vimproc#system_bg('fcitx-remote -o')
    else
      call vimproc#system_bg('fcitx-remote -c')
    endif
  endfunction
  set imstatusfunc=ImStatus
  function! ImStatus()
    return vimproc#system('fcitx-remote')[0] is# '2'
  endfunction
endif
