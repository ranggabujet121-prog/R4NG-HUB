-- R4NG AIMBOT UNIVERSAL (murni Roblox UI, no external lib)
-- Execute di executor untuk munculkan GUI

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")
local Camera = Workspace.CurrentCamera
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

-- Hapus GUI lama kalau ada
if PlayerGui:FindFirstChild("R4NG_AIMBOT") then
    PlayerGui.R4NG_AIMBOT:Destroy()
end

-- ScreenGui
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "R4NG_AIMBOT"
ScreenGui.Parent = PlayerGui
ScreenGui.ResetOnSpawn = false

-- Frame utama (tampilan premium, semi-transparan)
local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(0, 340, 0, 280)
Frame.Position = UDim2.new(0.5, -170, 0.5, -140)
Frame.BackgroundColor3 = Color3.fromRGB(10, 10, 20)
Frame.BackgroundTransparency = 0.15
Frame.BorderSizePixel = 0
Frame.Parent = ScreenGui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 16)
UICorner.Parent = Frame

local UIStroke = Instance.new("UIStroke")
UIStroke.Color = Color3.fromRGB(120, 0, 255)
UIStroke.Thickness = 2.5
UIStroke.Transparency = 0.3
UIStroke.Parent = Frame

-- Title
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 45)
Title.BackgroundColor3 = Color3.fromRGB(30, 0, 80)
Title.BackgroundTransparency = 0.4
Title.Text = "R4NG AIMBOT UNIVERSAL"
Title.TextColor3 = Color3.new(1, 1, 1)
Title.Font = Enum.Font.GothamBlack
Title.TextSize = 26
Title.Parent = Frame

-- Close button
local Close = Instance.new("TextButton")
Close.Size = UDim2.new(0, 45, 0, 45)
Close.Position = UDim2.new(1, -45, 0, 0)
Close.BackgroundColor3 = Color3.fromRGB(180, 0, 0)
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
Toggle.Size = UDim2.new(0.88, 0, 0, 55)
Toggle.Position = UDim2.new(0.06, 0, 0.18, 0)
Toggle.BackgroundColor3 = Color3.fromRGB(50, 0, 120)
Toggle.Text = "AIMBOT OFF"
Toggle.TextColor3 = Color3.new(1,1,1)
Toggle.Font = Enum.Font.GothamSemibold
Toggle.TextSize = 20
Toggle.Parent = Frame

local ToggleCorner = Instance.new("UICorner")
ToggleCorner.CornerRadius = UDim.new(0, 12)
ToggleCorner.Parent = Toggle

-- Variabel
local Enabled = false
local Smooth = 0.22
local MaxDist = 450
local Target = nil

local function GetClosest()
    local closest = nil
    local shortest = MaxDist

    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and p.Character then
            local h = p.Character:FindFirstChild("Humanoid")
            local r = p.Character:FindFirstChild("HumanoidRootPart")
            if h and h.Health > 0 and r then
                local d = (r.Position - Camera.CFrame.Position).Magnitude
                if d < shortest then
                    shortest = d
                    closest = r
                end
            end
        end
    end

    return closest
end

-- Loop aimbot
local conn
local function StartLoop()
    if conn then conn:Disconnect() end

    conn = RunService.RenderStepped:Connect(function()
        if not Enabled then return end

        Target = GetClosest()

        if Target then
            local headPos = Target.Position + Vector3.new(0, 2, 0)
            local dir = (headPos - Camera.CFrame.Position).Unit
            local targetCF = CFrame.new(Camera.CFrame.Position, Camera.CFrame.Position + dir)
            Camera.CFrame = Camera.CFrame:Lerp(targetCF, Smooth)
        end
    end)
end

Toggle.MouseButton1Click:Connect(function()
    Enabled = not Enabled

    if Enabled then
        Toggle.Text = "AIMBOT ON"
        Toggle.BackgroundColor3 = Color3.fromRGB(0, 170, 70)
        StartLoop()
    else
        Toggle.Text = "AIMBOT OFF"
        Toggle.BackgroundColor3 = Color3.fromRGB(50, 0, 120)
        if conn then conn:Disconnect() end
        Target = nil
    end
end)

