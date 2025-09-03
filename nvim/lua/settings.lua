-- set indentation
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.autoindent = true

-- set leader
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- set numbers
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.numberwidth = 2
vim.opt.colorcolumn = "80"

-- match terminal theme with nvim
vim.opt.termguicolors = true

-- indent while remaining in visual mode
vim.keymap.set("v", ">", ">gv", { noremap = true })
vim.keymap.set("v", "<", "<gv", { noremap = true })

-- dismiss search highlights
vim.keymap.set("n", "<C-c>", "<cmd> noh <CR>", {})

-- base64 encode selected text
vim.keymap.set("v", "<leader>64", "c<c-r>=system('base64', @\")<cr><esc>")

-- base64 decode selected text
vim.keymap.set(
  "v",
  "<leader>d64",
  "c<c-r>=system('base64 --decode', @\")<cr><esc>"
)

-- hide cmdline by default
vim.opt.cmdheight = 0

-- save buffer on :W as well as :w
vim.api.nvim_create_user_command(
  "W",
  "<line1>,<line2>write<bang>",
  { bang, range = "%", complete = "file", nargs = "*" }
)

-- set system clipboard to vim register
vim.opt.clipboard = "unnamedplus"

-- offset cursor position by minimum 10 lines up/down
vim.opt.scrolloff = 999

vim.opt.list = true
vim.opt.listchars = {
  -- eol = "↵",
  -- space = "~",
  trail = "~",
  tab = ">-",
  nbsp = "␣",
}

-- set global status line (recommended for avante.nvim)
-- Ref: https://github.com/yetone/avante.nvim/blob/2ead26f809dd9804678de3dd18fa65ab3fadce29/README.md?plain=1#L201
vim.opt.laststatus = 3
