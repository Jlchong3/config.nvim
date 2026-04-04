vim.pack.add {
    {
        src = 'https://github.com/Saghen/blink.cmp',
        version = vim.version.range("^1")
    },
    'https://github.com/rafamadriz/friendly-snippets'
}

local function get_mini_icon(ctx)
  if ctx.source_name == "Path" then
    local is_unknown_type = vim.tbl_contains(
        { "link", "socket", "fifo", "char", "block", "unknown" },
        ctx.item.data.type
    )
    local mini_icon, mini_hl, _ = require("mini.icons").get(
        is_unknown_type and "os" or ctx.item.data.type,
        is_unknown_type and "" or ctx.label
    )
    if mini_icon then
        return mini_icon, mini_hl
    end
  end
  local mini_icon, mini_hl, _ = require("mini.icons").get("lsp", ctx.kind)
  return mini_icon, mini_hl
end

require('blink.cmp').setup {
    keymap = { preset = 'default' },

    completion = {
        menu = {
            border = 'none',
            draw = {
                columns = { { 'label', 'label_description', gap = 1 }, { 'kind_icon', gap = 1, 'kind' } },
                components = {
                    kind_icon = {
                        text = function(ctx)
                            local kind_icon, _, _ = get_mini_icon(ctx)
                            return kind_icon
                        end,
                        highlight = function(ctx)
                            local _, hl, _ = get_mini_icon(ctx)
                            return hl
                        end,
                    },
                    kind = {
                        highlight = function(ctx)
                            local _, hl, _ = get_mini_icon(ctx)
                            return hl
                        end,
                    }
                }
            }
        },

        accept = { auto_brackets = { enabled = false } },
        documentation = { auto_show = true, }
    },

    signature = { enabled = true, },

    sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer' },
    },
}

