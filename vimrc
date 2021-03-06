" ------------------------------------------------------------------------------
"          FILE: .vimrc
"   DESCRIPTION: Vim configuration file. Based heavily on Sorin Ionescu"s.
"        AUTHOR: Will Raxworthy.
" ------------------------------------------------------------------------------

" ------------------------------------------------------------------------------
" General Settings
" ------------------------------------------------------------------------------
command! W :w                                " Seriously, it's not like :W is bound
                                             " to anything anyway.
set nocompatible                             " Turn off vi compatibility.
set undolevels=1000                          " Large undo levels.
set undofile                                 " Save undo tree.
set undodir=/tmp                             " Undo tree directory.
set history=50                               " Size of command history.
set encoding=utf8                            " Always use unicode.
set backspace=indent,eol,start               " Fix backspace.

set nobackup                                 " Disable backups.
set nowritebackup
set noswapfile

set notimeout                                " Fix lag in iTerm.
set ttimeout
set timeoutlen=50
set nomodeline
set selection=inclusive                      " Select to the end of line.

set spelllang=en_au                          " Set spell check language.
set tags+=tags                               " Enable tags.

" ------------------------------------------------------------------------------
" Vim Plug
" ------------------------------------------------------------------------------

call plug#begin('~/.vim/plugged')

Plug 'tomtom/tcomment_vim'
Plug 'tpope/vim-fugitive'
Plug 'godlygeek/tabular'
Plug 'henrik/rename.vim'
Plug 'skalnik/vim-vroom'
Plug 'dyng/auto_mkdir'
Plug 'rking/ag.vim'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'w0rp/ale'
Plug 'jparise/vim-graphql'
Plug 'prettier/vim-prettier', { 'do': 'yarn install' }
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'willrax/vim-colors'
Plug 'tpope/vim-obsession'

call plug#end()

" ------------------------------------------------------------------------------
" Binds
" ------------------------------------------------------------------------------
let mapleader = ","

map <Left> <Nop>
map <Right> <Nop>
map <Up> <Nop>
map <Down> <Nop>

" Ag
nnoremap <leader>a :Ag<space>

" Rename buffer
nnoremap <Leader><Leader>r :Rename!<space>

" Fugitive Status
map <Leader>s :Gstatus<CR>

" Remap esc
imap jj <ESC>

" Use v to toggle visual mode.
vno v <esc>

nmap <Leader>n :nohlsearch<CR>

" airline
"
" let g:airline_powerline_fonts = 1
let g:airline_theme = 'base16_eighties'

" ------------------------------------------------------------------------------
" vroom
" ------------------------------------------------------------------------------
let g:vroom_map_keys = 0
let g:vroom_use_dispatch = 0
let g:vroom_use_spring = 1

" ------------------------------------------------------------------------------
" Ctrl-p
" ------------------------------------------------------------------------------
let g:ctrlp_map = "<Leader>t"
let g:ctrlp_user_command = 'rg -l ""'

" ------------------------------------------------------------------------------
" Search and Replace
" ------------------------------------------------------------------------------
set incsearch                     " Show partial matches as search is entered.
set hlsearch                      " Highlight search patterns.
set ignorecase                    " Enable case insensitive search.
set smartcase                     " Disable case insensitivity if mixed case.
set wrapscan                      " Wrap to top of buffer when searching.
set gdefault                      " Make search and replace global by default.

" ------------------------------------------------------------------------------
" White Space
" ------------------------------------------------------------------------------
set tabstop=2                     " Set tab to equal 4 spaces.
set softtabstop=2                 " Set soft tabs equal to 4 spaces.
set shiftwidth=2                  " Set auto indent spacing.
set shiftround                    " Shift to the next round tab stop.
set expandtab                     " Expand tabs into spaces.
set smarttab                      " Insert spaces in front of lines.
set listchars=tab:··,trail:·      " Show leading whitespace
set list

" ------------------------------------------------------------------------------
" Presentation
" ------------------------------------------------------------------------------
let base16colorspace=256
colorscheme base16-material

set shortmess=aIoO                " Show short messages, no intro.
set ttyfast                       " Fast scrolling when on a decent connection.
set nowrap                        " Wrap text.
set showcmd                       " Show last command.
set ruler                         " Show the cursor position.
set hidden                        " Allow hidden buffers.
set showmatch                     " Show matching parenthesis.
set matchpairs+=<:>               " Pairs to match.
set cf                            " Enable error jumping.
syntax on                         " Enable syntax highlighting.
filetype on                       " Detect file type.
filetype indent on                " Enable file indenting.
filetype plugin indent on         " Load syntax files for better indenting.
highlight ColorColumn ctermbg=236 guibg=#262D51

" ------------------------------------------------------------------------------
" User Interface
" ------------------------------------------------------------------------------

if has("mouse")
    set mouse=a                   " Enable mouse everywhere.
    set mousemodel=popup_setpos   " Show a pop-up for right-click.
    set mousehide                 " Hide mouse while typing.
endif

" ------------------------------------------------------------------------------
" Ale
" ------------------------------------------------------------------------------
let g:ale_sign_column_always = 1

" ------------------------------------------------------------------------------
" Language Client
" ------------------------------------------------------------------------------
let g:LanguageClient_autoStart = 1

nnoremap <silent> K :call LanguageClient_textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient_textDocument_definition()<CR>
nnoremap <silent> <F2> :call LanguageClient_textDocument_rename()<CR>

" ------------------------------------------------------------------------------
" Status Line
" ------------------------------------------------------------------------------

" Always show status.
set laststatus=2

" Disable status line fill chars.
set fillchars+=stl:\ ,stlnc:\ " Space.

au FileType ruby setlocal tabstop=2 softtabstop=2 shiftwidth=2 colorcolumn=121 textwidth=120
au FileType html,haml,scss setlocal tabstop=2 softtabstop=2 shiftwidth=2
au FileType go setlocal tabstop=4 shiftwidth=4 noexpandtab nolist
au FileType javascript,js setlocal tabstop=2 shiftwidth=2 softtabstop=2 colorcolumn=100

" ------------------------------------------------------------------------------
" Functions
" ------------------------------------------------------------------------------

" Strip Trailing Whitespace
function! StripTrailingWhitespace()
    if !&binary && &modifiable && &filetype != "diff"
        let l:winview = winsaveview()
        %s/\s\+$//e
        let @/=""
        call winrestview(l:winview)
    endif
endfunction
nnoremap <leader>W :call StripTrailingWhitespace()<CR>

let g:ale_linters = {
      \  'javascript': ['eslint'],
      \  'ruby': ['ruby'],
      \  'scss': ['prettier', 'sass-lint', 'scss-lint', 'stylelint'],
      \  'html': ['HTMLHint', 'proselint', 'tidy', 'write-good'],
      \}

autocmd BufNewFile,BufRead *.ts set syntax=javascript

" Load any local project specific configurations.
silent! so .vimlocal
