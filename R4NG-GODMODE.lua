-- R4NG GODMODE (huruf biasa semua, universal, client-side)
-- Execute di executor untuk munculkan GUI

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

-- Hapus GUI lama kalau ada
if PlayerGui:FindFirstChild("R4NG_GODMODE") then
    PlayerGui.R4NG_GODMODE:Destroy()
end

-- ScreenGui
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "R4NG_GODMODE"
ScreenGui.Parent = PlayerGui
ScreenGui.ResetOnSpawn = false

-- Frame utama
local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(0, 300, 0, 220)
Frame.Position = UDim2.new(0.5, -150, 0.5, -110)
Frame.BackgroundColor3 = Color3.fromRGB(20, 15, 35)
Frame.BackgroundTransparency = 0.15
Frame.BorderSizePixel = 0
Frame.Parent = ScreenGui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 14)
UICorner.Parent = Frame

local UIStroke = Instance.new("UIStroke")
UIStroke.Color = Color3.fromRGB(180, 0, 255)
UIStroke.Thickness = 2
UIStroke.Transparency = 0.35
UIStroke.Parent = Frame

-- Title
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 40)
Title.BackgroundColor3 = Color3.fromRGB(60, 0, 120)
Title.BackgroundTransparency = 0.4
Title.Text = "R4NG GODMODE"
Title.TextColor3 = Color3.new(1, 1, 1)
Title.Font = Enum.Font.GothamBlack
Title.TextSize = 26
Title.Parent = Frame

-- Close button
local Close = Instance.new("TextButton")
Close.Size = UDim2.new(0, 40, 0, 40)
Close.Position = UDim2.new(1, -40, 0, 0)
Close.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
Close.Text = "X"
Close.TextColor3 = Color3.new(1,1,1)
Close.Font = Enum.Font.GothamBold
Close.TextSize = 24
Close.Parent = Frame

Close.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

-- Toggle button
local Toggle = Instance.new("TextButton")
Toggle.Size = UDim2.new(0.9, 0, 0, 60)
Toggle.Position = UDim2.new(0.05, 0, 0.25, 0)
Toggle.BackgroundColor3 = Color3.fromRGB(70, 0, 160)
Toggle.Text = "GOD MODE OFF"
Toggle.TextColor3 = Color3.new(1,1,1)
Toggle.Font = Enum.Font.GothamSemibold
Toggle.TextSize = 22
Toggle.Parent = Frame

local ToggleCorner = Instance.new("UICorner")
ToggleCorner.CornerRadius = UDim.new(0, 12)
ToggleCorner.Parent = Toggle

-- Status label
local Status = Instance.new("TextLabel")
Status.Size = UDim2.new(0.9, 0, 0, 40)
Status.Position = UDim2.new(0.05, 0, 0.55, 0)
Status.BackgroundTransparency = 1
Status.Text = "Status: Mati bisa"
Status.TextColor3 = Color3.fromRGB(255, 100, 100)
Status.Font = Enum.Font.Gotham
Status.TextSize = 18
Status.Parent = Frame

-- Variabel
local GodEnabled = false

local function StartGodMode()
    local character = LocalPlayer.Character
    if not character then return end

    local humanoid = character:FindFirstChild("Humanoid")
    if not humanoid then return end

    humanoid.MaxHealth = math.huge
    humanoid.Health = math.huge

    -- Block damage sebisa mungkin (client-side)
    local healthConnection
    healthConnection = humanoid.HealthChanged:Connect(function(health)
        if health < math.huge then
            humanoid.Health = math.huge
        end
        if health <= 0 then
            humanoid.Health = math.huge
        end
    end)

    -- Reset kalau respawn
    local diedConnection
    diedConnection = humanoid.Died:Connect(function()
        wait(0.2)
        StartGodMode()
    end)

    -- Update status
    Status.Text = "Status: Tidak bisa mati"
    Status.TextColor3 = Color3.fromRGB(0, 255, 100)
end

local function StopGodMode()
    local character = LocalPlayer.Character
    if not character then return end

    local humanoid = character:FindFirstChild("Humanoid")
    if not humanoid then return end

    humanoid.MaxHealth = 100
    humanoid.Health = 100

    Status.Text = "Status: Bisa mati"
    Status.TextColor3 = Color3.fromRGB(255, 100, 100)
end

Toggle.MouseButton1Click:Connect(function()
    GodEnabled = not GodEnabled

    if GodEnabled then
        Toggle.Text = "GOD MODE ON"
        Toggle.BackgroundColor3 = Color3.fromRGB(0, 180, 80)
        StartGodMode()
    else
        Toggle.Text = "GOD MODE OFF"
        Toggle.BackgroundColor3 = Color3.fromRGB(70, 0, 160)
        StopGodMode()
    end
end)

-- Drag GUI
local dragging, dragInput, dragStart, startPos

Title.InputBegan:Connect(function(input)
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

Title.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        local delta = input.Position - dragStart
        Frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

print("R4NG GODMODE GUI loaded! Drag title untuk geser.")
