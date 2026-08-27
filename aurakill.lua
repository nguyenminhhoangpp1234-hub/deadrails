-- =================================================
-- DEAD RAILS CUSTOM MENU (CLEAN VERSION)
-- =================================================

local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()
local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"))()

local Window = Fluent:CreateWindow({
    Title = "Dead Rails | Pro Script",
    SubTitle = "v1.0",
    TabWidth = 160,
    Size = UDim2.fromOffset(580, 460),
    Acrylic = true,
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.RightControl
})

-- Màu đỏ mận đặc trưng
Fluent.Themes.Dark.Accent = Color3.fromRGB(165, 30, 55)

local Tabs = {
    Home = Window:AddTab({ Title = "Home", Icon = "rbxassetid://6023426915" }),
    Main = Window:AddTab({ Title = "Main", Icon = "rbxassetid://6031094670" }),
    Teleport = Window:AddTab({ Title = "Teleport", Icon = "rbxassetid://6023426915" }),
    Other = Window:AddTab({ Title = "Other Features", Icon = "rbxassetid://6034509993" }),
    Towns = Window:AddTab({ Title = "Towns", Icon = "rbxassetid://6023426915" }),
    BringItems = Window:AddTab({ Title = "Bring Items", Icon = "rbxassetid://6035047391" }),
    ESP = Window:AddTab({ Title = "ESP", Icon = "rbxassetid://6034789531" }),
    Config = Window:AddTab({ Title = "Config", Icon = "rbxassetid://6031265454" }),
    Creators = Window:AddTab({ Title = "Content Creators", Icon = "rbxassetid://6035047409" })
}

local Options = Fluent.Options

-- --- TAB MAIN ---
local MainSection = Tabs.Main:AddSection("Automation & Combat")

MainSection:AddToggle("AuraKillToggle", {
    Title = "Aura Kill (Auto Kill Mobs/Sói)",
    Description = "Tự động tiêu diệt quái và sói xung quanh.",
    Default = false
})

Options.AuraKillToggle:OnChanged(function()
    getgenv().CustomAura = Options.AuraKillToggle.Value
    if getgenv().CustomAura then
        Fluent:Notify({ Title = "Aura Kill", Content = "Đã Bật!", Duration = 3 })
    else
        Fluent:Notify({ Title = "Aura Kill", Content = "Đã Tắt!", Duration = 3 })
    end
end)

-- --- TAB BRING ITEMS ---
local ItemSection = Tabs.BringItems:AddSection("Infinite Items / Spawner")

ItemSection:AddDropdown("ItemChoice", {
    Title = "Select items for Infinite Get",
    Values = { "rifle", "shotgun", "bandage", "snake_oil", "dynamite" },
    Multi = false,
    Default = 1,
})

ItemSection:AddButton({
    Title = "Get Selected Item",
    Description = "Nhận item đã chọn từ danh sách.",
    Callback = function()
        local selected = Options.ItemChoice.Value
        Fluent:Notify({
            Title = "Item Spawner",
            Content = "Đang lấy: " + tostring(selected),
            Duration = 3
        })
    end
})

-- --- CONFIG & SETTINGS ---
SaveManager:SetLibrary(Fluent)
InterfaceManager:SetLibrary(Fluent)
SaveManager:IgnoreThemeSettings()
SaveManager:SetFolder("DeadRailsCustom")
SaveManager:BuildInterfaceSection(Tabs.Config)
InterfaceManager:BuildInterfaceSection(Tabs.Config)

Window:SelectTab(2)
Fluent:Notify({ Title = "Script Loaded", Content = "Giao diện đã sẵn sàng!", Duration = 4 })

-- --- HỆ THỐNG CHẠY NGẦM AURA KILL ---
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

local lastTick = 0
RunService.Heartbeat:Connect(function()
    if not getgenv().CustomAura then return end
    local currentTick = tick()
    if currentTick - lastTick < 0.05 then return end
    lastTick = currentTick

    pcall(function()
        local char = LocalPlayer.Character
        if not char then return end
        for _, v in pairs(Workspace:GetDescendants()) do
            if v:IsA("Model") and v ~= char and not Players:GetPlayerFromCharacter(v) then
                local hum = v:FindFirstChildOfClass("Humanoid")
                if hum and hum.Health > 0 then
                    hum.Health = 0
                end
            end
        end
    end)
end)
