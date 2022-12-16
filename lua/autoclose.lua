local autoclose = {}

-- TODO: use ["()"] as key
local config = {
   ["("] = { escape = false, close = true, pair = "()"},
   ["["] = { escape = false, close = true, pair = "[]"},
   ["{"] = { escape = false, close = true, pair = "{}"},

   [">"] = { escape = true, close = false, pair = "<>"},
   [")"] = { escape = true, close = false, pair = "()"},
   ["]"] = { escape = true, close = false, pair = "[]"},
   ["}"] = { escape = true, close = false, pair = "{}"},

   ['"'] = { escape = true, close = true, pair = '""'},
   ["'"] = { escape = true, close = true, pair = "''"},
   ["`"] = { escape = true, close = true, pair = "``"},

   ["<BS>"] = {},
   ["<CR>"] = {},
}

local function get_pair()
   -- add "_" to let close function work in the first col
   local line = "_" .. vim.api.nvim_get_current_line()
   local col = vim.api.nvim_win_get_cursor(0)[2] + 1

   return line:sub(col, col+1)
end

local function is_pair(pair)
   for _, info in pairs(config) do
      if pair == info.pair then
         return true
      end
   end
   return false
end

local function handler(key, info)
   local pair = get_pair()

   if key == "<BS>" and is_pair(pair) then
      return "<BS><Del>"
   elseif key == "<CR>" and is_pair(pair) then
      return "<CR><ESC>O"
   elseif info.escape and pair:sub(2, 2) == key then
      return "<Right>"
   elseif info.close then
      return info.pair .. "<Left>"
   else
      return key
   end
end

function autoclose.setup(user_config)
   for key, info in pairs(user_config) do
      config[key] = info
   end

   for key, info in pairs(config) do
      vim.keymap.set("i", key, function() return handler(key, info) end,
         { noremap = true, expr = true })
   end
end

return autoclose
