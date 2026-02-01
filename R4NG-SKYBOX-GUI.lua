-- R4NG SKYBOX GUI (murni Lua Roblox, no external lib)
-- Execute di executor untuk munculkan GUI

local Players = game:GetService("Players")
local Lighting = game:GetService("Lighting")
local SoundService = game:GetService("SoundService")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

-- Cek kalau GUI sudah ada → hapus dulu biar ga dobel
if PlayerGui:FindFirstChild("R4NG_SKYBOX_GUI") then
    PlayerGui.R4NG_SKYBOX_GUI:Destroy()
end

-- Buat ScreenGui
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "R4NG_SKYBOX_GUI"
ScreenGui.Parent = PlayerGui
ScreenGui.ResetOnSpawn = false

-- Frame utama (draggable)
local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(0, 280, 0, 180)
Frame.Position = UDim2.new(0.5, -140, 0.5, -90)
Frame.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
Frame.BorderSizePixel = 0
Frame.Parent = ScreenGui

-- Title bar (biar bisa digeser)
local TitleBar = Instance.new("TextLabel")
TitleBar.Size = UDim2.new(1, 0, 0, 30)
TitleBar.BackgroundColor3 = Color3.fromRGB(40, 0, 80)
TitleBar.Text = "R4NG SKYBOX GUI"
TitleBar.TextColor3 = Color3.new(1,1,1)
TitleBar.Font = Enum.Font.SourceSansBold
TitleBar.TextSize = 20
TitleBar.Parent = Frame

-- Tombol close
local CloseButton = Instance.new("TextButton")
CloseButton.Size = UDim2.new(0, 30, 0, 30)
CloseButton.Position = UDim2.new(1, -30, 0, 0)
CloseButton.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
CloseButton.Text = "X"
CloseButton.TextColor3 = Color3.new(1,1,1)
CloseButton.Font = Enum.Font.SourceSansBold
CloseButton.TextSize = 20
CloseButton.Parent = Frame

CloseButton.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

-- Toggle button
local ToggleButton = Instance.new("TextButton")
ToggleButton.Size = UDim2.new(0.9, 0, 0, 50)
ToggleButton.Position = UDim2.new(0.05, 0, 0.3, 0)
ToggleButton.BackgroundColor3 = Color3.fromRGB(60, 0, 120)
ToggleButton.Text = "Aktifkan Horror Mode"
ToggleButton.TextColor3 = Color3.new(1,1,1)
ToggleButton.Font = Enum.Font.SourceSans
ToggleButton.TextSize = 18
ToggleButton.Parent = Frame

local horrorActive = false
local horrorSound = nil

local function ActivateHorror()
    if horrorActive then return end
    horrorActive = true

    Lighting.Brightness = 0.25
    Lighting.GlobalShadows = true
    Lighting.Ambient = Color3.fromRGB(8, 4, 12)
    Lighting.OutdoorAmbient = Color3.fromRGB(3, 0, 8)
    Lighting.ClockTime = 0
    Lighting.FogEnd = 120
    Lighting.FogColor = Color3.fromRGB(12, 4, 20)

    local sky = Instance.new("Sky")
    sky.Name = "R4NG_HorrorSky"
    sky.Parent = Lighting

    sky.SkyboxBk = "rbxassetid://6071579801"
    sky.SkyboxDn = "rbxassetid://6071579961"
    sky.SkyboxFt = "rbxassetid://6071579925"
    sky.SkyboxLf = "rbxassetid://6071579897"
    sky.SkyboxRt = "rbxassetid://6071579946"
    sky.SkyboxUp = "rbxassetid://6071579831"
    sky.StarCount = 0
    sky.CelestialBodiesShown = false

    horrorSound = Instance.new("Sound")
    horrorSound.Name = "R4NG_HorrorSound"
    horrorSound.SoundId = "rbxassetid://1839246711"
    horrorSound.Volume = 0.35
    horrorSound.Looped = true
    horrorSound.Parent = SoundService
    horrorSound:Play()

    ToggleButton.Text = "Matikan Horror Mode"
    ToggleButton.BackgroundColor3 = Color3.fromRGB(120, 0, 60)
end

local function DeactivateHorror()
    if not horrorActive then return end
    horrorActive = false

    if Lighting:FindFirstChild("R4NG_HorrorSky") then
        Lighting.R4NG_HorrorSky:Destroy()
    end

    if horrorSound then
        horrorSound:Stop()
        horrorSound:Destroy()
        horrorSound = nil
    end

    Lighting.Brightness = 2
    Lighting.Ambient = Color3.fromRGB(128, 128, 128)
    Lighting.OutdoorAmbient = Color3.fromRGB(128, 128, 128)
    Lighting.ClockTime = 14
    Lighting.FogEnd = 100000
    Lighting.FogColor = Color3.fromRGB(192, 192, 192)

    ToggleButton.Text = "Aktifkan Horror Mode"
    ToggleButton.BackgroundColor3 = Color3.fromRGB(60, 0, 120)
end

ToggleButton.MouseButton1Click:Connect(function()
    if horrorActive then
        DeactivateHorror()
    else
        ActivateHorror()
    end
end)

-- Drag GUI (title bar bisa digeser)
local dragging, dragInput, dragStart, startPos

TitleBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = Frame.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

TitleBar.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

game:GetService("UserInputService").InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        local delta = input.Position - dragStart
        Frame.Position = UDim2.new(
            startPos.X.Scale,
            startPos.X.Offset + delta.X,
            startPos.Y.Scale,
            startPos.Y.Offset + delta.Y
        )
    end
end)

print("R4NG SKYBOX GUI muncul! Toggle tombol untuk aktifkan/matiin mode horror.")
