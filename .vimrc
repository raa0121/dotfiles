" coding:utf-8
" ζ*'ヮ')ζ ζ(*'ヮ'リ+
"
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
set shiftwidth=4
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

if has('+regexpengine')
  set re=0
endif

set nocompatible
filetype off

if has('vim_starting')
  set runtimepath+=~/.vim/neobundle.vim.git

endif
call neobundle#rc(expand('~/.bundle'))

NeoBundle 'Shougo/echodoc', '', 'default'
call neobundle#config('echodoc', {
  \ 'lazy' : 1,
  \ 'autoload' : {
  \ 'insert' : 1,
  \ }})
NeoBundle 'Shougo/neocomplcache', '', 'default'
call neobundle#config('neocomplcache', {
  \ 'lazy' : 1,
  \ 'autoload' : {
  \ 'commands' : 'NeoComplCacheEnable',
  \ }})
NeoBundle 'Shougo/neocomplcache-rsense', '', 'default'
call neobundle#config('neocomplcache-rsense', {
  \ 'lazy' : 1,
  \ 'depends' : 'Shougo/neocomplcache',
  \ 'autoload' : { 'filetypes' : 'ruby' }
  \ })
NeoBundle 'Shougo/neobundle.vim'
NeoBundle 'Shougo/unite.vim', '', 'default'
call neobundle#config('unite.vim',{
  \ 'lazy' : 1,
  \ 'autoload' : {
  \ 'commands' : [{ 'name' : 'Unite',
  \                 'complete' : 'customlist,unite#complete_source'},
  \                 'UniteWithCursorWord', 'UniteWithInput']
  \ }})
NeoBundle 'Shougo/vimfiler', '', 'default'
call neobundle#config('vimfiler', {
  \ 'lazy' : 1,
  \ 'depends' : 'Shougo/unite.vim',
  \ 'autoload' : {
  \     'commands' : [
  \                   { 'name' : 'VimFiler',
  \                     'complete' : 'customlist,vimfiler#complete' },
  \                   { 'name' : 'VimFilerExplorer',
  \                     'complete' : 'customlist,vimfiler#complete' },
  \                   { 'name' : 'Edit',
  \                     'complete' : 'customlist,vimfiler#complete' },
  \                   { 'name' : 'Write',
  \                     'complete' : 'customlist,vimfiler#complete' },
  \                   'Read', 'Source'],
  \     'mappings' : ['<Plug>(vimfiler_switch)'],
  \     'explorer' : 1,
  \ }
  \ })
NeoBundle 'Shougo/vimshell', '', 'default'
call neobundle#config('vimshell', {
  \ 'lazy' : 1,
  \ 'autoload' : {
  \     'commands' : [{ 'name' : 'VimShell',
  \                     'complete' : 'customlist,vimshell#complete'},
  \                     'VimShellExecute', 'VimShellInteractive',
  \                     'VimShellTerminal', 'VimShellPop'],
  \     'mappings' : ['<Plug>(vimshell_switch)']
  \ }})
NeoBundle 'Shougo/vimproc', '', 'default'
call neobundle#config('vimproc', {
  \ 'build' : {
  \     'windows' : 'make -f make_mingw32.mak',
  \     'cygwin' : 'make -f make_cygwin.mak',
  \     'mac' : 'make -f make_mac.mak',
  \     'unix' : 'make -f make_unix.mak',
  \   },
  \ })
NeoBundleLazy 'thinca/vim-quickrun', { 'autoload' : {
  \ 'mappings' : [
  \   ['nxo', '<Plug>(quickrun)']],
  \ }}
NeoBundle 'tsukkee/lingr-vim'
call neobundle#config('lingr-vim', {
  \ 'lazy' : 1,
  \ 'autoload' : {
  \   'commands' : 'LingrLaunch',
  \ },
  \ })
NeoBundle 'Shougo/neosnippet', '', 'default'
call neobundle#config('neosnippet', {
  \ 'lazy' : 1,
  \ 'autoload' : {
  \ 'insert' : 1,
  \ 'filetypes' : 'snippet',
  \ 'unite_sources' : ['snippet', 'neosnippet/user', 'neosnippet/runtime'],
  \ }})
NeoBundle 'browser.vim'
NeoBundle 'synmark.vim'
NeoBundleLazy 'tyru/open-browser.vim', { 'autoload' : {
  \ 'mappings' : '<Plug>(open-browser-wwwsearch)',
  \ }}
NeoBundle 'mattn/gist-vim'
NeoBundle 'mattn/webapi-vim'
NeoBundle 'mru.vim'
NeoBundle 'thinca/vim-ft-clojure'
NeoBundleLazy 'ujihisa/neco-ghc', { 'autoload' : {
  \ 'filetypes' : 'haskell',
  \ }}
NeoBundle 'sudo.vim'
NeoBundleLazy 'ujihisa/vimshell-ssh', { 'autoload' : {
  \ 'filetypes' : 'vimshell',
  \ }}
NeoBundle 'Shougo/unite-ssh'
NeoBundle 'ujihisa/neco-look'
NeoBundle 'vim-jp/vital.vim', '', 'default'
call neobundle#config('vital.vim', {
  \ 'lazy' : 1,
  \ 'autoload' : {
  \   'commands' : ['Vitalize'],
  \ }})
NeoBundleLazy 'dag/vim2hs', { 'autoload' : {
  \ 'filetypes' : 'haskell',
  \ }}
