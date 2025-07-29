return {
    "chrisgrieser/nvim-spider",   -- nvim-spider 插件
    lazy = true,                  -- 延遲加載插件
    config = function()
        require("spider").setup() -- 初始化並配置 nvim-spider
    end,
    event = "BufRead",            -- 只有在打開文件時才會加載插件
    keys = {
        { "w", "<cmd>lua require('spider').motion('w')<CR>", mode = { "n", "o", "x" } },
        { "e", "<cmd>lua require('spider').motion('e')<CR>", mode = { "n", "o", "x" } },
        { "b", "<cmd>lua require('spider').motion('b')<CR>", mode = { "n", "o", "x" } },
    },
}
