local M = {}

function M.setup()
	local dap = require("dap")

	dap.adapters.java = function(callback)
		-- This will be called when dap.continue() is called for a Java debugging session
		callback({
			type = "server",
			host = "127.0.0.1",
			port =  vim.fn.expand("${port}"), -- The JDTLS will automatically forward the debug server port
			executable = {
				command = vim.fn.exepath("java"),
			},
		})
	end

	dap.configurations.java = {
		{
			type = "java",
			request = "attach",
			name = "Debug (Attach) - Remote",
			hostName = "127.0.0.1",
			port = 5005,
		},
	}

	dap.configurations.java = {
		{
			type = "java",
			request = "launch", -- Ändere von 'attach' auf 'launch'
			name = "Debug (Launch) - Main Class",
			mainClass = "src.main.java.Main", -- Hier deine Hauptklasse angeben (z.B. com.example.Main)
			args = "", -- Optionale Argumente für das Main-Class
			cwd = vim.fn.getcwd(), -- Setzt das Arbeitsverzeichnis auf das aktuelle Verzeichnis
			projectName = "DeinProjektName", -- Optional, falls du den Projektnamen angeben möchtest
		},
	}
	-- Register the vscode-java-debug extension
	local jdtls = require("jdtls")
	local bundles = {
		vim.fn.glob(
			vim.fn.stdpath("data")
          .. "/mason/packages/java-debug-adapter/extension/server/com.microsoft.java.debug.plugin-*.jar"
		),
	}

	-- Add all JAR files in the server directory
	vim.list_extend(
		bundles,
		vim.split(
			vim.fn.glob(vim.fn.stdpath("data") .. "/mason/packages/java-debug-adapter/extension/server/*.jar"),
			"\n"
		)
	)

	-- Ensure jdtls is properly configured to use these bundles
	vim.api.nvim_create_autocmd("FileType", {
		pattern = "java",
		callback = function()
			local config = {
				cmd = {
					"C:\\Program Files\\OpenJDK\\jdk-22.0.2\\bin\\java",
					"-Declipse.application=org.eclipse.jdt.ls.core.id1",
					"-Dosgi.bundles.defaultStartLevel=4",
					"-Declipse.product=org.eclipse.jdt.ls.core.product",
					"-Dlog.protocol=true",
					"-Dlog.level=ALL",
					"-Xms512m",
					"-Xmx2048m",
					"--add-modules=ALL-SYSTEM",
					"--add-opens",
					"java.base/java.util=ALL-UNNAMED",
					"--add-opens",
					"java.base/java.lang=ALL-UNNAMED",
					"-jar",
					vim.fn.glob(
						vim.fn.stdpath("data") .. "/mason/packages/jdtls/plugins/org.eclipse.equinox.launcher_*.jar"
					),
					"-configuration",
					vim.fn.stdpath("data") .. "/mason/packages/jdtls/config_win",
					"-data",
					vim.fn.getcwd(),
				},
				root_dir = jdtls.setup.find_root({ ".git", "pom.xml", "build.gradle" }),
				init_options = {
					bundles = bundles,
				},
			}

			jdtls.start_or_attach(config)

			-- Set up DAP integration
			jdtls.setup_dap({ hotcodereplace = "auto" })
			require("jdtls.dap").setup_dap_main_class_configs()
		end,
	})
end

return M
