local M = {}

M.BaseGroup = vim.api.nvim_create_augroup('Base', { clear = true })
M.LSPGroup = vim.api.nvim_create_augroup('LSPGroup', { clear = true })
M.MarkupGroup = vim.api.nvim_create_augroup('markup_language', { clear = true })
M.TSGroup = vim.api.nvim_create_augroup('TSGroup', { clear = true })

return M
