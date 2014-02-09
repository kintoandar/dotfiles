""""""""""""""""""""""""""
" kintoandar.blogspot.com
""""""""""""""""""""""""""

"""""""" COLOR SCHEME
"let g:solarized_termcolors=256
set t_Co=256
syntax enable
set background=dark
colorscheme solarized
"syntax on                " syntax highlight

"""""""" GLOBAL
"set nocompatible         " use config defaults
set nobackup              " don't save a working copy
set ruler                 " show the cursor position all the time
set completeopt=menuone   " auto-complete ctrl-x ctrl-p
set history=50            " keep last commands
set clipboard=unnamed     " +p paste OS clipboard
"set modeline             " load configs as a comment from files (insecure)
"set smartindent
"set autoindent
set tabstop=2
"set softtabstop=2
set expandtab
set shiftwidth=2

set incsearch
set hlsearch

filetype plugin on        " load plugins
"""""""" maintain viminfo file
set viminfo='10,\"100,:20,%,n~/.viminfo

"""""""" NERDtree on
noremap <F2> :NERDTreeToggle<CR>

"""""""" line magic
noremap <F3> :set nonumber!<CR>
noremap <F4> :set list!<CR>

"""""""" paste mode on/off
noremap <F5> :set paste!<CR>
"noremap <F6> :set nopaste<CR>

"""""""" hex editor on/off
noremap <F7> :%!xxd<CR>
noremap <F8> :%!xxd -r<CR>

"""""""" sudo save
noremap <F9> :w !sudo tee %<CR>


"""""""" PYTHON
"au FileType python setlocal tabstop=8 expandtab shiftwidth=4 softtabstop=4
" pydiction dictionary load
"let g:pydiction_location = '~/.vim/resources/complete-dict'

"""""""" PERL
"au FileType perl setlocal tabstop=8 expandtab shiftwidth=8 softtabstop=8

"""""""" BASH
"au FileType sh setlocal tabstop=8 expandtab shiftwidth=8 softtabstop=8

"""""""" YAML
"au BufNewFile,BufRead *.yaml,*.yml setf yaml

"""""""" JSON
"setfiletype json
let g:vim_json_syntax_conceal = 0

""""""" pathogen
execute pathogen#infect()

"""""""" syntastic
let g:syntastic_error_symbol = '✖'
let g:syntastic_warning_symbol = '⚠'
let g:syntastic_auto_loc_list=1
let g:syntastic_enable_signs=1
"let g:syntastic_disabled_filetypes=['html']
"let g:syntastic_json_checker="jsonlint"

"""""""" powerline
set rtp+=$HOME/.local/lib/python2.7/site-packages/powerline/bindings/vim/
set laststatus=2
