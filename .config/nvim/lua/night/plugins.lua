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

    use 'dylanaraps/fff.vim'

    -- fuzzy finder
    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.4',
        requires = { { 'nvim-lua/plenary.nvim' } },
        config = function() require('night.plugins.telescope') end
    }

    -- syntax highlighting
    use {
        'nvim-treesitter/nvim-treesitter',
        requires = { { 'p00f/nvim-ts-rainbow' } },
        run = ':TSUpdate',
        config = function() require('night.plugins.treesitter') end
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

    -- wiki
    use {
        'vimwiki/vimwiki',
        config = function() require('night.plugins.vimwiki') end,
    }

    -- startup screen
    use {
        'goolord/alpha-nvim',
        config = function() require('night.plugins.alpha') end,
    }

    -- distraction-free writing mode
    --use {
    --    'folke/zen-mode.nvim',
    --    opt = true,
    --    cmd = { 'ZenMode' },
    --    config = function() require('night.plugins.zen-mode') end
    --}

    -- wakatime to record coding time
    use 'wakatime/vim-wakatime'

    -- insert or delete brackets, parens, quotes in pair
    use 'jiangmiao/auto-pairs'

    -- autoclose html tags
    use 'alvan/vim-closetag'

    -- indent blankline
    use 'lukas-reineke/indent-blankline.nvim'

    -- lsp
    use {
        'VonHeikemen/lsp-zero.nvim',
        requires = {
            -- LSP support
            { 'neovim/nvim-lspconfig' },
            { 'williamboman/mason.nvim' },
            { 'williamboman/mason-lspconfig.nvim' },

            -- autocompletion
            { 'hrsh7th/nvim-cmp' },
            { 'hrsh7th/cmp-buffer' },
            { 'hrsh7th/cmp-path' },
            { 'saadparwaiz1/cmp_luasnip' },
            { 'hrsh7th/cmp-nvim-lsp' },
            { 'hrsh7th/cmp-nvim-lua' },

            -- snippets
            { 'L3MON4D3/LuaSnip' },
            { 'rafamadriz/friendly-snippets' },
        },
        config = function() require('night.plugins.lsp') end
    }

    -- rust formatter
    --use {
    --    'rust-lang/rust.vim',
    --    ft = "rust",
    --}

    -- tmux integration
    -- use 'christoomey/vim-tmux-navigator'

    -- copilot
    -- use 'github/copilot.vim'

    -- automatically set up the configuration after cloning packer.nvim
    if packer_bootstrap then
        require('packer').sync()
    end
end)
