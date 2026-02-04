-- NVIM-TREESITTER: syntax highlighting and code understanding, edition and navigation

return {
    {
        'nvim-treesitter/nvim-treesitter',
        event = { "BufReadPre", "BufNewFile" },
        build = ':TSUpdate',
        config = function()
            require("nvim-treesitter.config").setup {
                ensure_installed = { 
                    'bash',
                    'c',
                    'cpp',
                    'fortran',
                    'diff',
                    'html',
                    'css',
                    'lua',
                    'luadoc',
                    'markdown',
                    'markdown_inline',
                    'query',
                    'vim',
                    'vimdoc',
                    'help',
                    'python',
                    'julia',
                    'json',
                    'yaml',
                    'protobuf',
                    'gitignore',
                    'dockerfile'
                },
                auto_install = true,
                highlight = {
                    enable = true,
                    -- Note: Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
                    --         If you are experiencing weird indenting issues, add the language to
                    --         the list of additional_vim_regex_highlighting and disabled languages for indent.
                    additional_vim_regex_highlighting = { 'ruby' },
                },
                indent = { 
                    enable = true,
                    disable = { 'ruby' } 
                },
                incremental_selection = {
                    enable = true,
                    keymaps = {
                        init_selection = "<C-space>",
                        node_incremental = "<C-space>",
                        scope_incremental = false,
                        node_decremental = "<bs>",
                    },
                },
            }

            vim.treesitter.language.register("bash", "zsh") -- use bash parser for zsh config

            -- TODO: There are additional nvim-treesitter modules that you can use to interact
            --         with nvim-treesitter. You should go explore a few and see what interests you:
            --
            --          - Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
            --          - Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
            --          - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
        
        end 
    },
}
