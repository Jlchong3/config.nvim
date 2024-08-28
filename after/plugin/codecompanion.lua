require('codecompanion').setup{
    strategies = {
        chat = {
            adapter = 'gemini',
        },
        inline = {
            adapter = 'gemini',
        },
        agent = {
            adapter = 'gemini',
        },
    },
    adapters = {
        gemini = function()
            return require('codecompanion.adapters').extend('gemini', {
                env = {
                    api_key = 'GEMINI_API_KEY'
                },
            })
        end,
    },
}
