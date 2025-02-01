local settings_file = vim.fn.stdpath('config') .. "/settings.json"
local S = {}
local function loadSettings()
  local file = io.open(settings_file, "r")
  if not file then
    print("Fehler: Datei " .. settings_file .. " konnte nicht geöffnet werden.")
    return nil
  end
  local settings_content = file:read("*all")
  file:close() 
  return vim.fn.json_decode(settings_content)
end

local settings = loadSettings()

S.getSettings = function()
  return settings
end

S.writeSetting = function(el, newValue)
  settings[el] = newValue
  local new_settings_content = vim.fn.json_encode(settings)

  local file = io.open(settings_file, "w")
  if not file then
    print("Fehler: Datei " .. settings_file .. " konnte nicht geöffnet werden.")
    return
  end
  file:write(new_settings_content)
  file:close()
end

return S
