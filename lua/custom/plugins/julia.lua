local jetls_path = vim.fn.expand '~/.julia/bin/jetls'

return {
  cmd = { jetls_path, 'serve' },
  filetypes = { 'julia' },
  root_markers = { 'Project.toml', 'JuliaProject.toml', '.git' },
  settings = {
    code_lens = {
      references = true,
    },
    diagnostic = {
      patterns = {
        {
          pattern = '(toplevel|inference)/.*}',
          match_by = 'code',
          match_type = 'regex',
        },
      },
    },
  },
}
