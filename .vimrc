" coding:utf-8
set enc=utf8
scriptencoding utf-8
" ζ*'ヮ')ζ ζ(*'ヮ'リ+
"
if &compatible
  set nocompatible
endif
set ignorecase
set smartcase
set tabstop=2
set expandtab
set autoindent
set backspace=2
set wrapscan
set showmatch
set wildmenu
set formatoptions+=mM
set softtabstop=2
set shiftwidth=2
set fileencodings=utf-8,sjis,cp932,euc-jp,default,latin
set number
set ruler
set nolist
set wrap
set laststatus=2
set cmdheight=2
set showcmd
set title
set hlsearch
set list
set listchars=tab:>-
set ambiwidth=single
set ffs=unix,dos
colorscheme elflord
if has('gui_running')
  colorscheme evening
endif
syntax on
set updatetime=200

" ファイル名に大文字小文字の区別がないシステム用の設定:
"   (例: DOS/Windows/MacOS)
"
if filereadable($VIM . '/vimrc') && filereadable($VIM . '/ViMrC')
  " tagsファイルの重複防止
  set tags=./tags,tags
endif

" コンソールでのカラー表示のための設定(暫定的にUNIX専用)
if has('unix') && !has('gui_running') && !has('nvim')
  let uname = system('uname')
  if uname =~? "linux"
    set term=builtin_linux
  elseif g:uname =~? 'freebsd'
    set term=builtin_cons25
  elseif g:uname =~? 'Darwin'
    set term=beos-ansi
  else
    set term=builtin_xterm
  endif
endif

" コンソール版で環境変数$DISPLAYが設定されていると起動が遅くなる件へ対応
if !has('gui_running') && has('xterm_clipboard')
  set clipboard=exclude:cons\\\|linux\\\|cygwin\\\|rxvt\\\|screen
endif


if has('vim_starting')
  " 挿入モード時に非点滅の縦棒タイプのカーソル
  let &t_SI .= "\e[6 q"
  " ノーマルモード時に非点滅のブロックタイプのカーソル
  let &t_EI .= "\e[2 q"
  " 置換モード時に非点滅の下線タイプのカーソル
  let &t_SR .= "\e[4 q"
endif

" タブページの切り替えをWindowsのように
" CTRL+Tab SHIFT+Tabで行うように.
if v:version >= 700
  nnoremap <C-Tab>   gt
  nnoremap <C-S-Tab> gT
endif

let g:vim_indent_cont = 2

if filereadable(expand('~/.vimrc.local'))
  exe 'source' expand('~/.vimrc.local')
endif

filetype off

" プラグインが実際にインストールされるディレクトリ
let s:dpp_dir = '~/.cache/dpp'
" dpp.vim の 依存をインストール
let s:dpp_plugins = [
  \ 'Shougo/dpp.vim',
  \ 'Shougo/dpp-ext-installer',
  \ 'Shougo/dpp-ext-lazy',
  \ 'Shougo/dpp-ext-toml',
  \ 'Shougo/dpp-protocol-git',
  \ 'vim-denops/denops.vim',
  \ ]
