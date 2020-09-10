"
"        _
" __   _(_)_ __ ___  _ __ ___
" \ \ / / | '_ ` _ \| '__/ __|
"  \ V /| | | | | | | | | (__
" (_)_/ |_|_| |_| |_|_|  \___|
"
" ==========================================================================
"
" RESUMEN DE ATAJOS:
"   - <c-x><c-o>       :: Autocompletado usando ALE
"   - <leader>n        :: Alterna visualización de Netrw
"   - d                :: En Netrw, crea un directorio
"   - %                :: En Netrw, crea un archivo
"   - D                :: En Netrw, elimina el nodo sobre el que se encuentra el cursor
"   - <leader>k        :: Mueve línea actual hacia arriba (funciona con selecciones)
"   - <leader>j        :: Mueve línea actual hacia abajo (funciona con selecciones)
"   - <leader><leader> :: Alterna entre los dos últimos buffers abiertos
"   - <leader>B        :: Crea un nuevo buffer
"   - <tab>            :: Cambia al siguiente buffer
"   - <s-tab>          :: Cambia al buffer anterior
"   - <leader>bq       :: Elimina el buffer actual
"   - <leader>ba       :: Elimina todos los buffers
"   - <c-]>            :: Ir a la definición del tag actual
"   - g<c-]>           :: Listado de tags por palabra actual
"   - <c-[h|j|k|l]>    :: Navega entre las diferentes ventanas abiertas
"   - <leader>u        :: Añade la cláusula \"use\" del elemento dónde se encuentre el cursor
"   - <leader>e        :: Expande el elemento donde se encuentre el cursor a un espacio de nombre completo
"   - <leader>em       :: Extraer selección a método
"   - <leader>rlv      :: Renombrar variable local
"   - <leader>ep       :: Hace que la variable local pase a ser propiedad de la clase
"   - <leader>fi       :: Busca clases que implementen la interfaz donde se encuentre el cursor
"   - <leader>fe       :: Busca clases que extiendan la clase donde se encuentre el cursor
"   - <leader>fu       :: Busca usos del elemento donde se encuentre el cursor
"   - <leader>+        :: Amplía la ventana actual
"   - <leader>-        :: Reduce la ventana actual
"   - <leader>cf       :: Saca Clap para archivos
"   - <leader>cb       :: Saca Clap para buffers
"   - <leader>c        :: Saca Clap de forma genérica
"   - <leader>l        :: Entrar/salir en modo foco
"
" RESUMEN DE COMANDOS:
"   - lwindow  :: Lista de mensajes de ALE
"   - find     :: Busca un archivo recursivamente desde :pwd (funciona con RegExp)
"   - MakeTags :: Crea los tags recursivamente desde :pwd
"   - tag      :: Busca un tag
"   - split    :: Divide la ventana en horizontal
"   - vplit    :: Divide la ventana en vertical
"   - close    :: Cierra la ventana actual
"

" Autodescarga de VimPlug
let vimplug_exists=expand('~/.vim/autoload/plug.vim')

if !filereadable(vimplug_exists)
  echo "Installing Vim-Plug..."
  echo ""
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

  autocmd VimEnter * PlugInstall
endif

" Carga de plugins
call plug#begin(expand('~/.vim/plugged'))
  Plug 'bkad/CamelCaseMotion'
  Plug 'chr4/nginx.vim'
  Plug 'editorconfig/editorconfig-vim'
  Plug 'dense-analysis/ale'
  Plug 'itchyny/lightline.vim'
  Plug 'itchyny/vim-gitbranch'
  Plug 'airblade/vim-gitgutter'
  Plug 'takac/vim-hardtime'
  Plug 'chriskempson/base16-vim'
  Plug 'mike-hearn/base16-vim-lightline'
  Plug 'junegunn/limelight.vim'
  Plug 'vim-vdebug/vdebug'
  Plug 'arnaud-lb/vim-php-namespace'
  Plug 'adoy/vim-php-refactoring-toolbox'
  Plug 'mileszs/ack.vim'
  Plug 'lumiliet/vim-twig'
  Plug 'liuchengxu/vista.vim'
  Plug 'liuchengxu/vim-clap'
  Plug 'osyo-manga/vim-over'
  Plug 'andymass/vim-matchup'
  Plug 'morhetz/gruvbox'
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

colorscheme base16-solarized-dark

