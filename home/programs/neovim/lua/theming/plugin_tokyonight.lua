local M = {}
M.setup = function()
    local config = require("theming.configuration").get({
        style = "storm",
        transparent = false,
    })

    vim.g.tokyonight_style = config.style
    vim.g.tokyonight_sidebars = config.sidebars
    vim.g.tokyonight_transparent = config.transparent

    vim.cmd([[colorscheme tokyonight]])
end

return M
