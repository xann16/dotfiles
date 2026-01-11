-- LAZYDEV: configures Lua LSP for Neovim config, runtime and plugins
--            (completion, annotations and signatures of Neovim apis)

return {
    {
        'folke/lazydev.nvim',
        ft = 'lua',
        opts = {
            library = {
                {
                    path = '${3rd}/luv/library',
                    words = { 'vim%.uv' }
                },
            },
        },
    },
}
