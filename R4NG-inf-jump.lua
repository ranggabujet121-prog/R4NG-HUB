-- R4NG INFINITE JUMP (huruf biasa semua, client-side, universal)
-- Execute di executor untuk aktifkan

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

-- Hapus GUI lama kalau ada
if PlayerGui:FindFirstChild("R4NG_INFINITE_JUMP") then
    PlayerGui.R4NG_INFINITE_JUMP:Destroy()
end

-- ScreenGui sederhana
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "R4NG_INFINITE_JUMP"
ScreenGui.Parent = PlayerGui
ScreenGui.ResetOnSpawn = false

-- Frame status (tampilan minimalis)
local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(0, 220, 0, 80)
Frame.Position = UDim2.new(0.5, -110, 0.1, 0)
Frame.BackgroundColor3 = Color3.fromRGB(20, 20, 40)
Frame.BackgroundTransparency = 0.4
Frame.BorderSizePixel = 0
Frame.Parent = ScreenGui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 10)
UICorner.Parent = Frame

-- Status teks
local Status = Instance.new("TextLabel")
Status.Size = UDim2.new(1, 0, 1, 0)
Status.BackgroundTransparency = 1
Status.Text = "Infinite Jump: OFF"
Status.TextColor3 = Color3.fromRGB(255, 100, 100)
Status.Font = Enum.Font.GothamSemibold
Status.TextSize = 20
Status.TextWrapped = true
Status.Parent = Frame

-- Variabel
local InfiniteJumpEnabled = false
local jumpConnection = nil

local function StartInfiniteJump()
    if jumpConnection then jumpConnection:Disconnect() end

    jumpConnection = UserInputService.JumpRequest:Connect(function()
        if not InfiniteJumpEnabled then return end

        local character = LocalPlayer.Character
        if not character then return end

        local humanoid = character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
        end
    end)

    Status.Text = "Infinite Jump: ON"
    Status.TextColor3 = Color3.fromRGB(0, 255, 100)
end

local function StopInfiniteJump()
    if jumpConnection then jumpConnection:Disconnect() end
    jumpConnection = nil

    Status.Text = "Infinite Jump: OFF"
    Status.TextColor3 = Color3.fromRGB(255, 100, 100)
end

-- Toggle dengan tombol (misal tekan J untuk on/off, bisa diganti)
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == Enum.KeyCode.J then
        InfiniteJumpEnabled = not InfiniteJumpEnabled

        if InfiniteJumpEnabled then
            StartInfiniteJump()
        else
            StopInfiniteJump()
        end
    end
end)

-- Tombol toggle di layar (opsional, kalau mau klik manual)
local ToggleButton = Instance.new("TextButton")
ToggleButton.Size = UDim2.new(0, 180, 0, 50)
ToggleButton.Position = UDim2.new(0.5, -90, 0.2, 0)
ToggleButton.BackgroundColor3 = Color3.fromRGB(0, 120, 180)
ToggleButton.Text = "Toggle Infinite Jump (J)"
ToggleButton.TextColor3 = Color3.new(1,1,1)
ToggleButton.Font = Enum.Font.GothamSemibold
ToggleButton.TextSize = 18
ToggleButton.Parent = Frame

local ToggleCorner = Instance.new("UICorner")
ToggleCorner.CornerRadius = UDim.new(0, 10)
ToggleCorner.Parent = ToggleButton

ToggleButton.MouseButton1Click:Connect(function()
    InfiniteJumpEnabled = not InfiniteJumpEnabled

    if InfiniteJumpEnabled then
        StartInfiniteJump()
    else
        StopInfiniteJump()
    end
end)

print("R4NG INFINITE JUMP loaded! Tekan J atau tombol untuk toggle.")
