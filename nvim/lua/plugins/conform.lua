-- CONFORM: autoformatting
return {
    {
        'stevearc/conform.nvim',
    	event = { "BufReadPre", "BufNewFile" },
        cmd = { 'ConformInfo' },
        keys = {
            {
                '<leader>f',
                function()
                    require('conform').format { 
                        async = true, 
                        lsp_format = 'fallback',
                        timeout_ms = 1000,
                    }
                end,
                mode = '',
                desc = '[F]ormat buffer',
            },
        },
        opts = {
            notify_on_error = false,
            format_on_save = function(bufnr)
                local disable_filetypes = {} -- TODO: Consider { c = true, cpp = true }
                if disable_filetypes[vim.bo[bufnr].filetype] then
                    return nil
                else
                    return { timeout_ms = 1000, lsp_format = 'fallback' }
                end
            end,
            formatters_by_ft = {
                lua = { 'stylua' },
                -- TODO: python = { "isort", "black" (or "ruff") (???) },
                -- TODO: c = { "clang-format" },
                -- TODO: cpp = { "clang-format" },
                -- TODO: fortran = { "clang-format" }, (???)
            },
        },
    },
}
