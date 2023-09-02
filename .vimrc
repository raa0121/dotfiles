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
set ambiwidth=double
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
let s:dein_dir = '~/.cache/dein'
" dein.vim 本体
let s:dein_repo_dir = expand(s:dein_dir . '/repos/github.com/Shougo/dein.vim')
" dein.vim がなければ github から落としてくる
if &runtimepath !~# '/dein.vim'
  if !isdirectory(s:dein_repo_dir)
    execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
  endif
  execute 'set runtimepath^=' . s:dein_repo_dir
endif

" 設定開始
if dein#load_state(expand(s:dein_dir))
  call dein#begin(expand(s:dein_dir))

  " プラグインリストを収めた TOML ファイル
  " 予め TOML ファイル（後述）を用意しておく
  let g:rc_dir    = '~/dotfiles'
  let s:toml      = expand(g:rc_dir . '/dein.toml')
  let s:lazy_toml = expand(g:rc_dir . '/dein_lazy.toml')
  let s:ddc_toml  = expand(g:rc_dir . '/dein_ddc.toml')
  let s:ddu_toml  = expand(g:rc_dir . '/dein_ddu.toml')

  " TOML を読み込み、キャッシュしておく
  call dein#load_toml(s:toml,      {'lazy': 0})
  call dein#load_toml(s:lazy_toml, {'lazy': 1})
  call dein#load_toml(s:ddc_toml, {'lazy': 1})
  call dein#load_toml(s:ddu_toml, {'lazy': 1})

  " 設定終了
  call dein#end()
  call dein#save_state()
endif

filetype plugin indent on
syntax enable

" もし、未インストールものものがあったらインストール
if dein#check_install()
  call dein#install()
endif


if has('clientserver') && dein#tap('vim-singleton')
  call singleton#enable()
endif

set ww+=h,l,>,<,[,]
if !has('nvim')
  set ttymouse=xterm2
  set clipboard=unnamed
endif

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
nnoremap <silent> ,vr :tabnew ~/dotfiles/.vimrc<CR>:lcd<CR>
nnoremap <silent> ,de :tabnew ~/dotfiles/dein.toml<CR>:lcd<CR>
nnoremap <silent> ,dl :tabnew ~/dotfiles/dein_lazy.toml<CR>:lcd<CR>
nnoremap <silent> ,so :so ~/.vimrc<CR>
nnoremap <silent> ,cw :cwindow<CR>
nnoremap <Esc><Esc> <Cmd>:nohlsearch<CR><ESC><Cmd>:silent! HierStop<CR><ESC>
nnoremap <silent> ,ts :<C-u>tab stj <C-R>=expand('<cword>')<CR><CR>
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)


"let g:vimfiler_as_default_explorer = 1
"let g:vimfiler_safe_mode_by_default = 0

"let g:neocomplcache#sources#rsense#home_directory = '/opt/rsense-0.3/'

let g:monster#completion#rcodetools#backend = 'async_rct_complete'

let g:neosnippet#snippets_directory = '~/.vim/snippet,~/.cache/dein/honza/vim-snippets/snippets'

let g:pdv_template_dir = $HOME . "/.hariti/bundle/pdv/templates_snip"

"tabで補完候補の選択を行う
imap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
imap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<S-TAB>"
if dein#tap('neosnippet')
  imap <expr><CR> neosnippet#expandable_or_jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<CR>"
  smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
  \ "\<Plug>(neosnippet_expand_or_jump)"
  \: "\<TAB>"
endif
inoremap <buffer> <C-P> <ESC>:call pdv#DocumentWithSnip()<CR>i
nnoremap <buffer> <C-P> :call pdv#DocumentWithSnip()<CR>
if dein#tap('deoppet.nvim')
  call deoppet#initialize()
  call deoppet#custom#option('snippets_dirs',
  \ globpath(&runtimepath, 'neosnippets', 1, 1))
  imap <C-k>  <Plug>(deoppet_expand)
  imap <C-f>  <Plug>(deoppet_jump_forward)
  imap <C-b>  <Plug>(deoppet_jump_backward)
  smap <C-f>  <Plug>(deoppet_jump_forward)
  smap <C-b>  <Plug>(deoppet_jump_backward)
endif

if dein#tap('fern.vim')
  let g:fern#renderer = 'nerdfont'
endif

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
  autocmd FileType denite call s:denite_my_settings()
  function! s:denite_my_settings() abort
    if b:denite.buffer_name == 'search-buffer'
      nnoremap <silent><buffer><expr> <CR>
      \ denite#do_map('do_action', 'tabopen', '<cwords>')
    endif
  endfunction
  autocmd User lsp_buffer_enabled ++nested ++once call s:vista()
  function s:vista() abort
    call dein#source('vista.vim')
    Vista vim_lsp
  endfunction
augroup END


let g:netrw_nogx = 1
nmap gx <Plug>(openbrowser-smart-search)
vmap gx <Plug>(openbrowser-smart-search)

let g:Vimphpcs_Phpcscmd = expand('~/.config/composer/vendor/bin/phpcs')

let g:quickrun_config = {}

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

let g:quickrun_config['markdown'] = {
  \ 'outputter': 'browser'
  \}
let g:quickrun_config['ruby'] = {
  \ 'command': 'ruby',
  \ 'exec': '/usr/bin/env ruby %s',
  \ 'tempfile': '{tempname()}.rb'
  \}
