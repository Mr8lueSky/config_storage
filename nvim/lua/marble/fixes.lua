-- allow netrw to copy files to same directory 
vim.cmd[[
	" let g:netrw_keepdir=0
	set noswapfile
]]
vim.opt.shell = "zsh -l"

vim.opt.hidden = true
-- Close netrw auxiliary buffers (created/deleted messages, confirmations)
vim.api.nvim_create_autocmd("BufAdd", {
  pattern = "*",
  callback = function()
    vim.schedule(function()
      local buf = vim.api.nvim_get_current_buf()
      local ft = vim.bo[buf].filetype
      
      -- If it's a netrw buffer with no name or showing messages
      if ft == "netrw" then
        local name = vim.fn.bufname(buf)
        -- If buffer is empty (no file name) or is a message buffer
        if name == "" or name:match("^Message") then
          vim.bo[buf].bufhidden = "wipe"
        end
      end
    end)
  end,
})
