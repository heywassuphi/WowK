-- Toggle UI with Insert
local UIS = game:GetService("UserInputService")
UIS.InputBegan:Connect(function(input, gpe)
    if not gpe and input.KeyCode == Enum.KeyCode.Insert then
        library:ToggleUI()
    end
end)

-- Theme
local RGB = Color3.fromRGB
local baseWineRed, darkBlue, neonBlue, white = RGB(80, 0, 30), RGB(0, 40, 100), RGB(0, 180, 255), RGB(255, 255, 255)
if library.SetTheme then
    library:SetTheme{Background = baseWineRed, Accent = neonBlue, Border = darkBlue, Text = white, Hover = neonBlue}
end

local window = library:Load{playerlist = true}
window:SettingsTab(library:Watermark("WowK | dev | test | beta"))

-- Tabs
local tab = window:Tab("rage")
window:Tab("visuals")
window:Tab("legit"):Section{Side = "Middle"}
local sec = tab:Section{Side = "Right"}

-- Helper
local function optToggle(name, valKey)
    sec:Toggle{
        name = name,
        color = neonBlue,
        state = getgenv().WowKSilent[valKey],
        callback = function(val) getgenv().WowKSilent[valKey] = val end
    }
end

-- Silent Aim Controls
optToggle("WowK Silent Aim", "Enabled")
sec:Slider{
    name = "Prediction", min = 0, max = 0.3, default = getgenv().WowKSilent.Prediction or 0.11456, decimal = 5,
    color = neonBlue, callback = function(v) getgenv().WowKSilent.Prediction = v end
}
optToggle("Resolver", "Resolver")
optToggle("Wall Check", "WallCheck")
sec:Box{
    name = "Keybind", text = getgenv().WowKSilent.Keybind or "C", color = neonBlue,
    callback = function(k) getgenv().WowKSilent.Keybind = k end
}

-- FOV Controls
local fov = getgenv().WowKSilent.FovSettings
local fovSec = tab:Section{Side = "Right"}
local function fovOpt(name, key, isSlider, props)
    fovSec[isSlider and "Slider" or "Toggle"]{
        name = name, color = neonBlue, state = fov[key], default = fov[key],
        min = props and props.min, max = props and props.max, decimal = props and props.decimal,
        content = props and props.content,
        callback = function(v) fov[key] = v end
    }
end
fovOpt("Show FOV", "FovVisible")
fovOpt("FOV Radius", "FovRadius", true, {min=10, max=200})
fovSec:Dropdown{
    name = "FOV Shape", content = {"Circle", "Square", "Triangle"}, color = neonBlue,
    callback = function(v) fov.FovShape = v end
}
fovOpt("Filled FOV", "Filled")
fovOpt("FOV Transparency", "FovTransparency", true, {min=0, max=1, decimal=2})

-- HitPoint Controls
local hp = getgenv().WowKSilent.HitPoint
local hpSec = tab:Section{Side = "Right"}
local function hpSlider(name, key, min, max, dec)
    hpSec:Slider{
        name = name, min = min, max = max, default = hp[key], decimal = dec, color = neonBlue,
        callback = function(v) hp[key] = v end
    }
end
optToggle("Show HitPoint", "ShowHitPoint")
hpSlider("HitPoint Radius", "HitPointRadius", 1, 30)
hpSlider("HitPoint Thickness", "HitPointThickness", 1, 5)
hpSlider("HitPoint Transparency", "HitPointTransparency", 0, 1, 2)

-- Init & Load Core
library:Init()
loadstring(game:HttpGet("https://pastebin.com/raw/yourWowKSilentAimCodeHere"))()
