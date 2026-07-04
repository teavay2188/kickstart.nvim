-- ~/.config/nvim/lua/lsp_configs/verible.lua

-- Fetch standard Neovim capabilities to pass down to the server
local capabilities = vim.lsp.protocol.make_client_capabilities()

return {
  cmd = { 'verible-verilog-ls' },
  filetypes = { 'verilog', 'systemverilog' },
  capabilities = capabilities,
  -- Crucial: Tell Verible how to find the bounds of your design project
  root_markers = {
    '.git',
    'verilator.f',
    'Makefile',
    'compile_commands.json',
  },
  settings = {
    -- Verible custom configuration can be explicitly defined here
  },
}
