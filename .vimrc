"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" by Amix - http://amix.dk/
"
" Maintainer: redguardtoo <chb_sh@hotmail.com>, Amir Salihefendic <amix3k at gmail.com>
" Version: 2.1
" Last Change: 21/03/08 23:00:01
" fix some performance issue and syntax bugs
" Last Change: 12/08/06 13:39:28
" Fixed (win32 compatible) by: redguardtoo <chb_sh at gmail.com>
" This vimrc file is tested on platforms like win32,linux, cygwin,mingw
" and vim7.0, vim6.4, vim6.1, vim5.8.9 by redguardtoo
"
"
" Tip:
" If you find anything that you can't understand than do this:
" help keyword OR helpgrep keyword
" Example:
" Go into command-line mode and type helpgrep nocompatible, ie.
" :helpgrep nocompatible
" then press <leader>c to see the results, or :botright cw
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" by Wei Ding<dingwei2u@gmail.com>
"
" Version: 0.1
" Last Change: 29/08/08 23:00:01
" fix some performance issue and syntax bugs
" Begin....
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


" put this line first in ~/.vimrc
set nocompatible | filetype indent plugin on | syn on

fun! SetupVAM()
  let c = get(g:, 'vim_addon_manager', {})
  let g:vim_addon_manager = c
  let c.plugin_root_dir = expand('$HOME', 1) . '/.vim/vim-addons'
  " most used options you may want to use:
  " let c.log_to_buf = 1
  " let c.auto_install = 0
  let &rtp.=(empty(&rtp)?'':',').c.plugin_root_dir.'/vim-addon-manager'
  if !isdirectory(c.plugin_root_dir.'/vim-addon-manager/autoload')
    execute '!git clone --depth=1 git://github.com/MarcWeber/vim-addon-manager '
        \       shellescape(c.plugin_root_dir.'/vim-addon-manager', 1)
  endif

  " This provides the VAMActivate command, you could be passing plugin names, too
  call vam#ActivateAddons(['vim-pi','Command-T','tComment','surround','Pydiction','closetag','OmniCppComplete','Source_Explorer_SrcExpl','dbext','grep','guicolorscheme','LargeFile','minibufexplorer','multvals','snipmate','Supertab','taglist','valgrind'], {})
endfun

call SetupVAM()

" ACTIVATING PLUGINS

" OPTION 1, use VAMActivate
" VAMActivate

" OPTION 2: use call vam#ActivateAddons
call vam#ActivateAddons([], {})
" use <c-x><c-p> to complete plugin names

" OPTION 3: Create a file ~/.vim-srcipts putting a PLUGIN_NAME into each line
" See lazy loading plugins section in README.md for details
" call vam#Scripts('~/.vim-scripts', {'tag_regex': '.*'})


" The screen's title can automatically be updated to the name of
" the currently opend file, or whatever you like.
if &term =~ '^screen'
  let &titlestring = hostname() . "[vim:(" . expand("%:t") . ")]"
  exe "set title t_ts=\<ESC>k"
  exe "set title t_fs=\<ESC>\\"
endif
if &term =~ '^screen' || &term =~ '^rxvt' || &term =~ '^xterm'
  set title
endif

"
" 在状态栏显示目前所执行的指令，未完成的指令片段亦
" 会显示出来
set showcmd
set showmode

set completeopt=longest,menu
" set runtimepath+=~/.vim/textmateOnly
" set runtimepath+=~/.vim/after

so /home/wed3/.vim/vim-addons/Supertab/plugin/supertab.vim

let g:SuperTabRetainCompletionType = 2
let g:SuperTabDefaultCompletionType = ""

" 启动的时候不显示那个援助索马里儿童的提示
set shortmess=atI


" 在单词中间断行
set nolinebreak

"搜索不分大小写
set ic

"设置帮助语言
if version >= 603
  set helplang=cn
  set encoding=utf-8
endif

"打开自己工程的时候自动加载的脚本
if getfsize(".vimscript")>0
  source .vimscript
endif


"valgrind 相关
let g:valgrind_arguments='--leak-check=yes --num-callers=5000'


"---------------------------------------------------------------
" Use of dictionaries
"---------------------------------------------------------------
"
set complete+=k           " scan the files given with the 'dictionary' option
"字典完成
" Need pacman -S words

set dictionary-=/usr/share/dict/words dictionary+=/usr/share/dict/words

"cscope
if has("cscope")
  set csprg=/usr/bin/cscope
  set csto=0
  set nocst
  set nocsverb
  " add any database in current directory
  if filereadable("cscope.out")
    cs add cscope.out
    " else add database pointed to by environment
  elseif $CSCOPE_DB != ""
    cs add $CSCOPE_DB
  endif
  set csverb
endif
map <C-_> :cstag <C-R>=expand("<cword>")<CR><CR>
nmap <C-_>s :cs find s <C-R>=expand("<cword>")<CR><CR>
nmap <C-_>g :cs find g <C-R>=expand("<cword>")<CR><CR>
nmap <C-_>c :cs find c <C-R>=expand("<cword>")<CR><CR>
nmap <C-_>t :cs find t <C-R>=expand("<cword>")<CR><CR>
nmap <C-_>e :cs find e <C-R>=expand("<cword>")<CR><CR>
nmap <C-_>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
nmap <C-_>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
nmap <C-_>d :cs find d <C-R>=expand("<cword>")<CR><CR>

" Using 'CTRL-spacebar' then a search type makes the vim window
" split horizontally, with search result displayed in
" the new window.

nmap <C-Space>s :scs find s <C-R>=expand("<cword>")<CR><CR>
nmap <C-Space>g :scs find g <C-R>=expand("<cword>")<CR><CR>
nmap <C-Space>c :scs find c <C-R>=expand("<cword>")<CR><CR>
nmap <C-Space>t :scs find t <C-R>=expand("<cword>")<CR><CR>
nmap <C-Space>e :scs find e <C-R>=expand("<cword>")<CR><CR>
nmap <C-Space>f :scs find f <C-R>=expand("<cfile>")<CR><CR>
nmap <C-Space>i :scs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
nmap <C-Space>d :scs find d <C-R>=expand("<cword>")<CR><CR>

" Hitting CTRL-space *twice* before the search type does a vertical
" split instead of a horizontal one

nmap <C-Space><C-Space>s
      \:vert scs find s <C-R>=expand("<cword>")<CR><CR>
nmap <C-Space><C-Space>g
      \:vert scs find g <C-R>=expand("<cword>")<CR><CR>
nmap <C-Space><C-Space>c
      \:vert scs find c <C-R>=expand("<cword>")<CR><CR>
nmap <C-Space><C-Space>t
      \:vert scs find t <C-R>=expand("<cword>")<CR><CR>
