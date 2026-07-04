vim.pack.add { 'https://github.com/nvim-orgmode/orgmode', 'https://github.com/vimwiki/vimwiki' }
require('orgmode').setup {
  org_agenda_files = '~/vault/projects/**/*',
  org_default_notes_file = '~/vault/projects/refile.org',
  org_todo_keywords = { 'TODO(t)', 'NEXT(n)', '|', 'DONE(d)', '|', 'HOLD(h)' },
  org_todo_keyword_faces = {
    DONE = ':foreground green',
    NEXT = ':foreground orange :weight bold :underline on',
    HOLD = ':foreground yellow',
  },
  mappings = {
    org_return_uses_meta_return = true,
  },
}
vim.g.vimwiki_list = {
  {
    path = '~/vault/wiki/',
    syntax = 'default',
    ext = '.wiki',
  },
}

vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'vimwiki' },
  callback = function()
    vim.opt_local.expandtab = false
    vim.opt_local.shiftwidth = 4
    vim.opt_local.tabstop = 4
    vim.opt_local.softtabstop = 4
  end,
})
--   {
--     'renerocksai/telekasten.nvim',
--     dependencies = { 'nvim-telescope/telescope.nvim' },
--   },
--   {
--     {
--       'MeanderingProgrammer/render-markdown.nvim',
--       dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-mini/mini.nvim' }, -- if you use the mini.nvim suite
--       -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-mini/mini.icons' },        -- if you use standalone mini plugins
--       -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
--       ---@module 'render-markdown'
--       ---@type render.md.UserConfig
--       opts = {},
--     },
--   },
-- }
