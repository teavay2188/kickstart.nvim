-- ~/.config/nvim/lua/lsp_configs/svlangserver.lua

-- Fetch blink.cmp's extended capabilities so completions pop up instantly
local capabilities = require('blink.cmp').get_lsp_capabilities()

return {
  cmd = { 'svlangserver' },
  filetypes = { 'verilog', 'systemverilog' },
  capabilities = capabilities,
  root_markers = { '.git', 'Makefile' },
  settings = {
    systemverilog = {
      -- Tell the server to index all design files in your project directory
      includeIndexing = { '*.v', '*.sv', '*.svh' },
    },
  },
}