let g:quickrun_config['clojure/neoclojure'] = {
  \ 'type' : 'clojure/neoclojure',
  \ 'runner' : 'neoclojure',
  \ 'command' : 'dummy',
  \ 'tempfile' : '%{tempname()}.clj'
  \}
let g:quickrun_config['cpp/gcc']= {
  \ 'cmdopt': '-std=c++1y -Wall'
  \ }
let g:watchdogs_check_BufWritePost_enable = 1
let g:watchdogs_check_BufWritePost_enables = {
  \   'cpp' : 0,
  \   'php' : 1,
  \ }
let g:watchdogs_check_CursorHold_enable = 1
let g:watchdogs_check_CursorHold_enables = {
  \   'cpp' : 0,
  \   'php' : 1,
  \ }

if dein#tap('watchdocs.vim')
  call watchdogs#setup(g:quickrun_config)
endif

let g:conoline_auto_enable = 1

if dein#tap('vim-textobj-user')
  call textobj#user#plugin('datetime', {
  \   'date': {
  \     'pattern': '\<\d\d\d\d-\d\d-\d\d\>',
  \     'select': ['ad', 'id'],
  \   },
  \   'time': {
  \     'pattern': '\<\d\d:\d\d:\d\d\>',
  \     'select': ['at', 'it'],
  \   },
  \ })
endif


set diffexpr=unified_diff#diffexpr()

" configure with the followings (default values are shown below)
let g:unified_diff#executable = 'git'
let g:unified_diff#arguments = [
\   'diff', '--no-index', '--no-color', '--no-ext-diff', '--unified=0',
\ ]
let g:unified_diff#iwhite_arguments = [
\   '--ignore--all-space',
\ ]

let g:nyancat_offset = 24

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

let g:lightline = {
\ 'colorscheme': 'wombat',
\ 'active': {
\   'left': [
\     ['mode', 'paste'],
\     ['fugitive', 'gitgutter', 'filename', 'method'],
\   ],
\   'right': [
\     ['lineinfo', 'syntastic'],
\     ['percent'],
\     ['charcode', 'fileformat', 'fileencoding', 'filetype'],
\   ]
\ },
\ 'component_function': {
\   'modified': 'MyModified',
\   'readonly': 'MyReadonly',
\   'fugitive': 'MyFugitive',
\   'filename': 'MyFilename',
\   'fileformat': 'MyFileformat',
\   'filetype': 'MyFiletype',
\   'fileencoding': 'MyFileencoding',
\   'mode': 'MyMode',
\   'syntastic': 'SyntasticStatuslineFlag',
\   'charcode': 'MyCharCode',
\   'gitgutter': 'MyGitGutter',
\   'method' : 'MyMethod',
\ },
\ 'separator': { 'left': "\ue0c0", 'right': "\ue0c2" },
\ 'subseparator': { 'left': "\ue0c1", 'right': "\ue0c3" }
\ }


function! MyModified()
  return &ft =~? 'help\|vimfiler\|gundo' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! MyReadonly()
  return &ft !~? 'help\|vimfiler\|gundo' && &ro ? '\u2b64' : ''
endfunction

function! MyFilename()
  return ('' !=? MyReadonly() ? MyReadonly() . ' ' : '') .
        \ (&ft ==? 'vimfiler' ? vimfiler#get_status_string() :
        \  &ft ==? 'unite' ? unite#get_status_string() :
        \  &ft ==? 'vimshell' ? substitute(b:vimshell.current_dir,expand('~'),'~','') :
        \ '' !=? expand('%:t') ? expand('%:t') : '[No Name]') .
        \ ('' !=? MyModified() ? ' ' . MyModified() : '')
endfunction

function! MyFugitive()
  try
    if &ft !~? 'vimfiler\|gundo' && exists('*fugitive#head')
      let l:_ = fugitive#head()
      return strlen(l:_) ? '⭠ '. l:_ : ''
    endif
  catch
  endtry
  return ''
endfunction

function! MyFileformat()
  return winwidth('.') > 70 ? &fileformat : ''
endfunction

function! MyFiletype()
  return winwidth('.') > 70 ? (strlen(&filetype) ? &filetype : 'no ft') : ''
endfunction

function! MyFileencoding()
  return winwidth('.') > 70 ? (strlen(&fenc) ? &fenc : &enc) : ''
endfunction

function! MyMode()
  return winwidth('.') > 60 ? lightline#mode() : ''
endfunction

function! MyGitGutter()
  if ! exists('*GitGutterGetHunkSummary')
        \ || ! get(g:, 'gitgutter_enabled', 0)
        \ || winwidth('.') <= 90
    return ''
  endif
  let l:symbols = [
        \ g:gitgutter_sign_added . ' ',
        \ g:gitgutter_sign_modified . ' ',
        \ g:gitgutter_sign_removed . ' '
        \ ]
  let l:hunks = GitGutterGetHunkSummary()
  let l:ret = []
  for l:i in [0, 1, 2]
    if l:hunks[l:i] > 0
      call add(l:ret, l:symbols[l:i] . l:hunks[l:i])
    endif
  endfor
  return join(l:ret, ' ')
endfunction

function MyMethod()
  return get(b:, 'vista_nearest_method_or_function', '')
endfunction

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

let g:github_user = 'raa0121'

let g:github#user = 'raa0121'

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

let g:denops#server#service#deno_args = [
\ '-q',
\ '--unstable',
\ '-A',
\]
let g:lsp_log_verbose = 1
let g:lsp_log_file = expand('~/vim-lsp.log')
let g:denops_server_addr = '127.0.0.1:32123'
