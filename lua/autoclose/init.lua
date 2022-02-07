-- auto close
vim.api.nvim_set_keymap("i", "{", "{}<ESC>i", {noremap = true})
vim.api.nvim_set_keymap("i", "[", "[]<ESC>i", {noremap = true})
vim.api.nvim_set_keymap("i", "(", "()<ESC>i", {noremap = true})
vim.api.nvim_set_keymap("i", "'", "''<ESC>i", {noremap = true})
vim.api.nvim_set_keymap("i", "\"", "\"\"<ESC>i", {noremap = true})

local function delete(text)
    return text == "{" or 
	   text == "}" or
	   text == "(" or
	   text == ")" or
	   text == "[" or
	   text == "]" or
	   text == "'" or
	   text == "\""
end

local function check()
    local line = vim.fn.getpos(".")[2]
    local col = vim.fn.getpos(".")[3]

    local line_under_cursor = vim.api.nvim_buf_get_lines(0, line - 1, line, 0)[1]
    local text_before_cursor = string.sub(line_under_cursor, col-1, col-1)

    if(delete(text_before_cursor)) then
	print("delete")
    else 
	print("don't delete'")
    end
end

local function map_bs()
    local line = vim.fn.getpos(".")[2]
    local col = vim.fn.getpos(".")[3]

    local line_under_cursor = vim.api.nvim_buf_get_lines(0, line - 1, line, 0)[1]
    local text_before_cursor = string.sub(line_under_cursor, col-1, col-1)

    if delete(text_before_cursor) then
	vim.api.nvim_set_keymap("i", "<BS>", "<ESC>mm%x`ms", {noremap = true})
    else
	vim.api.nvim_set_keymap("i", "<BS>", "<BS>", {noremap = true})
    end
end

return {
    check = check,
    map_bs = map_bs
}