nmap <C-Space><C-Space>e
      \:vert scs find e <C-R>=expand("<cword>")<CR><CR>
nmap <C-Space><C-Space>i
      \:vert scs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
nmap <C-Space><C-Space>d
      \:vert scs find d <C-R>=expand("<cword>")<CR><CR>
"runtime ftplugin/man.vim
let Vimplate = "$HOME/bin/vimplate"
fun! ReadMan()
 " Assign current word under cursor to a script variable:
 let s:man_word = expand('<cword>')

  " Open a new window:
  :exe ":wincmd n"

  " Read in the manpage for man_word (col -b is for formatting):
  :exe ":r!man " . s:man_word . " | col -b"

  " Goto first line...
  :exe ":goto"

  " and delete it:
  :exe ":delete"
endfun

"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Autocommands
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
"加上日期 对应F2
:map <F2> gg:read !date<CR>

" bind :CD to :cd %:h, then change cwd to the dir that includes current file
sil! com -nargs=0 CD exe 'cd %:h'

" F5编译和运行C程序，F6编译和运行C++程序
" 请注意，下述代码在windows下使用会报错
" 需要去掉./这两个字符

" C的编译和运行
map <F5> :call CompileRunGcc()<CR>
func! CompileRunGcc()
  exec "w"
  exec "!gcc -Wall -g % -o %<"
  exec "! ./%<"
endfunc

" C++的编译和运行
map <F6> :call CompileRunGpp()<CR>
func! CompileRunGpp()
  exec "w"
  exec "!g++ -Wall -g % -o %<"
  exec "! ./%<"
endfunc

" 能够漂亮地显示.NFO文件
set encoding=utf-8
function! SetFileEncodings(encodings)
  let b:myfileencodingsbak=&fileencodings
  let &fileencodings=a:encodings
endfunction
function! RestoreFileEncodings()
  let &fileencodings=b:myfileencodingsbak
  unlet b:myfileencodingsbak
endfunction

au BufReadPre *.nfo call SetFileEncodings('cp437')|set ambiwidth=single
au BufReadPost *.nfo call RestoreFileEncodings()

" 高亮显示普通txt文件（需要txt.vim脚本）
"au BufRead,BufNewFile *  setfiletype txt

" Map the M key to the ReadMan function:
map M :call ReadMan()<CR>

"csupport
let g:alternateNoDefaultAlternate = 1

"a.vim
nnoremap <silent> <F12> :A<CR>

nmap wm :WMToggle<cr>

" 双反斜杠\\即可打开bufexplorer
map <leader><leader> \be
" Ctrl+Enter也可以切换buffer
map C-Enter C-Tab
nnoremap <silent> <F4> :tabprevious<CR>

:set cscopequickfix=s-,c-,d-,i-,t-,e-
nnoremap <silent> <F3> :Grep<CR>

":inoremap ( ()<ESC>i
":inoremap ) <c-r>=ClosePair(')')<CR>
":inoremap { {}<ESC>i
":inoremap } <c-r>=ClosePair('}')<CR>
":inoremap [ []<ESC>i
":inoremap ] <c-r>=ClosePair(']')<CR>
":inoremap < <><ESC>i
":inoremap > <c-r>=ClosePair('>')<CR>

function ClosePair(char)
  if getline('.')[col('.') - 1] == a:char
    return "\<Right>"
  else
    return a:char
  endif
endf

" mapping
" 如果下拉菜单弹出，回车映射为接受当前所选项目，否则，仍映射为回车；
"
" 如果下拉菜单弹出，CTRL-J映射为在下拉菜单中向下翻页。否则映射为CTRL-X CTRL-O；
"
" 如果下拉菜单弹出，CTRL-K映射为在下拉菜单中向上翻页，否则仍映射为CTRL-K；
"
" 如果下拉菜单弹出，CTRL-U映射为CTRL-E，即停止补全，否则，仍映射为CTRL-U；
inoremap <expr> <CR>       pumvisible()?"\<C-Y>":"\<CR>"
inoremap <expr> <C-J>      pumvisible()?"\<PageDown>\<C-N>\<C-P>":"\<C-X><C-O>"
inoremap <expr> <C-K>      pumvisible()?"\<PageUp>\<C-P>\<C-N>":"\<C-K>"

inoremap <expr> <C-U>      pumvisible()?"\<C-E>":"\<C-U>"a

inoremap <expr> <cr>       pumvisible() ? "\<c-y>" : "\<c-g>u\<cr>"
inoremap <expr> <c-n>      pumvisible() ? "\<c-n>" : "\<c-n>\<c-r>=pumvisible() ? \"\\<down>\" : \"\\<cr>\""
inoremap <expr> <m-;>      pumvisible() ? "\<c-n>" : "\<c-x>\<c-o>\<c-n>\<c-p>\<c-r>=pumvisible() ? \"\\<down>\" : \"\\<cr>\""

"
"----------------------------------------------------------------
" Various settings
"----------------------------------------------------------------
"
set autowrite             " write a modified buffer on each :next , ...
set browsedir  =current   " which directory to use for the file browser
" 自动换行显示
set nowrap                " do not wrap lines

" multi-encoding setting
if has("multi_byte")
			"文字编码加入utf8
			" 设定默认解码
			set fenc=utf-8
			set enc=utf-8
			let &termencoding=&encoding

			"set bomb
			set fileencodings=usc-bom,utf-8,euc-jp,euc-kr,gb18030,gbk,gb2312,big5,cp936,latin1
			" CJK environment detection and corresponding setting
			if v:lang =~"^zh_CN"
							set encoding=cp936
							set termencoding=cp936
							set fileencoding=cp936
			elseif v:lang =~"^zh_TW"
							set encoding=big5
							set termencoding=big5
							set fileencoding=big5
			elseif v:lang=~"^ko"
							set encoding=euc-kr
							set termencoding=euc-kr
							set fileencoding=euc-kr
			elseif v:lang=~"^ja_JP"
							set encoding=euc-jp
							set termencoding=euc-jp
							set fileencoding=euc-jp
	endif
	"Detect UTF-8 locale, and replace CJK setting if needed
	if v:lang =~"utf8$" || v:lang =~"UTF-8$"
		set encoding=utf-8
		set termencoding=utf-8
		set fileencoding=utf-8
	endif
else
	echoerr "Sorry,this version of (g)vim was not compiled with multi_byte"
endif

" 使用英文菜单,工具条及消息提示
set langmenu=none

" 使用http://www.vim.org/scripts/script.php?script_id=1506
" http://vim.wikia.com/wiki/Open_big_files_and_work_fast
let g:LargeFile = 10

