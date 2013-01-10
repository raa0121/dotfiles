" coding:utf-8

" 検索時に大文字小文字を無視 (noignorecase:無視しない)
set ignorecase
" 大文字小文字の両方が含まれている場合は大文字小文字を区別
set smartcase

" タブの画面上での幅
set tabstop=2
" タブをスペースに展開しない (expandtab:展開する)
set expandtab
" 自動的にインデントする (noautoindent:インデントしない)
set autoindent
" バックスペースでインデントや改行を削除できるようにする
set backspace=2
" 検索時にファイルの最後まで行ったら最初に戻る (nowrapscan:戻らない)
set wrapscan
" 括弧入力時に対応する括弧を表示 (noshowmatch:表示しない)
set showmatch
" コマンドライン補完するときに強化されたものを使う(参照 :help wildmenu)
set wildmenu
" テキスト挿入中の自動折り返しを日本語に対応させる
set formatoptions+=mM

set softtabstop=2

set shiftwidth=4

set fileencodings=utf-8,cp932,euc-jp,default,latin

" 行番号を非表示 (number:表示)
set number
" ルーラーを表示 (noruler:非表示)
set ruler
" タブや改行を表示 (list:表示)
set nolist
" 長い行を折り返して表示 (nowrap:折り返さない)
set wrap
" 常にステータス行を表示 (詳細は:he laststatus)
set laststatus=2
" コマンドラインの高さ (Windows用gvim使用時はgvimrcを編集すること)
set cmdheight=2
" コマンドをステータス行に表示
set showcmd
" タイトルを表示
set title
"シンタックスハイライトを有効にする
syntax on


" ファイル名に大文字小文字の区別がないシステム用の設定:
"   (例: DOS/Windows/MacOS)
"
if filereadable($VIM . '/vimrc') && filereadable($VIM . '/ViMrC')
  " tagsファイルの重複防止
  set tags=./tags,tags
endif

" コンソールでのカラー表示のための設定(暫定的にUNIX専用)
if has('unix') && !has('gui_running')
  let uname = system('uname')
  if uname =~? "linux"
    set term=builtin_linux
  elseif uname =~? "freebsd"
    set term=builtin_cons25
  elseif uname =~? "Darwin"
    set term=beos-ansi
  else
    set term=builtin_xterm
  endif
  unlet uname
endif

" コンソール版で環境変数$DISPLAYが設定されていると起動が遅くなる件へ対応
if !has('gui_running') && has('xterm_clipboard')
  set clipboard=exclude:cons\\\|linux\\\|cygwin\\\|rxvt\\\|screen
endif

" タブページの切り替えをWindowsのように
" CTRL+Tab SHIFT+Tabで行うように.
if v:version >= 700
  nnoremap <C-Tab>   gt
  nnoremap <C-S-Tab> gT
endif

