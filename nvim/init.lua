require('plugin-config.lualine')
require('plugin-config.nvim-tree')
require('plugin-config.lsp')
require('plugin-config.nightfox')

local map = vim.keymap.set

vim.opt.number = true
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4

-- Highlight para fondo transparente
vim.cmd([[
    highlight Normal guibg=none
    highlight NonText guibg=none
    highlight Normal ctermbg=none
    highlight NonText ctermbg=none
]])

-- Configuración de plugins con Packer
require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'
    use 'kyazdani42/nvim-web-devicons'
    use 'kyazdani42/nvim-tree.lua'
    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'kyazdani42/nvim-web-devicons', opt = true }
    }

    --lsp & autocompletion
    use 'neovim/nvim-lspconfig'
    use 'williamboman/mason.nvim'
    use 'williamboman/mason-lspconfig.nvim'

    --autocompletion
    use 'hrsh7th/nvim-cmp'
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-path'
    use 'L3MON4D3/LuaSnip'
    use 'saadparwaiz1/cmp_luasnip'


    use "EdenEast/nightfox.nvim"
    use "yorumicolors/yorumi.nvim"
end)

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- optionally enable 24-bit colour
vim.opt.termguicolors = true



-- Habilitar clic del mouse
vim.opt.mouse = ''

-- Mapeo de Shift + Tab para inverso tab en modo insert
vim.keymap.set('i', '<S-Tab>', '<C-d>', { noremap = true })

-- Ver caracteres invisibles
vim.opt.list = true
vim.opt.listchars = { tab = '> ', trail = '+', eol = '$' }

-- Wrap a la siguiente línea cuando se alcanza el final de línea
vim.opt.whichwrap:append('<,>,[,]')

-- Colorscheme
--vim.cmd('colorscheme wildcharm')
--vim.cmd("colorscheme nightfox")


map('n', '<leader>e', ':NvimTreeToggle<CR>', { noremap = true, silent = true, desc = 'Toggle NvimTree' })
map('n', '<C-n>', ':NvimTreeToggle<CR>', { noremap = true, silent = true, desc = 'Toggle NvimTree' })
map('n', '<leader>nf', ':NvimTreeFocus<CR>', { noremap = true, silent = true, desc = 'Focus NvimTree' })
map('n', '<leader>nc', ':NvimTreeCollapse<CR>', { noremap = true, silent = true, desc = 'Collapse NvimTree' })

--vim.cmd("colorscheme yorumi")
