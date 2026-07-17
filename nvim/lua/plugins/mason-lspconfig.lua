return {
    "mason-org/mason-lspconfig.nvim",
    opts = {
        ensure_installed = {"lua_ls", "basedpyright", "ts_ls"},
        automatic_enable = {
            exclude = {
                "basedpyright", "jedi-language-server", "roslyn_ls", "emmet_ls",
                "roslyn_ls", "ty"
            }
        }
    },
    dependencies = {
        {"mason-org/mason.nvim", opts = {}}, "neovim/nvim-lspconfig"
    }
}
