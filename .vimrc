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
set nrformats+=alpha
colorscheme elflord
syntax on
set enc=utf8
set updatetime=200

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

filetype off

if has('vim_starting')
  set runtimepath+=~/.vim/neobundle.vim.git

endif
call neobundle#rc(expand('~/.bundle'))

let g:neobundle_default_git_protocol='https'

NeoBundleFetch 'Shougo/neobundle.vim'

NeoBundle 'mattn/flappyvird-vim'

NeoBundle 'kamichidu/vim-vdbc', '', 'default'
call neobundle#config('vim-vdbc', {
\   'depends' : ['Shougo/vimproc'] ,
\   'build': {
\       'unix' :    'make -f Makefile',
\       'windows' : 'make -f Makefile.w64'
\   }
\})
NeoBundle 'tyru/kirikiri.vim'
NeoBundle 'yoppi/fluentd.vim'
NeoBundle 'Shougo/neomru.vim'
NeoBundle 'thinca/vim-threes'

NeoBundle 'jdonaldson/vaxe', '', 'default'
call neobundle#config('vaxe', {
\ 'lazy': 1,
\ 'autoload' : {'filetypes': 'haxe'}
\})

NeoBundle 'vim-jp/vimdoc-ja'
NeoBundle 'itchyny/calendar.vim'

NeoBundle 'fuenor/qfixhowm', '', 'default'
call neobundle#config('qfixhowm', {
  \ 'rev': '5bad8770a6d2ffd2e93182d937710ad6e3fe769f'
  \ })
NeoBundle 'osyo-manga/unite-qfixhowm'
call neobundle#config('unite-qfixhowm', {
  \ 'lazy' : 1,
  \ 'autoload' : { 'unite_sources' : ['qfixhowm', 'qfixhowm/new']},
  \ 'depends' : ['Shougo/unite.vim', 'fuenor/qfixhowm']
  \ })
NeoBundle 'thinca/vim-prettyprint'
call neobundle#config('vim-prettyprint', {
  \ 'lazy' : 1,
  \ 'autoload' : { 'commands' : ['PP', 'PrettyPrint']}
  \ })
NeoBundle 'jnwhiteh/vim-golang'
call neobundle#config('vim-golang', {
  \ 'lazy' : 1,
  \ 'autoload' : { 'filetypes' : 'go'}
  \ })
NeoBundle 'osyo-manga/vim-snowdrop'
call neobundle#config('vim-snowdrop', {
  \ 'lazy' : 1,
  \ 'autoload' : { 'filetypes' : 'cpp' }
  \ })
NeoBundle 'osyo-manga/vim-reunions'
NeoBundle 'osyo-manga/vim-marching'
call neobundle#config('vim-marching', {
  \ 'depends' : ['Shougo/vimproc', 'osyo-manga/vim-reunions']
  \ })
NeoBundle 'Shougo/echodoc', '', 'default'
call neobundle#config('echodoc', {
  \ 'lazy' : 1,
  \ 'autoload' : {
  \ 'insert' : 1,
  \ }})
if has('lua')
  NeoBundle 'Shougo/neocomplete.vim', '', 'default'
else
  NeoBundle 'Shougo/neocomplcache', '', 'default'
endif
"NeoBundle 'Shougo/neocomplcache-rsense', '', 'default'
"call neobundle#config('neocomplcache-rsense', {
"  \ 'lazy' : 1,
"  \ 'depends' : 'Shougo/neocomplcache',
"  \ 'autoload' : { 'filetypes' : 'ruby' }
"  \ })
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
if has('win32')
    NeoBundleLocal 'C:\vim\plugin'
else
  NeoBundle 'Shougo/vimproc', '', 'default'
  call neobundle#config('vimproc', {
    \ 'build' : {
    \     'windows' : 'make -f make_mingw32.mak',
    \     'cygwin' : 'make -f make_cygwin.mak',
    \     'mac' : 'make -f make_mac.mak',
    \     'unix' : 'make -f make_unix.mak',
    \   },
    \ })
