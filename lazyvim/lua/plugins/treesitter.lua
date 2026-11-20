-- Linux servers only (small RAM): LazyVim compiles every missing parser at
-- once, and gitcommit alone needs over 1.6 GB to compile (it OOM-killed gcc on
-- a 1.9 GB host). There: no gitcommit, and the rest one at a time (the largest,
-- vim, peaks around 360 MB).
if vim.uv.os_uname().sysname ~= "Linux" then
  return {}
end

local skip = { gitcommit = true }

return {
  "nvim-treesitter/nvim-treesitter",
  opts = function(_, opts)
    local want = vim.tbl_filter(function(lang)
      return not skip[lang]
    end, opts.ensure_installed or {})
    -- LazyVim installs nothing itself; this does, after its setup has run.
    opts.ensure_installed = {}
    vim.schedule(function()
      local TS = require("nvim-treesitter")
      local have = TS.get_installed()
      local missing = vim.tbl_filter(function(lang)
        return not vim.tbl_contains(have, lang)
      end, want)
      if #missing > 0 then
        TS.install(missing, { summary = true, max_jobs = 1 }):await(function()
          LazyVim.treesitter.get_installed(true)
        end)
      end
    end)
  end,
}
