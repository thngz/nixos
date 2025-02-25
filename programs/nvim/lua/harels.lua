local client = vim.lsp.start_client {
    name = "harels",
    -- cmd_cwd = {"/home/gkiviv/projects/javascript/harels_node"},
    cmd = { "npm", "run", "dev" },
    -- cmd = {"node", "--experimental-strip-types", "main.ts"}
}

if not client then
    vim.notify "server didnt start up"
    return
end

vim.api.nvim_create_autocmd("FileType", {
    pattern = "hare",
    callback = function()
        vim.lsp.buf_attach_client(0, client)
        -- vim.notify(res)
    end,
})
