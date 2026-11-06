-- emoji.nvim: search and insert emojis/kaomojis.
--
-- This config uses blink.cmp (kickstart's completion engine) via blink.compat,
-- NOT nvim-cmp. The nvim-cmp dependency has been intentionally dropped to avoid
-- running two completion frameworks side by side.
return {
  {
    'allaman/emoji.nvim',
    -- version = '1.0.0', -- optionally pin to a tag
    ft = 'markdown', -- adjust to your needs
    dependencies = {
      -- util for handling paths
      'nvim-lua/plenary.nvim',
      -- optional for telescope integration
      'nvim-telescope/telescope.nvim',
      -- optional for fzf-lua integration via vim.ui.select
      'ibhagwan/fzf-lua',
    },
    opts = {
      -- default is false, also needed for blink.cmp integration!
      enable_cmp_integration = true,
    },
    config = function(_, opts)
      require('emoji').setup(opts)
      -- Telescope integration
      local ts = require('telescope').load_extension 'emoji'
      vim.keymap.set('n', '<leader>se', ts.emoji, { desc = '[S]earch [E]moji' })
    end,
  },

  -- Register emoji as a blink.cmp source via blink.compat.
  -- Use an opts *function* so we append to the existing sources list
  -- (lsp/path/snippets/lazydev) rather than replacing it.
  {
    'saghen/blink.cmp',
    optional = true,
    dependencies = { 'allaman/emoji.nvim', 'saghen/blink.compat' },
    opts = function(_, opts)
      opts.sources = opts.sources or {}
      opts.sources.default = opts.sources.default or {}
      table.insert(opts.sources.default, 'emoji')

      opts.sources.providers = opts.sources.providers or {}
      opts.sources.providers.emoji = {
        name = 'emoji',
        module = 'blink.compat.source',
        -- overwrite kind of suggestion
        transform_items = function(_, items)
          local kind = require('blink.cmp.types').CompletionItemKind.Text
          for i = 1, #items do
            items[i].kind = kind
          end
          return items
        end,
      }
    end,
  },
}
