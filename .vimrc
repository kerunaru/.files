"
"        _
" __   _(_)_ __ ___  _ __ ___
" \ \ / / | '_ ` _ \| '__/ __|
"  \ V /| | | | | | | | | (__
" (_)_/ |_|_| |_| |_|_|  \___|forPHP
"
" ==========================================================================
"
" RESUMEN DE ATAJOS:
"   GENERAL:
"     <leader>n        :: Alterna visualización de Fern
"     <leader>nr       :: Revela la ubicación de un archivo en Fern
"     a                :: En Fern, hace aparecer el menu de acciones
"     +                :: En Fern, expande una carpeta
"     -                :: En Fern, colapsa una carpeta
"     <leader>k        :: Mueve línea actual hacia arriba (funciona con selecciones)
"     <leader>j        :: Mueve línea actual hacia abajo (funciona con selecciones)
"     <leader><leader> :: Alterna entre los dos últimos buffers abiertos
"     <leader>B        :: Crea un nuevo buffer
"     <tab>            :: Cambia al siguiente buffer
"     <s-tab>          :: Cambia al buffer anterior
"     <leader>bq       :: Elimina el buffer actual
"     <leader>ba       :: Elimina todos los buffers
"     <c-[h|j|k|l]>    :: Navega entre las diferentes ventanas abiertas
"     <leader>+        :: Amplía la ventana actual
"     <leader>-        :: Reduce la ventana actual
"     <leader>sf       :: Abre FZFpara archivos
"     <leader>sb       :: Saca ZFZ para buffers
"     <leader>v        :: Muestra la lista de símbolos
"     <leader>t        :: Abre la prueba asociada al archivo actual
"     <leader><esc>    :: Sale del modo búsqueda
"
"   PHP:
"     <leader>ga       :: Genera métodos get/set en una clase
"     <leader>em       :: Extrae a un método la selección actual
"     <leader>mf       :: Mueve el archivo actual (esto actualiza el namespace automáticamente)
"     <leader>cn       :: Crea una nueva clase
"     <leader>ic       :: Abre el menú de transformación de PHPactor
"     gtd              :: Va a la definición del símbolo
"     gti              :: Va a la implementación del símbolo actual
"     gte              :: Muestra los errores en el archivo actual
"     fr               :: Busca referencias del símbolo actual
"     gt               :: Muestra la definición del símbolo actual
"     rn               :: Renombra el símbolo actual
"     [g               :: Va al error anterior
"     ]g               :: Va al error siguiente
"
" RESUMEN DE COMANDOS:
"   find     :: Busca un archivo recursivamente desde :pwd (funciona con RegExp)
"   split    :: Divide la ventana en horizontal
"   vplit    :: Divide la ventana en vertical
"   close    :: Cierra la ventana actual
"

" Autodescarga de VimPlug
let vimplug_exists=expand('~/.vim/autoload/plug.vim')

if !filereadable(vimplug_exists)
  echo "Instalando Vim-Plug…"
  echo ""
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

  autocmd VimEnter * PlugInstall
endif

" Carga de plugins
call plug#begin(expand('~/.vim/plugged'))
  Plug 'chaoren/vim-wordmotion'
  Plug 'chr4/nginx.vim'
  Plug 'editorconfig/editorconfig-vim'
  Plug 'itchyny/lightline.vim'
  Plug 'itchyny/vim-gitbranch'
  Plug 'itchyny/vim-cursorword'
  Plug 'airblade/vim-gitgutter'
  Plug 'vim-vdebug/vdebug'
  Plug 'lumiliet/vim-twig'
  Plug 'liuchengxu/vista.vim'
  Plug 'hashivim/vim-terraform'
  Plug 'osyo-manga/vim-over'
  Plug 'andymass/vim-matchup'
  Plug 'APZelos/blamer.nvim'
  Plug 'obcat/vim-hitspop'
  Plug 'lambdalisue/fern.vim'
  Plug 'Yggdroot/indentLine'
  Plug 'phpactor/phpactor', {'for': 'php', 'branch': 'master', 'do': 'composer install --no-dev -o'}
  Plug 'prabirshrestha/vim-lsp'
  Plug 'mattn/vim-lsp-settings'
  Plug 'prabirshrestha/asyncomplete.vim'
  Plug 'prabirshrestha/asyncomplete-lsp.vim'
  Plug 'mg979/vim-visual-multi', {'branch': 'master'}
  Plug 'github/copilot.vim'
  Plug 'ap/vim-css-color'
  Plug 'junegunn/fzf'
  Plug 'junegunn/fzf.vim'
  Plug 'jwalton512/vim-blade'
  Plug 'tinted-theming/base16-vim'
  Plug 'kerunaru/base16lightline'
