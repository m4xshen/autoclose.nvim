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
  
A minimalist autoclose plugin for [Neovim](https://neovim.io/) written in Lua. 

## ⚙️ Functions

### Auto-close `{}` `[]` `()` `""` `''` ``` `` ```

<img src="https://github.com/m4xshen/autoclose.nvim/blob/main/assets/close.gif" width="500">

### Auto-delete `{}` `[]` `()` `""` `''` ``` `` ``` `<>`

<img src="https://github.com/m4xshen/autoclose.nvim/blob/main/assets/delete.gif" width="500">

### Auto-indent And Escape
  <img src="https://github.com/m4xshen/autoclose.nvim/blob/main/assets/indentAndEscape.gif" width="500">

## 📦 Installation

Install via your favorite package manager.
- [vim-plug](https://github.com/junegunn/vim-plug)
```VimL
Plug 'm4xshen/autoclose.nvim'
```

- [packer.nvim](https://github.com/wbthomason/packer.nvim)
```Lua
use 'm4xshen/autoclose.nvim'
```

- [paq](https://github.com/savq/paq-nvim)
```Lua
require "paq" {
    "m4xshen/autoclose.nvim";
}
```
