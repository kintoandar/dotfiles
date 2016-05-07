""""""""""""""""""""""
" blog.kintoandar.com
""""""""""""""""""""""

""""""" PATHOGEN """"""""
execute pathogen#infect()
execute pathogen#helptags()

"YouCompleteMe
"ag.vim
"ctrlp.vim
"gundo.vim nerdtree
"syntastic
"ultisnips
"vim-airline
"vim-fugitive
"vim-json
"vim-ruby
"vim-snippets
"jedi-vim

"""""""" COLOR SCHEME """"""""
""let g:solarized_termcolors=256
colorscheme solarized
set t_Co=256
syntax enable
set background=dark

"""""""" GLOBAL """"""""
set nocompatible          " old vi compatibility
set nobackup              " don't save a working copy
set ruler                 " show the cursor position all the time
set completeopt=menuone   " auto-complete ctrl-x ctrl-p
set history=100           " keep last commands
"set clipboard=unnamed    " +p paste OS clipboard
"set modeline             " load configs as a comment from files (insecure)
"set smartindent
"set autoindent
set tabstop=2
"set softtabstop=2
set expandtab
set shiftwidth=2
set nrformats-=octal
set cursorline
set shortmess+=I " Disable welcome message
set encoding=utf-8 " Set default encoding
set hidden " Hide buffers on switching instead of abandoning them
set autoread " Autoload hidden buffers on change
" j and k go by actual line on the screen and not the entire wrapped line
nnoremap j gj
nnoremap k gk
" Make backspace work
set backspace=indent,eol,start
filetype plugin on " load plugins
highlight SpecialKey term=standout ctermbg=red guibg=red
set listchars=tab:▸\ ,eol:¬,trail:~,extends:>,precedes:<,nbsp:_
" Maintain viminfo file
set viminfo='10,\"100,:20,%,n~/.vimstash/viminfo

set backupdir=~/.vimstash/backups
set directory=~/.vimstash/swaps
if exists("&undodir")
  set undofile
  set undodir=~/.vimstash/undo
endif

augroup vimrc
  autocmd!
augroup END

" Restore last edit location when opening a file
autocmd vimrc BufReadPost * if line("'\"") > 0 && line ("'\"") <= line("$") | exe "normal g'\"" | endif

""""""""" SEARCH """"""""
set ignorecase " Ignore case when searching
set smartcase " Unless the search term has capital letters
"set gdefault " Global search and replace by default; use s/a/b/g to override
set incsearch " Start searching as soon as text is typed
"set showmatch " Jump back to matching bracket briefly when closing one is inserted.
set hlsearch " Highlight search results. Can be annoying, so

"""""""" KEY SHORTCUTS """"""""
" Stop accidentally triggering help
inoremap <F1> <ESC>
nnoremap <F1> <ESC>
vnoremap <F1> <ESC>

let mapleader = ","
" leader+space will clear it.
nnoremap <leader><space> :noh<cr>

" Meh, using leader key is much faster!
noremap <F2> :set fileformat=unix<CR>
noremap <F3> :set list!<CR>
noremap <F4> :GundoToggle<CR>
noremap <F5> :set paste!<CR>
noremap <F6> :let g:syntastic_quiet_messages = {}<CR>
" HEX editor
noremap <F7> :%!xxd<CR>
noremap <F8> :%!xxd -r<CR>
noremap <F9> :w !sudo tee %<CR>

nnoremap <leader>u :GundoToggle<CR>
nnoremap <leader>p :set paste!<CR>
nnoremap <leader>t :NERDTreeToggle<CR>
nnoremap <leader>l :set list!<CR>
nnoremap <leader>n :set relativenumber! number!<CR>
nnoremap <leader>g :GitGutterSignsToggle<CR>
nnoremap <leader>c :NeoComplCacheEnable<CR>
nnoremap <leader>y :let g:ycm_auto_trigger=0<CR>
nnoremap <leader>Y :let g:ycm_auto_trigger=1<CR>
nnoremap <leader>s :w !sudo tee %<CR>

" buffer navigation
map gl :bn<cr>
map gh :bp<cr>
map gd :bd<CR>
map gb :ls<CR>

" hardmode
"noremap <Up> <NOP>
"noremap <Down> <NOP>
"noremap <Left> <NOP>
"noremap <Right> <NOP>

"""""""" FILETYPE SPECIFICS """"""""

"""""""" PYTHON
au FileType python setlocal expandtab tabstop=4 shiftwidth=4 colorcolumn=120

"""""""" RUBY
au FileType ruby setlocal expandtab tabstop=2 shiftwidth=2 colorcolumn=120
au BufRead,BufNewFile Vagrantfile set filetype=ruby

"""""""" PERL
"au FileType perl setlocal tabstop=8 expandtab shiftwidth=8 softtabstop=8

"""""""" BASH
"au FileType sh setlocal tabstop=8 expandtab shiftwidth=8 softtabstop=8

"""""""" YAML
"au BufNewFile,BufRead *.yaml,*.yml setf yaml

"""""""" JSON
"setfiletype json
let g:vim_json_syntax_conceal = 0

"""""""" PLUGIN SPECIFICS """"""""

"""""""" YCM
let g:ycm_register_as_syntastic_checker=0
let g:ycm_auto_trigger=1
let g:ycm_key_list_select_completion=['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion=['<C-p>', '<Up>']
let g:ycm_path_to_python_interpreter = '/usr/local/Cellar/python/2.7.11/bin/python'

"""""""" ULTISNIPS
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsListSnippets="<c-tab>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"

"""""""" SYNTASTIC
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0
let g:syntastic_error_symbol = 'x'
let g:syntastic_warning_symbol = '!'
let g:syntastic_style_error_symbol = '>>'
let g:syntastic_style_warning_symbol = '>'
let g:syntastic_auto_loc_list = 1
let g:syntastic_enable_signs = 1
"let g:syntastic_quiet_messages = {'level': 'warnings'}
let g:syntastic_python_flake8_args='--ignore=F403'
let g:syntastic_python_flake8_args = "--max-line-length=120"
let g:syntastic_python_checkers = ['flake8', 'pylint']
"let g:syntastic_disabled_filetypes = ['html']
"let g:syntastic_json_checker = "jsonlint"
"let g:syntastic_ruby_checkers = ['rubocop']

"""""""" VIM-GUTTER
let g:gitgutter_max_signs = 500

"""""""" CTRLP
let g:ctrlp_working_path_mode='a'
" Setup some default ignores
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/](\.(git|hg|svn)|\_site)$',
  \ 'file': '\v\.(exe|so|dll|class|png|jpg|jpeg)$',
\}
" Open as tab
let g:ctrlp_prompt_mappings = {
  \ 'AcceptSelection("e")': ['<c-t>'],
  \ 'AcceptSelection("b")': ['<cr>', '<2-LeftMouse>'],
\}

"""""""" NERDTree

"""""""" AIRLINE
set laststatus=2
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline_detect_paste=1
"let g:airline#extensions#tabline#fnamemod = ':t'
" Workaround for leaving insert mode delay with statusline active
if ! has('gui_running')
  set ttimeoutlen=10
  augroup FastEscape
    autocmd!
    au InsertEnter * set timeoutlen=0
    au InsertLeave * set timeoutlen=1000
  augroup END
endif
