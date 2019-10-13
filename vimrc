if &compatible
  set nocompatible
endif

augroup MyAutoCmd
  autocmd!
augroup END

let s:cache_home = empty($XDG_CACHE_HOME) ? expand('~/.cache') : $XDG_CACHE_HOME
let s:dein_dir = s:cache_home . '/dein'
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

if !isdirectory(s:dein_repo_dir)
  call system('git clone https://github.com/Shougo/dein.vim ' . shellescape(s:dein_repo_dir))
endif
let &runtimepath = s:dein_repo_dir .",". &runtimepath

let s:toml_file = fnamemodify(expand('<sfile>'), ':h').'/dein.toml'
let s:lazy_toml_file = fnamemodify(expand('<sfile>'), ':h').'/lazy_dein.toml'
if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)
  call dein#load_toml(s:toml_file, {'lazy': 0})
  call dein#load_toml(s:lazy_toml_file, {'lazy': 1})
  call dein#end()
  call dein#save_state()
endif

if has('vim_starting') && dein#check_install()
  call dein#install()
endif

let g:python_host_prog  = $PYENV_ROOT . '/versions/neovim2/bin/python'
let g:python3_host_prog = $PYENV_ROOT . '/versions/neovim3/bin/python'
let g:deoplete#enable_at_startup = 1
let g:deoplete#auto_complete_delay = 0
let g:deoplete#auto_complete_start_length = 1

set fencs=utf-8,euc-jp,default

set mouse-=a
set sh=zsh

set termguicolors

syntax on

filetype plugin indent on

set number
set ruler

set spelllang=en,cjk

set expandtab
set shiftwidth=2
set softtabstop=2
set autoindent
set smartindent

set pumheight=10

set showmatch
set matchtime=1

set nohlsearch

set ignorecase
set smartcase
set wildignorecase

set scrolloff=3

set display=lastline
set wrap

set conceallevel=0

set backspace=indent,eol,start

