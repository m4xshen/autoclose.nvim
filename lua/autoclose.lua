local autoclose = {}

local config = {
   keys = {
      ["("] = { escape = false, close = true, pair = "()" },
      ["["] = { escape = false, close = true, pair = "[]" },
      ["{"] = { escape = false, close = true, pair = "{}" },

      [">"] = { escape = true, close = false, pair = "<>" },
      [")"] = { escape = true, close = false, pair = "()" },
      ["]"] = { escape = true, close = false, pair = "[]" },
      ["}"] = { escape = true, close = false, pair = "{}" },

      ['"'] = { escape = true, close = true, pair = '""' },
      ["'"] = { escape = true, close = true, pair = "''" },
      ["`"] = { escape = true, close = true, pair = "``" },

      [" "] = { escape = false, close = true, pair = "  " },

      ["<BS>"] = {},
      ["<C-H>"] = {},
      ["<C-W>"] = {},
      ["<CR>"] = { disable_command_mode = true },
      ["<S-CR>"] = { disable_command_mode = true },
   },
   options = {
      disabled_filetypes = { "text" },
      disable_when_touch = false,
      touch_regex = "[%w(%[{]",
      pair_spaces = false,
      auto_indent = true,
      disable_command_mode = false,
   },
   disabled = false,
}

local function insert_get_pair()
   -- add "_" to let close function work in the first col
   local line = "_" .. vim.api.nvim_get_current_line()
   local col = vim.api.nvim_win_get_cursor(0)[2] + 1

   return line:sub(col, col + 1)
end

local function command_get_pair()
   -- add "_" to let close function work in the first col
   local line = "_" .. vim.fn.getcmdline()
   local col = vim.fn.getcmdpos()

   return line:sub(col, col + 1)
end

local function is_pair(pair)
   if pair == "  " then
      return false
   end

   for _, info in pairs(config.keys) do
      if pair == info.pair then
         return true
      end
   end
   return false
end

local function is_disabled(info)
   if config.disabled then
      return true
   end
   local current_filetype = vim.api.nvim_buf_get_option(0, "filetype")
   for _, filetype in pairs(config.options.disabled_filetypes) do
      if filetype == current_filetype then
         return true
      end
   end

   if info["enabled_filetypes"] ~= nil then
      for _, filetype in pairs(info.enabled_filetypes) do
         if filetype == current_filetype then
            return false
         end
      end
      return true
   end

   -- Let's check if the disabled_filetypes key is in the info table
   if info["disabled_filetypes"] ~= nil then
      for _, filetype in pairs(info.disabled_filetypes) do
         if filetype == current_filetype then
            return true
         end
      end
   end
   return false
end

local function handler(key, info, mode)
   if is_disabled(info) then
      return key
   end

   local pair = mode == "insert" and insert_get_pair() or command_get_pair()

   if (key == "<BS>" or key == "<C-H>" or key == "<C-W>") and is_pair(pair) then
      return "<BS><Del>"
   elseif
      mode == "insert"
      and (key == "<CR>" or key == "<S-CR>")
      and is_pair(pair)
   then
      return "<CR><ESC>O" .. (config.options.auto_indent and "" or "<C-D>")
   elseif info.escape and pair:sub(2, 2) == key then
      return mode == "insert" and "<C-G>U<Right>" or "<Right>"
   elseif info.close then
      -- disable if the cursor touches alphanumeric character
      if
         config.options.disable_when_touch
         and (pair .. "_"):sub(2, 2):match(config.options.touch_regex)
      then
         return key
      end

      -- don't pair spaces
      if
         key == " "
         and (
            not config.options.pair_spaces
            or (config.options.pair_spaces and not is_pair(pair))
            or pair:sub(1, 1) == pair:sub(2, 2)
         )
      then
         return key
      end

      return info.pair .. (mode == "insert" and "<C-G>U<Left>" or "<Left>")
   else
      return key
   end
end

function autoclose.setup(user_config)
   user_config = user_config or {}

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
      vim.keymap.set("i", key, function()
         return (key == " " and "<C-]>" or "") .. handler(key, info, "insert")
      end, { noremap = true, expr = true })

      if
         not config.options.disable_command_mode
         and not info.disable_command_mode
      then
         vim.keymap.set("c", key, function()
            return (key == " " and "<C-]>" or "")
               .. handler(key, info, "command")
         end, { noremap = true, expr = true })
      end
   end
end

function autoclose.toggle()
   config.disabled = not config.disabled
end

return autoclose