endif
NeoBundle 'thinca/vim-quickrun' 
call neobundle#config('vim-quickrun', {
  \ 'lazy' : 1,
  \ 'autoload' : {
  \   'mappings' : [
  \     ['nxo', '<Plug>(quickrun)']],
  \   'commands' : 'QuickRun',
  \ },
  \ })
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
NeoBundle 'Shougo/neosnippet-snippets', '', 'default'
call neobundle#config('neosnippet-snippets', {
  \ 'depends' : 'Shougo/neosnippet'
  \ })
NeoBundle 'tyru/open-browser.vim'
call neobundle#config('open-browser.vim',{
  \ 'lazy' : 1,
  \ 'autoload' : {
  \ 'mappings' : '<Plug>(open-browser-wwwsearch)',
  \ }})
NeoBundle 'mattn/gist-vim'
call neobundle#config('gist-vim', {
  \ 'lazy' : 1,
  \ 'autoload' : { 'commands' : 'Gist' }
  \ })
NeoBundle 'mattn/webapi-vim'
NeoBundle 'thinca/vim-ft-clojure'
call neobundle#config('vim-ft-clojure', {
  \ 'lazy' : 1,
  \ 'autoload' : { 'filetypes' : 'clojure' }
  \ })
NeoBundle 'ujihisa/neco-ghc'
call neobundle#config('neco-ghc', {
  \ 'lazy' : 1,
  \ 'autoload' : { 'filetypes' : 'haskell' }
  \ })
NeoBundle 'sudo.vim'
NeoBundle 'ujihisa/vimshell-ssh'
call neobundle#config('vimshell-ssh',{
  \ 'lazy' : 1,
  \ 'autoload' : { 'filetypes' : 'vimshell'}
  \ })
NeoBundle 'Shougo/unite-ssh'
call neobundle#config('unite-ssh', {
  \ 'lazy' : 1,
  \ 'autoload' : { 'unite_sources' : 'ssh' }
  \ })
NeoBundle 'ujihisa/neco-look'
NeoBundle 'vim-jp/vital.vim', '', 'default'
call neobundle#config('vital.vim', {
  \ 'lazy' : 1,
  \ 'autoload' : {
  \   'commands' : ['Vitalize'],
  \   'functions' : ['vital#of', 'vital']
  \ }})
NeoBundle 'dag/vim2hs'
call neobundle#config ('vim2hs', {
  \ 'lazy' : 1,
  \ 'autoload' : { 'filetypes' : 'haskell' }
  \})
NeoBundle 'eagletmt/ghcmod-vim'
call neobundle#config('ghcmod-vim', {
  \ 'lazy' : 1,
  \ 'autoload' : { 'filetypes' : 'haskell' }
  \ })
NeoBundle 'thinca/vim-ref'

NeoBundle 'thinca/vim-singleton'
NeoBundle 'mattn/benchvimrc-vim'
call neobundle#config('benchvimrc-vim', {
  \ 'lazy' : 1,
  \ 'autoload' : { 'commands' : 'BenchVimrc' }
  \ })
NeoBundle 'ryutorion/vim-itunes'
NeoBundle 'raa0121/vim-ulilith'
NeoBundle 'mattn/libcallex-vim'
NeoBundle 'thinca/vim-splash'
NeoBundle 'mattn/sonictemplate-vim'
call neobundle#config('sonictemplate-vim', {
  \ 'lazy' : 1,
  \ 'autoload' : { 'commands' : 'Template' }
  \ })
NeoBundle 'thinca/vim-github'
call neobundle#config('vim-github', {
  \ 'lazy' : 1,
  \ 'autoload' : { 'commands' : 'Github' }
  \ })
NeoBundle 'jceb/vim-orgmode'
call neobundle#config('vim-orgmode', {
  \ 'lazy' : 1,
  \ 'autoload' : { 'filetypes' : 'org' }
  \ })


NeoBundle 'itchyny/lightline.vim'


