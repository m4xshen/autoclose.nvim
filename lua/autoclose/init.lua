local map = vim.api.nvim_set_keymap
local modules = require("autoclose.modules")

local M = {}

M.auto_close = function()
    map("i", "{", "{}<ESC>i", {noremap = true})
    map("i", "[", "[]<ESC>i", {noremap = true})
    map("i", "(", "()<ESC>i", {noremap = true})
    map("i", "'", "''<ESC>i", {noremap = true})
    map("i", "\"", "\"\"<ESC>i", {noremap = true})
end

M.auto_delete = function()
    local col = vim.fn.getpos(".")[3]

    local cursor_line = vim.api.nvim_get_current_line()
    local cursor_left = string.sub(cursor_line, col - 1, col - 1)
    local cursor_position = string.sub(cursor_line, col, col)

    if modules.delete(cursor_left) and cursor_position == modules.pair(cursor_left) then
	map("i", "<BS>", "<ESC>\"_2s", {noremap = true})
    else
	map("i", "<BS>", "<BS>", {noremap = true})
    end
end

return M
