return {
  'ThePrimeagen/harpoon',
  event = 'VeryLazy',
  branch = 'harpoon2',
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function ()
    local harpoon = require('harpoon')

    harpoon:setup()

    -- Add file to harpoon list
    vim.keymap.set('n', '<leader>a', function() harpoon:list():add() end, { desc = '[A]dd to Harpoon' })

    -- Go to file in harpoon list
    vim.keymap.set('n', '<A-j>', function() harpoon:list():select(1) end)
    vim.keymap.set('n', '<A-k>', function() harpoon:list():select(2) end)
    vim.keymap.set('n', '<A-l>', function() harpoon:list():select(3) end)
    vim.keymap.set('n', '<A-f>', function() harpoon:list():select(4) end)
    vim.keymap.set('n', '<A-d>', function() harpoon:list():select(5) end)
    vim.keymap.set('n', '<A-s>', function() harpoon:list():select(6) end)
    for i = 1, 4, 1 do
      vim.keymap.set('n', string.format('<A-%d>', i), function () harpoon:list():select(i + 6) end)
    end

    -- Toggle previous & next buffers stored within Harpoon list
    vim.keymap.set('n', '<A-;>', function() harpoon:list():next() end)
    vim.keymap.set('n', '<A-,>', function() harpoon:list():prev() end)

    -- Open harpoon list
    vim.keymap.set('n', '<A-e>', function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

    harpoon:extend{
      UI_CREATE = function(cx)
        vim.keymap.set('n', '<C-v>', function()
          harpoon.ui:select_menu_item({ vsplit = true })
        end, { buffer = cx.bufnr })

        vim.keymap.set('n', '<C-x>', function()
          harpoon.ui:select_menu_item{ split = true }
        end, { buffer = cx.bufnr })

        vim.keymap.set('n', '<C-t>', function()
          harpoon.ui:select_menu_item{ tabedit = true }
        end, { buffer = cx.bufnr })
      end,
    }
  end
}