NeoBundle 'osyo-manga/quickrun-hook-u-nya-'
" call neobundle#config('quickrun-hook-u-nya-', {
"  \ 'lazy' : 1,
"  \ 'depends' : 'thinca/quickrun'
"  \ })
NeoBundle 'osyo-manga/unite-quickfix'
call neobundle#config('unite-quickfix', {
  \ 'lazy' : 1,
  \ 'autoload' : { 'unite_sources' : ['quickfix', 'location_list']},
  \ 'depends' : 'Shougo/unite.vim'
  \ })
NeoBundle 'basyura/J6uil.vim', '', 'default'
call neobundle#config('J6uil.vim', {
  \ 'lazy' : 1,
  \ 'autoload' : { 'commands' : 'J6uil' },
  \ 'depends' : 'mattn/webapi-vim',
  \ })
NeoBundle 'mattn/unite-rhythmbox'
call neobundle#config('unite-rhythmbox', {
  \ 'lazy' : 1,
  \ 'autoload' : { 'unite_sources' : 'rhythmbox' },
  \ 'depends' : 'Shougo/unite.vim'
  \ })
NeoBundle 'rbtnn/vimconsole.vim'
call neobundle#config('vimconsole.vim', {
  \ 'depends' : 'thinca/vim-prettyprint',
  \ 'autoload' : { 'commands' : 'VimConsoleOpen' }
  \ })

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
nnoremap <silent> ,vr :tabnew ~/.vimrc<CR>:lcd<CR>
nnoremap <silent> ,so :so ~/.vimrc<CR>
nnoremap <silent> ,nu :tabnew +Unite\ neobundle/update<CR>
nnoremap <silent> ,ll :tabnew +LingrLaunch<CR>
nnoremap <Esc><Esc> :nohlsearch<CR><ESC>

if neobundle#is_installed('neocomplcache')
  let g:neocomplcache_enable_at_startup = 1
  let g:neocomplcache_enable_smart_case = 1
  let g:neocomplcache_enable_camel_case_completion = 1
  let g:neocomplcache_enable_underbar_completion = 1
  let g:neocomplcache_min_syntax_length = 3
  let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'
  if !exists('g:neocomplcache_keyword_patterns')
    let g:neocomplcache_keyword_patterns = {}
  endif
  let g:neocomplcache_keyword_patterns['default'] = '\h\w*'
endif

if neobundle#is_installed('neocomplete.vim')
  let g:neocomplete#enable_at_startup = 1
  let g:neocomplete#enable_smart_case = 1
  let g:neocomplete#enable_camel_case_completion = 1
  let g:neocomplete#enable_underbar_completion = 1
  let g:neocomplete#min_syntax_length = 3
  let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'
  if !exists('g:neocomplete#keyword_patterns')
      let g:neocomplete#keyword_patterns = {}
  endif
  let g:neocomplete#keyword_patterns['default'] = '\h\w*'
  if !exists('g:neocomplete#force_omni_input_patterns')
    let g:neocomplete#force_omni_input_patterns = {}
  endif
  if !exists('g:neocomplete#sources#omni#input_patterns')
    let g:neocomplete#sources#omni#input_patterns = {}
  endif
endif


let g:vimfiler_as_default_explorer = 1

"let g:neocomplcache#sources#rsense#home_directory = '/opt/rsense-0.3/'

let g:neocomplcache_text_mode_filetypes = {
\  'tex': 1,
\  'plaintex': 1,
\} 
let g:neocomplete#text_mode_filetypes = {
\  'tex': 1,
\  'plaintex': 1,
\} 
let g:neocomplete#force_omni_input_patterns.cpp =
\ '[^.[:digit:] *\t]\%(\.\|->\)\w*\|\h\w*::\w*'

let g:neocomplete#sources#omni#input_patterns.haxe =
\ '\v([\]''"\)]|\w|(^\s*))(\.|\()'

let g:neosnippet#snippets_directory = '~/.vim/snippet'

