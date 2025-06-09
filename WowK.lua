-- UI Setup
local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/heywassuphi/WowK/main/WowK.lua"))()

-- Toggle UI with Insert
local UIS = game:GetService("UserInputService")
UIS.InputBegan:Connect(function(input, gpe)
    if not gpe and input.KeyCode == Enum.KeyCode.Insert then
        library:ToggleUI()
    end
end)

-- Theme
if library.SetTheme then
    library:SetTheme{
        Background = Color3.fromRGB(80, 0, 30),
        Accent = Color3.fromRGB(0, 180, 255),
        Border = Color3.fromRGB(0, 40, 100),
        Text = Color3.fromRGB(255, 255, 255),
        Hover = Color3.fromRGB(0, 180, 255)
    }
end

-- Load Window
local window = library:Load{playerlist = true}
window:SettingsTab(library:Watermark("WowK | dev | test | beta"))

-- Tabs and Sections
local tab = window:Tab("rage")
local sec = tab:Section{Side = "Right"}
local fovSec = tab:Section{Side = "Right"}
local hpSec = tab:Section{Side = "Right"}

-- Helpers
local function optToggle(name, key)
    sec:Toggle{
        name = name, color = Color3.fromRGB(0, 180, 255), state = getgenv().WowKSilent[key],
        callback = function(val) getgenv().WowKSilent[key] = val end
    }
end

local function simpleSlider(section, name, key, min, max, dec)
    section:Slider{
        name = name, min = min, max = max, decimal = dec, default = getgenv().WowKSilent[key], color = Color3.fromRGB(0, 180, 255),
        callback = function(val) getgenv().WowKSilent[key] = val end
    }
end

-- Silent Aim Controls
optToggle("WowK Silent Aim", "Enabled")
simpleSlider(sec, "Prediction", "Prediction", 0, 0.3, 5)
optToggle("Resolver", "Resolver")
optToggle("Wall Check", "WallCheck")
sec:Box{
    name = "Keybind", text = getgenv().WowKSilent.Keybind or "C", color = Color3.fromRGB(0, 180, 255),
    callback = function(k) getgenv().WowKSilent.Keybind = k end
}
sec:Dropdown{
    name = "Target Part", content = {"Head", "Torso", "HumanoidRootPart"}, color = Color3.fromRGB(0, 180, 255),
    callback = function(val) getgenv().WowKSilent.TargetPart = val end
}

-- FOV Controls
local fov = getgenv().WowKSilent.FovSettings
fovSec:Toggle{
    name = "Show FOV", color = Color3.fromRGB(0, 180, 255), state = fov.FovVisible,
    callback = function(val) fov.FovVisible = val end
}
simpleSlider(fovSec, "FOV Radius", "FovRadius", 10, 200)
fovSec:Dropdown{
    name = "FOV Shape", content = {"Circle", "Square", "Triangle"}, color = Color3.fromRGB(0, 180, 255),
    callback = function(val) fov.FovShape = val end
}
fovSec:Toggle{
    name = "Filled FOV", color = Color3.fromRGB(0, 180, 255), state = fov.Filled,
    callback = function(val) fov.Filled = val end
}
simpleSlider(fovSec, "FOV Transparency", "FovTransparency", 0, 1, 2)

-- HitPoint Controls
local hp = getgenv().WowKSilent.HitPoint
hpSec:Toggle{
    name = "Show HitPoint", color = Color3.fromRGB(0, 180, 255), state = hp.ShowHitPoint,
    callback = function(val) hp.ShowHitPoint = val end
}
simpleSlider(hpSec, "HitPoint Radius", "HitPointRadius", 1, 30)
simpleSlider(hpSec, "HitPoint Thickness", "HitPointThickness", 1, 5)
simpleSlider(hpSec, "HitPoint Transparency", "HitPointTransparency", 0, 1, 2)

-- Init and Core
library:Init()
loadstring(game:HttpGet("https://pastebin.com/raw/8WLaquw0"))()

-- Default Target Part
getgenv().WowKSilent.TargetPart = getgenv().WowKSilent.TargetPart or "Head"
