vim.api.nvim_create_autocmd("FileType", {
    pattern = "hare",
    callback = function()
        local client = vim.lsp.start_client {
            name = "harels",
            cmd = { "node", "/home/gkiviv/projects/javascript/harels/server/out/main.js"},
        }

        if not client then
            vim.notify "server didnt start up"
            return
        end

        vim.lsp.buf_attach_client(0, client)
        -- vim.notify(res)
    end,
})
