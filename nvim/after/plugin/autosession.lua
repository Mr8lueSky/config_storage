require('auto-session').setup({
  pre_save_cmds = {
    -- Automatically close all Oil buffers before saving the session
    function()
      for _, win in pairs(vim.api.nvim_list_wins()) do
        local buf = vim.api.nvim_win_get_buf(win)
        if vim.bo[buf].filetype == 'oil' then
          vim.api.nvim_win_close(win, true)
        end
      end
    end
  }
})
vim.o.sessionoptions="blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"

