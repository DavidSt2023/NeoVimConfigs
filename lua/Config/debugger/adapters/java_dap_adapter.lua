local M = {}


local dap = require("dap")
M.setupJava = function()
dap.adapters.java = {
    type = 'server',
    port = 5005, -- Port für den Debugger
    executable = {
        command = 'java',
        args = {
            '-agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=*:5005',
            '-jar', 'C:\\Users\\David\\AppData\\Local\\jdt-language-server\\plugins\\org.eclipse.equinox.launcher_1.6.900.v20240613-2009.jar',
            '-configuration', vim.fn.stdpath('data') .. '\\mason\\packages\\jdtls\\config_win',
            '-data', 'C:\\Users\\David\\repos\\Danger_Gang_GVI\\SUD\\Java\\JavaVerwaltung\\src\\main\\java'
        },
    },
}

-- Konfigurationen für Java
dap.configurations.java = {
    {
        type = 'java',
        name = 'Launch', -- Name der Konfiguration
        request = 'launch', -- Typ der Anfrage
        mainClass = 'com.example.Main', -- Ersetze dies mit dem vollqualifizierten Namen deiner Hauptklasse
        args = {}, -- Hier kannst du Argumente für die Hauptklasse hinzufügen, falls nötig
    },
    {
        type = 'java',
        name = 'Attach', -- Name der Konfiguration
        request = 'attach', -- Typ der Anfrage
        hostName = '127.0.0.1', -- Hostname für die Verbindung
        port = 5005, -- Port für die Verbindung
    },
}

end
return M
