-- tritan-dark: a tritanopia-safe, green-forward dark colorscheme.
-- Set as the DEFAULT colorscheme. Loaded eagerly at startup with high priority
-- so it beats other plugins' highlight setup (the standard pattern for a
-- default theme). Local dev checkout at ~/dev/tritan-dark.nvim.
return {
  {
    dir = '/home/pdudley/dev/tritan-dark.nvim',
    name = 'tritan-dark',
    lazy = false, -- a default colorscheme must load at startup, not on a command
    priority = 1000, -- load before other plugins so its highlights win
    config = function()
      require('tritan-dark').load()
    end,
  },
}
