scriptencoding utf-8

set nocompatible

if has('vim_starting')
    filetype plugin off
    filetype indent off
    execute 'set runtimepath+=' . expand('~/.vim/bundle/neobundle.vim')
    call neobundle#rc(expand('~/.vim/bundle'))
endif

NeoBundle 'git://github.com/kien/ctrlp.vim.git'
NeoBundle 'git://github.com/Shougo/neobundle.vim.git'
NeoBundle 'git://github.com/scrooloose/nerdtree.git'
NeoBundle 'git://github.com/scrooloose/syntastic.git'

NeoBundle 'git@github.com:Shougo/unite.vim.git'
NeoBundle 'git@github.com:Shougo/vimshell.git'
NeoBundle 'Shougo/vimproc'
NeoBundle 'git@github.com:Shougo/neocomplcache.git'
""NeoBundle 'YankRing.vim' "set clipboard=unnamedと競合しているらしい
NeoBundle 'git@github.com:mattn/zencoding-vim.git'
NeoBundle 'surround.vim'
NeoBundle 'jQuery'
NeoBundle 'git@github.com:derekwyatt/vim-scala.git'
NeoBundle 'rking/ag.vim'
NeoBundle 'nginx.vim'

"---------------------------
" unite.vim
"---------------------------
noremap <silent> ,ub :<C-u>Unite buffer<CR>
noremap <silent> ,uf :<C-u>UniteWithBufferDir -buffer-name=files file file/new<CR>
noremap <silent> ,uh :<C-u>Unite -buffer-name=register register<CR>
noremap <silent> ,um :<C-u>Unite file_mru<CR>

au FileType unite nnoremap <silent> <buffer> <ESC><ESC> :q<CR>

syntax on
filetype plugin on
filetype indent on

"---------------------------
" 基本設定
"---------------------------
set number
set scrolloff=3 "ページ送り時の余白
set textwidth=0 "一行で表示（自動折り返しなし）
set nobackup
set noswapfile
set autoread
set hidden
set formatoptions=lmoq  "テキスト整形オプション（マルチバイト系を追加）
set vb t_vb=  "ビープを鳴らさない
set browsedir=buffer  "Exploreの初期ディレクトリ
set whichwrap=b,s,h,l,<,>,[,]  "カーソルを行頭、行末で止まらないようにする
set showcmd
set showmode

set clipboard+=unnamed  "OSのクリップボードを使用可能に
set clipboard=unnamed  "ヤンクした文字をシステムのクリップボードに入れる

"insertモードを抜けるとIMEオフ
set noimdisable
set iminsert=0 imsearch=0
set noimcmdline
inoremap <silent> <ESC> <ESC>:set iminsert=0<CR>

"---------------------------
" Programming
"---------------------------
"Tabキーを空白に変換
set expandtab
",の後はスペース
inoremap , ,<Space>
" 保存時に行末の空白を除去する
autocmd BufWritePre * :%s/\s\+$//ge
"保存時にtabをスペースに変換する
autocmd BufWritePre * :%s/\t/  /ge

set wildmenu            "コマンド補完を強化
set wildchar=<tab>      "コマンド補完を開始するキー
set wildmode=list:full  "リスト表示、最長マッチ
set history=1000        "コマンド・検索パターンの履歴数
set complete+=k         "補完に辞書ファイル追加

"neocomplcache有効
let g:neocomplcache_enable_at_startup = 1
" 補完が自動で開始される文字数
let g:neocomplcache_auto_completion_start_length = 4
" smarrt case有効化。 大文字が入力されるまで大文字小文字の区別を無視する
let g:neocomplcache_enable_smart_case = 1
" camle caseを有効化。大文字を区切りとしたワイルドカードのように振る舞う
let g:neocomplcache_enable_camel_case_completion = 1
" _(アンダーバー)区切りの補完を有効化
let g:neocomplcache_enable_underbar_completion = 1
" シンタックスをキャッシュするときの最小文字長を3に
let g:neocomplcache_min_syntax_length = 4
" neocomplcacheを自動的にロックするバッファ名のパターン
let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'
" -入力による候補番号の表示
let g:neocomplcache_enable_quick_match = 1
" 補完候補の一番先頭を選択状態にする(AutoComplPopと似た動作)
let g:neocomplcache_enable_auto_select = 1
"ポップアップメニューで表示される候補の数。初期値は100
let g:neocomplcache_max_list = 20

