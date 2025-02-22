return {
  "iamcco/markdown-preview.nvim",
  cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
  build = "cd app && npm install",
  init = function()
    -- Dynamische Ermittlung der lokalen IP-Adresse
    local function get_local_ip()
      local handle = io.popen("ipconfig")
      local output = handle:read("*a")
      handle:close()

      -- Suche nach der IPv4-Adresse (Windows)
      local ip = output:match("IPv4.-: (%d+%.%d+%.%d+%.%d+)")
      if ip then
        return ip
      end

      -- Fallback: Rückgabewert im Falle von Fehlern oder wenn die IP nicht gefunden wurde
      return "127.0.0.1"
    end

    -- Setze die IP-Adresse dynamisch
    vim.g.mkdp_open_ip = get_local_ip()
    vim.g.mkdp_filetypes = { "markdown" }
    vim.g.mkdp_open_to_the_world = 1
    vim.g.mkdp_echo_preview_url = 1
    vim.g.mkdp_port = 9090
  end,
  ft = { "markdown" },
}
