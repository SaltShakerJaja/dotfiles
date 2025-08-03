return {
    "mason-org/mason-lspconfig.nvim",
    ensure_installed = {
        "lua_language_server",
        "pyright",
        "rust_analyzer",
        "typescript_language_server",
        "css_lsp",
        "html_lsp",
        "gopls",
        "clangd",
        "sqlls"
    },
    opts = {},
    dependencies = {
        { "mason-org/mason.nvim", opts = {} },
        "neovim/nvim-lspconfig",
    },
}
