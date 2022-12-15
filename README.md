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
  
A minimalist autoclose plugin for [Neovim](https://neovim.io/) written in 100% Lua. 

## ⚙️ Functions

### Auto-close
<img src="https://user-images.githubusercontent.com/74842863/207840883-b31b58d8-a3f9-49d4-a623-75b366662951.gif" width="500"/>

### Auto-delete
<img src="https://user-images.githubusercontent.com/74842863/207841011-813f368b-fca3-4b9e-b643-4ffc68ba0a7e.gif" width="500"/>

### Auto-escape And indent
<img src="https://user-images.githubusercontent.com/74842863/207841074-82dba234-0552-4f7e-b352-c36e0e73b828.gif" width="500"/>

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
require("autoclose").setup({})
```

## 🔧 Configuration

You can pass your config table into the `setup()` function.

Example: Add a `$$` pair.
```Lua
require("autoclose").setup({
  ["$"] = { escape = true, close = true, pair = "$$"},
})
```

You can also overwrite the default config.

Example: Remove the escape function of `>`.
```Lua
require("autoclose").setup({
  [">"] = { escape = false, close = false, pair = "<>"},
})
```

Here is the default config:
```Lua
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
```
