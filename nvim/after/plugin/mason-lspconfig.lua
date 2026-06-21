require("mason-lspconfig").setup {
    ensure_installed = {"lua_ls", "basedpyright", "ts_ls", "emmet_ls"},
    registries = {
        "github:mason-org/mason-registry",
        "github:Crashdummyy/mason-registry",
    },
}

