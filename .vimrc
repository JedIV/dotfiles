" Jed's Vim Profile
source ~/dotfiles/vim/autoload/pathogen.vim

" Run pathogen
execute pathogen#infect()

"###################################
"System
"###################################
"Save lots of history
set history=1000

" Set leader to the spacebar
let mapleader = "\<Space>"

" Turn off quotation autocomplete
let b:delimitMate_autoclose = 0

"Set spell check for text files
autocmd FileType gitcommit,mail,mkd,text set spell

"prevent vim from backing up crontabs
set backupskip=/tmp/*,/private/tmp/*

"When you move away from a buffer it will go into the background 
"it doesn't close the buffer when you close the window --needed for :Cdo
set hidden

"Makes it so powerline shows up upon opening vim
set laststatus=2

"Turn on syntax
syntax on

"Allow copy paste across windows
set clipboard=unnamed

"All backspacing over delete, over white space etc.
set backspace=indent,eol,start
"###################################
"Environment
"###################################

"Show the mode
set noshowmode
"Highlight the cursor line 
set cursorline
"Show column and line number at bottom right
set ruler
"Show the line numbers on the side
set number

"Set colorscheme
syntax enable
set background=dark
colorscheme solarized
" Set font and size
set guifont=Menlo:h14
" Highlight the last searched pattern:
set hlsearch
" Show matching brackets and parentheses
set showmatch 
" Ignore case in search
set ignorecase
" find as you type search
set incsearch
"clearing highlighted search using "<space> /"
nmap <silent> <leader>/ :nohlsearch<CR>
"Make search always go the same direction
noremap <silent> n /<CR>
noremap <silent> N ?<CR>

"Show whitespace that includes trailing whitespace.
highlight ExtraWhitespace ctermbg=darkgreen guibg=DarkCyan
nnoremap <Leader>wn :match ExtraWhitespace /\s\+\%#\@<!$/<CR>
nnoremap <Leader>wf :match<CR>
autocmd BufWinEnter * call clearmatches()

"Panic Button
"Space f takes you to the last place you edited
nnoremap <Leader>f `.

"###################################
"Editing
"###################################
" Copy indent from current line when starting a new line 
set autoindent
" wrap long lines
set nowrap
"" Break lines on words
"set linebreak

" In Insert mode: Use the appropriate number of spaces to insert a <Tab>.
" & Set indent to 2 spaces
set expandtab
set tabstop=2
set sw=2
set smarttab

" Map 'jk' to escape
imap jk <esc>


" Allow for pasting multiple lines
xnoremap p pgvy

" Ctrl - j/k deletes blank line below/above, and Alt-j/k inserts.
nnoremap <silent><C-j> m`:silent +g/\m^\s*$/d<CR>``:noh<CR>
nnoremap <silent><C-k> m`:silent -g/\m^\s*$/d<CR>``:noh<CR>
nnoremap <silent><D-j> :set paste<CR>m`o<Esc>``:set nopaste<CR>
nnoremap <silent><D-k> :set paste<CR>m`O<Esc>``:set nopaste<CR>

"Copy and paste to system clipboard with space y and space d
vmap <Leader>y "+y
vmap <Leader>d "+d
nmap <Leader>p "+p
nmap <Leader>P "+P
vmap <Leader>p "+p
vmap <Leader>P "+P


"Paste with space before
nmap <C-p> a <esc>p

" Yank from the cursor to the end of the line, to be consistent with C and D.
nnoremap Y y$

" Map cu to change to underscore
nnoremap cu ct_
nnoremap cU dT_s

" Indent/unindent visual mode selection with tab/shift+tab
vmap <tab> >gv
vmap <s-tab> <gv

"Enable omni completion
filetype plugin on
set omnifunc=syntaxcomplete#Complete
set completeopt=longest,menuone

"Remap <C-P> to <C-p>
"Use ctrl+p to autocomplete from insert mode
imap <C-p> <C-P>
imap <C-n> <C-N>

"Make it easier to navigate to first non-blank character in a line
nnoremap <Leader>0 ^

"use space j to provide the opposite of shift j
map <Leader>j i<CR><Esc>

"In insert mode '\fn' inserts the file name and
" '\fp' inserts the file path
inoremap \fn <C-R>=expand("%:t")<CR>
inoremap \fp <C-R>=expand("%:p:h")<CR>

"###################################
"setting buffers
"###################################
" Opens a new tab with the current buffer's path
" Super useful when editing files in the same directory
map <leader>te :tabedit <c-r>=expand("%:p:h")<cr>/

" Switch CWD to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>:pwd<cr>


"###################################
"Plugins
"###################################
"Nerd tree
map \ :NERDTreeToggle<CR>

"Double tap space to comment
map <leader><leader> <plug>NERDCommenterToggle

"Delimitmate
let delimitMate_matchpairs = "(:),[:],{:}"


"Lightline
let g:lightline = {
      \ 'colorscheme': 'solarized_dark',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'fugitive', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component': {
      \   'readonly': '%{&filetype=="help"?"":&readonly?"RO":""}',
      \   'modified': '%{&filetype=="help"?"":&modified?"+":&modifiable?"":"-"}',
      \   'fugitive': '%{exists("*fugitive#head")?fugitive#head():""}'
      \ },
      \ 'component_visible_condition': {
      \   'readonly': '(&filetype!="help"&& &readonly)',
      \   'modified': '(&filetype!="help"&&(&modified||!&modifiable))',
      \   'fugitive': '(exists("*fugitive#head") && ""!=fugitive#head())'
      \ }
      \ }
"###################################
"Source local .vimrc
"###################################
if filereadable($HOME . "/.vimrc_local")
  source ~/.vimrc.local
endif


:let g:notes_directories = ['~/masters_thesis/notes']
augroup RubyTests
au!
  autocmd BufRead,BufNewFile *_test.rb,test_*.rb,*_spec.rb
      \ :nmap gt V:<C-U>!$HOME/.vim/bin/ruby-run-focused-unit-test
      \ % <C-R>=line("'<")<CR>p <CR>|
      \ :nmap gT :<C-U>!ruby %<CR>
augroup END

"##################################
"For writing Prose
"##################################

func! WordProcessorMode()
  setlocal formatoptions=1 
  setlocal noexpandtab 
  map j gj 
  map k gk
  setlocal spell spelllang=en_us 
  set thesaurus+=/Users/sbrown/.vim/thesaurus/mthesaur.txt
  set complete+=s
  set formatprg=par
  setlocal wrap 
  setlocal linebreak 
endfu 
com! WP call WordProcessorMode()
