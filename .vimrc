" coding:utf-8
scriptencoding utf-8
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

let g:vim_indent_cont = 2

filetype off

if has('vim_starting')
  set runtimepath+=~/.vim/neobundle.vim.git

endif
call neobundle#begin(expand('~/.bundle'))

let g:neobundle_default_git_protocol='https'

if has('python')
  NeoBundle 'OmniSharp/omnisharp-vim'
  call neobundle#config('omnisharp-vim', {
    \ 'lazy' : 1,
    \ 'autoload' : {'filetypes': ['cs'] }
    \ })
endif

NeoBundleFetch 'Shougo/neobundle.vim'

NeoBundle 'Shougo/echodoc'
call neobundle#config('echodoc', {
  \ 'lazy' : 1,
  \ 'autoload' : {
  \ 'insert' : 1,
  \ }})
if has('lua')
  NeoBundle 'Shougo/neocomplete.vim'
else
  NeoBundle 'Shougo/neocomplcache'
endif
NeoBundle 'Shougo/neomru.vim'
NeoBundle 'Shougo/neosnippet'
call neobundle#config('neosnippet', {
  \ 'lazy' : 1,
  \ 'autoload' : {
  \ 'insert' : 1,
  \ 'filetypes' : 'snippet',
  \ 'unite_sources' : ['snippet', 'neosnippet/user', 'neosnippet/runtime'],
  \ }})
NeoBundle 'Shougo/neosnippet-snippets'
call neobundle#config('neosnippet-snippets', {
  \ 'depends' : 'Shougo/neosnippet'
  \ })
NeoBundle 'Shougo/unite-ssh'
call neobundle#config('unite-ssh', {
  \ 'lazy' : 1,
  \ 'depends' : 'Shougo/unite.vim',
  \ 'autoload' : { 'unite_sources' : 'ssh' }
  \ })
NeoBundle 'Shougo/unite.vim'
call neobundle#config('unite.vim',{
  \ 'lazy' : 1,
  \ 'autoload' : {
  \ 'commands' : [{ 'name' : 'Unite',
  \                 'complete' : 'customlist,unite#complete_source'},
  \                 'UniteWithCursorWord', 'UniteWithInput']
  \ }})
NeoBundle 'Shougo/unite-outline'
NeoBundle 'Shougo/vimfiler'
call neobundle#config('vimfiler', {
  \ 'lazy' : 1,
  \ 'depends' : 'Shougo/unite.vim',
  \ 'autoload' : {
  \     'commands' : [
  \                   { 'name' : 'VimFiler',
  \                     'complete' : 'customlist,vimfiler#complete' },
  \                   { 'name' : 'VimFilerExplorer',
  \                     'complete' : 'customlist,vimfiler#complete' },
  \                   { 'name' : 'VimFilerBufferDir',
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
if has('win32') || has('win64')
  NeoBundleFetch 'jnwhiteh/vim-golang'
  call neobundle#config('vim-golang', {
    \ 'type' : 'nosync',
    \ 'lazy' : 1,
    \ 'autoload' : { 'filetypes' : 'go'}
    \ })
else
  NeoBundle 'Shougo/vimproc.vim'
  call neobundle#config('vimproc.vim', {
    \ 'build' : {
    \     'windows' : 'make -f make_mingw64.mak',
    \     'cygwin' : 'make -f make_cygwin.mak',
    \     'mac' : 'make -f make_mac.mak',
    \     'unix' : 'make -f make_unix.mak',
    \   },
    \ })
  NeoBundle 'jnwhiteh/vim-golang'
  call neobundle#config('vim-golang', {
    \ 'lazy' : 1,
    \ 'autoload' : { 'filetypes' : 'go'}
    \ })
endif
NeoBundle 'Shougo/vimshell'
call neobundle#config('vimshell', {
  \ 'lazy' : 1,
  \ 'autoload' : {
  \     'commands' : [{ 'name' : 'VimShell',
  \                     'complete' : 'customlist,vimshell#complete'},
  \                     'VimShellExecute', 'VimShellInteractive',
  \                     'VimShellTerminal', 'VimShellPop'],
  \     'mappings' : ['<Plug>(vimshell_switch)']
  \ }})