call plug#end()

" Definición de constantes interesantes
let vimDir='$HOME/.vim'
let &runtimepath.=','.vimDir

" Mantenimiento de histórico de cambios persistente
if has('persistent_undo')
    let myUndoDir=expand(vimDir . '/undodir')
    call system('mkdir ' . vimDir)
    call system('mkdir ' . myUndoDir)
    let &undodir=myUndoDir
    set undofile
endif

" Básicos
syntax on
filetype plugin on

" base16 theme
if exists('$BASE16_THEME')
    \ && (!exists('g:colors_name')
    \ || g:colors_name != 'base16-$BASE16_THEME')
  let base16colorspace=256
  colorscheme base16-$BASE16_THEME
endif

set background=dark
set laststatus=2
set backspace=indent,eol,start
set path+=**
set wildmenu
set scrolloff=25
set incsearch
set ignorecase
set smartcase
set hlsearch
set autoindent
set noswapfile
set autoread
set lazyredraw
set relativenumber
set number
set colorcolumn=80,120
set tw=119
set listchars=eol:↓,tab:»\ ,trail:~,space:·
set list
set cursorline
set noshowmode
set tabstop=4
set mouse=a

" Define la tecla líder
let mapleader=","

" Accede rápidamente al .vimrc
nnoremap <leader>rc :edit $MYVIMRC<cr>

" Elimina espacios al guardar
augroup PreSaveTasks
    autocmd!

    autocmd BufWritePre * :%s/\s\+$//e
augroup END

" Movimiento de líneas
nnoremap <leader>k :move-2<cr>==
nnoremap <leader>j :move+<cr>==

" Movimiento de selección
xnoremap <leader>k :move-2<cr>gv=gv
xnoremap <leader>j :move'>+<cr>gv=gv

" Mantiene selección después de tabulación
vnoremap < <gv
vnoremap > >gv

" Fern
function! s:init_fern() abort
  nmap <buffer> + <Plug>(fern-action-expand)
  nmap <buffer> - <Plug>(fern-action-collapse)
endfunction

augroup FernCustom
  autocmd! *
  autocmd FileType fern call s:init_fern()
  autocmd FileType fern set nonumber norelativenumber nolist
augroup END

nnoremap <leader>n :Fern . -drawer -toggle<cr>
nnoremap <leader>nr :Fern . -reveal=% -drawer<cr>

" Gestión de buffers (¡No uses pestañas!)
nnoremap <leader>B :enew<cr>
nnoremap <tab> :bnext<cr>
nnoremap <s-tab> :bprevious<cr>
nnoremap <leader>bq :bp <bar> bd! #<cr>
nnoremap <leader>ba :bufdo bd!<cr>
nnoremap <leader><leader> :bprev<cr>
nnoremap <silent> <c-h> :wincmd h<cr>
nnoremap <silent> <c-j> :wincmd j<cr>
nnoremap <silent> <c-k> :wincmd k<cr>
nnoremap <silent> <c-l> :wincmd l<cr>
nnoremap <silent> <leader>+ :vertical resize +5<cr>
nnoremap <silent> <leader>- :vertical resize -5<cr>

" Función para localizar la prueba del archivo actual y abrirla
function! GetTestFileName()
  return system("fd " . expand("%:t:r") . 'Test')
endfunction

nnoremap <leader>t :execute ':e ' . GetTestFileName()<cr>

