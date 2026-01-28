local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)

local config = {
	"folke/lazy.nvim",
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "master",
		dependencies = {
			"HiPhish/rainbow-delimiters.nvim",
		},
		build = ":TSUpdate",
		opts = {
  -- LazyVim config for treesitter
  indent = { enable = true }, ---@type lazyvim.TSFeat
  highlight = { enable = true }, ---@type lazyvim.TSFeat
  folds = { enable = true }, ---@type lazyvim.TSFeat
  ensure_installed = {
	  "javascript",
	  "typescript",
	  "bash",
	  "c",
	  "lua",
	  "html",
	  "json",
	  "python",
	  "typst",
	  "go",
  },
},
 event = { 'BufReadPost', 'BufNewFile', 'BufWritePre', 'VeryLazy' },

		config = function() require("night.plugins.treesitter") end,
	},
	{
		-- color scheme
		"catppuccin/nvim",
		name = "catppuccin",
		config = function() require("night.plugins.theme") end,
	},
	{
		-- fancier status bar
		"nvim-lualine/lualine.nvim",
		config = function() require("night.plugins.lualine") end,
	},
	-- insert or delete brackets, parens, quotes in pair
	"jiangmiao/auto-pairs",
	-- autoclose html tags
	"alvan/vim-closetag",
	{
		"mason-org/mason-lspconfig.nvim",
		dependencies = {
			-- LSP support
			{ "mason-org/mason.nvim" },
			{ "neovim/nvim-lspconfig" },
			{ "Saghen/blink.cmp" },
		},
		config = function() require("night.plugins.lsp") end
	},
	{
		"saghen/blink.cmp",
		dependencies = {
			{ "moyiz/blink-emoji.nvim" },
			{ "MahanRahmati/blink-nerdfont.nvim" },
			{ "ribru17/blink-cmp-spell" },
		},
		version = '1.*',
		opts = {
      cmdline = {
        keymap = { preset = 'inherit' },
        completion = { menu = { auto_show = true } },
      },
      completion = {
        documentation = { auto_show = true, auto_show_delay_ms = 500 },
        ghost_text = { enabled = true },
        menu = {
          -- TODO: menu item direction, not implemented yet
          direction_priority = { 'n', 's' },
          draw = {
            columns = {
              { 'label', 'label_description' },
              { 'kind_icon', 'source_name', gap = 1 },
            },
          },
        },
        trigger = {
          show_on_backspace_in_keyword = true,
        },
      },
      sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer', 'emoji', 'nerdfont', 'spell' },
        providers = {
          emoji = {
            name = 'Emoji',
            module = 'blink-emoji',
            score_offset = -200,
            opts = { trigger = ':' },
          },
          nerdfont = {
            name = 'Nerd',
            module = 'blink-nerdfont',
            score_offset = -200,
            opts = { trigger = ':' },
          },
          spell = {
            name = 'Spell',
            module = 'blink-cmp-spell',
            score_offset = -400,
            enabled = function()
              return vim.opt.spell:get()
            end,
            opts = { use_cmp_spell_sorting = true, keep_all_entries = true, max_entries = 10 },
          },
          buffer = {
            score_offset = -600,
          }
        },
      },
  },
      keymap = {
        preset = 'super-tab',
        ['<M-Left>'] = { 'cancel' },
        ['<M-Right>'] = { 'accept' },
      },
	  event = {
		  "InsertEnter",
		  "CmdlineEnter",
	  }
	},
	{
		"night0721/ccc.nvim",
		config = function() require("night.plugins.ccc") end
	},
	-- copilot
	"github/copilot.vim",
}
require("lazy").setup(config)