set laststatus=2
set statusline& statusline+=%#StatusLineFilename#%{'٩(๑´3｀)۶@'}%F
set statusline+=%m
set statusline+=%#warningmsg#
set statusline+=%=
set statusline+=%#StatusLineCursorPosition#(%l,%c)/(%L,%{strwidth(getline('.'))})
set statusline+=%{fugitive#statusline()}

set noswapfile
set backupskip=/tmp/*,/private/tmp/*

set nopaste

set vb t_vb=

set guicursor=a:hor5,a:blinkon500,a:blinkoff500,a:blinkwait0

set ambiwidth=double

set tags=tags,vendor.tags

set cursorline
hi clear CursorLine

augroup QfGroup
  au!
  au QuickFixCmdPost *grep* cwindow
augroup END

augroup TrailingSpace
  au!
  au VimEnter,WinEnter,ColorScheme * highlight link TrailingSpaces Error
  au VimEnter,WinEnter * match TrailingSpaces /\s\+$/
augroup END

augroup TwitVimSetting
  au!
  au FileType twitvim set wrap
augroup END

hi StatusLineFilename ctermfg=46 guifg=#00ff00
hi StatusLineCursorPosition ctermfg=184 guifg=#d7d700

" let g:tex_conceal = ''

let g:markdown_syntax_conceal = ''

let g:vim_markdown_folding_disabled=1

let g:unite_enable_start_insert=1

augroup MarkdownCtagsUpdate
  autocmd!
  autocmd BufWritePost,FilterWritePost,FileAppendPost,FileWritePost /Users/nakatam/markdowns/*.md QuickRun -type ctags
augroup END

augroup CppCtagsUpdate
  autocmd!
  "autocmd BufWritePost,FilterWritePost,FileAppendPost,FileWritePost {/Users/nakatam/}\@!*.{cpp\|h} QuickRun -type ctags
augroup END

augroup RemoveSpacesAfterZenkakuPunc
  autocmd!
  autocmd InsertLeave *.tex '[,']s/，\s+/，/ge
  autocmd InsertLeave *.tex '[,']s/．\s+/．/ge
  autocmd InsertLeave *.tex '[,']s/\s\+（/（/ge
  autocmd InsertLeave *.tex '[,']s/（\s\+/（/ge
  autocmd InsertLeave *.tex '[,']s/\s\+）/）/ge
  autocmd InsertLeave *.tex '[,']s/）\s\+/）/ge
  autocmd InsertLeave *.tex '[,']s/\s\+\\defterm/\\defterm/ge
  autocmd InsertLeave *.tex '[,']s/　/ /ge
augroup END

let g:opamshare = substitute(system('opam config var share'),'\n$','','''')
execute 'set rtp+=' . g:opamshare . '/merlin/vim'
execute 'set rtp^=' . g:opamshare . '/ocp-indent/vim'

function! s:ocaml_format()
    let now_line = line('.')
    exec ':%! ocp-indent'
    exec ':' . now_line
endfunction

augroup ocaml_format
    autocmd!
    autocmd BufWrite,FileWritePre,FileAppendPre *.mli\= call s:ocaml_format()
augroup END

augroup ChangeKeywordsOnTeX
  autocmd!
  autocmd BufNewFile,BufRead *.tex setlocal iskeyword=@,48-57,_,-,:,192-255
augroup END

set rtp+=~/.local/share/nvimpager/runtime

let s:config_home = empty($XDG_CONFIG_HOME) ? expand('~/.config') : $XDG_CONFIG_HOME
exec "source " . s:config_home . "/nvim/keymaps/main.vim"

augroup ReadmeFiletype
  autocmd!
  autocmd BufRead,BufNewFile README.md set filetype=markdown.readme
augroup END

augroup SLMIncFT
  autocmd!
  autocmd BufRead,BufNewFile *.h.acdi,*.h.acme,*.h.dadi,*.h.dame set filetype=cpp
augroup END
" ## added by OPAM user-setup for vim / base ## 93ee63e278bdfc07d1139a748ed3fff2 ## you can edit, but keep this line
let s:opam_share_dir = system("opam config var share")
let s:opam_share_dir = substitute(s:opam_share_dir, '[\r\n]*$', '', '')

let s:opam_configuration = {}

function! OpamConfOcpIndent()
  execute "set rtp^=" . s:opam_share_dir . "/ocp-indent/vim"
endfunction
let s:opam_configuration['ocp-indent'] = function('OpamConfOcpIndent')

function! OpamConfOcpIndex()
  execute "set rtp+=" . s:opam_share_dir . "/ocp-index/vim"
endfunction
let s:opam_configuration['ocp-index'] = function('OpamConfOcpIndex')

function! OpamConfMerlin()
  let l:dir = s:opam_share_dir . "/merlin/vim"
  execute "set rtp+=" . l:dir
endfunction
let s:opam_configuration['merlin'] = function('OpamConfMerlin')

let s:opam_packages = ["ocp-indent", "ocp-index", "merlin"]
let s:opam_check_cmdline = ["opam list --installed --short --safe --color=never"] + s:opam_packages
let s:opam_available_tools = split(system(join(s:opam_check_cmdline)))
for tool in s:opam_packages
  " Respect package order (merlin should be after ocp-index)
  if count(s:opam_available_tools, tool) > 0
    call s:opam_configuration[tool]()
  endif
endfor
" ## end of OPAM user-setup addition for vim / base ## keep this line
" ## added by OPAM user-setup for vim / ocp-indent ## 1535ee9d29fb4ddeab65767953f3eab5 ## you can edit, but keep this line
if count(s:opam_available_tools,"ocp-indent") == 0
  source "/home/naughie/.opam/4.08.1/share/ocp-indent/vim/indent/ocaml.vim"
endif
" ## end of OPAM user-setup addition for vim / ocp-indent ## keep this line

augroup TexConcealLevelAndHilight
  autocmd!
  autocmd BufNewFile,BufRead,InsertLeave *.tex setlocal conceallevel=1
  "autocmd InsertEnter *.tex setlocal conceallevel=0
  autocmd BufNewFile,BufRead,InsertLeave *.tex set concealcursor=""
  autocmd BufNewFile,BufRead *.tex hi Conceal ctermbg=NONE guibg=NONE
augroup END

augroup TeXSetSpellAuto
  autocmd!
  autocmd BufNewFile,BufRead *.tex setlocal spell
augroup END