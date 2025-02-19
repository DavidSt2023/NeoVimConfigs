local mason_path = vim.fn.stdpath("data") .. "\\mason\\share\\jdtls"
local config = {
    cmd = {mason_path .. "\\plugins\\org.eclipse.equinox.launcher.jar",},
    root_dir = vim.fs.dirname(vim.fs.find({'gradlew', '.git', 'mvnw'}, { upward = true })[1]),
}
require('jdtls').start_or_attach(config)