NeoBundle 'basyura/J6uil.vim'
call neobundle#config('J6uil.vim', {
  \ 'lazy' : 1,
  \ 'autoload' : { 'commands' : 'J6uil',
  \                'unice_source' : ['J6uil/rooms', 'J6uil/members']},
  \ 'depends' : 'mattn/webapi-vim',
  \ })
NeoBundle 'cohama/agit.vim'
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
if has('python')
  NeoBundle 'editorconfig/editorconfig-vim'
endif
NeoBundle 'groenewege/vim-less'
call neobundle#config('vim-less', {
  \ 'lazy' : 1,
  \ 'autoload' : { 'filetypes' : 'less' }
  \ })
NeoBundle 'haya14busa/incsearch.vim'
NeoBundle 'honza/vim-snippets'
NeoBundle 'itchyny/calendar.vim'
NeoBundle 'itchyny/lightline.vim'
NeoBundle 'jceb/vim-orgmode'
call neobundle#config('vim-orgmode', {
  \ 'lazy' : 1,
  \ 'autoload' : { 'filetypes' : 'org' }
  \ })
if has('python')
  NeoBundle 'kakkyz81/evervim'
endif
NeoBundle 'kamichidu/unite-javaimport', ''
call neobundle#config('unite-javaimport', {
  \ 'lazy' : 1,
  \ 'depends' : [
  \ 'kamichidu/vim-javalang', 'kamichidu/vim-javaclasspath',
  \ 'Shougo/unite.vim'],
  \ 'autoload' : { 'filetypes' : ['java', 'scala', 'clojure']}
  \})
NeoBundle 'kamichidu/vim-milqi', 'dev'
NeoBundle 'kamichidu/vim-ref-java'
call neobundle#config('vim-ref-java', {
  \ 'depends' : [ 'mattn/wwwrenderer-vim' ],
  \})
NeoBundle 'kamichidu/vim-vdbc'
call neobundle#config('vim-vdbc', {
  \ 'depends' : ['Shougo/vimproc.vim'] ,
  \ 'build': {
  \     'unix' :    'make -f Makefile',
  \     'windows' : 'make -f Makefile.w64'
  \ }
  \})
NeoBundle 'kana/vim-smartinput'
NeoBundle 'kana/vim-textobj-function'
NeoBundle 'kana/vim-textobj-user'
NeoBundle 'mattn/benchvimrc-vim'
call neobundle#config('benchvimrc-vim', {
  \ 'lazy' : 1,
  \ 'autoload' : { 'commands' : 'BenchVimrc' }
  \ })
NeoBundle 'mattn/flappyvird-vim'
call neobundle#config('flappyvird-vim', {
  \ 'lazy' : 1,
  \ 'autoload' : { 'commands' : 'FlappyVird' }
  \ })
NeoBundle 'mattn/gist-vim'
call neobundle#config('gist-vim', {
  \ 'lazy' : 1,
  \ 'autoload' : { 'commands' : 'Gist' }
  \ })
NeoBundle 'mattn/libcallex-vim'
NeoBundle 'mattn/sonictemplate-vim'
call neobundle#config('sonictemplate-vim', {
  \ 'lazy' : 1,
  \ 'autoload' : { 'commands' : 'Template' }
  \ })
NeoBundle 'mattn/unite-rhythmbox'
call neobundle#config('unite-rhythmbox', {
  \ 'lazy' : 1,
  \ 'autoload' : { 'unite_sources' : 'rhythmbox' },
  \ 'depends' : 'Shougo/unite.vim'
  \ })
NeoBundle 'mattn/webapi-vim'
NeoBundle 'miyakogi/conoline.vim'
NeoBundle 'osyo-manga/quickrun-hook-u-nya-'
call neobundle#config('quickrun-hook-u-nya-', {
  \ 'depends' : 'thinca/vim-quickrun'
  \ })
NeoBundle 'osyo-manga/shabadou.vim'
NeoBundle 'osyo-manga/unite-filetype'
call neobundle#config('unite-filetype', {
  \ 'lazy' : 1,
  \ 'autoload' : { 'unite_sources' : ['filetype', 'filetype/new']},
  \ 'depends' : ['Shougo/unite.vim']
  \ })