NeoBundleLazy 'eagletmt/ghcmod-vim', { 'autoload' : {
  \ 'filetypes' : 'haskell',
  \ }}
NeoBundle 'thinca/vim-ref'

NeoBundle 'thinca/vim-singleton'
NeoBundle 'mattn/benchvimrc-vim'
NeoBundle 'ryutorion/vim-itunes'
NeoBundle 'raa0121/vim-ulilith'
NeoBundle 'mattn/libcallex-vim'
NeoBundle 'thinca/vim-splash'
NeoBundle 'mattn/sonictemplate-vim'
NeoBundle 'raa0121/vim-eclim'
NeoBundle 'thinca/vim-github'
NeoBundle 'nosami/Omnisharp'
NeoBundle 'jceb/vim-orgmode'

"NeoBundle 'Lokaltog/powerline', { 'rtp' : 'powerline/bindings/vim'}
"NeoBundle 'taichouchou2/alpaca_powertabline'
"NeoBundle 'zhaocai/linepower.vim'

NeoBundle 'osyo-manga/quickrun-hook-u-nya-'
NeoBundle 'osyo-manga/unite-quickfix'
NeoBundle 'basyura/J6uil.vim', '', 'default'
call neobundle#config('J6uil.vim', {
  \ 'lazy' : 1,
  \ 'autoload' : {
  \   'commands' : 'J6uil',
  \ },
  \ 'depends' : 'mattn/webapi-vim',
  \ })
NeoBundle 'mattn/unite-rhythmbox'
NeoBundleLazy 'rbtnn/vimconsole.vim', {
  \ 'depends' : 'thinca/vim-prettyprint',
  \ 'autoload' : {
  \   'commands' : 'VimConsoleOpen'
  \ }}

filetype plugin indent on
if has('clientserver')
  call singleton#enable()
end

set ww+=h,l,>,<,[,]
set mouse=a
set ttymouse=xterm2
set clipboard=unnamedplus

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
" ,vs: vimshell
nnoremap <silent> ,vs :tabnew +VimShell<CR>
" ,vr: .vimrc
nnoremap <silent> ,vr :tabnew ~/.vimrc<CR>
nnoremap <silent> ,so :so ~/.vimrc<CR>
nnoremap <silent> ,nu :tabnew +Unite\ neobundle/update<CR>
nnoremap <silent> ,ll :tabnew +LingrLaunch<CR>
nnoremap <Esc><Esc> :nohlsearch<CR><ESC>
" Disable AutoComplPop. Comment out this line if AutoComplPop is not
" installed.
let g:acp_enableAtStartup = 0
" Launches neocomplcache automatically on vim startup.
let g:neocomplcache_enable_at_startup = 1
" Use smartcase.
let g:neocomplcache_enable_smart_case = 1
" Use camel case completion.
let g:neocomplcache_enable_camel_case_completion = 1
" Use underscore completion.
let g:neocomplcache_enable_underbar_completion = 1
" Sets minimum char length of syntax keyword.
let g:neocomplcache_min_syntax_length = 3

let g:vimfiler_as_default_explorer = 1

let g:neocomplcache#sources#rsense#home_directory = '/opt/rsense-0.3/'

let g:neocomplcache_text_mode_filetypes = {
\  'tex': 1,
\  'plaintex': 1,
\} 

"tabで補完候補の選択を行う
inoremap <expr><TAB> pumvisible() ? "\<Down>" : "\<TAB>"
inoremap <expr><S-TAB> pumvisible() ? "\<Up>" : "\<S-TAB>"

let g:OmniSharp_host = 'http://localhost:2020'
let g:OmniSharp_typeLookupInPreview = 1
setlocal omnifunc=OmniSharp#Complete
set noshowmatch


let g:netrw_nogx = 1
nmap gx <Plug>(openbrowser-smart-search)
vmap gx <Plug>(openbrowser-smart-search)

let g:quickrun_config = {}
let g:quickrun_config['markdown'] = {
  \ 'outputter': 'browser'
\ }
let g:quickrun_config.ruby = {
  \ 'command': 'ruby',
  \ 'exec': '/usr/bin/env ruby %s',
  \ 'tempfile': '{tempname()}.rb'
\ }
let g:quickrun_config = {
  \ '_' : {
    \ 'hook/close_unite_quickfix/enable_hook_loaded' : 1,
    \ 'hook/unite_quickfix/enable_failure' : 1,
    \ 'hook/close_quickfix/enable_exit' : 1,
    \ 'hook/close_buffer/enable_failure' : 1,
    \ 'hook/close_buffer/enable_empty_data' : 1,
    \ 'outputter' : 'multi:buffer:quickfix',
    \ 'hook/u_nya_/enable' : 1,
    \ 'hook/sweep/enable' : 0,
    \ 'outputter/buffer/split' : ':botright 15sp',
    \ 'outputter/buffer/running_mark' : 'ﾊﾞﾝ（∩`･ω･）ﾊﾞﾝﾊﾞﾝﾊﾞﾝﾊﾞﾝﾞﾝ',
    \ 'runner' : 'vimproc',
    \ 'runner/vimproc/updatetime' : 40,
    \ 'runner/vimproc/sleep' : 0,
  \ }
\ }

let g:lingr_vim_user = 'raa0121'
let g:J6uil_display_offline  = 0
let g:J6uil_display_online   = 0
let g:J6uil_echo_presence    = 1
let g:J6uil_display_icon     = 0
let g:J6uil_display_interval = 0
let g:J6uil_updatetime       = 1000

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

let g:github#user = 'raa0121'
