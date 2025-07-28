return {
  "neovim/nvim-lspconfig",
  config = function()
    local lspconfig = require("lspconfig")

    local servers = {
      gopls = {},
      pyright = {},
      lua_ls = {},
      ts_ls = {},
      cssls = {},
      html = {},
      sqlls = {},
      clangd = {},
      rust_analyzer = {},
    }

    for lsp, config in pairs(servers) do
      lspconfig[lsp].setup(config)
    end

    vim.api.nvim_create_autocmd("LspAttach", {
      callback = function(ev)
        local opts = { buffer = ev.buf }
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
        vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
        vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
        vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
      end,
    })
  end,
}

