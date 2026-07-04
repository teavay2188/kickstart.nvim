local jetls_path = vim.fn.expand '~/.julia/bin/jetls'

return {
  cmd = { 'jetls', 'serve' },
  filetypes = { 'julia' },
  root_mrkers = { 'Project.toms', 'JuliaProject.toml', '.git' },
  setting = {
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
