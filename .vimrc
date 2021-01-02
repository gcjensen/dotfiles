""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" .vimrc as found at https://github.com/gcjensen/dotfiles
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Remove trailing whitespace
autocmd FileType,BufRead * autocmd BufWritePre <buffer> %s/\s\+$//e

" Ensure .md is read as markdown
autocmd BufNewFile,BufReadPost *.md set filetype=markdown

" Use visual bell instead of beeping
set noerrorbells visualbell t_vb=
set vb

" Show line numbers
set number

" Show matching brackets
set showmatch

" Incremental search
set incsearch

" Autoindent
autocmd FileType perl set autoindent|set smartindent

" 4-space width tabs for go
autocmd Filetype go setlocal tabstop=4 shiftwidth=4 softtabstop=4

" 4 space tabs for perl and some config files
autocmd FileType,BufRead *.pm,*.pl,*.t,perl,*.conf set tabstop=4|set shiftwidth=4|set expandtab|set

" 2 space tabs for js, html and scss
autocmd FileType,BufRead javascript,*.ts,*.tsx,*.jsx,html,*.scss,*.css,*json,*.tt,*.xml,*.json set tabstop=2|set shiftwidth=2|set expandtab|set

" JavaScript syntax highlighting for TypeScript
autocmd FileType,BufRead *ts set syntax=javascript
autocmd FileType *ts setlocal commentstring=// %s

let g:prettier#autoformat = 0
let g:prettier#config#arrow_parens = 'always'
autocmd BufWritePre *.js,*ts,*.tsx,*.jsx,*.css,*.scss,*.md,*.mdx,*.html Prettier

" Make tab in v mode ident code
vmap <tab> >gv
vmap <s-tab> <gv

" Make tab in normal mode ident code
nmap <tab> I<tab><esc>
nmap <s-tab> ^i<bs><esc>

" Comment/uncomment blocks of code (in vmode)
vmap _c :s/^/#/gi<Enter>
vmap _C :s/^#//gi<Enter>

" Run perltidy ona line with _t:
nnoremap <silent> _t :%!perltidy -q<Enter>
vnoremap <silent> _t :!perltidy -q<Enter>

" Syntax hightlighting for perl test scripts
autocmd BufRead *.t set syntax=perl

" Color scheme
colorscheme ron

" Grey comments
highlight Comment ctermfg=Grey ctermbg=None gui=NONE guifg=Grey guibg=NONE

highlight Error ctermfg=LightRed ctermbg=None gui=NONE guifg=Grey guibg=NONE
highlight SpellBad ctermfg=Red ctermbg=LightRed gui=NONE guifg=Grey guibg=NONE

" Grey line numbers
highlight LineNr term=bold cterm=NONE ctermfg=DarkGrey ctermbg=NONE gui=NONE guifg=DarkGrey guibg=NONE

" Black line at 80 chars to help keep lines in check
set colorcolumn=80
highlight ColorColumn ctermbg=Black gui=NONE guibg=Black

" Set lowercase searches to be case insensitive, but uppercase searches to be
" case sensitive
set ignorecase
set smartcase

" disable automatic comment insertions
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" Display open filename in tmux tab bar
autocmd BufReadPost,FileReadPost,BufNewFile,BufEnter * call system("tmux rename-window 'vim | " . expand("%:t") . "'")

" Unbind arrow keys!
noremap <up> <nop>
noremap <down> <nop>
noremap <left> <nop>
noremap <right> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>

let g:ale_typescript_tslint_use_global = 1
let g:ale_completion_enabled = 1
let g:ale_lint_on_text_changed = 'normal'
let g:ale_lint_on_insert_leave = 1
let g:ale_linters_ignore = {'typescript': ['tslint', 'eslint']}

" save swap files to ~/.vim/tmp/swap
set directory=~/.vim/tmp/swap

" Automatically install vim-plug if not already installed
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

Plug 'tpope/vim-commentary'
Plug 'leafgarland/typescript-vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'prettier/vim-prettier', { 'do': 'yarn install' }
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

call plug#end()
