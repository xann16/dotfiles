-- NVIM-LSPCONFIG: main LSP configuration

return {
    {
        'neovim/nvim-lspconfig',
        dependencies = {
            { 'mason-org/mason.nvim', opts = {} },
            'mason-org/mason-lspconfig.nvim',
            'WhoIsSethDaniel/mason-tool-installer.nvim',
            { 'j-hui/fidget.nvim', opts = {} },
            'saghen/blink.cmp',
        },
        config = function()

            vim.api.nvim_create_autocmd('LspAttach', {
                group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
                callback = function(event)

                    -- helper function to generate LSP-related key-bindings
                    local map = function(keys, func, desc, mode)
                        mode = mode or 'n'
                        vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
                    end

                    -- Rename the variable under your cursor.
                    map('grn', vim.lsp.buf.rename, '[R]e[n]ame')

                    -- Execute a code action, usually your cursor needs to be on top of an error
                    --   or a suggestion from your LSP for this to activate.
                    map('gra', vim.lsp.buf.code_action, '[G]oto Code [A]ction', { 'n', 'x' })

                    -- Find references for the word under your cursor.
                    map('grr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')

                    -- Jump to the implementation of the word under your cursor.
                    map('gri', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')

                    -- Jump to the definition of the word under your cursor (to jump back, press <C-t>).
                    map('grd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
                    map('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')

                    -- Jump to the declaration of the word under your cursor (e.g. in C/C++ go to header).
                    map('grD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

                    -- Fuzzy find all the symbols in your current document.
                    map('gO', require('telescope.builtin').lsp_document_symbols, 'Open Document Symbols')

                    -- Fuzzy find all the symbols in your current workspace.
                    map('gW', require('telescope.builtin').lsp_dynamic_workspace_symbols, 'Open Workspace Symbols')

                    -- Jump to the definition of a type of the word under your cursor.
                    map('grt', require('telescope.builtin').lsp_type_definitions, '[G]oto [T]ype Definition')

                    -- Show documentation for a symbol under the cursor.
                    map('K', vim.lsp.buf.hover, 'Hover Documentation under the [K]ursor')

                    -- Navigate diagnostic items
                    map("[d", vim.diagnostic.goto_next, "Next [D]iagnostic Item")
                    map("]d", vim.diagnostic.goto_prev, "Previous [D]iagnostic Item")

                    -- Restart LSP
                    map('<leader>lr', ":LspRestart<CR>", '[R]estart LSP')

                    -- Signature help in Insert Mode
                    map('<C-h>', vim.lsp.buf.signature_help, 'Signature [H]elp', 'i')

                end
            })

            -- Diagnostic Config
            -- See :help vim.diagnostic.Opts
            vim.diagnostic.config {
                severity_sort = true,
                float = { border = 'rounded', source = 'if_many' },
                underline = true,
                update_in_insert = false,
                signs = vim.g.have_nerd_font and {
                    text = {
                        [vim.diagnostic.severity.ERROR] = '󰅚 ',
                        [vim.diagnostic.severity.WARN] = '󰀪 ',
                        [vim.diagnostic.severity.INFO] = '󰋽 ',
                        [vim.diagnostic.severity.HINT] = '󰌶 ',
                    },
                } or {},
                virtual_text = {
                    source = 'if_many',
                    spacing = 2,
                    format = function(diagnostic)
                        local diagnostic_message = {
                            [vim.diagnostic.severity.ERROR] = diagnostic.message,
                            [vim.diagnostic.severity.WARN] = diagnostic.message,
                            [vim.diagnostic.severity.INFO] = diagnostic.message,
                            [vim.diagnostic.severity.HINT] = diagnostic.message,
                        }
                        return diagnostic_message[diagnostic.severity]
                    end,
                },
            }

            local capabilities = require('blink.cmp').get_lsp_capabilities()

            local servers = {
                lua_ls = { -- lua
                    settings = {
                        Lua = {
                            completion = {
                                callSnippet = 'Replace',
                            },
                            diagnostics = {
                                disable = { 'missing-fields' },
                                globals = { "vim" },
                            },
                            workspace = {
                                library = {
                                    [vim.fn.expand('$VIMRUNTIME') .. '/lua'] = true,
                                    [vim.fn.stdpath("config") .. "/lua"] = true,
                                }
                            },
                        },
                    },
                },
                -- TODO: clangd = {},
                -- TODO: pyright = {},
            }

            local ensure_installed = vim.tbl_keys(servers or {})
            
            -- extra tools - formatters
            vim.list_extend(ensure_installed, {
                'stylua', -- lua
            })

            -- extra tools - linters
            vim.list_extend(ensure_installed, {
                'luacheck', -- lua
            })


            require('mason-tool-installer').setup { ensure_installed = ensure_installed }

            require('mason-lspconfig').setup {
                ensure_installed = {}, -- explicitly set to an empty table (installs populated via mason-tool-installer)
                automatic_installation = false,
                handlers = {
                    function(server_name)
                        local server = servers[server_name] or {}

                        -- This handles overriding only values explicitly passed by the server configuration above.
                        -- Useful when disabling certain features of an LSP (for example, turning off formatting for ts_ls).
                        server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
                        require('lspconfig')[server_name].setup(server)
                    end,
                },
            }
        end,
    }
}