"Dictionary定義
let g:neocomplcache_dictionary_filetype_lists = {
    \ 'default' : '',
    \ 'scala' : $HOME.'/.vim/dict/scala.dict',
    \ 'java' : $HOME.'/.vim/dict/java.dict',
    \ 'javascript' : $HOME.'/.vim/dict/javascript.dict',
    \ }

" FileType毎のOmni補完を設定
"autocmd FileType python     setlocal omnifunc=pythoncomplete#Complete
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html       setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType css        setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType xml        setlocal omnifunc=xmlcomplete#CompleteTags
"autocmd FileType php        setlocal omnifunc=phpcomplete#CompletePHP
"autocmd FileType c          setlocal omnifunc=ccomplete#Complete
autocmd FileType ruby       setlocal omnifunc=rubycomplete#Complete

"inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
"オムニ補完の手動呼び出し
inoremap <expr><C-Space> neocomplcache#manual_omni_complete()
"オムニ補完のパターンを設定
if !exists('g:neocomplcache_omni_patterns')
  let g:neocomplcache_omni_patterns = {}
endif

"Ex-modeでの<C-p><C-n>をzshのヒストリ補完っぽくする
cnoremap <C-p> <Up>
cnoremap <Up>  <C-p>
cnoremap <C-n> <Down>
cnoremap <Down>  <C-n>

set ffs=unix,dos,mac  " 改行文字

"---------------------------
" 移動系
"---------------------------
"insertモードでもhjklで移動
inoremap <C-j> <Down>
inoremap <C-k> <Up>
inoremap <C-h> <Left>
inoremap <C-l> <Right>

" CTRL-hjklでウィンドウ移動
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
nnoremap <C-h> <C-w>h

"画面送り
noremap <Space>j <C-f>
noremap <Space>k <C-b>


"---------------------------
" 検索設定
"---------------------------
set wrapscan    "最後まで検索したら先頭へ戻る
set ignorecase  "大文字小文字無視
set smartcase   "検索文字列に大文字が含まれている場合は区別して検索
set incsearch   "インクリメンタルサーチ
set hlsearch    "検索文字をハイライト
nmap <ESC><ESC> ;nohlsearch<CR><ESC>    "Escの２回押しでハイライト消去

"---------------------------
" インデント
"---------------------------
set autoindent
set smartindent
set tabstop=2 shiftwidth=2 softtabstop=0

if has("autocmd")
  "ファイルタイプの検索を有効にする
  filetype plugin on
  "そのファイルタイプにあわせたインデントを利用する
  filetype indent on

  autocmd FileType apache     setlocal sw=4 sts=4 ts=4 et
  autocmd FileType aspvbs     setlocal sw=4 sts=4 ts=4 et
  autocmd FileType c          setlocal sw=4 sts=4 ts=4 et
  autocmd FileType cpp        setlocal sw=4 sts=4 ts=4 et
  autocmd FileType cs         setlocal sw=4 sts=4 ts=4 et
  autocmd FileType css        setlocal sw=2 sts=2 ts=2 et
  autocmd FileType diff       setlocal sw=4 sts=4 ts=4 et
  autocmd FileType eruby      setlocal sw=4 sts=4 ts=4 et
  autocmd FileType html       setlocal sw=2 sts=2 ts=2 et
  autocmd FileType java       setlocal sw=4 sts=4 ts=4 et
  autocmd FileType javascript setlocal sw=2 sts=2 ts=2 et
  autocmd FileType perl       setlocal sw=4 sts=4 ts=4 et
  autocmd FileType php        setlocal sw=4 sts=4 ts=4 et
  autocmd FileType python     setlocal sw=4 sts=4 ts=4 et
  autocmd FileType ruby       setlocal sw=2 sts=2 ts=2 et
  autocmd FileType haml       setlocal sw=2 sts=2 ts=2 et
  autocmd FileType sh         setlocal sw=4 sts=4 ts=4 et
  autocmd FileType sql        setlocal sw=4 sts=4 ts=4 et
  autocmd FileType vb         setlocal sw=4 sts=4 ts=4 et
  autocmd FileType vim        setlocal sw=2 sts=2 ts=2 et
  autocmd FileType wsh        setlocal sw=4 sts=4 ts=4 et
  autocmd FileType xhtml      setlocal sw=4 sts=4 ts=4 et
  autocmd FileType xml        setlocal sw=4 sts=4 ts=4 et
  autocmd FileType yaml       setlocal sw=2 sts=2 ts=2 et
  autocmd FileType zsh        setlocal sw=4 sts=4 ts=4 et
  autocmd FileType scala      setlocal sw=2 sts=2 ts=2 et
endif



" Installation check.
NeoBundleCheck
