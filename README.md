# markdown.nvim

A lightweight **Markdown slide previewer** for Neovim.  
Split your Markdown files into slides using `#` headings and navigate them directly inside Neovim.

---

## Features

- Parse Markdown files into slides using `#` headings
- Navigate slides with **next** (**`n`**) and **previous** (**`p`**) keys
- Quit preview with **`q`**
- Fullscreen preview with **`f`** 

---

## Installation

Lazy 

```lua
use {
    "chirag-juneja/markdown.nvim",
    config = function()
        require("markdown").setup()
    end
}