set background=dark
set termguicolors
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
set cursorline
set colorcolumn=80,120
set tw=119

" Define la tecla líder
let mapleader=","

" Generación de tags
command! MakeTags !ctags -R --languages=php . &> /dev/null &
augroup PreSaveTasks
    autocmd!

    autocmd BufWritePre *.php :silent MakeTags
    " Elimina espacios al guardar
    autocmd BufWritePre * :%s/\s\+$//e
augroup END

" Asistente para espacios de nombres de PHP
function! IPhpInsertUse()
    call PhpInsertUse()
    call feedkeys('a',  'n')
endfunction

function! IPhpExpandClass()
    call PhpExpandClass()
    call feedkeys('a', 'n')
endfunction

augroup PhpNamespacesHelper
    autocmd!

    autocmd FileType php inoremap <leader>u <esc>:call IPhpInsertUse()<cr>
    autocmd FileType php inoremap <leader>e <esc>:call IPhpExpandClass()<cr>
augroup END

" Navegación de código PHP
function! PhpImplementations(word)
    exe 'Ack "implements.*' . a:word . ' *($|{)"'
endfunction

function! PhpSubclasses(word)
    exe 'Ack "extends.*' . a:word . ' *($|{)"'
endfunction

function! PhpUsage(word)
    exe 'Ack "::' . a:word . '\(|>' . a:word . '\("'
endfunction

nnoremap <leader>fi :call PhpImplementations('<cword>')<cr>
nnoremap <leader>fe :call PhpSubclasses('<cword>')<cr>
nnoremap <leader>fu :call PhpUsage('<cword>')<cr>

" Movimiento de líneas
nnoremap <leader>k :move-2<cr>==
nnoremap <leader>j :move+<cr>==

" Movimiento de selección
xnoremap <leader>k :move-2<cr>gv=gv
xnoremap <leader>j :move'>+<cr>gv=gv

" Mantiene selección después de tabulación
vnoremap < <gv
vnoremap > >gv

" Mejora el visualizado y comportamiento de NEWTRW
nnoremap <leader>n :Lexplore<cr>
let g:netrw_banner=0
let g:netrw_browse_split=4
let g:netrw_altv=1
let g:netrw_liststyle=3
let g:netrw_winsize = 25

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

" Atajos para tokens de PHP
inoremap ≤ =>
inoremap ≥ ->
inoremap ' ''<left>
inoremap " ""<left>
inoremap ( ()<left>
inoremap [ []<left>
inoremap { {}<left>


" Sobreescribe las teclas de movimiento
let g:camelcasemotion_key = '<leader>'

" Habilita autocompletado de ALE (^x^o)
let g:ale_completion_enabled=1
set omnifunc=ale#completion#OmniFunc
" Hace que ALE solo compruebe al guardar para aumentar velocidad
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_insert_leave = 0
let g:ale_php_phpcs_executable='~/.composer/vendor/bin/phpcs'

" Personaliza Lightline
let g:lightline = {
      \ 'colorscheme': 'base16_solarized_dark',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ],
      \   'right': [ [ 'lineinfo' ],
      \              [ 'percent' ],
      \              [ 'fileformat', 'fileencoding', 'filetype', 'charvaluehex' ] ]
      \ },
      \ 'component': {
      \   'charvaluehex': '0x%B'
      \ },
      \ 'component_function': {
      \   'gitbranch': 'gitbranch#name'
      \ }
      \ }

" Limelight
nnoremap <leader>l :Limelight!!<cr>
xnoremap <leader>l :Limelight!!<cr>

" Ack
if executable('ag')
    let g:ackprg = 'ag --vimgrep'

    augroup AckRelated
        autocmd!

        autocmd QuickFixCmdPost [^l]* nested cwindow
    augroup END
endif

" Clap
nnoremap <leader>c :Clap<cr>
nnoremap <leader>cf :Clap files<cr>
nnoremap <leader>cb :Clap buffers<cr>

" TODOTags personalizados
augroup CustomTODOTags
    autocmd!

    autocmd BufWinEnter * let w:m1=matchadd('Error', '\<BROKEN\>\|\<WTF\>', -1)
    autocmd BufWinEnter * let w:m1=matchadd('Todo', '\<HACK\>\|\<BUG\>\|\<REVIEW\>\|\<FIXME\>\|\<TODO\>\|\<NOTE\>', -1)
augroup END
