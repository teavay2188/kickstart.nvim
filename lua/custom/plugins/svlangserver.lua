-- ~/.config/nvim/lua/lsp_configs/svlangserver.lua

-- Fetch blink.cmp's extended capabilities so completions pop up instantly
local capabilities = require('blink.cmp').get_lsp_capabilities()

return {
  cmd = { 'svlangserver' },
  filetypes = { 'verilog', 'systemverilog' },
  capabilities = capabilities,
  root_dir = function(bufnr, on_dir)
    -- svlangserver cannot initialize correctly with a null rootUri.
    on_dir(
      vim.fs.root(bufnr, { '.svlangserver', '.rules.verible_lint', 'verilator.f', 'Makefile', '.git' }) or vim.fs.dirname(vim.api.nvim_buf_get_name(bufnr))
    )
  end,
  on_init = require('custom.sv_diagnostics').on_init,
  settings = {
    systemverilog = {
      disableLinting = false,
      linterWhitelist = {
        -- Keep svlangserver's default interface diagnostic exclusions.
        'Unsupported: Interfaced port on top level module',
        "Parent instance's interface is not found",
        -- Questa supports resolved nettypes; suppress Verilator's limitation.
        '^Unsupported: nettype with$',
      },
      -- Tell the server to index all design files in your project directory
      includeIndexing = { '**/*.v', '**/*.sv', '**/*.svh' },
    },
  },
}