NeoBundle 'osyo-manga/unite-highlight'
call neobundle#config('unite-highlight', {
  \ 'lazy' : 1,
  \ 'autoload' : { 'unite_sources' : ['highlight']},
  \ 'depends' : ['Shougo/unite.vim']
  \ })
NeoBundle 'osyo-manga/unite-quickfix'
call neobundle#config('unite-quickfix', {
  \ 'lazy' : 1,
  \ 'autoload' : { 'unite_sources' : ['quickfix', 'location_list']},
  \ 'depends' : 'Shougo/unite.vim'
  \ })
NeoBundle 'osyo-manga/vim-marching'
call neobundle#config('vim-marching', {
  \ 'depends' : ['Shougo/vimproc.vim', 'osyo-manga/vim-reunions']
  \ })
NeoBundle 'osyo-manga/vim-monster'
call neobundle#config('vim-monster', {
  \ 'lazy' : 1,
  \ 'autoload' : { 'filetypes' : 'ruby' }
  \ })
NeoBundle 'osyo-manga/vim-reunions'
NeoBundle 'osyo-manga/vim-snowdrop'
call neobundle#config('vim-snowdrop', {
  \ 'lazy' : 1,
  \ 'autoload' : { 'filetypes' : 'cpp' }
  \ })
NeoBundle 'osyo-manga/vim-watchdogs'
NeoBundle 'raa0121/vim-ulilith'
NeoBundle 'rbtnn/vimconsole.vim'
call neobundle#config('vimconsole.vim', {
  \ 'lazy' : 1,
  \ 'depends' : 'thinca/vim-prettyprint',
  \ 'autoload' : { 'commands' : 'VimConsoleOpen' }
  \ })
NeoBundle 'ryutorion/vim-itunes'
NeoBundle 'slim-template/vim-slim'
NeoBundle 'stephpy/vim-php-cs-fixer'
call neobundle#config('vim-php-cs-fixer', {
  \ 'lazy' : 1,
  \ 'autoload' : { 'filetypes' : 'php' }
  \ })
NeoBundle 'supermomonga/thingspast.vim'
"call neobundle#config('thingspast.vim', {
"  \ 'build' : { 'unix' : 'bundle install' }
"  \ })
NeoBundle 'thinca/vim-ft-clojure'
call neobundle#config('vim-ft-clojure', {
  \ 'lazy' : 1,
  \ 'autoload' : { 'filetypes' : 'clojure' }
  \ })
NeoBundle 'thinca/vim-github'
call neobundle#config('vim-github', {
  \ 'lazy' : 1,
  \ 'autoload' : { 'commands' : 'Github' }
  \ })
NeoBundle 'thinca/vim-prettyprint'
call neobundle#config('vim-prettyprint', {
  \ 'lazy' : 1,
  \ 'autoload' : { 'commands' : ['PP', 'PrettyPrint']}
  \ })
NeoBundle 'thinca/vim-quickrun'
call neobundle#config('vim-quickrun', {
  \ 'lazy' : 1,
  \ 'autoload' : {
  \   'mappings' : [
  \     ['nxo', '<Plug>(quickrun)']],
  \   'commands' : 'QuickRun',
  \ },
  \ })
NeoBundle 'thinca/vim-ref'
call neobundle#config('vim-ref', {
  \ 'lazy' : 1,
  \ 'autoload' : { 'commands' : ['Ref', 'RefHistory'],
  \                'unite_sources' : ['ref/erlang', 'ref/man',
  \                                   'ref/pydoc', 'ref/redis',
  \                                   'ref/clojure',
  \                                   'ref/refe', 'ref/webdict']}
  \ })
NeoBundle 'thinca/vim-singleton'
NeoBundle 'thinca/vim-splash'
NeoBundle 'thinca/vim-textobj-function-javascript'
call neobundle#config('vim-textobj-function-javascript', {
  \ 'depends' : ['kana/vim-textobj-function'],
  \ 'lazy' : 1,
  \ 'autoload' : { 'filetypes' : 'javascript' }
  \ })
NeoBundle 'thinca/vim-threes'
call neobundle#config('vim-threes', {
  \ 'lazy' : 1,
  \ 'autoload' : { 'commands' : 'ThreesStart' }
  \ })
