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
"   - <c-x><c-o>     :: Autocompletado usando ALE
"   - <space>n       :: Alterna visualización de Netrw
"   - <space>k       :: Mueve línea actual hacia arriba (funciona con selecciones)
"   - <space>j       :: Mueve línea actual hacia abajo (funciona con selecciones)
"   - <space><space> :: Alterna entre los dos últimos buffers abiertos
"   - <space>B       :: Crea un nuevo buffer
"   - <tab>          :: Cambia al siguiente buffer
"   - <s-tab>        :: Cambia al buffer anterior
"   - <space>bq      :: Elimina el buffer actual
"   - <space>ba      :: Elimina todos los buffers
"   - <c-]>          :: Ir a la definición del tag actual
"   - g<c-]>         :: Listado de tags por palabra actual
"   - <c-[h|j|k|l]>  :: Navega entre las diferentes ventanas abiertas
"
" RESUMEN DE COMANDOS:
"   - lwindow  :: Lista de mensajes de ALE
"   - find     :: Busca un archivo recursivamente desde :pwd (funciona con RegExp)
"   - MakeTags :: Crea los tags recursivamente desde :pwd
"   - split    :: Divide la ventana en horizontal
"   - vplit    :: Divice la ventana en vertical
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
  Plug 'ayu-theme/ayu-vim'
call plug#end()

" Definición de constantes interesantes
let vimDir='$HOME/.vim'
let &runtimepath.=','.vimDir

" Básicos
syntax on
filetype plugin on

colorscheme ayu
let ayucolor="dark"

set termguicolors
set laststatus=2
set backspace=indent,eol,start
set path+=**
set wildmenu
set scrolloff=3
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

" Mantenimiento de histórico de cambios persistente
if has('persistent_undo')
    let myUndoDir=expand(vimDir . '/undodir')
    call system('mkdir ' . vimDir)
    call system('mkdir ' . myUndoDir)
    let &undodir=myUndoDir
    set undofile
endif

" Generación de tags
command! MakeTags !ctags -R --languages=php,ruby . &> /dev/null &
augroup PreSaveTasks
    autocmd!

    autocmd BufWritePre *.php :silent MakeTags
    autocmd BufWritePre *.rb :silent MakeTags
    " Elimina espacios al guardar
    autocmd BufWritePre * :%s/\s\+$//e
augroup END

" Define la tecla líder
let mapleader="\<space>"

" Movimiento de líneas
nnoremap <leader>k :m-2<cr>==
nnoremap <leader>j :m+<cr>==

" Movimiento de selección
xnoremap <leader>k :m-2<cr>gv=gv
xnoremap <leader>j :m'>+<cr>gv=gv

" Mantiene selección después de tabulación
vnoremap < <gv
vnoremap > >gv

" Mejora el visualizado y comportamiento de NEWTRW
nnoremap <leader>n :Lexplore<CR>
let g:netrw_banner=0
let g:netrw_browse_split=4
let g:netrw_altv=1
let g:netrw_liststyle=3
let g:netrw_list_hide=netrw_gitignore#Hide()
let g:netrw_list_hide.=',\(^\|\s\s\)\zs\.\S\+'

" Gestión de buffers (¡No uses pestañas!)
nnoremap <leader>B :enew<cr>
nnoremap <Tab> :bnext<cr>
nnoremap <S-Tab> :bprevious<cr>
nnoremap <leader>bq :bp <bar> bd! #<cr>
nnoremap <leader>ba :bufdo bd!<cr>
nnoremap <leader><leader> <c-^>
nnoremap <silent> <c-h> :wincmd h<cr>
nnoremap <silent> <c-j> :wincmd j<cr>
nnoremap <silent> <c-k> :wincmd k<cr>
nnoremap <silent> <c-l> :wincmd l<cr>

" Atajos para tokens de PHP
inoremap ≤ =>
inoremap ≥ ->
inoremap ' ''<Left>
inoremap " ""<Left>
inoremap ( ()<Left>
inoremap [ []<Left>
inoremap { {}<Left>

" Sobreescribe las teclas de movimiento
let g:camelcasemotion_key = '<leader>'

" Habilita autocompletado de ALE (^x^o)
let g:ale_completion_enabled=1
set omnifunc=ale#completion#OmniFunc
" Hace que ALE solo compruebe al guardar para aumentar velocidad
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_insert_leave = 0

" Personaliza Lightline
let g:lightline = {
      \ 'colorscheme': 'ayu',
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

" TODOTags personalizados
augroup CustomTODOTags
    autocmd!

    autocmd BufWinEnter * let w:m1=matchadd('Error', '\<BROKEN\>\|\<WTF\>', -1)
    autocmd BufWinEnter * let w:m1=matchadd('Todo', '\<HACK\>\|\<BUG\>\|\<REVIEW\>\|\<FIXME\>\|\<TODO\>\|\<NOTE\>', -1)
augroup END
