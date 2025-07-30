require("mason-lspconfig").setup {
    ensure_installed = {"lua_ls", "basedpyright", "ts_ls", "emmet_ls"},
    automatic_enable = {exclude = {"basedpyright", "emmet_ls"}}
}
