return {
  'neovim/nvim-lspconfig', -- LSP-Config
  dependencies = {
    'williamboman/mason.nvim',
    'williamboman/mason-lspconfig.nvim',
    'hrsh7th/cmp-nvim-lsp',
    'mfussenegger/nvim-jdtls',
  },
  config = function()
    local lspconfig = require('lspconfig')
    local capabilities = require('cmp_nvim_lsp').default_capabilities()
    local on_attach = function(client, bufnr)
      client.server_capabilities.documentFormattingProvider = true
      vim.keymap.set('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', {})
      vim.keymap.set('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', {})
      vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', {})
      vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', {})
      vim.api.nvim_buf_set_keymap(bufnr, "v", "<leader>f", "<cmd>lua vim.lsp.buf.formatting_sync()<CR>",
        { noremap = true, silent = true })
      vim.keymap.set('n', 'gr', require("telescope.builtin").lsp_references, {})
      vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', {})
    end
    require'jdtls'.start_or_attach({
    cmd = {
        vim.fn.expand'C:/Users/dstemmler/AppData/Local/nvim-data/mason/bin/jdtls',
        ('--jvm-arg=-javaagent:%s'):format(vim.fn.expand'C:/Users/dstemmler/AppData/Local/nvim-data/mason/packages/jdtls/lombok.jar')
      }
    })
    -- Lua LSP-Setup (Lua Language Server)
    lspconfig["lua_ls"].setup({
      capabilities = capabilities,
      on_attach = on_attach,
      settings = {
        Lua = {
          diagnostics = {
            globals = { 'vim' },
          },
        },
      },
    })

    lspconfig["ts_ls"].setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })


    lspconfig["cssls"].setup({
      capabilities = capabilities,
    })

    lspconfig["eslint"].setup({
      capabilities = capabilities,
    })
  end
}
