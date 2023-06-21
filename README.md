<h1 align="center">
autoclose.nvim
</h1>
    
<p align="center">
<a href="https://github.com/m4xshen/autoclose.nvim/stargazers">
    <img
      alt="Stargazers"
      src="https://img.shields.io/github/stars/m4xshen/autoclose.nvim?style=for-the-badge&logo=starship&color=fae3b0&logoColor=d9e0ee&labelColor=282a36"
    />
  </a>
  <a href="https://github.com/m4xshen/autoclose.nvim/issues">
    <img
      alt="Issues"
      src="https://img.shields.io/github/issues/m4xshen/autoclose.nvim?style=for-the-badge&logo=gitbook&color=ddb6f2&logoColor=d9e0ee&labelColor=282a36"
    />
  </a>
  <a href="https://github.com/m4xshen/autoclose.nvim/contributors">
    <img
      alt="Contributors"
      src="https://img.shields.io/github/contributors/m4xshen/autoclose.nvim?style=for-the-badge&logo=opensourceinitiative&color=abe9b3&logoColor=d9e0ee&labelColor=282a36"
    />
  </a>
</p>
  
## 📃 Introduction
  
A minimalist [Neovim](https://neovim.io/) plugin that auto pairs & closes brackets written in 100% Lua.

## ⚙️ Functions

### Auto-close
<img src="https://user-images.githubusercontent.com/74842863/208931426-4f171094-e1c8-4f85-918a-92250d92c933.gif" width="500"/>

### Auto-delete
(works in `<BS>` and `<C-W>`)

<img src="https://user-images.githubusercontent.com/74842863/208931458-0ed78f76-0080-4aa9-a36e-e55881090a0c.gif" width="500"/>

### Auto-escape
<img src="https://user-images.githubusercontent.com/74842863/208931512-6f06036a-267a-42d7-9d3e-58a7ddfab1a6.gif" width="500"/>

### Auto-indent
(works in `<CR>` and `<S-CR>`)

<img src="https://user-images.githubusercontent.com/74842863/208931561-b9170d08-0697-49b4-90fb-6d432e03c393.gif" width="500"/>

## ⚡ Requirements

- Neovim >= [v0.7.0](https://github.com/neovim/neovim/releases/tag/v0.7.0)

## 📦 Installation

1. Install via your favorite package manager.
- [vim-plug](https://github.com/junegunn/vim-plug)
```VimL
Plug 'm4xshen/autoclose.nvim'
```

- [packer.nvim](https://github.com/wbthomason/packer.nvim)
```Lua
use 'm4xshen/autoclose.nvim'
```

2. Setup the plugin in your `init.lua`.
```Lua
require("autoclose").setup()
```

## 🔧 Configuration

You can pass your config table into the `setup()` function.

### Keys

The available options in `keys`:
- `close`: If set to true, pressing the character will insert both the opening and closing characters, and place the cursor in between them.
- `escape`: If set to true, pressing the character again will escape it instead of inserting a closing character.
- `pair`: The string that represents the pair of opening and closing characters. This should be a two-character string, with the opening character first and the closing character second.
- `disabled_filetypes`: Table of filetypes where the specific key should not be autoclosed.

Example: Add a `$$` pair.
```Lua
require("autoclose").setup({
   keys = {
      ["$"] = { escape = true, close = true, pair = "$$", disabled_filetypes = {} },
   },
})
```

You can also overwrite the default config.

Example: Remove the escape function of `>`.
```Lua
require("autoclose").setup({
   keys = {
      [">"] = { escape = false, close = false, pair = "<>", disabled_filetypes = {} },
   },
})
```

### Options

The available options in `options`:
- `disabled_filetypes`: The plugin will be disabled under the filetypes in this table.
  - type of the value: table of strings
  - default value: `{ "text" }`

Example: Disable the plugin in text and markdown file.
```Lua
require("autoclose").setup({
   options = {
      disabled_filetypes = { "text", "markdown" },
   },
})
```

- `disable_when_touch`: Set this to true will disable the auto-close function when the cursor touches alphanumeric character.
  - type of the value: boolean
  - default value: `false`

Example:

Your current file: ( `^` points to your cursor position)
```text
word
^
```

You press `(` and the file will become
```
(word
^
```
It doesn't autoclose for you because your cursor touches `w`.

- `pair_spaces`: Pair the spaces when cursor is inside a pair of `keys`.
  - type of the value: boolean
  - default value: `false`

Example:

The `|` is your cursor in insert mode.

```javascript
import {|}
```

after inserting a space:

```javascript
import { | }
```

- `auto_indent`: Enable auto-indent feature
  - type of the value: boolean
  - default value: `true`

### Default config

```Lua
local config = {
   keys = {
      ["("] = { escape = false, close = true, pair = "()", disabled_filetypes = {} },
      ["["] = { escape = false, close = true, pair = "[]", disabled_filetypes = {} },
      ["{"] = { escape = false, close = true, pair = "{}", disabled_filetypes = {} },

      [">"] = { escape = true, close = false, pair = "<>", disabled_filetypes = {} },
      [")"] = { escape = true, close = false, pair = "()", disabled_filetypes = {} },
      ["]"] = { escape = true, close = false, pair = "[]", disabled_filetypes = {} },
      ["}"] = { escape = true, close = false, pair = "{}", disabled_filetypes = {} },

      ['"'] = { escape = true, close = true, pair = '""', disabled_filetypes = {} },
      ["'"] = { escape = true, close = true, pair = "''", disabled_filetypes = {} },
      ["`"] = { escape = true, close = true, pair = "``", disabled_filetypes = {} },

      [" "] = { escape = false, close = true, pair = "  ", disabled_filetypes = {} },

      ["<BS>"] = {},
      ["<C-H>"] = {},
      ["<C-W>"] = {},
      ["<CR>"] = {},
      ["<S-CR>"] = {},
   },
   options = {
      disabled_filetypes = { "text" },
      disable_when_touch = false,
      pair_spaces = false,
      auto_indent = true,
   },
   disabled = false,
}
```
