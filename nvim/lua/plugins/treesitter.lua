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
            }

            vim.treesitter.language.register("bash", "zsh") -- use bash parser for zsh config
        end 
    },
    {
        'MeanderingProgrammer/treesitter-modules.nvim',
        event = { "BufReadPre", "BufNewFile" },
        dependencies = { 'nvim-treesitter/nvim-treesitter' },
        opts = {
            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = "<C-.>",
                    node_incremental = "<C-.>",
                    scope_incremental = false,
                    node_decremental = "<C-,>",
                },
            },
        },
    },
    {
        'nvim-treesitter/nvim-treesitter-context',
        event = { "BufReadPre", "BufNewFile" },
        dependencies = { 'nvim-treesitter/nvim-treesitter' },
        config = function()
            require("treesitter-context").setup {}

            vim.keymap.set("n", "[c", function()
                require("treesitter-context").go_to_context(vim.v.count1)
            end, { silent = true })
        end
    },
}
