local wk = require("which-key")

-- [[ Basic Keymaps ]]

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

-- Set highlight on search, but clear on pressing <Esc> in normal mode
vim.opt.hlsearch = true
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Remap for dealing with word wrap
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Diagnostic keymaps
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic message" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next diagnostic message" })
vim.keymap.set("n", "<leader>cf", vim.diagnostic.open_float, { desc = "Open [f]loating diagnostic message" })
vim.keymap.set("n", "<leader>cd", vim.diagnostic.setloclist, { desc = "Open [d]iagnostics list" })

wk.add({
  {
    "<leader>b",
    group = "buffers",
    desc = "[B]uffers",
    expand = function()
      return require("which-key.extras").expand.buf()
    end,
  },
})
