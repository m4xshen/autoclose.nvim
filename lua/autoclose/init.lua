local map = vim.api.nvim_set_keymap
local modules = require("autoclose.modules")

local M = {}

M.close = function()
    map("i", "{", "{}<ESC>i", {noremap = true})
    map("i", "[", "[]<ESC>i", {noremap = true})
    map("i", "(", "()<ESC>i", {noremap = true})
    map("i", "`", "``<ESC>i", {noremap = true})
    map("i", "'", "''<ESC>i", {noremap = true})
    map("i", "\"", "\"\"<ESC>i", {noremap = true})
end

M.deleteAndIndent = function()
    local col = vim.fn.getpos(".")[3]

    local cursor_line = vim.api.nvim_get_current_line()
    local cursor_left = string.sub(cursor_line, col - 1, col - 1)
    local cursor_position = string.sub(cursor_line, col, col)

    if modules.delete(cursor_left) and cursor_position == modules.pair(cursor_left) then
	map("i", "<BS>", "<ESC>\"_2s", {noremap = true})
	map("i", "<Enter>", "<Enter><ESC>O", {noremap = true})
    else
	map("i", "<BS>", "<BS>", {noremap = true})
	map("i", "<Enter>", "<Enter>", {noremap = true})
    end
end

M.escape = function()
    local col = vim.fn.getpos(".")[3]

    local cursor_line = vim.api.nvim_get_current_line()
    local input = string.sub(cursor_line, col - 1, col - 1)
    local cursor_position = string.sub(cursor_line, col, col)

    if modules.escape(input) and input == cursor_position then
	if col == string.len(cursor_line) then
	    vim.api.nvim_command("normal r ")
	else
	    vim.api.nvim_command('normal "_x')
	end
    end
end

return M