NeoBundle 'tpope/vim-cucumber'
call neobundle#config('vim-cucumber', {
  \ 'lazy' : 1,
  \ 'autoload' : { 'filetypes' : 'cucumber' }
  \ })
NeoBundle 'tsukkee/lingr-vim'
call neobundle#config('lingr-vim', {
  \ 'lazy' : 1,
  \ 'autoload' : { 'commands' : 'LingrLaunch' }
  \ })
NeoBundle 'tyru/kirikiri.vim'
call neobundle#config('lingr-vim', {
  \ 'lazy' : 1,
  \ 'autoload' : { 'filetypes' : 'kscript' }
  \ })
NeoBundle 'tyru/open-browser.vim'
call neobundle#config('open-browser.vim',{
  \ 'lazy' : 1,
  \ 'autoload' : {
  \   'mappings' : '<Plug>(open-browser-wwwsearch)',
  \ }
  \ })
NeoBundle 'ujihisa/neco-ghc'
call neobundle#config('neco-ghc', {
  \ 'lazy' : 1,
  \ 'autoload' : { 'filetypes' : 'haskell' }
  \ })
if executable('look')
  NeoBundle 'ujihisa/neco-look'
endif
NeoBundle 'ujihisa/neoclojure.vim'
call neobundle#config('neco-ghc', {
  \ 'lazy' : 1,
  \ 'autoload' : { 'filetypes' : 'clojure',
  \                'unite_sources' : ['ref/neoclojure'] }
  \ })
NeoBundle 'ujihisa/unite-colorscheme'
call neobundle#config('unite-colorscheme', {
  \ 'lazy' : 1,
  \ 'autoload' : { 'unite_sources' : ['colorscheme'] }
  \ })
NeoBundle 'ujihisa/vimshell-ssh'
call neobundle#config('vimshell-ssh',{
  \ 'lazy' : 1,
  \ 'depends' : 'Shougo/vimshell',
  \ 'autoload' : { 'filetypes' : 'vimshell'}
  \ })
NeoBundle 'vim-jp/vimdoc-ja'
NeoBundle 'vim-jp/vital.vim'
call neobundle#config('vital.vim', {
  \ 'lazy' : 1,
  \ 'autoload' : {
  \   'commands' : ['Vitalize'],
  \   'functions' : ['vital#of', 'vital']
  \ }
  \ })
NeoBundle 'vim-scripts/AnsiEsc.vim'
NeoBundle 'vim-scripts/sudo.vim'
NeoBundle 'yoppi/fluentd.vim'
call neobundle#config('fluentd.vim',{
  \ 'lazy' : 1,
  \ 'autoload' : { 'filetypes' : 'fluentd'}
  \ })
if executable('w3m')
  NeoBundle 'yuratomo/w3m.vim'
  call neobundle#config('w3m.vim',{
    \ 'lazy' : 1,
    \ 'autoload' : { 'commands' : ['W3m', 'W3mTab']}
    \ })
endif

call neobundle#end()
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
nnoremap <silent> ,ts :<C-u>tab stj <C-R>=expand('<cword>')<CR><CR>
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)

if neobundle#is_installed('neocomplcache')
  let g:neocomplcache_enable_at_startup = 1
  let g:neocomplcache_enable_smart_case = 1
  let g:neocomplcache_enable_camel_case_completion = 1
  let g:neocomplcache_enable_underbar_completion = 1
  let g:neocomplcache_min_syntax_length = 3
  let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'
  let g:neocomplcache_keyword_patterns = get(g:, 'neocomplecache_keyword_patterns', {})
  let g:neocomplcache_keyword_patterns['default'] = '\h\w*'
endif

