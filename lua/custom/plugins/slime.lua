vim.pack.add {
  'https://github.com/jpalardy/vim-slime',
}

vim.g.slime_target = 'tmux'

vim.g.slime_default_config = {
  socket_name = 'default',
  target_pane = ':.2',
}