"tabで補完候補の選択を行う
imap <expr><TAB> neosnippet#expandable_or_jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : pumvisible() ? "\<C-n>" : "\<TAB>"
imap <expr><S-TAB> neosnippet#expandable_or_jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : pumvisible() ? "\<C-u>" : "\<S-TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)"
\: "\<TAB>"

augroup vimrc
    autocmd!
augroup END

autocmd vimrc FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd vimrc FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd vimrc FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd vimrc FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd vimrc FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
autocmd vimrc BufNewFile,BufRead *.{md,mdwn,mkd,mkdn,mark*} setlocal filetype=markdown
autocmd vimrc FileType haxe setl autowrite
autocmd vimrc FileType hxml setl autowrite
autocmd vimrc FileType nmml.xml setl autowrite
autocmd vimrc BufNewFile,BufRead *.rb set tags+=$HOME/ctags/ruby.tags

let g:vaxe_haxe_version = 3

function! s:init_vaxe_keymap()
  " .hxmlファイルを開いてくれるやつ
  nnoremap <buffer> ,vo :<C-u>call vaxe#OpenHxml()<CR>
  " タグファイル作ってくれるやつ(別途、.ctagsの定義をしませう)
  nnoremap <buffer> ,vc :<C-u>call vaxe#Ctags()<CR>
  " 自動インポートな
  nnoremap <buffer> ,vi :<C-u>call vaxe#ImportClass()<CR>
endfunction

autocmd vimrc FileType haxe call s:init_vaxe_keymap()
autocmd vimrc FileType hxml call s:init_vaxe_keymap()
autocmd vimrc FileType nmml.xml call s:init_vaxe_keymap()

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
  \ 'cpp': {
  \ 'cmdopt': '-std=c++11 -Wall' 
  \ }
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

let QFixHowm_Key = 'g'
let howm_dir             = '~/howm'
let howm_filename        = '%Y/%m/%Y-%m-%d-%H%M%S.txt'
let howm_fileencoding    = 'utf-8'
let howm_fileformat      = 'unix'
let g:qfixmemo_calendar = 0
let g:calendar_howm_syntax = 0

let mygrepprg = 'grep'
if has('win32unix')
  let MyGrep_cygwin17 = 1
endif

let g:calendar_google_calendar = 1
let g:calendar_google_task = 1

let g:marching_clang_command = '/usr/bin/clang'
let g:marching_clang_command_option="-std=c++1y"
let g:marching_enable_neocomplete = 1
let g:marching_include_paths = ['/usr/include/c++/4.8.2/']
let g:snowdrop#libclang_path='/usr/lib'

call unite#filters#matcher_default#use(['matcher_fuzzy'])
let g:unite_enable_start_insert = 1
let g:unite_source_directory_mru_long_limit = 3000
let g:unite_source_file_mru_filename_format = ''
let g:unite_source_file_mru_long_limit = 3000
let g:unite_source_history_yank_enable = 1
let g:unite_split_rule = 'botright'
let g:unite_winheight = 15

augroup plugin-lingr-vim
  autocmd!
  autocmd FileType lingr-messages nmap <silent> <buffer> t <Plug>(lingr-messages-show-say-buffer)
  autocmd FileType lingr-say let &syntax='clojure'
augroup END

function! s:SID_PREFIX()
    return matchstr(expand('<sfile>'), '<SNR>\d\+_')
endfunction

set titlelen=100
set guioptions-=e

autocmd vimrc BufEnter * let &titlestring = '%{' . s:SID_PREFIX() . 'titlestring()}'
autocmd vimrc User plugin-lingr-unread let &titlestring = '%{' . s:SID_PREFIX() . 'titlestring()}'

if !has('gui_running')
  set t_Co=256
endif


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

let g:lightline = {
\ 'colorscheme': 'wombat',
\ 'component': {
\   'readonly': '%{&readonly?"":""}',
\ },
\ 'separator': { 'left': "\ue0b0", 'right': "\ue0b2" },
\ 'subseparator': { 'left': "\ue0b1", 'right': "\ue0b3" }
\ }

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