let g:denops_server_addr = '127.0.0.1:32123'
for s:plugin in s:dpp_plugins->filter({_, val -> &runtimepath !~# '/' .. val->fnamemodify(':t')})
  let s:dir = expand(s:dpp_dir .. '/repos/github.com/' .. s:plugin)
  if !(s:dir->isdirectory())
    execute '!git clone https://github.com/' .. s:plugin s:dir
  endif
  execute 'set runtimepath^=' . s:dir->fnamemodify(':p')->substitute('[/\\]$', '', '')
endfor

" 設定開始
if dpp#min#load_state(expand(s:dpp_dir))
  augroup dpp-load
    autocmd!
    autocmd User DenopsReady call dpp#make_state(s:dpp_dir, expand('~/dotfiles/dpp.ts'))
  augroup END
else
  augroup dpp-load
    autocmd!
    autocmd BufWritePost *.lua,*.vim,*.toml,*.ts,vimrc,.vimrc
        \ call dpp#check_files()
  augroup END
endif

augroup dpp-load-after
    autocmd!
    autocmd User Dpp:makeStatePost
      \ : echohl WarningMsg
      \ | echomsg 'dpp make_state() is done'
      \ | echohl NONE
augroup END

filetype plugin indent on
syntax enable

"if dpp#sync_ext_action('installer', 'checkNotInstalled')
"  call dpp#async_ext_action('installer','install')
"endif

set ww+=h,l,>,<,[,]
if !has('nvim')
  set ttymouse=xterm2
  set clipboard=unnamed
endif

nnoremap <silent> ,vr :tabnew ~/dotfiles/.vimrc<CR>:lcd<CR>
nnoremap <silent> ,de :tabnew ~/dotfiles/dein.toml<CR>:lcd<CR>
nnoremap <silent> ,dl :tabnew ~/dotfiles/dein_lazy.toml<CR>:lcd<CR>
nnoremap <silent> ,so :so ~/.vimrc<CR>
nnoremap <silent> ,cw :botrigiht cwindow<CR>
nnoremap <Esc><Esc> <Cmd>:nohlsearch<CR><ESC><Cmd>:silent! HierStop<CR><ESC>
nnoremap <silent> ,ts :<C-u>tab stj <C-R>=expand('<cword>')<CR><CR>
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)


let g:monster#completion#rcodetools#backend = 'async_rct_complete'

let g:neosnippet#snippets_directory = '~/.vim/snippet,~/.cache/dein/honza/vim-snippets/snippets'

let g:OmniSharp_server_type = 'roslyn'

augroup vimrc
  autocmd!
  autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
  autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
  autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
  autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
  autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
  autocmd FileType cs setlocal omnifunc=OmniSharp#Complete
  autocmd FileType clojure setlocal omnifunc=neoclojure#complete#omni
  autocmd FileType quickrun AnsiEsc
  autocmd BufNewFile,BufRead *.{md,mdwn,mkd,mkdn,mark*} setlocal filetype=markdown
  autocmd BufNewFile,BufRead *.gradle setlocal filetype=groovy
  autocmd BufNewFile,BufRead */Classes/*.{cpp,h,hpp} setlocal tags+=$HOME/ctags/cocos2dx.tags
  autocmd BufNewFile,BufRead *.{jsx,tsx} setlocal filetype=typescript.tsx
  autocmd FileType php setlocal omnifunc=padawan#Complete noexpandtab wrap tabstop=4 shiftwidth=4 tags+=$HOME/ctags/php.tags
  autocmd FileType smarty setlocal noexpandtab wrap tabstop=4 shiftwidth=4 softtabstop=4 tags+=$HOME/ctags/php.tags
  autocmd FileType java setlocal noexpandtab wrap tabstop=4 shiftwidth=4
  autocmd FileType ruby setlocal tags+=$HOME/ctags/ruby.tags
  autocmd FileType c setlocal tags+=$HOME/ctags/c.tags
  autocmd FileType cpp call s:cpp_my_settings()
  function! s:cpp_my_settings() abort
    if has('win32')
      setlocal path+=.,C:\msys64\mingw64\include
    else
      setlocal path+=.
    endif
  endfunction
  autocmd FileType diff setlocal ts=4
  autocmd FileType go setlocal noexpandtab tabstop=4 shiftwidth=4 softtabstop=4
  autocmd BufNewFile Gemfile Template Gemfile
  autocmd User DirvishEnter let b:dirvish.showhidden = 1
  autocmd User lsp_buffer_enabled ++nested ++once call s:vista()
  function s:vista() abort
    call dein#source('vista.vim')
    Vista vim_lsp
  endfunction
augroup END


let g:netrw_nogx = 1

function! s:SID_PREFIX()
    return matchstr(expand('<sfile>'), '<SNR>\d\+_')
endfunction

set titlelen=100
set guioptions-=e

if !has('gui_running')
  set t_Co=256
endif


if exists('$TMUX') || exists('$WINDOW')
    set t_ts=k
    set t_fs=\
endif

" tabline
set showtabline=2 " always show tabline

let &tabline = '%!' . s:SID_PREFIX() . 'tabline()'

function! s:tabline()
    " show each tab
    let l:s = ''
    for l:i in range(1, tabpagenr('$'))
        let l:list = tabpagebuflist(l:i)
        let l:nr = tabpagewinnr(l:i)
        let l:current_tabnr = tabpagenr()

        "let title = bufname('')
        if l:i ==? l:current_tabnr
            let l:title = fnamemodify(getcwd(), ':t') . '/'
            "let title = bufname('')
        else
            let l:title = fnamemodify(gettabvar(l:i, 'cwd'), ':t') . '/'
        endif
        let l:title = empty(l:title) ? '[No Name]' : l:title
        let l:s .= l:i ==? l:current_tabnr ? '%#TabLineSel#' : '%#TabLine#'
        let l:s .= '%' . l:i . 'T[' . l:i . '] ' . l:title
        let l:s .= '  '
    endfor

    " build tabline
    let l:s .= '%#TabLineFill#%T%=%<[' . getcwd() . ']'
    return l:s
endfunction

augroup vimrc-scratch-buffer
  autocmd!
  " Make a scratch buffer when unnamed buffer.
  autocmd BufEnter * call s:scratch_buffer()
  autocmd FileType qfreplace autocmd! vimrc-scratch * <buffer>

  function! s:scratch_buffer()
    if exists('b:scratch_buffer') || bufname('%') !=# '' || &l:buftype !=# ''
      return
    endif
    let b:scratch_buffer = 1
    setlocal buftype=nofile nobuflisted noswapfile bufhidden=hide
    augroup vimrc-scratch
      autocmd! * <buffer>
      autocmd BufWriteCmd <buffer> call s:scratch_on_BufWriteCmd()
    augroup END
  endfunction
  function! s:scratch_on_BufWriteCmd()
    silent! setl buftype< buflisted< swapfile< bufhidden< nomodified
    autocmd! vimrc-scratch * <buffer>
    if bufname('%') ==# '' && exists('b:scratch_buffer')
      execute 'saveas' . (v:cmdbang ? '!' : '') ' <afile>'
      filetype detect
    endif
    unlet! b:scratch_buffer
  endfunction
augroup END

command! -nargs=? ExtractMatches let s:pat = empty(<q-args>) ? @/ : <q-args> | let s:result = filter(getline(1, '$'), 'v:val =~# s:pat') | new | put =s:result

let g:terminal_ansi_colors = [
\ '#073642',
\ '#dc322f',
\ '#859900',
\ '#b58900',
\ '#268bd2',
\ '#d33682',
\ '#2aa198',
\ '#eee8d5',
\ '#002b36',
\ '#cb4b16',
\ '#586e75',
\ '#657b83',
\ '#839496',
\ '#6c71c4',
\ '#93a1a1',
\ '#fdf6e3',
\ ]

