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
"   - <leader>n        :: Alterna visualización de Fern
"   - <leader>nr       :: Revela la ubicación de un archivo en Fern
"   - a                :: En Fern, hace aparecer el menu de acciones
"   - +                :: En Fern, expande una carpeta
"   - -                :: En Fern, colapsa una carpeta
"   - <leader>k        :: Mueve línea actual hacia arriba (funciona con selecciones)
"   - <leader>j        :: Mueve línea actual hacia abajo (funciona con selecciones)
"   - <leader><leader> :: Alterna entre los dos últimos buffers abiertos
"   - <leader>B        :: Crea un nuevo buffer
"   - <tab>            :: Cambia al siguiente buffer
"   - <s-tab>          :: Cambia al buffer anterior
"   - <leader>bq       :: Elimina el buffer actual
"   - <leader>ba       :: Elimina todos los buffers
"   - <c-[h|j|k|l]>    :: Navega entre las diferentes ventanas abiertas
"   - <leader>+        :: Amplía la ventana actual
"   - <leader>-        :: Reduce la ventana actual
"   - <leader>cf       :: Saca Clap para archivos
"   - <leader>cb       :: Saca Clap para buffers
"   - <leader>c        :: Saca Clap de forma genérica
"   - <leader>l        :: Entrar/salir en modo foco
"   - <leader>v        :: Muestra la lista de símbolos
"   - <leader><space>  :: Sale del modo búsqueda
"
" RESUMEN DE COMANDOS:
"   - find     :: Busca un archivo recursivamente desde :pwd (funciona con RegExp)
"   - MakeTags :: Crea los tags recursivamente desde :pwd
"   - tag      :: Busca un tag
"   - split    :: Divide la ventana en horizontal
"   - vplit    :: Divide la ventana en vertical
"   - close    :: Cierra la ventana actual
"   - Ack      :: Busca una cadena de texto recursivamente desde :pwd
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
  Plug 'bkad/CamelCaseMotion'
  Plug 'chr4/nginx.vim'
  Plug 'editorconfig/editorconfig-vim'
  Plug 'itchyny/lightline.vim'
  Plug 'itchyny/vim-gitbranch'
  Plug 'itchyny/vim-cursorword'
  Plug 'airblade/vim-gitgutter'
  Plug 'takac/vim-hardtime'
  Plug 'junegunn/limelight.vim'
  Plug 'vim-vdebug/vdebug'
  Plug 'mileszs/ack.vim'
  Plug 'lumiliet/vim-twig'
  Plug 'liuchengxu/vista.vim'
  Plug 'liuchengxu/vim-clap'
  Plug 'osyo-manga/vim-over'
  Plug 'andymass/vim-matchup'
  Plug 'APZelos/blamer.nvim'
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  Plug 'phpactor/phpactor', {'for': 'php', 'branch': 'master', 'do': 'composer install --no-dev -o'}
  Plug 'obcat/vim-hitspop'
  Plug 'sonph/onehalf', { 'rtp': 'vim' }
  Plug 'chrisbra/Colorizer'
  Plug 'lambdalisue/fern.vim'
  Plug 'nathanaelkane/vim-indent-guides'
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
set colorcolumn=80,120
set tw=119
set termguicolors
set listchars=eol:↓,tab:»\ ,trail:~,space:·
set list
set cursorline
set noshowmode

" Define la tecla líder
let mapleader=","
let maplocalleader="_"

" Generación de tags
command! MakeTags !ctags -R --languages=php . &> /dev/null &
augroup PreSaveTasks
    autocmd!

    autocmd BufWritePre *.php :silent MakeTags
    " Elimina espacios al guardar
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
  autocmd FileType fern set norelativenumber nolist
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

" Atajos para tokens de PHP
inoremap ≤ =>
inoremap ≥ ->
inoremap ' ''<left>
inoremap " ""<left>
inoremap ( ()<left>
inoremap [ []<left>
inoremap { {}<left>

" Elimina búsqueda actual
nnoremap <silent> <leader><space> :<C-u>nohlsearch<cr>

" Sobreescribe las teclas de movimiento
let g:camelcasemotion_key = '<leader>'

" Vista
let g:vista#renderer#enable_icon = 0

nnoremap <silent> <leader>v :Vista!!<cr>

colorscheme onehalfdark

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
let g:clap_open_preview = 'never'
let g:clap_theme = g:colors_name
let g:clap_current_selection_sign = { 'text': '❯', 'texthl': "ClapCurrentSelectionSign", "linehl": "ClapCurrentSelection"}

" Phpactor
nnoremap <leader>gtd :PhpactorGotoDefinition<cr>
nnoremap <leader>gti :PhpactorGotoImplementations<cr>
nnoremap <leader>fr :PhpactorFindReferences<cr>
nnoremap <leader>cc :PhpactorCompleteConstructor<cr>
nnoremap <leader>ga :PhpactorGenerateAccessor<cr>
nnoremap <leader>em :PhpactorExtractMethod<cr>
nnoremap <leader>mc :PhpactorMoveFile<cr>
nnoremap <leader>cm :PhpactorContextMenu<cr>

" Blamer
let g:blamer_enabled = 1
let g:blamer_show_in_insert_modes = 0
if g:colors_name == 'onehalflight'
    highlight Blamer guibg=#f0f0f0 ctermbg=255 guifg=#a0a1a7 ctermbg=247
elseif g:colors_name == 'onehalfdark'
    highlight Blamer guibg=#313640 ctermbg=237 guifg=#5c6370 ctermbg=241
endif

" TODOTags personalizados
augroup CustomTODOTags
    autocmd!

    autocmd BufWinEnter * let w:m1=matchadd('Error', '\<BROKEN\>\|\<WTF\>', -1)
    autocmd BufWinEnter * let w:m1=matchadd('Todo', '\<HACK\>\|\<BUG\>\|\<REVIEW\>\|\<FIXME\>\|\<TODO\>\|\<NOTE\>', -1)
augroup END

" HACK: corrige el tintado de los espacios en blanco
if g:colors_name == 'onehalflight'
    highlight SpecialKey guifg=#e5e5e5 ctermfg=252
elseif g:colors_name == 'onehalfdark'
    highlight SpecialKey guifg=#373C45 ctermfg=239
endif

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
      \ 'colorscheme': g:colors_name,
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

" Activa y personaliza vim-indent-guides
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_start_level = 2
let g:indent_guides_guide_size = 1
let g:indent_guides_auto_colors = 0
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd guibg='#373C45' ctermbg=239 guifg='#373C45' ctermfg=239
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg='#373C45' ctermbg=239 guifg='#373C45' ctermfg=239