-- Smoothness slider
local SmoothText = Instance.new("TextLabel")
SmoothText.Size = UDim2.new(0.88, 0, 0, 25)
SmoothText.Position = UDim2.new(0.06, 0, 0.45, 0)
SmoothText.BackgroundTransparency = 1
SmoothText.Text = "Smoothness: 0.22"
SmoothText.TextColor3 = Color3.new(1,1,1)
SmoothText.Font = Enum.Font.Gotham
SmoothText.TextSize = 16
SmoothText.Parent = Frame

local SmoothBar = Instance.new("Frame")
SmoothBar.Size = UDim2.new(0.88, 0, 0, 12)
SmoothBar.Position = UDim2.new(0.06, 0, 0.52, 0)
SmoothBar.BackgroundColor3 = Color3.fromRGB(70, 70, 90)
SmoothBar.Parent = Frame

local SmoothFill = Instance.new("Frame")
SmoothFill.Size = UDim2.new(0.3, 0, 1, 0)
SmoothFill.BackgroundColor3 = Color3.fromRGB(0, 220, 100)
SmoothFill.Parent = SmoothBar

local SmoothCorner = Instance.new("UICorner")
SmoothCorner.CornerRadius = UDim.new(0, 6)
SmoothCorner.Parent = SmoothBar

local draggingS = false
SmoothBar.InputBegan:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
        draggingS = true
    end
end)

UserInputService.InputEnded:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
        draggingS = false
    end
end)

UserInputService.InputChanged:Connect(function(i)
    if draggingS and (i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch) then
        local rel = math.clamp((i.Position.X - SmoothBar.AbsolutePosition.X) / SmoothBar.AbsoluteSize.X, 0, 1)
        Smooth = 0.05 + rel * 0.75
        SmoothFill.Size = UDim2.new(rel, 0, 1, 0)
        SmoothText.Text = "Smoothness: " .. string.format("%.2f", Smooth)
    end
end)

-- Max Distance slider (mirip)
local DistText = Instance.new("TextLabel")
DistText.Size = UDim2.new(0.88, 0, 0, 25)
DistText.Position = UDim2.new(0.06, 0, 0.62, 0)
DistText.BackgroundTransparency = 1
DistText.Text = "Max Distance: 450 studs"
DistText.TextColor3 = Color3.new(1,1,1)
DistText.Font = Enum.Font.Gotham
DistText.TextSize = 16
DistText.Parent = Frame

local DistBar = Instance.new("Frame")
DistBar.Size = UDim2.new(0.88, 0, 0, 12)
DistBar.Position = UDim2.new(0.06, 0, 0.69, 0)
DistBar.BackgroundColor3 = Color3.fromRGB(70, 70, 90)
DistBar.Parent = Frame

local DistFill = Instance.new("Frame")
DistFill.Size = UDim2.new(0.45, 0, 1, 0)
DistFill.BackgroundColor3 = Color3.fromRGB(100, 220, 0)
DistFill.Parent = DistBar

local DistCorner = Instance.new("UICorner")
DistCorner.CornerRadius = UDim.new(0, 6)
DistCorner.Parent = DistBar

local draggingD = false
DistBar.InputBegan:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
        draggingD = true
    end
end)

UserInputService.InputEnded:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
        draggingD = false
    end
end)

UserInputService.InputChanged:Connect(function(i)
    if draggingD and (i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch) then
        local rel = math.clamp((i.Position.X - DistBar.AbsolutePosition.X) / DistBar.AbsoluteSize.X, 0, 1)
        MaxDist = 100 + rel * 900
        DistFill.Size = UDim2.new(rel, 0, 1, 0)
        DistText.Text = "Max Distance: " .. math.floor(MaxDist) .. " studs"
    end
end)

-- Lock indicator (lingkaran kecil tengah layar)
local Indicator = Instance.new("Frame")
Indicator.Size = UDim2.new(0, 24, 0, 24)
Indicator.Position = UDim2.new(0.5, -12, 0.5, -12)
Indicator.BackgroundTransparency = 1
Indicator.Parent = ScreenGui

local Circle = Instance.new("Frame")
Circle.Size = UDim2.new(1, 0, 1, 0)
Circle.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
Circle.BackgroundTransparency = 0.5
Circle.Parent = Indicator

local CircleCorner = Instance.new("UICorner")
CircleCorner.CornerRadius = UDim.new(1, 0)
CircleCorner.Parent = Circle

RunService.RenderStepped:Connect(function()
    Indicator.Visible = Enabled and Target ~= nil
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

print("R4NG AIMBOT UNIVERSAL loaded! Drag title bar untuk geser GUI.")
