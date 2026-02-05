--Gui brookhaven script by rangga


--==================================================
-- SERVICES
--==================================================

local Players = game:GetService("Players")
local StarterGui = game:GetService("StarterGui")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer

--==================================================
-- GAME CHECK + POPUP SETTING
--==================================================

local BROOKHAVEN_PLACEID = 4924922222
local DECAL_ID = 94300218950105 -- << GANTI DENGAN ID DECAL KAMU

if game.PlaceId ~= BROOKHAVEN_PLACEID then
    pcall(function()
        StarterGui:SetCore("SendNotification", {
            Title = "Achievement Unlocked!";
            Text = "This game is not supported";
            Icon = "rbxassetid://" .. DECAL_ID;
            Duration = 6;
        })
    end)
    return
end

--==================================================
-- TAG SETTINGS
--==================================================

local PREFIX = "R4NG HUB BROOKHAVEN SC"
local SEPARATOR = " | "
local RAINBOW_SPEED = 0.008

--==================================================
-- TAG CREATION
--==================================================

local hue = 0
local textLabel

local function createTag(character)
    local head = character:WaitForChild("Head", 5)
    if not head then return end

    if head:FindFirstChild("CustomNameTag") then
        head.CustomNameTag:Destroy()
    end

    local gui = Instance.new("BillboardGui")
    gui.Name = "CustomNameTag"
    gui.Parent = head
    gui.Adornee = head
    gui.Size = UDim2.new(0, 260, 0, 55)
    gui.StudsOffset = Vector3.new(0, 2.8, 0)
    gui.AlwaysOnTop = true

    local label = Instance.new("TextLabel")
    label.Parent = gui
    label.Size = UDim2.new(1, 0, 1, 0)
    label.BackgroundTransparency = 1
    label.TextScaled = true
    label.Font = Enum.Font.GothamBold

    -- Glow / outline
    label.TextStrokeTransparency = 0
    label.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)

    label.Text = PREFIX .. SEPARATOR .. player.DisplayName
    textLabel = label
end

--==================================================
-- RAINBOW EFFECT
--==================================================

RunService.RenderStepped:Connect(function()
    if textLabel then
        hue = (hue + RAINBOW_SPEED) % 1
        textLabel.TextColor3 = Color3.fromHSV(hue, 1, 1)
    end
end)

--==================================================
-- CHARACTER HANDLER
--==================================================

if player.Character then
    createTag(player.Character)
end

player.CharacterAdded:Connect(createTag)

--=================================================
-- ORION LIBRARY
--=================================================

local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/jensonhirst/Orion/main/source')))()

-- Tambahin theme DarkBlood
OrionLib.Themes.DarkBlood = {
	Main = Color3.fromRGB(18, 18, 18),        -- background utama
	Second = Color3.fromRGB(28, 28, 28),      -- panel / card
	Stroke = Color3.fromRGB(120, 0, 0),       -- garis pinggir
	Divider = Color3.fromRGB(90, 0, 0),

	Text = Color3.fromRGB(230, 230, 230),     -- teks utama
	TextDark = Color3.fromRGB(170, 170, 170), -- teks secondary

	TabBackground = Color3.fromRGB(22, 22, 22),
	TabStroke = Color3.fromRGB(120, 0, 0),
	TabBackgroundSelected = Color3.fromRGB(120, 0, 0),
	TabTextColor = Color3.fromRGB(200, 200, 200),
	SelectedTabTextColor = Color3.fromRGB(255, 255, 255),

	Button = Color3.fromRGB(120, 0, 0),
	ButtonHover = Color3.fromRGB(160, 0, 0),
	ButtonActive = Color3.fromRGB(200, 0, 0),

	Toggle = Color3.fromRGB(120, 0, 0),
	ToggleDisabled = Color3.fromRGB(60, 0, 0),

	Slider = Color3.fromRGB(120, 0, 0),
	SliderBackground = Color3.fromRGB(40, 40, 40),

	Dropdown = Color3.fromRGB(25, 25, 25),
	DropdownStroke = Color3.fromRGB(120, 0, 0),

	Input = Color3.fromRGB(25, 25, 25),
	InputStroke = Color3.fromRGB(120, 0, 0),
	InputFocused = Color3.fromRGB(200, 0, 0)
}

-- Aktifkan theme DarkBlood
OrionLib.SelectedTheme = "DarkBlood"

local Window = OrionLib:MakeWindow({Name = "R4NG HUB | Brookhaven Script", HidePremium = false, SaveConfig = true, ConfigFolder = "OrionTest"})


local MainTab = Window:MakeTab({
	Name = "Brookhaven Sc",
	Icon = "rbxassetid://94300218950105",
	PremiumOnly = false
})

local Section = MainTab:AddSection({
	Name = "Brookhaven Script Pilihan"
})

MainTab:AddButton({
	Name = "Spectate players By: ByteScripts",
	Callback = function()
      		loadstring(game:HttpGet("https://pastebin.com/raw/7EAbhifj"))("t.me/ByteScripts")
  	end    
})

Tab:AddSlider({
	Name = "WalkSpeed",
	Min = 16,
	Max = 400,
	Default = 16,
	Increment = 1,
	ValueName = "WS",
	Callback = function(Value)
		local char = game.Players.LocalPlayer.Character
    if char then
        local hum = char:FindFirstChildOfClass("Humanoid")
        if hum then
            hum.WalkSpeed = Value
        end
    end   
end

})

Tab:AddSlider({
	Name = "JumpPower",
	Min = 50,
	Max = 670,
	Default = 5,
	Increment = 1,
	ValueName = "JP",
	Callback = function(Value)
		local char = game.Players.LocalPlayer.Character
    if char then
        local hum = char:FindFirstChildOfClass("Humanoid")
        if hum then
            hum.JumpPower = Value
        end
    end
end    
})


MainTab:AddButton({
	Name = "Coolkid Script By: nullSector ",
	Callback = function()
      		loadstring(game:HttpGet("https://pastebin.com/raw/KyJT0pMR"))() -- C00LGUI

  	end    
})

MainTab:AddButton({
	Name = "Touch Fling gui",
	Callback = function()
      		loadstring(game:HttpGet("https://pastebin.com/raw/LgZwZ7ZB",true))()
  	end    
})

MainTab:AddButton({
	Name = "Fling Multi Players",
	Callback = function()
      		loadstring(game:HttpGet("https://raw.githubusercontent.com/ranggabujet121-prog/R4NGHUBV1.1/refs/heads/main/Multi-fling.lua"))() 

  	end    
})

MainTab:AddButton({
	Name = "Fly Gui v3",
	Callback = function()
      		loadstring(game:HttpGet("https://raw.githubusercontent.com/XNEOFF/FlyGuiV3/main/FlyGuiV3.txt"))()
  	end    
})

local HomeTab = Window:MakeTab({
	Name = "Info",
	Icon = "rbxassetid://11656483343",
	PremiumOnly = false
})

local AdminInfo = HomeTab:AddSection({
	Name = "Admin Info"
})

AdminInfo:AddLabel("Coded by: Rangapu bjirr")
AdminInfo:AddLabel("Versi: v1.0.0")

AdminInfo:AddTextbox({
	Name = "Tiktok",
	Default = "https://www.tiktok.com/@ranggaputra262?_r=1&_t=ZS-93fLDyetubs",
	TextDisappear = false,
	Callback = function() end

OrionLib:MakeNotification({
	Name = "R4NG HUB LOADED",
	Content = "Semua scdiot berhasil dimuat!",
	Image = "rbxassetid://94300218950105",
	Time = 5
})


OrionLib:Init()
