local modules = require("autoclose.modules")
-- auto close
vim.api.nvim_set_keymap("i", "{", "{}<ESC>i", {noremap = true})
vim.api.nvim_set_keymap("i", "[", "[]<ESC>i", {noremap = true})
vim.api.nvim_set_keymap("i", "(", "()<ESC>i", {noremap = true})
vim.api.nvim_set_keymap("i", "'", "''<ESC>i", {noremap = true})
vim.api.nvim_set_keymap("i", "\"", "\"\"<ESC>i", {noremap = true})

local function keyMap()
    local line = vim.fn.getpos(".")[2]
    local col = vim.fn.getpos(".")[3]

    local cursorLine = vim.api.nvim_buf_get_lines(0, line - 1, line, 0)[1]
    local cursorLeft = string.sub(cursorLine, col-1, col-1)
    local cursorPosition = string.sub(cursorLine, col, col)

    if modules.delete(cursorLeft) and cursorPosition == modules.pair(cursorLeft) then
	vim.api.nvim_set_keymap("i", "<BS>", "<ESC>2s", {noremap = true})
    else
	vim.api.nvim_set_keymap("i", "<BS>", "<BS>", {noremap = true})
    end
end

return {
    keyMap = keyMap
}
