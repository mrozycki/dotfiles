set encoding=utf-8
set backspace=2
set nocompatible
execute pathogen#infect()
let g:go_disable_autoinstall = 1

"""
" Colors
"""
colorscheme molokai
set cursorline
function Showcase ()
  if &background == "light"
    set guifont=Powerline_Consolas:h12:cEASTEUROPE
    colorscheme molokai
    set background=dark
    set relativenumber
  else
    set guifont=Powerline_Consolas:h16:cEASTEUROPE
    colorscheme solarized
    set background=light
    set norelativenumber
  end
endfunction

"""
" Line breaks and 80 column margin
"""
let &colorcolumn=join(range(81,999),",")
highlight ColorColumn ctermbg=235 guibg=#2c2d27
set nowrap
set linebreak
set breakat=80

"""
" Tabs
"""
set tabstop=8
set softtabstop=4
set shiftwidth=4
set noexpandtab

"""
" Start in documents directory by default
"""
cd $HOME\Documents
cd %:p:h

"""
" Line numbering
"""
set number
set relativenumber

"""
" Syntax
"""
syntax on
set autoindent

"""
" Statusline (uses airline)
"""
set laststatus=2
set statusline=%n\ %f\ %m
set statusline+=%=%c,%l
let g:airline_powerline_fonts = 1
let g:airline#extentions#branch#enabled = 1
let g:airline#extensions#hunks#enabled = 1
let g:airline_section_b = '%n'
let g:airline_section_y = '%{airline#util#wrap(airline#extensions#branch#get_head(),0)}'
let g:airline_section_x = '%{airline#util#wrap(airline#parts#ffenc(),0)}'
let g:airline_section_warning = '%r'

function GetSFName ()
  let sfname = join(split(expand('%f'),'\'),'  ')
  if match(expand('%f'), '\') == 0 
    return ' '.sfname
  else
    return sfname
  endif
endfunction

let g:airline_section_c = "%{airline#util#wrap(GetSFName(),0)}"
let g:airline#extensions#tabline#enabled = 1

"""
" GUI
"""
set guioptions=a
set guifont=Powerline_Consolas:h12:cEASTEUROPE
au GUIEnter * simalt ~s
if has("gui_running")
  autocmd GUIEnter * set vb t_vb=
endif

"""
" Spellcheck
"""
set spelllang=en_us
set spell

function SpellcheckToggle()
  if &spell == 1
    set nospell
  else
    set spell
  end
endfunction

function SpellcheckLanguageToggle()
  if &spelllang == "en_gb"
    set spelllang="pl"
  else
    set spelllang="en_gb"
  end
endfunction

"""
" Building tools
"""
function Build()
  w
  let type = expand("%:e")

  if type == "tex" || type == "latex"
    :!pdflatex "%"

  elseif type == "cpp" 
    :!g++ "%" -Wall -O2 -o "%:r.exe"
  
  elseif type == "c"
    :!gcc "%" -Wall -O2 -o "%:r.exe"

  elseif type == "d"
    :!dmd %

  elseif type == "py"
    :!python %

  elseif type == "java"
    :!javac %

  elseif type == "js"
    :!node %

  elseif type == "php"
    :!php %

  elseif type == "vim"
    :source %

  endif
endfunction

function BuildRun ()
  w
  let type = expand("%:e")

  if type == "cpp" 
    :!g++ "%" -Wall -O2 -o "%:r.exe" && "%:r.exe"

  elseif type == "c"
    :!gcc % -Wall -O2 -o %:r.exe && %:r.exe

  elseif type == "d"
    :!dmd % && %:r.exe

  elseif type == "java"
    :!javac % && cls && java %:r

  elseif type == "sml"
    :!mosml %

  else
    :call Build()

  endif
endfunction

"""
" Keys
"""
map , <C-W>
map <C-W>m :NERDTree<CR>

map <F3> :call Showcase()<CR>
map <F5> :call Build()<CR>
imap <F5> <ESC>:call Build()<CR>i
map <F6> :call BuildRun()<CR>
imap <F6> <ESC>:call BuildRun()<CR>i
map <F9> :call SpellcheckToggle()<CR>
map <C-F9> :call SpellcheckLanguageToggle()<CR>
