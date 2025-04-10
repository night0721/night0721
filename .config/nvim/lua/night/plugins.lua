-- install packer if not installed on this machine
local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
        vim.cmd [[packadd packer.nvim]]
        return true
    end
    return false
end

-- first time startup?
local packer_bootstrap = ensure_packer()

-- autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

return require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'

    -- syntax highlighting
    use {
        'nvim-treesitter/nvim-treesitter',
--        requires = { { 'p00f/nvim-ts-rainbow' } },
        run = ':TSUpdate',
        config = function() require('night.plugins.treesitter') end
    }

	use {
		"https://gitlab.com/HiPhish/rainbow-delimiters.nvim"
	}
    -- color scheme
    use {
        "catppuccin/nvim",
        as = "catppuccin",
        config = function() require('night.plugins.theme') end
    }

    -- fancier status bar
    use {
        'nvim-lualine/lualine.nvim',
        config = function() require('night.plugins.lualine') end,
    }

    -- insert or delete brackets, parens, quotes in pair
    use 'jiangmiao/auto-pairs'

    -- autoclose html tags
	use 'alvan/vim-closetag'

    -- lsp
    use {
        'neovim/nvim-lspconfig',
        requires = {
            -- LSP support
            { 'williamboman/mason.nvim' },
            { 'williamboman/mason-lspconfig.nvim' },
            { 'hrsh7th/nvim-cmp' },
            { 'hrsh7th/cmp-nvim-lsp' },
        },
        config = function() require('night.plugins.lsp') end
    }
    use {
        'night0721/ccc.nvim',
        config = function() require('night.plugins.ccc') end
    }

    -- copilot
    use 'github/copilot.vim'

    -- automatically set up the configuration after cloning packer.nvim
    if packer_bootstrap then
        require('packer').sync()
    end
end)
