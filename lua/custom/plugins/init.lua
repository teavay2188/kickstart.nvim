-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information

---@module 'lazy'
---@type LazySpec
return {
  {
    'stevearc/conform.nvim',
    opts = {},
    config = function()
      require('conform').setup {
        formatters_by_ft = {
          lua = { 'stylua' },
        },
      }
    end,
  },
  {
    -- add this to your lua/plugins.lua, lua/plugins/init.lua,  or the file you keep your other plugins:
    'numToStr/Comment.nvim',
    opts = {
      -- add any options here
    },
    config = function() require('Comment').setup {
            padding = true,
            opleader = {
                line = 'gc',
                block = 'gb',
            },
        } end,
  },
}
