-- ~/nvim/lua/slydragonn/plugins/mason.lua

return {
    "williamboman/mason.nvim",
    dependencies = {
        "williamboman/mason-lspconfig.nvim",
        "WhoIsSethDaniel/mason-tool-installer.nvim",
    },
    config = function()
        require("mason").setup()
--only Listed https://github.com/williamboman/mason-lspconfig.nvim
        require("mason-lspconfig").setup({
            automatic_installation = true,
            ensure_installed = {
                "cssls",
                "eslint",
                "html",
                "jsonls",
                "ast_grep",
                "ltex",
                "tailwindcss",
                
				
            },
        })
--Any
        require("mason-tool-installer").setup({
            ensure_installed = {
                "prettier",
                "stylua", -- lua formatter
                "eslint_d",
				"typescript-language-server",
				
            },
        })
    end,
}