" Disable beeping
" http://vim.wikia.com/wiki/Disable_beeping
function! Errorbells_off(...)
  " control Vim's audio and visual warnings
  " * Arguments:
  " "beep": turn off just beeping
  " "flash": turn off just flashing
  " (empty): both off
  " * Must be initialized after the GUI starts!
  " off
  if a:0 == 0
    let myeb = ""
  else
    let myeb = a:1
  endif
  if myeb ==? "flash"
    " audibly beep on error messages
    set errorbells
    " Screen flash on error (See also 't_vb')
    set novisualbell
    set t_vb=
  elseif myeb ==? "beep"
    " audibly beep on error messages
    set noerrorbells
    " Screen flash on error (See also 't_vb')
    set visualbell
    set t_vb&
  elseif myeb ==? ""
    " audibly beep on error messages
    set noerrorbells
    " Screen flash on error (See also 't_vb')
    set visualbell
    set t_vb=
  endif
endfunction


set noerrorbells
set visualbell
set vb t_vb=
if has('autocmd')
  autocmd GUIEnter * set vb t_vb=
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" by Wei Ding<dingwei2u@gmail.com>
"
" Version: 0.1
" Last Change: 29/08/08 23:00:01
" fix some performance issue and syntax bugs
" End
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" User configuration
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" turn on  nice effect on status bar title
let performance_mode=1
let use_plugins_i_donot_use=0
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Get out of VI's compatible mode..
"去掉有关vi一致性模式，避免以前版本的一些bug和局限

set nocompatible

"设置拼写检查
"set spell
hi SpellBad  cterm=NONE ctermfg=0 ctermbg=219

function! MySys()
	if has("win32")
		return "win32"
	elseif has("unix")
		return "unix"
	elseif has("linux")
		return "unix"
	else
		return "mac"
	endif
endfunction

"Set shell to be zsh
if MySys() == "unix" || MySys() == "mac"
	set shell=zsh
else
	"I have to run win32 python without cygwin
	set shell=E:cygwininsh
endif

"Sets how many lines of history VIM har to remember
set history=400

"Enable filetype plugin
"检测文件的类型 开启codesnip
filetype on
if has("eval") && v:version>=600
	filetype plugin on
	filetype indent on
endif

"Set to auto read when a file is changed from the outside
" 自动重新加载外部修改内容
if exists("&autoread")
	set autoread
endif

" 自动切换当前目录为当前文件所在的目录
if exists("&autochdir")
    set autochdir
endif

"Have the mouse enabled all the time:
"鼠标支持
"if has('mouse')
if exists("&mouse")
	set mouse=a
    " use xterm mouse behaviour
    set ttymouse=xterm
endif

"Set mapleader
let mapleader = ","
let g:mapleader = ","

"Fast saving
"Comment by Dingzi
"nmap <leader>x :xa!<cr>
"nmap <leader>w :w!<cr>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and Font
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"语法高亮度显示
"Enable syntax hl
if MySys()=="unix"
	if v:version<600
		if filereadable(expand("$VIM/syntax/syntax.vim"))
			syntax on
		endif
	else
		syntax on
	endif
else
	syntax on
endif