try
  let s:plugins = map(filter(neobundle#config#get_neobundles(), 'isdirectory(v:val.path) && neobundle#config#is_sourced(v:val.name)'), 'v:val.name')
catch
  let s:plugins = []
endtry

function! s:has_plugin(...)
  return len(filter(copy(a:000), 'index(s:plugins, v:val) >= 0')) == len(a:000)
endfunction

set nocompatible
filetype off

if has('vim_starting')
  set runtimepath+=~/.vim/neobundle.vim.git

  call neobundle#rc(expand('~/.bundle'))
endif


NeoBundle 'Shougo/echodoc.git'
NeoBundle 'Shougo/neocomplcache.git'
NeoBundle 'Shougo/neobundle.vim.git'
NeoBundle 'Shougo/unite.vim.git'
NeoBundle 'Shougo/vimfiler.git'
NeoBundle 'Shougo/vimshell.git'

NeoBundle 'Shougo/vimproc'
NeoBundle 'thinca/vim-quickrun'
NeoBundle 'tsukkee/lingr-vim'
NeoBundle 'Shougo/neosnippet'
NeoBundle 'browser.vim'
NeoBundle 'synmark.vim'
NeoBundle 'tyru/open-browser.vim'
NeoBundle 'mattn/gist-vim'
NeoBundle 'mattn/webapi-vim'
NeoBundle 'mru.vim'
NeoBundle 'thinca/vim-ft-clojure'
NeoBundle 'ujihisa/neco-ghc'
NeoBundle 'sudo.vim'
NeoBundle 'ujihisa/vimshell-ssh'
NeoBundle 'Shougo/unite-ssh'
"NeoBundle 'tyru/skkdict.vim'
"NeoBundle 'tyru/eskk.vim'
NeoBundle 'ujihisa/neco-look'
NeoBundle 'vim-jp/vital.vim'
NeoBundle 'dag/vim2hs'
NeoBundle 'eagletmt/ghcmod-vim'

NeoBundle 'git://vim-latex.git.sourceforge.net/gitroot/vim-latex/vim-latex'

filetype plugin indent on

set ww+=h,l,>,<,[,]
set mouse=a
set ttymouse=xterm2
set clipboard+=unnamed

if s:has_plugin('VimShell')
  " ,is: シェルを起動
  nnoremap <silent> ,is :VimShell<CR>
  " ,ipy: pythonを非同期で起動
  nnoremap <silent> ,ipy :VimShellInteractive python<CR>
  " ,irb: irbを非同期で起動
  nnoremap <silent> ,irb :VimShellInteractive irb<CR>
  " ,ss: 非同期で開いたインタプリタに現在の行を評価させる
  vmap <silent> ,ss :VimShellSendString<CR>
  " 選択中に,ss: 非同期で開いたインタプリタに選択行を評価させる
  nnoremap <silent> ,ss <S-v>:VimShellSendString<CR>
endif

if s:has_plugin('neocomplcache')
  let g:neocomplcache_enable_at_startup = 1

  "tabで補完候補の選択を行う
  inoremap <expr><TAB> pumvisible() ? "\<Down>" : "\<TAB>"
  inoremap <expr><S-TAB> pumvisible() ? "\<Up>" : "\<S-TAB>"
endif

if s:has_plugin('openbrower.vim')
  nmap gx <Plug>(openbrowser-smart-search)
  vmap gx <Plug>(openbrowser-smart-search)
endif

augroup plugin-lingr-vim
  autocmd!
  autocmd FileType lingr-messages nmap <silent> <buffer> t <Plug>(lingr-messages-show-say-buffer)
  autocmd FileType lingr-say let &syntax='clojure'
augroup END

augroup vimrc
    autocmd!
augroup END

function! s:SID_PREFIX()
    return matchstr(expand('<sfile>'), '<SNR>\d\+_')
endfunction

set titlelen=100
set guioptions-=e

autocmd vimrc BufEnter * let &titlestring = '%{' . s:SID_PREFIX() . 'titlestring()}'
autocmd vimrc User plugin-lingr-unread let &titlestring = '%{' . s:SID_PREFIX() . 'titlestring()}'

if exists('$TMUX') || exists('$WINDOW')
    set t_ts=k
    set t_fs=\
endif

function! s:titlestring()
    if &filetype =~ '^lingr'
        let &titlestring = 'lingr: ' . lingr#unread_count()
    else
        let &titlestring = bufname('')
    endif
endfunction

" tabline
set showtabline=2 " always show tabline
let &tabline = '%!' . s:SID_PREFIX() . 'tabline()'

function! s:tabline()
    " show each tab
    let s = ''
    for i in range(1, tabpagenr('$'))
        let list = tabpagebuflist(i)
        let nr = tabpagewinnr(i)
        let current_tabnr = tabpagenr()

        "let title = bufname('') 
        if i == current_tabnr
            let title = fnamemodify(getcwd(), ':t') . '/'
            "let title = bufname('')
        else
            let title = fnamemodify(gettabvar(i, 'cwd'), ':t') . '/'
        endif
        let title = empty(title) ? '[No Name]' : title
        let s .= i == current_tabnr ? '%#TabLineSel#' : '%#TabLine#'
        let s .= '%' . i . 'T[' . i . '] ' . title
        let s .= '  '
    endfor

    " show lingr unread count
    let lingr_unread = ""
    if exists('*lingr#unread_count')
        let lingr_unread_count = lingr#unread_count()
        if lingr_unread_count > 0
            let lingr_unread = "%#ErrorMsg#(" . lingr_unread_count . ")"
        elseif lingr_unread_count == 0
            let lingr_unread = "()"
        endif
    endif
    " build tabline
    let s .= '%#TabLineFill#%T%=%<[' . getcwd() . ']' . lingr_unread
    return s
endfunction

let g:github_user = 'raa0121'
let g:github_token = 'e3ded9cf6669cc31dbca'

if s:has_plugin('eskk.vim')
  let g:eskk#directory = "~/.eskk"
  let g:eskk#dictionary = { 'path': "~/.skk-jisyo", 'sorted': 0, 'encoding': 'utf-8', }
  let g:eskk#large_dictionary = { 'path': "~/.eskk/SKK-JISYO.L", 'sorted': 1, 'encoding': 'euc-jp', }
  let g:eskk#enable_completion = 1
endif

if s:has_plugin('vim-latex')
  set shellslash
  set grepprg=grep\ -nH\ $*
  let g:tex_flavor='tex'
  let g:Tex_CompileRule_div = 'platex --interaction=nonstopmode $*'
  let g:Tex_BibtexFlavor = 'jbibtex'
  let g:Tex_ViewRule_dvi = '/cygdrive/c/texlive/2012/bin/win32/dviout.exe'
  let g:Tex_FormatDependency_pdf = 'dvi,pdf'
  let g:Tex_CompileRule_pdf = 'dvipdfmx $*.dvi'
  let g:Tex_ViewRule_pdf = '/cygdrive/d/Program/SumatraPDF/SumatraPDF.exe'
endif
" set imdisable
