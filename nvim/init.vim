set number

set number
set expandtab
set autoindent
set smartindent
set softtabstop=4
set shiftwidth=4
set tabstop=4

let g:airline_theme='bubblegum'

highlight Normal guibg=none
highlight NonText guibg=none
highlight Normal ctermbg=none
highlight NonText ctermbg=none

call plug#begin()

    Plug 'kyazdani42/nvim-web-devicons' " for file icons
    Plug 'kyazdani42/nvim-tree.lua'
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'

call plug#end()

"Enable mouse click for nvim
set mouse=
"Fix cursor replacement after closing nvim
"set guicursor=
"Shift + Tab does inverse tab
inoremap <S-Tab> <C-d>

"See invisible characters
set list listchars=tab:>\ ,trail:+,eol:$

"wrap to next line when end of line is reached
set whichwrap+=<,>,[]