"if you use vim in tty,
"'uxterm -cjk' or putty with option 'Treat CJK ambiguous characters as wide' on
" ambiwidth 默认值为 single。在其值为 single 时，
" 若 encoding 为 utf-8，gvim 显示全角符号时就会
" 出问题，会当作半角显示。
if exists("&ambiwidth")
	set ambiwidth=double
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Change by Wei Ding<dingwei2u@gmail.com>
"
" Version: 0.1
" Last Change: 30/03/09 23:00:01
" Begin....
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"配色
" Avoid clearing hilight definition in plugins
if !exists("g:vimrc_loaded")
    if has("gui_running")
      " don't include toolbar
	  set guioptions-=T
      " don't add tab pages
      " allow pasting into other applications after visual selection
      set guioptions+=a
      " use console dialogs instead of popups
      set guioptions+=c
      " don't add tab pages
      set guioptions-=e
	  set guioptions-=m
      set guioptions-=L
      set guioptions-=r
      set guioptions-=l
      set guioptions-=R
      set guifont=Bitstream\ Vera\ Sans\ Mono\ 12
      "中文字体
      set guifontset=wenquanyi\ bitmap\ 12

      if MySys()=="win32"
          "start gvim maximized
          if has("autocmd")
            au GUIEnter * simalt ~x
          endif " has("autocmd")
          " set number of columns and lines
          set columns=120
          set lines=60
          " select font
          set guifont=Bitstream_Vera_Sans_Mono:h8:cANSI
      endif " Mysys() == "win32"

      "let psc_style='cool'
      if v:version > 602
          "colorscheme default
           colorscheme blackboard
           "colorscheme zenburn
      endif " v:version > 602
      "对于html，xml文件，通过ctrl+_来closetag
      if has("autocmd")
          autocmd FileType text,xml,html,perl,shell,bash,python,vim,php,ruby color blackboard
          autocmd FileType xml,html vmap <C-o> <ESC>'<i<!--<ESC>o<ESC>'>o-->
          autocmd FileType java,c,cpp,cs color desertEx
          autocmd FileType html,text,php,vim,c,java,xml,bash,shell,perl,python,json setlocal textwidth=400
          autocmd Filetype html,xml,xsl source ~/.vim/plugin/closetag.vim
      endif " has("autocmd")
    else "has("gui_running")

      "
      " if we're in a linux console
      "
      if v:version > 602

        " For xterm16 color
        "let xterm16_brightness = 'default'     " Change if needed
        "let xterm16_colormap = 'allblue'       " Change if needed
        " leaving this out makes the colours brighter
        " set term color is 256, need yaourt -S rxvt-unicode-256color
        if &term =~ '^screen' || &term =~ '^rxvt'
          set t_Co=256
          colorscheme desert256-transparent
        elseif has("terminfo")
          set t_Co=16
          set t_Sb=^[[4%pl%dm
          set t_Sf=^[[3%pl%dm
          set t_vb=
          colors desertEx
        else
          set t_Co=16
          set t_Sb=^[[4%dm
          set t_Sf=^[[3%dm
          set t_vb=
          colors desert
        endif

        "对于html，xml文件，通过ctrl+_来closetag
        if has("autocmd")
          autocmd FileType xml,html vmap <C-o> <ESC>'<i<!--<ESC>o<ESC>'>o-->
          autocmd FileType html,text,php,vim,c,java,xml,bash,shell,perl,python setlocal textwidth=400
          autocmd Filetype html,xml,xsl source ~/.vim/plugin/closetag.vim
        endif " has("autocmd")
      endif " v:version > 602
    endif " else
endif " exists(...)
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Change by Wei Ding<dingwei2u@gmail.com>
"
" Version: 0.1
" Last Change: 30/03/09 23:00:01
" End....
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"

"Some nice mapping to switch syntax (useful if one mixes different languages in one file)
map <leader>1 :set syntax=cheetah<cr>
map <leader>2 :set syntax=xhtml<cr>
map <leader>3 :set syntax=python<cr>
map <leader>4 :set ft=javascript<cr>
map <leader>$ :syntax sync fromstart<cr>


"Highlight current
" Line highlight 設此標整行會標註顏色
autocmd InsertLeave * se cul
autocmd InsertEnter * se nocul
if has("gui_running")
	hi CursorLine guibg=LightBlue
else
    se cursorline
	"hi CursorLine term=none cterm=none ctermbg=LightGray
    "hi CursorLine term=inverse cterm=bold,inverse ctermfg=Black ctermbg=Green
	hi CursorLine term=none cterm=none ctermbg=LightBlue
endif
"autocmd InsertLeave * hi CursorLine term=none cterm=none
"autocmd InsertEnter * hi CursorLine term=none cterm=none

if has("gui_running")
  if exists("&cursorline")
	set cursorline
endif
endif
" Column highlight 設此是遊標整列會標註顏色
if has("gui_running")
  if exists("&cursorcolumn")
	set cursorcolumn
	highlight CursorLine cterm=none ctermbg=2 ctermfg=0
endif
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Fileformat
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Favorite filetype
set ffs=unix,dos,mac

nmap <leader>fd :se ff=dos<cr>
nmap <leader>fu :se ff=unix<cr>



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VIM userinterface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Set 7 lines to the curors - when moving vertical..
"光标在窗口上下边界时距离边界7行即开始滚屏
set so=7

"Turn on WiLd menu
" 增强模式中的命令行自动完成操作
set wildmenu

"Always show current position
"在编辑过程中，在右下角显示光标位置的状态行
set ruler
"set rulerformat=%20(%2*%<%f%=\ %m%r\ %3l\ %c\ %p%%%)

"The commandbar is 2 high
" 设定命令行的行数为 1
set cmdheight=2

"Show line number
"显示行号
set number

"Do not redraw, when running macros.. lazyredraw
set lz

"Change buffer - without saving
set hid

"Set backspace
"在insert模式下能用删除键进行删除
set backspace=eol,start,indent

"Bbackspace and cursor keys wrap to
set whichwrap+=<,>,h,l

"Ignore case when searching
"set ignorecase
set incsearch

"Set magic on
" regexp chars have special meaning
set magic

"No sound on errors.
" 不要闪烁
set noerrorbells
set novisualbell
set t_vb=
if has('autocmd')
  autocmd GUIEnter * set vb t_vb=
endif "No sound on errors End }}}

"show matching bracet
"显示匹配括号
set showmatch

"How many tenths of a second to blink
set mat=8
" Tell vim to optimize for a fast terminal; will be on by
				" default if your $TERM is xterm or screen, but could be
				" turned off if you use a weird terminal (e.g. 'screen-bce').
				" Set 'nottyfast' for slow SSH connections.
set ttyfast

"Highlight search thing
"标识关键字
"set hls
set hlsearch
"hi Search term=inverse cterm=bold,inverse ctermfg=Gray ctermbg=Green

""""""""""""""""""""""""""""""
" => Statusline
""""""""""""""""""""""""""""""
"Format the statusline
" Nice statusbar
if performance_mode
else
	" 显示状态栏 (默认值为 1, 无法显示状态栏)
	set laststatus=2
	"set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [ASCII=\%03.3b]\ [HEX=\%02.2B]\ [POS=%04l,%04v][%p%%]\ [LEN=%L]
	set statusline=
	set statusline+=%2*%-3.3n%0*\ " buffer number
	set statusline+=%f\ " file name
	set statusline+=%h%1*%m%r%w%0* " flags
	set statusline+=[
	if v:version >= 600
		set statusline+=%{strlen(&ft)?&ft:'none'}, " filetype
		set statusline+=%{&encoding}, " encoding
	endif
	set statusline+=%{&fileformat}] " file format
	if filereadable(expand("$VIM/vimfiles/plugin/vimbuddy.vim"))
		set statusline+=\ %{VimBuddy()} " vim buddy
	endif
	set statusline+=%= " right align
	set statusline+=%2*0x%-8B\ " current char
	set statusline+=%-14.(%l,%c%V%)\ %<%P " offset


	" special statusbar for special windows
	if has("autocmd")
		au FileType qf
					\ if &buftype == "quickfix" |
					\ setlocal statusline=%2*%-3.3n%0* |
					\ setlocal statusline+=\ \[Compiler\ Messages\] |
					\ setlocal statusline+=%=%2*\ %<%P |
					\ endif

		fun! FixMiniBufExplorerTitle()
			if "-MiniBufExplorer-" == bufname("%")
				setlocal statusline=%2*%-3.3n%0*
				setlocal statusline+=\[Buffers\]
				setlocal statusline+=%=%2*\ %<%P
			endif
		endfun

		if v:version>=600
			"编辑状态保存
			au BufWinLeave * mkview
			au BufWinEnter *
						\ let oldwinnr=winnr() |
						\ windo call FixMiniBufExplorerTitle() |
						\ exec oldwinnr . " wincmd w"
			au BufWinEnter * silent loadview
		endif
	endif

	" Nice window title
	if has('title') && (has('gui_running') || &title)
        	"set titlestring=%t%(\ %M%)%(\ (%{expand(\"%:p:h\")})%)%(\ %a%)\ -\ %{v:servername}
		set titlestring=
		set titlestring+=%f\ " file name
		set titlestring+=%h%m%r%w " flags
		set titlestring+=\ -\ %{v:progname} " program name
		" 高亮字符，让其不受100列限制
		highlight OverLength ctermbg=red ctermfg=white guibg=grey guifg=white
		match OverLength '\%101v.*'
		" 状态行颜色
		highlight StatusLine ctermbg=red ctermfg=white guifg=SlateBlue guibg=Yellow
		highlight StatusLineNC ctermbg=red ctermfg=white guifg=Gray guibg=White
	endif
endif



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Moving around and tab
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Map space to / and c-space to ?
map <space> /

"Smart way to move btw. window
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l


"Tab configuration
map <leader>tn :tabnew %<cr>
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove

if v:version>=700
	set switchbuf=usetab
endif

if exists("&showtabline")
	set stal=2
endif

"Moving fast to front, back and 2 sides ;)
imap <m-$> <esc>$a
imap <m-0> <esc>0i
imap <D-$> <esc>$a
imap <D-0> <esc>0i


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General Autocommand
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Switch to current dir
" Comment by Dingzi
"map <leader>cd :cd %:p:h<cr>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Parenthesis/bracket expanding
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
vnoremap $1 <esc>`>a)<esc>`<i(<esc>
")
vnoremap $2 <esc>`>a]<esc>`<i[<esc>
vnoremap $3 <esc>`>a}<esc>`<i{<esc>
vnoremap $$ <esc>`>a"<esc>`<i"<esc>
vnoremap $q <esc>`>a'<esc>`<i'<esc>
vnoremap $w <esc>`>a"<esc>`<i"<esc>

"Map auto complete of (, ", ', [
"http://www.vim.org/tips/tip.php?tip_id=153
"

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General Abbrev
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Comment for C like language
if has("autocmd")
	au BufNewFile,BufRead *.js,*.htc,*.c,*.tmpl,*.css ino $c /**<cr> **/<esc>O
endif

"My information
ia xdate <c-r>=strftime("%d/%m/%y %H:%M:%S")<cr>
"iab xname Amir Salihefendic

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Editing mappings etc.
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Remap VIM 0
"map 0 ^

"Move a line of text using control
nmap <M-j> mz:m+<cr>`z
nmap <M-k> mz:m-2<cr>`z
vmap <M-j> :m'>+<cr>`<my`>mzgv`yo`z
vmap <M-k> :m'<-2<cr>`>my`<mzgv`yo`z

if MySys() == "mac"
	nmap <D-j> <M-j>
	nmap <D-k> <M-k>
	vmap <D-j> <M-j>
	vmap <D-k> <M-k>
endif


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Command-line config
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
func! Cwd()
	let cwd = getcwd()
	return "e " . cwd
endfunc

func! DeleteTillSlash()
	let g:cmd = getcmdline()
	if MySys() == "unix" || MySys() == "mac"
		let g:cmd_edited = substitute(g:cmd, "(.*[/]).*", "", "")
	else
		let g:cmd_edited = substitute(g:cmd, "(.*[\]).*", "", "")
	endif
	if g:cmd == g:cmd_edited
		if MySys() == "unix" || MySys() == "mac"
			let g:cmd_edited = substitute(g:cmd, "(.*[/]).*/", "", "")
		else
			let g:cmd_edited = substitute(g:cmd, "(.*[\]).*[\]", "", "")
		endif
	endif
	return g:cmd_edited
endfunc

func! CurrentFileDir(cmd)
	return a:cmd . " " . expand("%:p:h") . "/"
endfunc

"cno $q <C->eDeleteTillSlash()<cr>
"cno $c e <C->eCurrentFileDir("e")<cr>
"cno $tc <C->eCurrentFileDir("tabnew")<cr>
cno $th tabnew ~/
cno $td tabnew ~/Desktop/

"Bash like
cno <C-A> <Home>
cno <C-E> <End>
cno <C-K> <C-U>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Buffer realted
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Fast open a buffer by search for a name
"map <c-q> :sb

"Open a dummy buffer for paste
map <leader>q :e ~/buffer<cr>

" Restore cursor to file position in previous editing session
" Make our folds look like how they were when we exited vim last time.
"set viminfo='10,"100,:20,%,n~/.viminfo
set viminfo=s1,<1024,'1024,/1024,:1024,@1024,c,f1,%,n~/.viminfo
autocmd BufReadPost *
	\ if expand("<afile>:p:h") !=? $TEMP |
    \   if line("'\"") > 0 && line("'\"") <= line("$") |
    \     exe "normal g`\"" |
    \     let b:doopenfold = 1 |
    \   endif |
    \ endif
    " Need to postpone using "zv" until after reading the modelines
autocmd BufWinEnter *
    \ if exists("b:doopenfold") |
    \   unlet b:doopenfold |
    \   exe "normal zv" |
    \ endif


" Buffer - reverse everything ... :)
map <F9> ggVGg?

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Files and backup
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Turn backup off
if has("vms")
	set nobackup
else
	set backup
endif
set nowb
"set nowritebackup
"set noswapfile

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Folding
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Enable folding, I find it very useful
"设置语法折叠
set foldmethod=syntax
"设置折叠区域的宽度
set foldcolumn=3
"设置为自动关闭折叠
"set foldclose=all

" 用空格键来开关折叠
set foldenable
nnoremap <space> @=((foldclosed(line('.')) < 0) ? 'zc' : 'zo')<CR>
if exists("&foldenable")
	set fen
endif

if exists("&foldlevel")
	set fdl=0
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text option
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" python script
set expandtab
set shiftwidth=4
" makes the spaces feel like real tabs
set softtabstop=4
set tabstop=4
"set backspace=4
set smarttab
set lbr
set tw=500

""""""""""""""""""""""""""""""
" => Indent
""""""""""""""""""""""""""""""
"缩进相关
" 继承前一行的缩进方式，特别适用于多行注释
" Auto indent
"自动缩排
set ai

" 为C程序提供自动缩进
"Smart indet
"set smartindent
set si

" 使用C样式的缩进
"C-style indenting
if has("cindent")
	set cindent
endif
function! GnuIndent()
  setlocal cinoptions=>4,n-2,{2,^-2,:2,=2,g0,h2,p5,t0,+2,(0,u0,w1,m1
  setlocal shiftwidth=2
  setlocal tabstop=8
  setlocal softtabstop=4
endfunction

au FileType c,cpp setlocal cinoptions=:0,g0,(0,w1 shiftwidth=4 tabstop=8 softtabstop=4
au FileType diff  setlocal shiftwidth=4 tabstop=8
au FileType html  setlocal autoindent indentexpr=
au FileType changelog setlocal textwidth=76

" Recognize standard C++ headers
au BufEnter /usr/include/c++/*    setf cpp
au BufEnter /usr/include/g++-3/*  setf cpp

" Setting for files following the GNU coding standard
au BufEnter /usr/*                call GnuIndent()

function! RemoveTrailingSpace()
  if $VIM_HATE_SPACE_ERRORS != '0' &&
        \(&filetype == 'c' || &filetype == 'cpp' || &filetype == 'vim')
    normal m`
    silent! :%s/\s\+$//e
    normal ``
  endif
endfunction
" Remove trailing spaces for C/C++ and Vim files
au BufWritePre *                  call RemoveTrailingSpace()

"Wrap line
set wrap


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Spell checking
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <leader>sn ]
map <leader>sp [
map <leader>sa zg
map <leader>s? z=



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Plugin configuration
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" by Wei Ding<dingwei2u@gmail.com>
"
" Version: 0.1
" Last Change: 29/08/08 23:00:01
" fix some performance issue and syntax bugs
" Begin....
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"Tlist 和 wm的设置
"命令模式输入wm打开Tlist和WM
"Taglist插件的设置
" For Taglist plugin
let g:Tlist_Use_Right_Window=1
let g:Tlist_Show_One_File=1
let Tlist_File_Fold_Auto_Close=1
let g:Tlist_Compact_Format=1
let Tlist_Exit_OnlyWindow=1
let g:winManagerWindowLayout='FileExplorer|TagList'
let tlist_Inc_Winwidth=0

"Tree explorer的设置
let g:treeExplVertical=1
let g:treeExplWinSize=30

" For ctags.vim plugin
" need pacman -S ctags
let g:ctags_statusline=1
let g:ctags_title=1
let g:generate_tags=1
let g:ctags_regenerate=1

" For vim-latex plugins
" IMPORTANT: win32 users will need to have 'shellslash' set so that latex
" can be called correctly
set shellslash

" IMPORTANT: grep will somtimes skip displaying the file name if you
" search in a single file. This will confuse Latex-Suite. Set your grep
" program to always generate a file-name
set grepprg=grep\ -nH\ $*

" OPTIONAL: This enables automatic indentation as you type
filetype indent on

" OPTIONAL: Starting with vim 7,the filetype of empty .tex files defaults to
" 'plaintex' instead of 'tex', which results in vim-latex not being loaded.
" The following changes the default filetype back to 'tex':
let g:tex_flavor='latex'

" This is mostly a matter of taste. but LaTex looks good with just a bit
" of indentation
set sw=2
" TIP: if you write your \label's as \label{fig:something}, then if you
" type in \ref{fig: and press <C-n> you will automatically cycle through
" all the figure labels. Very useful!
set iskeyword+=


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" by Wei Ding<dingwei2u@gmail.com>
"
" Version: 0.1
" Last Change: 29/08/08 23:00:01
" fix some performance issue and syntax bugs
" End
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""




""""""""""""""""""""""""""""""
" => Yank Ring
""""""""""""""""""""""""""""""
map <leader>y :YRShow<cr>

""""""""""""""""""""""""""""""
" => File explorer
""""""""""""""""""""""""""""""
"Split vertically
let g:explVertical=1

"Window size
let g:explWinSize=25

let g:explSplitLeft=1
let g:explSplitBelow=1

"Hide some file
let g:explHideFiles='^.,.*.class$,.*.swp$,.*.pyc$,.*.swo$,.DS_Store$'

"Hide the help thing..
let g:explDetailedHelp=0


""""""""""""""""""""""""""""""
" => Minibuffer
""""""""""""""""""""""""""""""
"let g:miniBufExplModSelTarget = 1
"let g:miniBufExplorerMoreThanOne = 0
"let g:miniBufExplModSelTarget = 0
"let g:miniBufExplUseSingleClick = 1
"let g:miniBufExplMapWindowNavVim = 1
"let g:miniBufExplVSplit = 25
"let g:miniBufExplSplitBelow=1
" minibufexpl插件的一般设置
let g:miniBufExplMapWindowNavArrows = 1
let g:miniBufExplModSelTarget = 1
"实现<C-Tab>     向前循环切换到每个buffer上,并在当前窗口打开
let g:miniBufExplMapCTabSwitchBufs = 1
"<C-S-Tab>     向后循环切换到每个buffer上,并在当前窗口打开
"可以用<C-h,j,k,l>切换到上下左右的窗口中去
let g:miniBufExplMapWindowNavVim = 1

"选中一段文字并全文搜索这段文字
:vnoremap <silent> ,/ y/<C-R>=escape(@", '\\/.*$^~[]')<CR><CR>
:vnoremap <silent> ,? y?<C-R>=escape(@", '\\/.*$^~[]')<CR><CR>

" 只在下列文件类型被侦测到的时候显示行号，普通文本文件不显示
:runtime! ftplugin/man.vim
set keywordprg=dicty
"ab ssh #!/bin/bash<CR><CR>
"ab ppy #!/usr/bin/python<CR><CR>
"ab ppl #!/usr/bin/perl<CR><CR><{}>
"ab rru #!/usr/bin/ruby<CR><CR><{}>


" For the NERD Commenter
"let NERDDefaultNesting = 1       "for the NERD Commenter
"let NERDMapleader          = '\c'
"let NERDAltComMap          = '\ca'
"let NERDAppendComMap       = '\ce'
"let NERDComAlignLeftMap    = '\cl'
"let NERDComAlignBothMap    = '\cb'
"let NERDComAlignRightMap   = '\cr'
"let NERDComInInsertMap     = '\<C-c>'
"let NERDComLineInvertMap   = '\ci'
"let NERDComLineToggleMap   = '\cc'
"let NERDComLineNestMap     = '\cn'
"let NERDComLineSexyMap     = '\cs'
"let NERDComLineMap         = '\c<space>'
"let NERDComLineMinimalMap  = '\cm'
"let NERDComToEOLMap        = '\c$'
"let NERDComLineYankMap     = '\cy'
"let NERDUncomLineMap       = '\cu'
"let NERDCompactSexyComs    = 1


"WindowZ
map <c-w><c-t> :WMToggle<cr>
let g:bufExplorerSortBy = "name"

""""""""""""""""""""""""""""""
" => LaTeX Suite thing
""""""""""""""""""""""""""""""
"set grepprg=grep -r -s -n
let g:Tex_DefaultTargetFormat="pdf"
let g:Tex_ViewRule_pdf='xpdf'

if has("autocmd")
	"Binding
	au BufRead *.tex map <silent><leader><space> :w!<cr> :silent! call Tex_RunLaTeX()<cr>

	"Auto complete some things ;)
	au BufRead *.tex ino <buffer> $i indent
	au BufRead *.tex ino <buffer> $* cdot
	au BufRead *.tex ino <buffer> $i item
	au BufRead *.tex ino <buffer> $m [<cr>]<esc>O
endif

""""""""""""""""""""""""""""""
" => Tag list (ctags) - not used
""""""""""""""""""""""""""""""
"let Tlist_Ctags_Cmd = "/sw/bin/ctags-exuberant"
"let Tlist_Sort_Type = "name"
"let Tlist_Show_Menu = 1
"map <leader>t :Tlist<cr>
map <F3> :Tlist<cr>
"ctags设置
set tags=~/.vim/tags/stltags
"set tags+=~/.vim/sgitag
"set tags+=~/.vim/ctags
"set tags+=~/.vim/glibctag
"智能补全ctags -R --c++-kinds=+p --fields=+iaS --extra=+q
let OmniCpp_DefaultNamespaces = ["std"]
let OmniCpp_GlobalScopeSearch = 1  " 0 or 1
let OmniCpp_NamespaceSearch = 1   " 0 ,  1 or 2
let OmniCpp_DisplayMode = 1
let OmniCpp_ShowScopeInAbbr = 0
let OmniCpp_ShowPrototypeInAbbr = 1
let OmniCpp_ShowAccess = 1
let OmniCpp_MayCompleteDot = 1
let OmniCpp_MayCompleteArrow = 1
let OmniCpp_MayCompleteScope = 1
highlight Pmenu ctermbg=13 guibg=LightGray
highlight PmenuSel ctermbg=7 guibg=DarkBlue guifg=White
highlight PmenuSbar ctermbg=7 guibg=DarkGray
highlight PmenuThumb guibg=Black



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Filetype generic
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Todo
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"au BufNewFile,BufRead *.todo so ~/vim_local/syntax/amido.vim

""""""""""""""""""""""""""""""
" => VIM
""""""""""""""""""""""""""""""
if has("autocmd") && v:version>600
	au BufRead,BufNew *.vim map <buffer> <leader><space> :w!<cr>:source %<cr>
endif

""""""""""""""""""""""""""""""
" => HTML related
""""""""""""""""""""""""""""""
" HTML entities - used by xml edit plugin
let xml_use_xhtml = 1
"let xml_no_auto_nesting = 1

"To HTML
let html_use_css = 0
let html_number_lines = 0
let use_xhtml = 1


""""""""""""""""""""""""""""""
" => Ruby & PHP section
""""""""""""""""""""""""""""""
"
"rails.vim
runtime! macros/matchit.vim
augroup myfiletypes
  " Clear old autocmds in group
  autocmd!
  " autoindent with two spaces, always expand tabs
  autocmd FileType ruby,eruby,yaml set ai sw=2 sts=2 et
augroup END

"autocmd FileType ruby,eruby set omnifunc=rubycomplete#Complete
autocmd FileType ruby,eruby set omnifunc=rubycomplete#Complete
"if you want buffer/rails/global completion you must add the following:
autocmd FileType ruby,eruby let g:rubycomplete_buffer_loading = 1
"if you want rails support add the following in addition
autocmd FileType ruby,eruby let g:rubycomplete_rails = 1
"if you want classes included in global completions add the following
autocmd FileType ruby,eruby let g:rubycomplete_classes_in_global = 1


"
""""""""""""""""""""""""""""""
" For PHP
" php indent
" To disable autoformating of comment by default
" if set to 0,this script will let the 'formatoptions'
" setting intact

let PHP_autoformatcomment=0
" of sw will be added to the indent of each line
" of PHP code(non PHP codes isn't affected)
" default is 0
let PHP_default_indenting=0
" Will make the script automatically remove
" CR at end of lines(by default this option
" is unset),NOTE that you MUST remove CR when
" the fileformat is UNIX else the indentation
" won't be correct
let PHP_removeCRwhenUnix=1
" Will indent the '{' and '}' at the same level than
let PHP_BracesAtCodeLevel=1

"
""""""""""""""""""""""""""""""
" => Python section
"
" Python Check syntax and run script
" http://vim.wikia.com/wiki/Python_-check_syntax_and_run_script
" Type wm open Tlist and wm if you run vim on conle
"
" http://blog.sontek.net/2008/05/11/python-with-a-modular-ide-vim/
"
""""""""""""""""""""""""""""""

" There are 2 ways to add your ability to jump between python class libraries,
" the first is to setup vim to know where the python libs are so you can use
" 'gf' to get them (gf is goto file), You can do this by adding this snippet to
" your .vimrc

"python << EOF
"import os
"import sys
"import vim
"for p in sys.path:
"    if os.path.isdir(p):
"        vim.command(r"set path+=%s" % (p.replace(" ", r"\ ")))
"EOF

"ctags设置
" Continuing accessibility of the Python class lbiraries we are going to
" want to use ctags to generate an index of all the code for vim to reference
" $ctags -R -f ~/.vim/tags/python.ctags /usr/lib/python2.6/
" This will give you the ability to use CTRL_J to  jump to the method/property
" under your cursor in the system libraries and CTRL+T to jump back to your
" source code
set tags+=~/.vim/tags/python.ctags
" I also have 2 tweaks in my .vimrc so you can use CTRL+LeftArrow and CTRL+Right
" Arrow to move between the files with more natural key bindings
map <silent><C-Left> <C-T>
map <silent><C-Right> <C-J>


"autocmd BufRead *.py compiler pylint

"Syntax Checking
"Vim already has built in syntax highlighting for python but I have a small tweak
"to vim to give you notifications of small syntax errors like forgetting a
"colon after a for loop. Create a file called ~/.vim/syntax/python.vim and add
"following into it:
"syn match pythonError "^\s*def\s\+\w\+(.*)\s*$" display
"syn match pythonError "^\s*class\s\+\w\+(.*)\s*$" display
"syn match pythonError "^\s*for\s.*[^:]$” display
"syn match pythonError “^\s*except\s*$” display
"syn match pythonError “^\s*finally\s*$” display
"syn match pythonError “^\s*try\s*$” display
"syn match pythonError “^\s*else\s*$” display
"syn match pythonError “^\s*else\s*[^:].*” display
"syn match pythonError “^\s*if\s.*[^\:]$” display
"syn match pythonError “^\s*except\s.*[^\:]$” display
"syn match pythonError “[;]$” display
"syn keyword pythonError         do
"
"Now that you have the basics covered, lets get more complicated checking added.
"Add these 3 lines to your .vimrc so you can type :make and get a list of syntax
"errors
"Set some bindings up for 'compile' of python
"按F5自动Make buffer里面的内容
autocmd BufRead *.py set makeprg=python\ -c\ \"import\ py_compile,sys;\ sys.stderr=sys.stdout;\ py_compile.compile(r'%')\"
autocmd BufRead *.py set efm=%C\ %.%#,%A\ \ File\ \"%f\"\\,\ line\ %l%.%#,%Z%[%^\ ]%\\@=%m
autocmd BufNewFile,BufRead *.py nmap <buffer> <F5> :!python %<CR>
"au BufNewFile,BufRead *.py nmap <buffer> <F5> :w!<cr>:make<cr>

nmap <buffer> <F5> :w<Esc>mwG:r!python %<CR>`.

" You will have the ability to to type :cn and :cp to move around the error list.
" You can also type :dist to see all errors, and finally, sometimes you will
" want to check the syntax of small chunks of code, so we'll add the ability
" to execute visually selected lines of code, add this snippet to your .vimrc

python << EOL
import vim
def EvaluateCurrentRange():
  eval(compile('\n'.join(vim.current.range),'','exec'),globals())
EOL
"map <C-h> :py EvaluateCurrentRange()

" Browsing the source
" Moving around the source code is an important feature in most IDE's
" with their project explorers, so to get that type of functionality in vim
" we grab the TagList plugin. This will give you the ability to view all
" opened buffers easily and jump to certain method calls in those buffers.

" The Other must-have feature of an IDE when browsing code is being able to
" open up multiple files in tabs. To do this you type :tabnew to open up a
" file in a new tab and than :tabn and :tabp to move around the tabs. Add
" these to lines to your .vimrc to be able to move between the tabs with
" ALT+LeftArrow and ALT+RightArrow:
map <silent><A-Right> :tabnext<CR>
map <silent><A-Left> :tabprevious<CR>

function! Python_Eval_VSplit() range
    "let src=tempname()
    let dst=tempname()
    "execute ": " . a:firstline . ",". a:lastline . ' w '.srca
    let filename=bufname("%")
    execute ":!python " . filename . " > " . dst
    execute ":pedit! " . dst
endfunction
"au FileType python map <F5> :call Python_Eval_VSplit()<cr>
"Run the current buffer in python - ie. on leader+space

autocmd BufRead *.py set ai sw=4 ts=4 sta et fo=croql
autocmd BufRead *.py set expandtab
autocmd BufRead *.py set nowrap
autocmd BufRead *.py set go+=b
autocmd BufRead *.py set softtabstop=4
autocmd BufEnter *.py set sw=4 ts=4 sta et fo=croql
autocmd BufEnter *.py set sw=4 ts=4 sta et fo=croql
autocmd FileType python set softtabstop=4|set tabstop=4|set shiftwidth=4|set expandtab

au BufNewFile,BufRead *.py so ~/.vim/syntax/python.vim
au BufNewFile,BufRead *.py map <buffer> <leader><space> :w!<cr>:!python %<cr>
"" python_ifold setup
let g:ifold_mode=2
au BufNewFile,BufRead *.py so ~/.vim/ftplugin/python_ifold.a.vim

" Code Completion
" To enable code completion support for Python in Vim you should be able
" to add the following line to your .vimrc
autocmd FileType python set omnifunc=pythoncomplete#Complete
" but this relies on the fact that your distro compiled python support
" into vim (which they should!)
" Then all you have to do to use your code completion is hit the unnatural,
" wrist breaking, keystorkes CTRL+X, CTRL+O. I've re-bound the code
" completion to CTRL+Space since we are making vim and IDE! Add this command
" to your .vimrc to get the better keybinding
inoremap <Nul> <C-x><C-o>

" Python Auto-complete set pydiction
if has("autocmd")
"  autocmd FileType python set dictionary+=~/.vim/pydiction/pydiction
"  autocmd FileType python set complete+=k
  autocmd FileType python set complete+=k~/.vim/pydiction/pydiction isk+=.,(
endif" has("autocmd"
" 在处理未保存或只读文件的时候，弹出确认 set confirm " 带有如下符号的单词不要被换行分割
set iskeyword+=_,$,@,%,#,-,.

""Python iMap
au BufNewFile,BufRead *.py set cindent
au BufNewFile,BufRead *.py ino <buffer> $r return
au BufNewFile,BufRead *.py ino <buffer> $s self
au BufNewFile,BufRead *.py ino <buffer> $c ##<cr>#<space><cr>#<esc>kla
au BufNewFile,BufRead *.py ino <buffer> $i import
au BufNewFile,BufRead *.py ino <buffer> $p print
au BufNewFile,BufRead *.py ino <buffer> $d """<cr>"""<esc>O

""""""""""""""""""""""""""""""
" => Cheetah section
"""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""
" => Java section
"""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""
" => JavaScript section
"""""""""""""""""""""""""""""""
"au BufNewFile,BufRead *.js so ~/vim_local/syntax/javascript.vim
"function! JavaScriptFold()
" set foldmethod=marker
" set foldmarker={,}
" set foldtext=getline(v:foldstart)
"endfunction
"au BufNewFile,BufRead *.js call JavaScriptFold()
"au BufNewFile,BufRead *.js imap <c-t> console.log();<esc>hi
"au BufNewFile,BufRead *.js imap <c-a> alert();<esc>hi
"au BufNewFile,BufRead *.js set nocindent
"au BufNewFile,BufRead *.js ino <buffer> $r return

"au BufNewFile,BufRead *.js ino <buffer> $d //<cr>//<cr>//<esc>ka<space>
"au BufNewFile,BufRead *.js ino <buffer> $c /**<cr><space><cr>**/<esc>ka


if has("eval") && has("autocmd")
	"vim 5.8.9 on mingw donot know what is <SID>, so I avoid to use function
	"c/cpp
	fun! Abbrev_cpp()
		ia <buffer> cci const_iterator
		ia <buffer> ccl cla
		ia <buffer> cco const
		ia <buffer> cdb bug
		ia <buffer> cde throw
		ia <buffer> cdf /** file<CR><CR>/<Up>
		ia <buffer> cdg ingroup
		ia <buffer> cdn /** Namespace <namespace<CR><CR>/<Up>
		ia <buffer> cdp param
		ia <buffer> cdt test
		ia <buffer> cdx /**<CR><CR>/<Up>
		ia <buffer> cit iterator
		ia <buffer> cns Namespace ianamespace
		ia <buffer> cpr protected
		ia <buffer> cpu public
		ia <buffer> cpv private
		ia <buffer> csl std::list
		ia <buffer> csm std::map
		ia <buffer> css std::string
		ia <buffer> csv std::vector
		ia <buffer> cty typedef
		ia <buffer> cun using Namespace ianamespace
		ia <buffer> cvi virtual
		ia <buffer> #i #include
		ia <buffer> #d #define
	endfunction

	fun! Abbrev_java()
		ia <buffer> #i import
		ia <buffer> #p System.out.println
		ia <buffer> #m public static void main(String[] args)
	endfunction

	fun! Abbrev_python()
		ia <buffer> #i import
		ia <buffer> #p print
		ia <buffer> #m if __name__=="__main__":
	endfunction

	fun! Abbrev_aspvbs()
		ia <buffer> #r Response.Write
		ia <buffer> #q Request.QueryString
		ia <buffer> #f Request.Form
	endfunction

	fun! Abbrev_js()
		ia <buffer> #a if(!0){throw Error(callStackInfo());}
	endfunction

	augroup abbreviation
		au!
		au FileType javascript :call Abbrev_js()
		au FileType cpp,c :call Abbrev_cpp()
		au FileType java :call Abbrev_java()
		au FileType python :call Abbrev_python()
		au FileType aspvbs :call Abbrev_aspvbs()
	augroup END
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => MISC
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Remove the Windows ^M
noremap <leader>m :%s/\r//g<CR>

"Paste toggle - when pasting something in, don't indent.
set pastetoggle=<F3>

"Remove indenting on empty line
map <F2> :%s/s*$//g<cr>:noh<cr>''

"Super paste
ino <C-v> <esc>:set paste<cr>mui<C-R>+<esc>mv'uV'v=:set nopaste<cr>

"clipboard with xclip
if MySys() == "unix"
	vmap <F6> :!xclip -sel c<CR>
	map <F7> :-1r!xclip -o -seln c<CR>'z
endif

" Mutt and Vim
au BufRead ~/.mutt/.tmp/mutt-* set tw=72
          colorscheme desert256-transparent