inoremap ' ''<left>
inoremap " ""<left>
inoremap ( ()<left>
inoremap [ []<left>
inoremap { {}<left>

" Elimina búsqueda actual
nnoremap <silent> <leader><esc> :nohlsearch<CR>

" Vista
let g:vista#renderer#enable_icon = 0
let g:vista_default_executive = 'vim_lsp'
nnoremap <silent> <leader>v :Vista!!<cr>

" FZF
let g:fzf_preview_window = []

nnoremap <leader>sf :Files<cr>
nnoremap <leader>sb :Buffers<cr>
nnoremap <leader>st :BTags<cr>

" VIM LSP
function! s:on_lsp_buffer_enabled() abort
    setlocal omnifunc=lsp#complete
    setlocal signcolumn=yes
    if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif
    nmap <buffer> gtd <plug>(lsp-definition)
    nmap <buffer> gti <plug>(lsp-implementation)
    nmap <buffer> gte <plug>(lsp-document-diagnostics)
    nmap <buffer> fr <plug>(lsp-references)
    nmap <buffer> gt <plug>(lsp-type-definition)
    nmap <buffer> <leader>rn <plug>(lsp-rename)
    nmap <buffer> [g <plug>(lsp-previous-diagnostic)
    nmap <buffer> ]g <plug>(lsp-next-diagnostic)

    let g:lsp_format_sync_timeout = 1000
    autocmd! BufWritePre *.php call execute('LspDocumentFormatSync')
endfunction

augroup lsp_install
    au!
    " call s:on_lsp_buffer_enabled only for languages that has the server registered.
    autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END

augroup User lsp_setup call lsp#register_server({
    \ 'name': 'intelephense',
    \ 'cmd': {server_info->['intelephense', '--stdio']},
    \ 'initialization_options': {"storagePath": "/tmp/intelephense", "clearCache": v:true},
    \ 'whitelist': ['php'],
    \ 'root_uri':{server_info->lsp#utils#path_to_uri(
    \             lsp#utils#find_nearest_parent_file_directory(
    \             lsp#utils#get_buffer_path(),
    \             ['.git/']
    \ ))},
    \ 'workspace_config': { 'intelephense': {
    \   'files.maxSize': 1000000,
    \   'files.associations': ['*.php'],
    \   'trace.server': 'verbose',
    \   'stubs': [
    \         "Memcached",
    \   ],
    \ }},
    \ })
augroup END

" Phpactor
nnoremap <leader>ga :PhpactorGenerateAccessor<cr>
nnoremap <leader>em :PhpactorExtractMethod<cr>
nnoremap <leader>mf :PhpactorMoveFile<cr>
nnoremap <leader>cn :PhpactorClassNew<cr>
nnoremap <leader>ic :PhpactorTransform<cr>

" Blamer
let g:blamer_enabled = 1
let g:blamer_show_in_insert_modes = 0

" TODOTags personalizados
augroup CustomTODOTags
    autocmd!

    autocmd BufWinEnter * let w:m1=matchadd('Error', '\<BROKEN\>\|\<WTF\>', -1)
    autocmd BufWinEnter * let w:m1=matchadd('Todo', '\<HACK\>\|\<BUG\>\|\<REVIEW\>\|\<FIXME\>\|\<TODO\>\|\<NOTE\>', -1)
augroup END

" Personaliza Lightline
" Obtiene el método actual para mostrarlo desde Vista
function! NearestMethodOrFunction() abort
    return 'ƒ() ' . get(b:, 'vista_nearest_method_or_function', '')
endfunction
augroup VistaNearestMethodOrFunction
    autocmd!

    autocmd VimEnter * call vista#RunForNearestMethodOrFunction()
augroup END

let g:lightline = {
      \ 'colorscheme': 'base16lightline',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified', 'method' ] ],
      \   'right': [ [ 'lineinfo' ],
      \              [ 'percent' ],
      \              [ 'fileformat', 'fileencoding', 'filetype', 'charvaluehex' ] ]
      \ },
      \ 'component': {
      \   'charvaluehex': '0x%B'
      \ },
      \ 'component_function': {
      \   'gitbranch': 'gitbranch#name',
      \   'method': 'NearestMethodOrFunction'
      \ }
      \ }

" Hitspop
highlight link hitspopErrorMsg ErrorMsg

" Personaliza indentLines
let g:indentLine_defaultGroup = 'SpecialKey'
let g:indentLine_char_list = ['|', '¦', '┆', '┊']

" .conf files syntax highlighting
autocmd BufRead,BufNewFile *.conf setf dosini
