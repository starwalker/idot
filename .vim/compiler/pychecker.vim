" Vim compiler file
" Compiler: Pychecker for Python
if exists("current_compiler")
  finish
endif
let current_compiler = "pychecker"
if exists(":CompilerSet") != 2 " older Vim always used :setlocal
  command -nargs=* CompilerSet setlocal <args>
endif
CompilerSet makeprg=pychecker\ --quiet\ -q\ %
CompilerSet efm=%f:%l:%m

