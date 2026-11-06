-- kirocrew.nvim: Neovim front-end for Kiro Crew (streaming chat, non-blocking
-- tool approvals, parallel sessions). Local dev checkout at ~/dev/kirocrew.nvim.
--
-- Commands after load: :KiroChat (open a session), :KiroSessions (switcher),
-- :KiroSend <text> (send without focusing the input buffer).
return {
  {
    dir = '/home/pdudley/dev/kirocrew.nvim',
    name = 'kirocrew.nvim',
    -- Load on the commands so startup stays fast; the sidecar only spawns on first use.
    cmd = { 'KiroChat', 'KiroResume', 'KiroSessions', 'KiroSend', 'KiroGateway', 'KiroApprovals', 'KiroInput', 'KiroHistory', 'KiroLayout', 'KiroReload', 'KiroStop', 'KiroInterrupt', 'KiroModel', 'KiroAgent', 'KiroTitle' },
    config = function()
      require('kirocrew').setup {
        gateway = {
          url = 'http://localhost:5476', -- token = nil → sidecar bootstraps via ~/.kiro/crew/.local_secret
        },
        sidecar = {
          kind = 'go', -- 'go' uses the built bin/kirocrew-sidecar; 'python' uses the venv
          auto_build = true, -- build the artifact if missing/stale and the toolchain is present
          debug = false, -- set true to log WS frames + requests to ~/.local/state/nvim/kirocrew-sidecar.log
        },
        approvals = {
          float = false, -- buffers + keymaps are the default; opt-in float is non-modal
        },
      }
    end,
  },
}
