-- useful
-- :help user-manual
-- :checkhealth
vim.opt.showmode = false -- don't show modes, e.g. -- INSERT --
vim.o.clipboard = "unnamedplus"
vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.ignorecase = true -- ignore case in search patterns
vim.opt.smartcase = true -- smart case

vim.opt.number = true
vim.opt.numberwidth = 2
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.wrap = true
vim.opt.breakindent = true

vim.opt.smartindent = true

vim.opt.colorcolumn = "80"

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

vim.opt.colorcolumn = "80"
vim.g.mapleader = " "

vim.cmd([[
let g:closetag_filenames = '*.html,*.xhtml,*.jsx,*.tsx'
let g:closetag_xhtml_filenames = '*.xhtml,*.jsx,*.tsx'
let g:closetag_filetypes = 'html,js'
let g:closetag_xhtml_filetype = 'xhtml,jsx,tsx'
let g:closetag_emptyTags_caseSensitive = 1
let g:closetag_regions = {
  \ 'typescript.tsx': 'jsxRegion,tsxRegion',
  \ 'javascript.jsx': 'jsxRegion',
  \ }
let g:closetag_shortcut = '>'
let g:rustfmt_autosave = 1
]])
