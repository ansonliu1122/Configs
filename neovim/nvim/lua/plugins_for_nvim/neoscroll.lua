return {
    "karb94/neoscroll.nvim",
    event = "VeryLazy",
    config = function()
        local neoscroll = require("neoscroll")

        neoscroll.setup({
            easing_function = "sine",
        })

        local scroll = neoscroll.scroll

        local map = function(lhs, lines)
            vim.keymap.set("n", lhs, function()
                scroll(lines, {
                    move_cursor = true,
                    duration = 150,
                    easing = "sine",
                })
            end, { silent = true, desc = "neoscroll: " .. lhs })
        end

        map("<C-d>", vim.wo.scroll)
        map("<C-u>", -vim.wo.scroll)
        map("<C-f>", vim.api.nvim_win_get_height(0))
        map("<C-b>", -vim.api.nvim_win_get_height(0))
        map("<C-e>", 0.10)
        map("<C-y>", -0.10)

        local win_height = vim.api.nvim_win_get_height(0)

        vim.keymap.set("n", "zz", function()
            neoscroll.zz(win_height / 2, 150)
        end, { silent = true })
        vim.keymap.set("n", "zt", function()
            neoscroll.zt(win_height / 2, 150)
        end, { silent = true })
        vim.keymap.set("n", "zb", function()
            neoscroll.zb(win_height / 2, 150)
        end, { silent = true })
    end,
}
