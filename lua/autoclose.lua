local M = {}
local H = {}

M.setup = function()
  vim.keymap.set('i', '(', '()<Left>')
  vim.keymap.set('i', '[', '[]<Left>')
  vim.keymap.set('i', '{', '{}<Left>')

  vim.keymap.set('i', '<BS>', function()
    local pair = H.getPair()

    if H.isPair(pair) then
      return '<BS><Del>'
    else
      return '<BS>'
    end
  end, { expr = true })

  vim.keymap.set('i', '<CR>', function()
    local pair = H.getPair()

    if H.isPair(pair) and (pair.left=='{'
      or pair.left=='[' or pair.left=='(') then
      return '<CR><ESC>O'
    else
      return '<CR>'
    end
  end, { expr = true })

  vim.keymap.set('i', '}', function()
    local right = H.getPair().right

    if right == '}' then
      return '<Right>'
    else
      return '}'
    end
  end, { expr = true })

  vim.keymap.set('i', ']', function()
    local right = H.getPair().right

    if right == ']' then
      return '<Right>'
    else
      return ']'
    end
  end, { expr = true })

  vim.keymap.set('i', ')', function()
    local right = H.getPair().right

    if right == ')' then
      return '<Right>'
    else
      return ')'
    end
  end, { expr = true })

  vim.keymap.set('i', '"', function()
    local right = H.getPair().right

    if right == '"' then
      return '<Right>'
    else
      return '""<Left>'
    end
  end, { expr = true })

  vim.keymap.set('i', "'", function()
    local right = H.getPair().right

    if right == "'" then
      return '<Right>'
    else
      return "''<Left>"
    end
  end, { expr = true })

  vim.keymap.set('i', '`', function()
    local right = H.getPair().right

    if right == '`' then
      return '<Right>'
    else
      return '``<Left>'
    end
  end, { expr = true })
end

H.getPair = function()
  local pair = {}
  local line = vim.api.nvim_get_current_line()
  local col = vim.api.nvim_win_get_cursor(0)[2]

  pair.left = string.sub(line, col, col)
  pair.right = string.sub(line, col+1, col+1)

  return pair
end

H.isPair = function(pair)
  if (pair.left == '{' and pair.right == '}') or
    (pair.left == '[' and pair.right == ']') or
    (pair.left == '(' and pair.right == ')') or
    (pair.left == '<' and pair.right == '>') or
    (pair.left == '"' and pair.right == '"') or
    (pair.left == "'" and pair.right == "'") or
    (pair.left == '`' and pair.right == '`') then
    return true
  else 
    return false
  end
end

return M
