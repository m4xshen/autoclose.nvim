if exists("g:loaded_autoclose") | finish | endif

if !has("nvim-0.5")
    echohl Error
    echomsg "autoclose.nvim is only available for Neovim versions 0.5 and above"
    echohl clear
    finish
endif

let s:save_cpo = &cpo
set cpo&vim

lua autoclose = require("autoclose")
lua autoclose.auto_close()
autocmd CursorMovedI,CursorMoved * :lua autoclose.auto_delete()

let g:loaded_autoclose = 1

let &cpo = s:save_cpo
unlet s:save_cpo
