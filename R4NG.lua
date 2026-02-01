local OrionLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/jensonhirst/Orion/main/source"))()

local Window = OrionLib:MakeWindow({Name = "R4NG HUB | SCRIPT HUB", HidePremium = false, SaveConfig = true, ConfigFolder = "R4NG", 
    BackgroundColor = Color3.fromRGB(0, 0, 0)
})

local UniversalTab = Window:MakeTab({
	Name = "Universal Script",
	Icon = "rbxassetid://4915380697",
	PremiumOnly = false
})

local Players = game:GetService("Players")

local player = Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local humanoid = char:WaitForChild("Humanoid")

local Section = UniversalTab:AddSection({
	Name = "Script Universal"
})
-- FUNGSI DARI WALKSPEED
local function SetWalkSpeed(Value)
    humanoid.WalkSpeed = Value
end
-- FUNGSI DARI JUMP POWER
local function SetJumpPower(Value)
    humanoid.JumpPower = Value
end
--FUNGSI INF HEALT
local infHealth = false
local healthConn

local function SetInfiniteHealth(Value)
    infHealth = Value

    if Value then
        humanoid.Health = humanoid.MaxHealth
        healthConn = humanoid.HealthChanged:Connect(function()
            if infHealth then
                humanoid.Health = humanoid.MaxHealth
            end
        end)
    else
        if healthConn then
            healthConn:Disconnect()
            healthConn = nil
        end
    end
end

--FUNGSI DARI INVISIBLE
local function SetInvisible(Value)
    local char = player.Character
    if not char then return end

    for _, part in pairs(char:GetDescendants()) do
        if part:IsA("BasePart") then
            if Value then
                part.Transparency = 1          -- invisible
                if part:FindFirstChild("Decal") then
                    part.Decal.Transparency = 1
                end
            else
                part.Transparency = 0          -- visible
                if part:FindFirstChild("Decal") then
                    part.Decal.Transparency = 0
                end
            end
        end
    end
end
UniversalTab:AddSlider({
	Name = "Walk Speed",
	Min = 16,
	Max = 490,
	Default = 16,
	Color = Color3.fromRGB(0,170,255),
	Increment = 2,
	ValueName = "WP",
	Callback = function(Value)
		SetWalkSpeed(Value)
	end    
})

UniversalTab:AddSlider({
	Name = "Jump Power",
	Min = 50,
	Max = 500,
	Default = 50,
	Color = Color3.fromRGB(0,170,255),
	Increment = 5,
	ValueName = "JP",
	Callback = function(Value)
		SetJumpPower(Value)
	end    
})
UniversalTab:AddToggle({
	Name = "Inf Healt",
	Default = false,
	Callback = function(Value)
		SetInfiniteHealth(Value)
	end    
})

UniversalTab:AddToggle({
	Name = "Invisible",
	Default = false,
	Callback = function(Value)
		SetInvisible(Value)
	end
})

UniversalTab:AddButton({
	Name = "Fly GUI v3",
	Callback = function()
      		loadstring(game:HttpGet("https://raw.githubusercontent.com/XNEOFF/FlyGuiV3/main/FlyGuiV3.txt"))()
  	end    
})

local GameTab = Window:MakeTab({
	Name = "Game",
	Icon = "rbxassetid://6034818375",
	PremiumOnly = false
})

local Section = GameTab:AddSection({
	Name = "Script Game Pilihan (KEYLESS DAN KEY)"
})

GameTab:AddButton({
	Name = "MURDER MYSTERY 2",
	Callback = function()
      		--TARUH FUNCTION DISINI!!
      		loadstring(game:HttpGet("https://pastefy.app/S7j2Sd08/raw"))()
  	end    
})

GameTab:AddButton({
	Name = "Escape tsunami for brainrots",
	Callback = function()
      		loadstring(game:HttpGet('https://zaphub.xyz/Exec'))()
      		
  	end    
})

GameTab:AddButton({
	Name = "Brookhaven (🔑KEY)",
	Callback = function()
      		loadstring(game:HttpGet("https://pastefy.app/vpDAh99W/raw"))()
      		
  	end    
})

local AdminTab = Window:MakeTab({
    Name = "Admin Info",
    Icon = "rbxassetid://3926309567", -- ID gambar icon
    PremiumOnly = false
})

local Section = AdminTab:AddSection({
	Name = "Admin info"
})

AdminTab:AddLabel("Coded by: rangapu bjirr")
AdminTab:AddLabel("My Tiktok: @ranggaputra262")
AdminTab:AddLabel("Version: 1.0")

OrionLib:MakeNotification({
	Name = "R4NG HUB Loaded",
	Content = "Semua script berhasil di muat",
	Image = "rbxassetid://3926307978",
	Time = 6.5
})

OrionLib:Init()
