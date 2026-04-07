-- Disable automatic previews.
require("markview").setup({
    preview = { enable = false },
    markdown = {enable = true},
    markdown_inline = {enable = true}
});

vim.api.nvim_set_keymap("n", "<leader>m", "<CMD>Markview detach<CR><CMD>Markview attach<CR><CMD>Markview<CR>", { desc = "Toggles `markview` previews globally." });
