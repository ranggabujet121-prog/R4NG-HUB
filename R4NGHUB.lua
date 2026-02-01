local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "R4NG HUB | SCRIPT HUB",
   Icon = crown, -- Icon in Topbar. Can use Lucide Icons (string) or Roblox Image (number). 0 to use no icon (default).
   LoadingTitle = "R4NG HUB LOADING...",
   LoadingSubtitle = "Coded by: rangapu bjirr",
   ShowText = "R4NG HUB", -- for mobile users to unhide rayfield, change if you'd like
   Theme = "Serenity", -- Check https://docs.sirius.menu/rayfield/configuration/themes

   ToggleUIKeybind = "K", -- The keybind to toggle the UI visibility (string like "K" or Enum.KeyCode)

   DisableRayfieldPrompts = false,
   DisableBuildWarnings = false, -- Prevents Rayfield from warning when the script has a version mismatch with the interface

   ConfigurationSaving = {
      Enabled = true,
      FolderName = nil, -- Create a custom folder for your hub/game
      FileName = "Big Hub"
   },

  
  
   KeySystem = false, -- Set this to true to use our key system
   KeySettings = {
      Title = "Key sistem",
      Subtitle = "by rangapu bjirr",
      Note = "The key is asep67", -- Use this to tell the user how to get a key
      FileName = "Key", -- It is recommended to use something unique as other scripts using Rayfield may overwrite your key file
      SaveKey = true, -- The user's key will be saved, but if you change the key, they will be unable to use your script
      GrabKeyFromSite = false, -- If this is true, set Key below to the RAW site you would like Rayfield to get the key from
      Key = {"asep67"} -- List of keys that will be accepted by the system, can be RAW file links (pastebin, github etc) or simple strings ("hello","key22")
   }
})
Window:SetWindowTransparency(0.15)

local function JumpPower(value)
    Humanoid.JumpPower = value
end

local function WalkSpeed(value)
    Humanoid.WalkSpeed = value
end

local UniTab = Window:CreateTab("Universal tab", "globe")
local Section = Tab:CreateSection("scripts pilihan")

local Button = UniTab:CreateButton({
   Name = "SkyBox Changer",
   Callback = function()
       loadstring(game:HttpGet("https://raw.githubusercontent.com/ranggabujet121-prog/R4NG-HUB/refs/heads/main/R4NG-SKYBOX-GUI.lua"))()

   -- The function that takes place when the button is pressed
   end,
})
local Button = UniTab:CreateButton({
   Name = "AimBot Gui",
   Callback = function()
       loadstring(game:HttpGet("https://raw.githubusercontent.com/ranggabujet121-prog/R4NG-HUB/refs/heads/main/R4NG-AIMBOT.lua"))()

   -- The function that takes place when the button is pressed
   end,
})
local Button = UniTab:CreateButton({
   Name = "Inf Jump Gui",
   Callback = function()
       loadstring(game:HttpGet("https://raw.githubusercontent.com/ranggabujet121-prog/R4NG-HUB/refs/heads/main/R4NG-inf-jump.lua"))() 

   -- The function that takes place when the button is pressed
   end,
})
local Button = UniTab:CreateButton({
   Name = "Fly GUI v3",
   Callback = function()
       loadstring(game:HttpGet("https://raw.githubusercontent.com/XNEOFF/FlyGuiV3/main/FlyGuiV3.txt"))()
   -- The function that takes place when the button is pressed
   end,
})
local Button = UniTab:CreateButton({
   Name = "Invisible Gui",
   Callback = function()
       loadstring(game:HttpGet("https://pastebin.com/raw/zRCi5gub"))()
   -- The function that takes place when the button is pressed
   end,
})

local Slider = UniTab:CreateSlider({
   Name = "Jump Power",
   Range = {50, 670},
   Increment = 10,
   Suffix = "JP",
   CurrentValue = 50,
   Flag = "JumpPowerFlag", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
   Callback = function(Value)
       JumpPower(value)
   -- The function that takes place when the slider changes
   -- The variable (Value) is a number which correlates to the value the slider is currently at
   end,
})
local Slider = UniTab:CreateSlider({
   Name = "Walk Speed",
   Range = {16, 500},
   Increment = 1,
   Suffix = "WP",
   CurrentValue = 16,
   Flag = "WalkSpeedFlag", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
   Callback = function(Value)
       WalkSpeed(Value)
   -- The function that takes place when the slider changes
   -- The variable (Value) is a number which correlates to the value the slider is currently at
   end,
})

local GameTab = Window:CreateTab("Game Script", "gamepad-2")
local Section = GameTab:CreateSection("Script Game Khusus!")

local Button = GameTab:CreateButton({
   Name = "Escape tsunami for brainrots",
   Callback = function()
       loadstring(game:HttpGet("https://raw.githubusercontent.com/mynamewendel-ctrl/Blessed-Hub-X-/refs/heads/main/Escape%20Tsunami%20For%20Brainrots.lua"))()

   -- The function that takes place when the button is pressed
   end,
})
local Button = GameTab:CreateButton({
   Name = "Blox fruit",
   Callback = function()
       loadstring(game:HttpGet("https://raw.githubusercontent.com/alan11ago/BloxFruits/refs/heads/main/Main.lua"))()

   -- The function that takes place when the button is pressed
   end,
})
local Button = GameTab:CreateButton({
   Name = "Doors",
   Callback = function()
       loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))()

   -- The function that takes place when the button is pressed
   end,
})
local Button = GameTab:CreateButton({
   Name = "FISCH",
   Callback = function()
       loadstring(game:HttpGet("https://raw.githubusercontent.com/alan11ago/Fisch/refs/heads/main/Main.lua"))()

   -- The function that takes place when the button is pressed
   end,
})
local Button = GameTab:CreateButton({
   Name = "Murder Mystery 2 (MM2)",
   Callback = function()
       loadstring(game:HttpGet("https://raw.githubusercontent.com/RegularVynixu/Utilities/main/MM2/Script.lua"))()
   -- The function that takes place when the button is pressed
   end,
})

Rayfield:Notify({
   Title = "R4NG HUB Loaded",
   Content = "Semua script dari R4NG HUB berhasil dimuat!!",
   Duration = 6.5,
   Image = "check",
})

Rayfield:LoadConfiguration()
