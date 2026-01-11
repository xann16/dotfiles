-- BLINK.CMP - autocompletions

return {
    {
        'saghen/blink.cmp',
        event = 'VimEnter',
        version = '1.*',
        dependencies = {
            {
                'L3MON4D3/LuaSnip', -- snippet engine
                version = '2.*',
                build = ( function()
                    if vim.fn.executable 'make' == 0 then
                        return
                    end
                    return 'make install_jsregexp'
                end)(),
                dependencies = {
                    {
                        'rafamadriz/friendly-snippets',
                        config = function()
                            require('luasnip.loaders.from_vscode').lazy_load()
                        end,
                    },
                },
                opts = {},
            },
            'folke/lazydev.nvim',
        },
        opts = {
            keymap = {
                -- TODO: For more advanced Luasnip keymaps (e.g. selecting choice nodes, expansion) see:
                --          https://github.com/L3MON4D3/LuaSnip?tab=readme-ov-file#keymaps
                preset = 'default',
            },
            appearance = {
                nerd_font_variant = 'mono',
            },
            completion = {
                -- By default, you may press `<c-space>` to show the documentation.
                -- Optionally, set `auto_show = true` to show the documentation after a delay.
                documentation = { 
                    auto_show = false,
                    auto_show_delay_ms = 500
                },
            },
            sources = {
                default = { 'lsp', 'path', 'snippets', 'lazydev' },
                providers = {
                    lazydev = { module = 'lazydev.integrations.blink', score_offset = 100 },
                },
            },
            snippets = { 
                preset = 'luasnip'
            },
            fuzzy = { 
                -- TODO: Consider using the rust implementation via `'prefer_rust_with_warning'`
                --         See :h blink-cmp-config-fuzzy for more information
                implementation = 'lua'
            },
            signature = {
                -- Shows a signature help window while you type arguments for a function
                enabled = true
            },
        },
    },
}
