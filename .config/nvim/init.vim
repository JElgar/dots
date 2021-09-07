
"  __      _______ __  __ _____   _____   "  
"  \ \    / /_   _|  \/  |  __ \ / ____|  "
"   \ \  / /  | | | \  / | |__) | |       "
"    \ \/ /   | | | |\/| |  _  /| |       "
"     \  /   _| |_| |  | | | \ \| |____   "
"      \/   |_____|_|  |_|_|  \_\\_____|  "
"                                         "
"
                                      
call plug#begin('~/.config/nvim/plugged')

" LSP
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/completion-nvim'

" Colour Scheme
Plug 'morhetz/gruvbox'
Plug 'ap/vim-css-color'

" File navigation
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'

" Pane navigation
Plug 'christoomey/vim-tmux-navigator'

"" Python
Plug 'plytophogy/vim-virtualenv'
Plug 'psf/black', { 'branch': 'stable' }
Plug 'tmhedberg/SimpylFold'

"" Codi - Repl
Plug 'metakirby5/codi.vim'

"Latex
Plug 'lervag/vimtex'

" Status line
Plug 'itchyny/lightline.vim'

" Flutter
Plug 'dart-lang/dart-vim-plugin'

" Lorem Ipsum
Plug 'vim-scripts/loremipsum'

" FZF
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'airblade/vim-rooter'

" Markdown
Plug 'JamshedVesuna/vim-markdown-preview'

" Git
Plug 'tpope/vim-fugitive'

" Vim Zoom
Plug 'dhruvasagar/vim-zoom'

" Folding
Plug 'Konfekt/FastFold'

" Syntax highlight
Plug 'sheerun/vim-polyglot'

" Doc Gen
Plug 'kkoomen/vim-doge', { 'do': { -> doge#install() } }

" Sneak
Plug 'justinmk/vim-sneak'

" CSV
Plug 'chrisbra/csv.vim'

"" Scary frontend world
" JavaScript support
Plug 'pangloss/vim-javascript'
" TypeScript and TypeScriptReact syntax
Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'
" JS and JSX syntax
Plug 'maxmellon/vim-jsx-pretty'
" GraphQL syntax
Plug 'jparise/vim-graphql'

" Debugging
Plug 'puremourning/vimspector'

"""" Other """"
Plug 'szw/vim-maximizer'
" For moving around func args
Plug 'PeterRincker/vim-argumentative'

call plug#end()

" Map leader to space
nnoremap <SPACE> <Nop>
let mapleader=" "
let maplocalleader=","

" fzf mapping
nmap <leader><leader> fzf#vim#complete#path('fd')
nmap <leader><s> fzf#vim#complete#path('fd')


" Use Control A as Escape
imap <C-A> <Esc>
vmap <C-A> <Esc>
nmap <C-A> <Esc>
imap jk <Esc>

syntax on
set background=dark
set number
set relativenumber
set tabstop=4
set softtabstop=2 shiftwidth=2 expandtab
set mouse=a
set encoding=UTF-8

" Colour scheme 
set termguicolors     " enable true colors support
" let ayucolor="light"  " for light version of theme
" let ayucolor="mirage" " for mirage version of theme
"let ayucolor="dark"   " for dark version of theme
let gruvbox_contrast_dark="medium" " soft, medium or hard
colorscheme gruvbox
highlight Pmenu ctermbg=black guibg=#1f2937
" colorscheme ayu
"
" Status bar colourscheme
let g:lightline = {
\ 'colorscheme': 'seoul256',
\ 'active': {
\   'left': [ [ 'mode', 'paste' ],
\             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'FugitiveHead'
      \ },
      \ }

"" Auto compile with F5
autocmd Filetype rmd map <F5> :!echo<space>"require(rmarkdown);<space>render('<c-r>%')"<space>\|<space>sudo<space>R<space>--vanilla<enter>

"Map Ctrl + E and Ctrl + E then e to save and quit
"map <C-E> :w<CR> 
"map <C-E>e :wq<CR>
nnoremap <C-e> <C-w>
nmap <C-e>m <Plug>(zoom-toggle)
" Splits
set splitbelow
" set splitrig
"
"map - // in visual to search for selection
vnoremap // y/\V<C-R>=escape(@",'/\')<CR><CR>

" Control P Setup
let g:ctrlp_map = '<c-p>'

" Vim Wiki Setup.
let g:vimwiki_folding='custom'
let g:vimwiki_list = [{'path': '~/Documents/uni/Notes/', 'syntax': 'markdown', 'ext': '.Rmd'}, {'path': '~/Documents/IB/', 'syntax': 'markdown', 'ext': '.Rmd'}]

" Folding
set foldmethod=expr
function! RmdFold()
		let line = getline(v:lnum)
		if match(line, '^\\begin') > -1
				return ">1"
		elseif match(line, '^\\end') > -1
				return "<1"
		else
				return "="
		endif
endfunction
set foldlevelstart=20

autocmd Filetype vimwiki setlocal foldmethod=expr foldexpr=RmdFold()

"NERD Tree
nnoremap <silent> <C-n>:NERDTreeToggle<Enter>
"nnoremap <silent> <Leader>e :CocCommand explorer<CR>
let NERDTreeQuitOnOpen = 1
let NERDTreeAutoDeleteBuffer = 1
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1

" Yaml
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

" Python

"" Format on save
autocmd BufWritePre *.py execute ':Black'

" Linting
let g:syntastic_cpp_checkers = ['cpplint']
let g:syntastic_c_checkers = ['cpplint']
let g:syntastic_cpp_cpplint_exec = 'cpplint'
" The following two lines are optional. Configure it to your liking!
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 1

"" Folding
" let g:SimpylFold_docstring_preview = 1

"" Execute selection
xnoremap <leader>p :w !python<cr>

" nnoremap <silent> <leader>ff za 
" nnoremap <silent> <leader>fdo zO
" nnoremap <silent> <leader>fdc zC
" nnoremap <silent> <leader>fao zR
" nnoremap <silent> <leader>fac zM

" lsp
set completeopt=menuone,noinsert,noselect
let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy']
lua require'lspconfig'.pyright.setup{on_attach=require'completion'.on_attach}


" Source other configs
source $HOME/.config/nvim/configs/fzf.vim
source $HOME/.config/nvim/configs/fugitive.vim
source $HOME/.config/nvim/configs/lsp.vim

" Doc Gen
" g:doge_doc_standard_python = "google"

" Debugging
let g:vimspector_install_gadgets = [ 'debugpy' ]
