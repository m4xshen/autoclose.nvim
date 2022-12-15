local autoclose = {}

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
}

local function get_pair()
   -- add "_" to let close function work in the first col
   local line = "_" .. vim.api.nvim_get_current_line()
   local col = vim.api.nvim_win_get_cursor(0)[2] + 1

   return string.sub(line, col, col+1)
end

local function is_pair(pair)
   for _, info in pairs(config) do
      if pair == info.pair then
         return true
      end
   end
   return false
end

local function map_general(key, info)
   for key, info in pairs(config) do
      vim.keymap.set("i", key, function()
         if info.escape and string.sub(get_pair(), 2, 2) == key then
            return "<Right>"
         elseif info.close then
            return info.pair .. "<Left>"
         else
            return key
         end
      end, { expr = true })
   end
end

local function map_bs()
   vim.keymap.set("i", "<BS>", function()
      if is_pair(get_pair()) then
         return "<BS><Del>"
      else
         return "<BS>"
      end
   end, { expr = true })
end

local function map_cr()
   vim.keymap.set("i", "<CR>", function()
      local pair = get_pair()

      for _, info in pairs(config) do
         if info.close and pair == info.pair then
            return "<CR><ESC>O"
         end
      end
      return "<CR>"
   end, { expr = true })
end

function autoclose.setup(user_config)
   for key, info in pairs(user_config) do
      config[key] = info
   end

   map_general()
   map_bs()
   map_cr()
end

return autoclose
