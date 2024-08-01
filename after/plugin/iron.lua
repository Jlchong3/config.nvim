local iron = require("iron.core")

iron.setup {
  config = {
    -- Whether a repl should be discarded or not
    scratch_repl = true,
    -- Your repl definitions come here
    repl_definition = {
      sh = {
        command = {"zsh"}
      },
      python = {
        command = { 'ipython' },
      },
      r = {
        command = { 'R' },
      }
    },
    repl_open_cmd = 'vertical botright 130vnew'
  },

  keymaps = {
    send_motion = "<space>rm",
    visual_send = "<space>rm",
    send_file = "<space>rf",
    send_line = "<space>rl",
    send_paragraph = "<space>rap",
    send_until_cursor = "<space>ru",
    send_mark = "<space>ms",
    mark_motion = "<space>mc",
    mark_visual = "<space>mc",
    remove_mark = "<space>md",
    cr = "<space>s<cr>",
    interrupt = "<space>s<space>",
    exit = "<space>rq",
    clear = "<space>cl",
  },

  highlight = {
    italic = true
  },
  ignore_blank_lines = true, -- ignore blank lines when sending visual select lines
}

