-- Rust package manager
return {
    'saecki/crates.nvim',
    tag = 'stable',
    event = { 'BufRead Cargo.toml' },
    config = function ()
        require('crates').setup{
            popup = { border = 'single' }
        }
        vim.api.nvim_create_autocmd('BufRead', {
            group = vim.api.nvim_create_augroup('CmpSourceCargo', { clear = true }),
            pattern = 'Cargo.toml',
            callback = function()
                require('cmp').setup.buffer({ sources = { { name = 'crates' } } })
                local crates = require('crates')
                vim.keymap.set('n', '<leader>ct', crates.toggle, { silent = true, desc = 'Crates toggle'})
                vim.keymap.set('n', '<leader>cr', crates.reload, { silent = true, desc = 'Crates reload'})

                vim.keymap.set('n', '<leader>cf', crates.show_features_popup, { silent = true, desc = 'Crates show features'})
                vim.keymap.set('n', '<leader>cd', crates.show_dependencies_popup, { silent = true, desc = 'Crates dependencies'})

                vim.keymap.set('n', '<leader>cu', crates.update_crate, { silent = true, desc = 'Update crate'})
                vim.keymap.set('v', '<leader>cu', crates.update_crates, { silent = true, desc = 'Update crates'})
                vim.keymap.set('n', '<leader>cl', crates.update_all_crates, { silent = true, desc = 'Update all crates'})
                vim.keymap.set('n', '<leader>cU', crates.upgrade_crate, { silent = true, desc = 'Upgrade crate'})
                vim.keymap.set('v', '<leader>cU', crates.upgrade_crates, { silent = true, desc = 'Upgrade crates'})
                vim.keymap.set('n', '<leader>cL', crates.upgrade_all_crates, { silent = true, desc = 'Upgrade all crates'})

                vim.keymap.set('n', '<leader>cx', crates.expand_plain_crate_to_inline_table, { silent = true, desc = 'Expand to inline table'})
                vim.keymap.set('n', '<leader>cX', crates.extract_crate_into_table, { silent = true, desc = 'Expand into table'})
            end,
        })
    end
}
