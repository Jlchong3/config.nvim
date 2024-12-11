return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  opts = {
    bigfile = { enabled = true },
    dashboard = { enabled = true },
    dim = { enabled = true },
    git = { enabled = true },
    gitbrowse = { enabled = true },
    notifier = { enabled = true },
    toggle = { enabled = true, },
  },
  keys = {
    { '<leader>gb', function () Snacks.git.blame_line() end, desc = '[G]it [B]lame' },
    { '<leader>gr', function () Snacks.gitbrowse.open() end, desc = '[G]it [R]epository' },
    { '<leader>mh', function () Snacks.notifier.show_history() end, desc = '[M]essage [H]istory' },
    { "<leader>hn", function() Snacks.notifier.hide() end, desc = '[H]ide [N]otifications' },
  },
  init = function ()
    vim.api.nvim_create_autocmd("User", {
      pattern = "VeryLazy",
      callback = function()
        -- Create some toggle mappings
        Snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>ts")
        Snacks.toggle.option("list", { name = "List C hars" }):map("<leader>tc")
        Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("<leader>tl")
        Snacks.toggle.diagnostics():map("<leader>td")
        Snacks.toggle.inlay_hints():map("<leader>in")
        Snacks.toggle.dim():map("<leader>tm")
      end,
    })

  end
}
