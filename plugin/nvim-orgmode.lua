vim.pack.add { 'https://github.com/nvim-orgmode/orgmode' }

require('orgmode').setup({
  org_agenda_files = '~/Documents/notes/**/*',
  org_default_notes_file = '~/Documents/notes/refile.org',
})

vim.lsp.enable('org')
