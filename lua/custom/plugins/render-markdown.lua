-- render-markdown.nvim: pretty in-buffer markdown rendering (headings, code
-- blocks, bullets, quotes, tables), following the live buffer as it streams.
-- Colors come from the RenderMarkdown* highlight groups, which tritan-dark
-- defines in its tritanopia-safe palette — so this renders in-theme, no blue.
--
-- Used by kirocrew.nvim's chat history pane (filetype=markdown) and any
-- markdown file.
return {
  {
    'MeanderingProgrammer/render-markdown.nvim',
    -- Icon provider is OPTIONAL (only code-block language icons). You already
    -- have both mini.nvim (mini.icons) and nvim-web-devicons installed, plus
    -- have_nerd_font = true. We depend on mini.icons so lazy.nvim guarantees an
    -- icon provider is loaded before render-markdown and the choice is explicit
    -- (avoids load-order ambiguity between the two providers you have).
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
      'echasnovski/mini.nvim', -- provides mini.icons (the suite you already use)
    },
    ft = { 'markdown' },
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    opts = {
      -- Keep rendering while the cursor is on the line (don't flip to raw) so a
      -- streaming chat buffer stays rendered as it updates.
      anti_conceal = { enabled = true },
      -- Render the agent's streamed markdown even though the buffer is 'nofile'.
      render_modes = { 'n', 'i', 'c' },
    },
    config = function(_, opts)
      -- Kickstart's mini.nvim block sets up ai/surround/statusline but NOT
      -- mini.icons, so register it here as the devicons-compatible provider for
      -- code-block language icons. Harmless if already set up elsewhere.
      pcall(function()
        require('mini.icons').setup()
      end)
      require('render-markdown').setup(opts)
    end,
  },
}
