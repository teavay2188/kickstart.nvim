-- Set Vimwiki options before loading it. Only .wiki files belong to Vimwiki;
-- Markdown files must keep their filetype so render-markdown can attach.
vim.g.vimwiki_ext2syntax = vim.empty_dict()
vim.g.vimwiki_list = {
  {
    path = '~/vault/wiki/',
    syntax = 'default',
    ext = '.wiki',
  },
}

vim.pack.add {
  'https://github.com/nvim-orgmode/orgmode',
  'https://github.com/vimwiki/vimwiki',
  'https://github.com/MeanderingProgrammer/render-markdown.nvim',
}

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

-- Treesitter (including markdown and markdown_inline) and mini.icons are set up in init.lua.
---@module 'render-markdown'
---@type render.md.UserConfig
require('render-markdown').setup {
  file_types = { 'markdown' },
  -- Render math when an optional converter is available.
  latex = { enabled = vim.fn.executable 'utftex' == 1 or vim.fn.executable 'latex2text' == 1 },
}

vim.keymap.set('n', '<leader>tm', '<cmd>RenderMarkdown toggle<CR>', { desc = '[T]oggle [M]arkdown rendering' })

vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'vimwiki' },
  callback = function()
    vim.opt_local.expandtab = false
    vim.opt_local.shiftwidth = 4
    vim.opt_local.tabstop = 4
    vim.opt_local.softtabstop = 4
  end,
})
