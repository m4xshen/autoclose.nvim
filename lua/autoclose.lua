local M = {}

function M.setup()
  -- general
  for key, info in pairs(H.keys) do
    H.map(key, info)
  end

  -- <BS>
  vim.keymap.set('i', '<BS>', function()
    local pair = H.get_pair()

    if H.is_pair(pair) then
      return '<BS><Del>'
    else
      return '<BS>'
    end
  end, { expr = true })

  -- <CR>
  vim.keymap.set('i', '<CR>', function()
    local pair = H.get_pair()

    for _, info in pairs(H.keys) do
      if info.is_open and pair == info.pair then
        return '<CR><ESC>O'
      end
    end
    return '<CR>'
  end, { expr = true })
end

local H = {}

H.keys = {
  ['('] = { is_closed = false, is_open = true, pair = '()'},
  ['['] = { is_closed = false, is_open = true, pair = '[]'},
  ['{'] = { is_closed = false, is_open = true, pair = '{}'},

  ['>'] = { is_closed = true, is_open = false, pair = '<>'},
  [')'] = { is_closed = true, is_open = false, pair = '()'},
  [']'] = { is_closed = true, is_open = false, pair = '[]'},
  ['}'] = { is_closed = true, is_open = false, pair = '{}'},

  ['"'] = { is_closed = true, is_open = true, pair = '""'},
  ["'"] = { is_closed = true, is_open = true, pair = "''"},
  ['`'] = { is_closed = true, is_open = true, pair = '``'}
}


function H.map(key, info)
  vim.keymap.set('i', key, function()
    local right = string.sub(H.get_pair(), 2, 2)

    if info.is_closed and right == key then
      return '<Right>'
    elseif info.is_open then
      return info.pair .. '<Left>'
    else
      return key
    end
  end, { expr = true }
  )
end

function H.get_pair()
  local line = vim.api.nvim_get_current_line()
  local col = vim.api.nvim_win_get_cursor(0)[2]

  return string.sub(line, col, col+1)
end

function H.is_pair(pair)
  for _, info in pairs(H.keys) do
    if pair == info.pair then
      return true
    end
  end

  return false
end

return M
