-- ~/nvim/lua/slydragonn/plugins/mason.lua

return {
    "williamboman/mason.nvim",
    dependencies = {
        "williamboman/mason-lspconfig.nvim",
        "WhoIsSethDaniel/mason-tool-installer.nvim",
    },
    config = function()
        require("mason").setup()

        require("mason-lspconfig").setup({
            automatic_installation = true,
            ensure_installed = {
                "cssls",
                "eslint",
                "html",
                "jsonls",
                "pyright",
                "tailwindcss",
				"java-language-server",
            },
        })

        require("mason-tool-installer").setup({
            ensure_installed = {
                "prettier",
                "stylua", -- lua formatter
                "eslint_d",
				"java-language-server",
            },
        })
    end,
}

