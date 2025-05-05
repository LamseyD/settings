"Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
"If you're using tmux version 2.2 or later, you can remove the outermost $TMUX check and use tmux's 24-bit color support
"(see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more information.)
if (empty($TMUX))
  if (has("nvim"))
    "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  "For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
  "Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
  " < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
  if (has("termguicolors"))
    set termguicolors
  endif
endif

set nocompatible "Forget being compatible with good ol' vi
let g:onedark_hide_endofbuffer = 1 "enable buffer line at the top
let g:onedark_termcolors = 256 "show buffer line only when at least 2 buffers are open
let g:onedark_terminal_italics = 1 "show numbers in buffer line
syntax on "turn on syntax highlighting
colorscheme onedark

"tab settings
"set expandtab "expand tabs to spaces
set tabstop=4 "number of spaces that a <tab> in the file counts for
set softtabstop=4 "number of spaces that a <tab> counts for while performing editing operations
set shiftwidth=4
set autoindent "automatically align to indentation for a new line

set hlsearch " turn on search pattern highlighting
set ignorecase " ignore case when searching...
set smartcase " ... unless pattern has uppercase character
set incsearch " enable incremental matches
"set list " display tabs and line endings
set listchars=trail:-,tab:-- " change the way tabs and line ends are displayed
set number "show line number in files
set backspace=2 "allow backspace to delete characters
set hidden "allow multiple files to opened in different buffers, 'hidden' in the background
set wildmenu "Enable enhanced command-line completion
set lazyredraw "no screen redraw while executing macros, registers and other commands that haven't been typed
set autochdir "change the working directory to the directory in which the file being opened lives
set cursorline "highlight current line
set cinoptions=:0,b1: "align switch case and break on switch statement
set history=1000 "remember 1000 commands/search strings
set sessionoptions-=options "when a session is saved, do not store vimrc options
set autoread "reread file if an external program has changed a file
autocmd Filetype c setlocal textwidth=132  "max 132 characters in a line for c files

let g:snipMate = { 'snippet_version' : 1 }
"set default shell within vim to zsh
if !empty(glob('/usr/bin/zsh'))
    set shell=/usr/bin/zsh
endif

if empty(glob('~/.vim/autoload/plug.vim'))
	silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
else
	"plugin installed, load plugins
	call plug#begin('~/.vim/plugged')
		" airline plugin
		Plug 'vim-airline/vim-airline'
		Plug 'vim-airline/vim-airline-themes'

		"Plugins to support snips
		Plug 'MarcWeber/vim-addon-mw-utils'
		Plug 'tomtom/tlib_vim'
		Plug 'garbas/vim-snipmate'
		Plug 'honza/vim-snippets'

		"Git plugins
		Plug 'airblade/vim-gitgutter'
		Plug 'tpope/vim-fugitive'
		Plug 'gregsexton/gitv', {'on': ['Gitv']}
		"rhubarb is used for :Gbrowse command
		Plug 'tpope/vim-rhubarb'

		"Marks :help signature
		Plug 'kshenoy/vim-signature'

		"Make Org files look better
		Plug 'jceb/vim-orgmode'
	call plug#end()
endif

let g:airline#extensions#tabline#enabled = 1 "enable buffer line at the top
let g:airline#extensions#tabline#buffer_min_count = 2 "show buffer line only when at least 2 buffers are open
let g:airline#extensions#tabline#buffer_idx_mode = 1 "show numbers in buffer line
