local autoclose = {}

local config = {
   keys = {
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
      ["<C-W>"] = {},
      ["<CR>"] = {},
   },
   options = {
      disabled_filetypes = { "text" },
      disable_when_touch = false,
   },
}

local function get_pair()
   -- add "_" to let close function work in the first col
   local line = "_" .. vim.api.nvim_get_current_line()
   local col = vim.api.nvim_win_get_cursor(0)[2] + 1

   return line:sub(col, col+1)
end

local function is_pair(pair)
   for _, info in pairs(config.keys) do
      if pair == info.pair then
         return true
      end
   end
   return false
end

local function is_disabled()
   local current_filetype = vim.api.nvim_buf_get_option(0, "filetype")
   for _, filetype in pairs(config.options.disabled_filetypes) do
      if filetype == current_filetype then
         return true
      end
   end
   return false
end

local function handler(key, info)
   if is_disabled() then return key end
   local pair = get_pair()

   if key == "<BS>" or key == "<C-W>" and is_pair(pair) then
      return "<BS><Del>"
   elseif key == "<CR>" and is_pair(pair) then
      return "<CR><ESC>O"
   elseif info.escape and pair:sub(2, 2) == key then
      return "<Right>"
   elseif info.close then
      -- disable if the cursor touches alphanumeric character
      if config.options.disable_when_touch and
         (get_pair() .. " "):sub(2, 2):match("%w") then
         return key
      end

      return info.pair .. "<Left>"
   else
      return key
   end
end

function autoclose.setup(user_config)
   if user_config.keys ~= nil then
      for key, info in pairs(user_config.keys) do
         config.keys[key] = info
      end
   end

   if user_config.options ~= nil then
      for key, info in pairs(user_config.options) do
         config.options[key] = info
      end
   end

   for key, info in pairs(config.keys) do
      vim.keymap.set("i", key, function() return handler(key, info) end,
         { noremap = true, expr = true })
   end
end

return autoclose
