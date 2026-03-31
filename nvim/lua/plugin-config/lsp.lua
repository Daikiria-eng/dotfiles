-- ~/.config/nvim/lua/plugin-config/lsp.lua

-- Configurar Mason
require("mason").setup({
    ui = {
        icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
        }
    }
})

-- Configurar Mason LSPConfig
require("mason-lspconfig").setup({
    ensure_installed = {
        "lua_ls",           -- Lua
        "pyright",          -- Python
        "ts_ls",            -- TypeScript/JavaScript
        "jdtls",            -- Java
        "html",             -- HTML
        "cssls",            -- CSS
        "jsonls",           -- JSON
        "bqls",
        "clangd"
        --"postgres-language-server"
    },
    automatic_installation = true,
})

-- Configuración de autocompletado
local cmp = require('cmp')
local luasnip = require('luasnip')

cmp.setup({
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
        ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            else
                fallback()
            end
        end, { 'i', 's' }),
        ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { 'i', 's' }),
    }),
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
    }, {
        { name = 'buffer' },
        { name = 'path' },
    })
})

-- Capacidades de LSP con autocompletado
local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- Función para configurar keymaps cuando se activa un LSP
local on_attach = function(client, bufnr)
    local opts = { noremap = true, silent = true, buffer = bufnr }

    -- Navegación
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)

    -- Acciones de código
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)

    -- Diagnósticos
    vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, opts)
    vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
    vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)

    -- Formato
    vim.keymap.set('n', '<leader>f', function()
        vim.lsp.buf.format({ async = true })
    end, opts)
end

-- Configuración base para todos los servidores
local default_config = {
    capabilities = capabilities,
    on_attach = on_attach,
}

-- Configuración de servidores LSP usando la nueva API
-- Lua
vim.lsp.config('lua_ls', vim.tbl_extend('force', default_config, {
    settings = {
        Lua = {
            diagnostics = {
                globals = { 'vim' }
            },
            workspace = {
                library = vim.api.nvim_get_runtime_file("", true),
                checkThirdParty = false,
            },
            telemetry = {
                enable = false,
            },
        },
    },
}))

-- Python
vim.lsp.config('pyright', default_config)

-- TypeScript/JavaScript
vim.lsp.config('ts_ls', default_config)

-- Java (JDTLS) - Configuración especial
local jdtls_config = vim.tbl_extend('force', default_config, {
    cmd = { 
        'jdtls',
        '--jvm-arg=-javaagent:' .. vim.fn.expand('~/.local/share/nvim/mason/packages/jdtls/lombok.jar'),
    },
    root_markers = { 'pom.xml', 'build.gradle', 'gradlew', '.git', 'mvnw' },
    settings = {
        java = {
            eclipse = {
                downloadSources = true,
            },
            configuration = {
                updateBuildConfiguration = "interactive",
            },
            maven = {
                downloadSources = true,
            },
            implementationsCodeLens = {
                enabled = true,
            },
            referencesCodeLens = {
                enabled = true,
            },
            references = {
                includeDecompiledSources = true,
            },
            format = {
                enabled = true,
            },
        },
        signatureHelp = { enabled = true },
        completion = {
            favoriteStaticMembers = {
                "org.hamcrest.MatcherAssert.assertThat",
                "org.hamcrest.Matchers.*",
                "org.hamcrest.CoreMatchers.*",
                "org.junit.jupiter.api.Assertions.*",
                "java.util.Objects.requireNonNull",
                "java.util.Objects.requireNonNullElse",
                "org.mockito.Mockito.*",
            },
        },
        sources = {
            organizeImports = {
                starThreshold = 9999,
                staticStarThreshold = 9999,
            },
        },
        codeGeneration = {
            toString = {
                template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
            },
            useBlocks = true,
        },
    },
})

-- Solo configurar jdtls si el comando existe
if vim.fn.executable('jdtls') == 1 then
    vim.lsp.config('jdtls', jdtls_config)
else
    vim.notify('jdtls no está instalado. Instálalo con :Mason', vim.log.levels.WARN)
end

-- HTML
vim.lsp.config('html', default_config)

-- CSS
vim.lsp.config('cssls', default_config)

-- JSON
vim.lsp.config('jsonls', default_config)

-- C
vim.lsp.config('clangd', default_config)

-- SQL
vim.lsp.config('bqls', default_config)

-- PLPSQL
--vim.lsp.config('postgres-language-server', default_config)

-- Habilitar los servidores LSP
local servers = {'lua_ls', 'pyright', 'ts_ls', 'html', 'cssls', 'jsonls','bqls','clangd'}
if vim.fn.executable('jdtls') == 1 then
    table.insert(servers, 'jdtls')
end
vim.lsp.enable(servers)

-- Configurar diagnósticos
vim.diagnostic.config({
    virtual_text = true,
    signs = true,
    update_in_insert = false,
    underline = true,
    severity_sort = true,
    float = {
        border = 'rounded',
        source = 'always',
    },
})

-- Símbolos de diagnósticos
local signs = { Error = "✘", Warn = "", Hint = "", Info = "" }
for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end