if neobundle#is_installed('neocomplete.vim')
  let g:neocomplete#enable_at_startup = 1
  let g:neocomplete#enable_smart_case = 1
  let g:neocomplete#enable_camel_case_completion = 1
  let g:neocomplete#enable_underbar_completion = 1
  let g:neocomplete#min_syntax_length = 3
  let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'
  let g:neocomplete#keyword_patterns = get(g:, 'neocomplete#keyword_patterns', {})
  let g:neocomplete#keyword_patterns['default'] = '\h\w*'
  let g:neocomplete#force_omni_input_patterns = get(g:, 'neocomplete#force_omni_input_patterns', {})
  let g:neocomplete#sources#omni#input_patterns = get(g:, 'neocomplete#sources#omni#input_patterns', {})
  let g:neocomplete#text_mode_filetypes = {'tex': 1, 'plaintex': 1}
  let g:neocomplete#force_omni_input_patterns.cpp =
  \ '[^.[:digit:] *\t]\%(\.\|->\)\w*\|\h\w*::\w*'
  let g:neocomplete#force_omni_input_patterns.ruby = '[^. *\t]\.\|\h\w*::'
  let g:neocomplete#sources#omni#input_patterns.cs = '[^.]\.\%(\u\{2,}\)\?'
endif

let g:vimfiler_as_default_explorer = 1
let g:vimfiler_safe_mode_by_default = 0

"let g:neocomplcache#sources#rsense#home_directory = '/opt/rsense-0.3/'

let g:neocomplcache_text_mode_filetypes = {
\  'tex': 1,
\  'plaintex': 1,
\} 
let g:monster#completion#rcodetools#backend = "async_rct_complete"

let g:neosnippet#snippets_directory = '~/.vim/snippet,~/.bundle/vim-snippets/snippets'

"tabで補完候補の選択を行う
imap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
imap <expr><S-TAB> pumvisible() ? "\<C-u>" : "\<S-TAB>"
imap <expr><CR> neosnippet#expandable_or_jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<CR>"
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
autocmd vimrc FileType cs setlocal omnifunc=OmniSharp#Complete
autocmd vimrc FileType clojure setlocal omnifunc=neoclojure#complete#omni
autocmd vimrc FileType quickrun AnsiEsc
autocmd vimrc BufNewFile,BufRead *.{md,mdwn,mkd,mkdn,mark*} setlocal filetype=markdown
autocmd vimrc BufNewFile,BufRead *.gradle setlocal filetype=groovy
autocmd vimrc FileType php setlocal noexpandtab wrap tabstop=4 shiftwidth=4
autocmd vimrc FileType java setlocal noexpandtab wrap tabstop=4 shiftwidth=4
autocmd vimrc FileType ruby setlocal tags+=$HOME/ctags/ruby.tags
autocmd vimrc FileType c setlocal tags+=$HOME/ctags/c.tags
autocmd vimrc BufNewFile Gemfile Template Gemfile

let g:netrw_nogx = 1
nmap gx <Plug>(openbrowser-smart-search)
vmap gx <Plug>(openbrowser-smart-search)

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
let g:quickrun_config.ruby = {
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
let g:quickrun_config.cpp = {
  \ 'cmdopt': '-std=c++1y -Wall' 
  \ }

call watchdogs#setup(g:quickrun_config)

let g:lingr_vim_user = 'raa0121'
let g:J6uil_display_offline  = 0
let g:J6uil_display_online   = 0
let g:J6uil_echo_presence    = 1
let g:J6uil_display_icon     = 0
let g:J6uil_display_interval = 0
let g:J6uil_updatetime       = 1000

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

let g:conoline_auto_enable = 1

call unite#filters#matcher_default#use(['matcher_fuzzy'])
let g:unite_enable_start_insert = 1
let g:unite_source_directory_mru_long_limit = 3000
let g:unite_source_file_mru_filename_format = ''
let g:unite_source_file_mru_long_limit = 3000
let g:unite_source_history_yank_enable = 1
let g:unite_split_rule = 'botright'
let g:unite_winheight = 15


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

let g:php_cs_fixer_level = "all"
let g:php_cs_fixer_config = "default"
let g:php_cs_fixer_php_path = "php"
let g:php_cs_fixer_enable_default_mapping = 1
let g:php_cs_fixer_dry_run = 0
let g:php_cs_fixer_verbose = 0

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
\   'readonly': '%{&readonly?"\u2b64":""}'
\ },
\ 'separator': { 'left': "\u2b80", 'right': "\u2b82" },
\ 'subseparator': { 'left': "\u2b81", 'right': "\u2b83" }
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
