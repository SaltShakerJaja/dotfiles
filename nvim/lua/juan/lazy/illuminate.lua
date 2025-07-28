return {
    "RRethy/vim-illuminate",
    config = function()
        require("illuminate").configure({
        providers = { "lsp", "treesitter", "regex" },
        delay = 100,
        filetypes_denylist = { "dirbuf", "dirvish", "fugitive" },
        under_cursor = true,
        large_file_cutoff = 10000,
        large_file_config = { delay = 500 },
    })
    end,
}
