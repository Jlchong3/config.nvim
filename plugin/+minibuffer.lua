vim.g.minibuffer = {
    cmd = { enabled = false }
}
vim.pack.add {
    "https://github.com/simifalaye/minibuffer.nvim"
}

require("minibuffer")
