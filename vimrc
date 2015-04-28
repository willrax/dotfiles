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
" Vundle
" ------------------------------------------------------------------------------
call plug#begin("~/.nvim/plugged")

Plug 'junegunn/rainbow_parentheses.vim'
Plug 'chriskempson/base16-vim'
Plug 'junegunn/seoul256.vim'
Plug 'tomtom/tcomment_vim'
Plug 'tpope/vim-fugitive'
Plug 'bling/vim-airline'
Plug 'ervandew/supertab'
Plug 'godlygeek/tabular'
Plug 'henrik/rename.vim'
Plug 'junegunn/goyo.vim'
Plug 'mustache/vim-mode'
Plug 'skalnik/vim-vroom'
Plug 'tpope/vim-rails'
Plug 'dyng/auto_mkdir'
Plug 'kien/ctrlp.vim'
Plug 'elzr/vim-json'
Plug 'rking/ag.vim'
Plug 'junegunn/limelight.vim'

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

" Save and run tests in Ruby

au FileType ruby nmap <Leader>r :wa<CR>:VroomRunTestFile<CR>
au FileType ruby nmap <Leader>R :wa<CR>:VroomRunNearestTest<CR>
au FileType ruby imap <Leader>r <ESC>:wa<CR>:VroomRunTestFile<CR>
au FileType ruby imap <Leader>R <ESC>:wa<CR>:VroomRunNearestTest<CR>

" Goyo
"
map <Leader>go :Goyo<CR>

autocmd User GoyoEnter Limelight
autocmd User GoyoLeave Limelight!

" airline
"
let g:airline_powerline_fonts = 1

" ------------------------------------------------------------------------------
" vroom
" ------------------------------------------------------------------------------
let g:vroom_map_keys = 0
let g:vroom_use_dispatch = 0
let g:vroom_use_spring = 1

" ------------------------------------------------------------------------------
" CtrlP
" ------------------------------------------------------------------------------
let g:ctrlp_map = "<Leader>t"
let g:ctrlp_user_command = "ag %s -l --nocolor -g ''"

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
colo seoul256
let g:seoul256_background = 234

set background=dark

if has("gui_running")
    set guioptions-=m             " Disable menu bar.
    set guioptions-=T             " Disable the tool bar bar.
    set guioptions-=l             " Disable left scrollbar.
    set guioptions-=L             " Disable left scrollbar when split.
    set guioptions-=r             " Diable right scrollbar.
    set guioptions-=a             " Do not auto copy selection to clipboard.

    " If MacVim do some specific things.
    set guifont=Monaco:h16
    set lines=52                      " Window size.
    set columns=165
    set vb                            " Disable the audible bell.
endif

if has("mouse")
    set mouse=a                   " Enable mouse everywhere.
    set mousemodel=popup_setpos   " Show a pop-up for right-click.
    set mousehide                 " Hide mouse while typing.
endif

" ------------------------------------------------------------------------------
" Status Line
" ------------------------------------------------------------------------------

" Always show status.
set laststatus=2

" Disable status line fill chars.
set fillchars+=stl:\ ,stlnc:\ " Space.

" ------------------------------------------------------------------------------
" Rainbow Parenthesis
" ------------------------------------------------------------------------------
au VimEnter * :RainbowParentheses!!

au FileType coffee setlocal tabstop=2 softtabstop=2 shiftwidth=2
au FileType ruby setlocal tabstop=2 softtabstop=2 shiftwidth=2 colorcolumn=121 textwidth=120
au FileType html,haml,scss setlocal tabstop=2 softtabstop=2 shiftwidth=2
au FileType go setlocal tabstop=4 shiftwidth=4 noexpandtab nolist
au FileType javascript,js setlocal tabstop=2 shiftwidth=2 softtabstop=2

au BufNewFile,BufRead Vagrantfile,Berksfile set filetype=ruby

" Don"t hide quotes in JSON.
let g:vim_json_syntax_conceal = 0

" When not in a Rails project, vim-rails doesn"t highlight
" RSpec files. Do it manually.
if !exists(":Rails!")
  function! SyntaxForRspec()
    syn keyword rubyRspec describe context it its specify shared_context shared_examples_for it_should_behave_like it_behaves_like before after around subject fixtures controller_name helper_name scenario feature background
    syn match rubyRspec "\<let\>!\="
    syn keyword rubyRspec violated pending expect double mock mock_model stub_model
    syn match rubyRspec "\.\@<!\<stub\>!\@!"
    highlight def link rubyRspec Function
  endfunction
  au BufNewFile,BufRead *_spec.rb call SyntaxForRspec()
endif

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
