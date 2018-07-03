"
"        _
" __   _(_)_ __ ___  _ __ ___
" \ \ / / | '_ ` _ \| '__/ __|
"  \ V /| | | | | | | | | (__
" (_)_/ |_|_| |_| |_|_|  \___|
"
" Configuración personalizada de mi editor de texto favorito :3
"

"""
" PLUG
"

" Inicialización del excelente gestor de plugins Plug
let vimplug_exists=expand('~/.vim/autoload/plug.vim')

if !filereadable(vimplug_exists)
  echo "Installing Vim-Plug..."
  echo ""
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

  autocmd VimEnter * PlugInstall
endif

call plug#begin(expand('~/.vim/plugged'))

Plug 'tobyS/pdv'
Plug 'dag/vim-fish'
Plug 'chr4/nginx.vim'
Plug 'StanAngeloff/php.vim'
Plug 'airblade/vim-gitgutter'
Plug 'junegunn/limelight.vim'
Plug 'vim-syntastic/syntastic'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'adoy/vim-php-refactoring-toolbox'

call plug#end()

" Establece la carpeta en la que Plug va a instalar los plugins
let vimDir='$HOME/.vim'
let &runtimepath.=','.vimDir

"
" ENDPLUG
"""

"""
" BÁSICOS
"

" Persiste el histórico de deshacer en disco
if has('persistent_undo')
    let myUndoDir=expand(vimDir . '/undodir')
    call system('mkdir ' . vimDir)
    call system('mkdir ' . myUndoDir)
    let &undodir=myUndoDir
    set undofile
endif

colorscheme default " Redundante, pero IndentGuides lo necesita para arrancar

set t_Co=16 " Establece el número máximo de colores disponibles para VIM
set encoding=utf-8 " Codificación del texto por defecto
set expandtab " Convierte los carácteres \\t en espacios
set shiftwidth=4 " Número de espacios a la hora de indentar el código
set softtabstop=4 " Número de espacios correspondientes a una tabulación
set number " Muestra el número de línea actual en la regla de número de líneas
set relativenumber " Muestra una numeración relativa en la regla de número de
                   " líneas
set backspace=indent,eol,start " Permite que el backspace funcione sobre
                               " indentación, inicio de línea y fin de línea
set listchars=eol:↓,tab:»\ ,trail:~,space:· " Establece carácteres para mostrar
                                            " diferentes carácteres invisibles
set list " Especifica que se muestren los carácteres invisibles
" Sobreescribe el color en el que se tiene que mostrar los carácteres
" invisibles
hi SpecialKey ctermfg=239
hi NonText ctermfg=239
set hlsearch " Resalta los resultados de una búsqueda
set incsearch " Especifica que las búsquedas deben ser incrementales
set ignorecase " Establece que no se distinga entra minúscula y mayúscula en
               " las búsquedas
set smartcase " En caso de que el texto contenga mayúsculas y minúsculas,
              " ignora la configuración anterior.
set scrolloff=3 " Hace scroll cuando aún queden el número de líneas
                " especificado

"
" ENDBÁSICOS
"""

"""
" MAPEOS
"

" El carácter \t cambia de pestaña
nnoremap <Tab> gt
" El carácter \T cambia de pestaña hacía atrás
nnoremap <S-Tab> gT
" El carácter T crea una nueva pestaña
nnoremap <silent> <S-t> :tabnew<CR>
" ctrl+j mueve el foco al buffer situado a la izquierda
noremap <C-h> <C-w>h
" ctrl+j mueve el foco al buffer situado abajo
noremap <C-j> <C-w>j
" ctrl+k mueve el foco al buffer situado arriba
noremap <C-k> <C-w>k
" ctrl+l mueve el foco al buffer situado a la derecha
noremap <C-l> <C-w>l

let mapleader="_" " Establece el carácter lider para las diferentes acciones
                  " que se especifican más abajo
" La secuencia leader espacio, desactiva la iluminación de los resultados de
" búsqueda
noremap <leader><space> :noh<CR>
" La secuencia leader h, divide la ventana en dos horizontalmente
noremap <leader>h :<C-u>split<CR>
" La secuencia leader v, divide la ventana en dos veticalmente
noremap <leader>v :<C-u>vsplit<CR>
" La secuencia leader n c, desactiva configuraciones que puedan interferir en
" a la hora de copiar texto
noremap <leader>nc :set nolist<CR>:set norelativenumber<CR>:set nonumber<CR>:IndentGuidesDisable<CR>:GitGutterDisable<CR>
" La secuencia leader c, activa las configuraciones que desactiva la secuencia
" anterior
noremap <leader>c :set list<CR>:set relativenumber<CR>:set number<CR>:IndentGuidesEnable<CR>:GitGutterEnable<CR>

"
" ENDMAPEOS
"""

"""
" AIRLINE
"

let g:airline#extensions#tabline#enabled=1
let g:airline_theme='base16color'

"
" ENDAIRLINE
"""

"""
" SYNTASTIC
"

let g:syntastic_php_checkers=['php', 'phpcs', 'phpmd']

"
" ENDSYNTASTIC
"""

"""
" INDENT-GUIDES
"

let g:indent_guides_enable_on_vim_startup=1
let g:indent_guides_start_level=2
let g:indent_guides_guide_size=1
let indent_guides_auto_colors=0

" Establece los colores en los que se tienen que mostrar las guías
hi IndentGuidesOdd ctermbg=239
hi IndentGuidesOdd ctermfg=239
hi IndentGuidesEven ctermbg=239
hi IndentGuidesEven ctermfg=239

"
" ENDINDENT-GUIDES
"""

"""
" MISC
"

" Añade resaltado a las etiquetas de notas no soportadas por defecto
au BufWinEnter * let w:m1=matchadd('Error', '\<BROKEN\>\|\<WTF\>', -1)
au BufWinEnter * let w:m1=matchadd('Todo', '\<HACK\>\|\<BUG\>\|\<REVIEW\>\|\<FIXME\>\|\<TODO\>\|\<NOTE\>', -1)

"
" ENDMISC
"""
