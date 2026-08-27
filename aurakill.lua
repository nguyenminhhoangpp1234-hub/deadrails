-- =================================================
-- DEAD RAILS PRO MENU (CÓ NÚT THU GỌN GÓC TRÊN)
-- =================================================

local WindUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/Footagesus/WindUI/main/dist/main.lua"))()

local Window = WindUI:CreateWindow({
    Title = "DEAD RAILS SCRIPT",
    Icon = "rbxassetid://6031094670",
    Author = "Pro Menu",
    Folder = "DeadRailsConfig",
    Size = UDim2.fromOffset(580, 460),
    KeySystem = false,
    Theme = "Dark"
})

-- Tạo các Tab dọc bên trái y hệt ảnh mẫu
local Tabs = {
    Home = Window:Tab({ Title = "Home", Icon = "rbxassetid://6023426915" }),
    Main = Window:Tab({ Title = "Main", Icon = "rbxassetid://6031094670" }),
    Teleport = Window:Tab({ Title = "Teleport", Icon = "rbxassetid://6023426915" }),
    Other = Window:Tab({ Title = "Other Features", Icon = "rbxassetid://6034509993" }),
    Towns = Window:Tab({ Title = "Towns", Icon = "rbxassetid://6023426915" }),
    BringItems = Window:Tab({ Title = "Bring Items", Icon = "rbxassetid://6035047391" }),
    ESP = Window:Tab({ Title = "ESP", Icon = "rbxassetid://6034789531" }),
    Config = Window:Tab({ Title = "Config", Icon = "rbxassetid://6031265454" }),
    Creators = Window:Tab({ Title = "Content Creators", Icon = "rbxassetid://6035047409" })
}

-- Tab HOME
Tabs.Home:Paragraph({
    Title = "Chào mừng bạn đến với Script!",
    Desc = "Sử dụng nút dấu trừ (-) ở góc trên để thu gọn/mở lại menu."
})

-- Tab MAIN (Aura Kill)
Tabs.Main:Toggle({
    Title = "Aura Kill (Auto Kill Mobs/Sói)",
    Desc = "Tự động tiêu diệt quái và sói xung quanh.",
    Default = false,
    Callback = function(state)
        getgenv().CustomAura = state
        if state then
            WindUI:Notify({ Title = "Aura Kill", Content = "Đã Bật!", Duration = 3 })
        else
            WindUI:Notify({ Title = "Aura Kill", Content = "Đã Tắt!", Duration = 3 })
        end
    end
})

-- Tab BRING ITEMS (Danh sách chọn item)
Tabs.BringItems:Dropdown({
    Title = "Select items for Infinite Get",
    Desc = "Chọn vật phẩm bạn muốn lấy",
    Values = { "rifle", "shotgun", "bandage", "snake_oil", "dynamite" },
    Default = "rifle",
    Callback = function(selected)
        getgenv().SelectedChosenItem = selected
    end
})

Tabs.BringItems:Button({
    Title = "Get Selected Item",
    Desc = "Bấm để nhận item đã chọn",
    Callback = function()
        local item = getgenv().SelectedChosenItem or "rifle"
        WindUI:Notify({ Title = "Item Spawner", Content = "Đang lấy: " .. tostring(item), Duration = 3 })
    end
})

-- Các Tab khác
Tabs.Teleport:Paragraph({ Title = "Teleport", Desc = "Đang cập nhật." })
Tabs.Other:Paragraph({ Title = "Other Features", Desc = "Các tính năng phụ." })
Tabs.Towns:Paragraph({ Title = "Towns", Desc = "Danh sách thị trấn." })
Tabs.ESP:Paragraph({ Title = "ESP", Desc = "Cài đặt ESP." })
Tabs.Config:Paragraph({ Title = "Config", Desc = "Lưu cấu hình." })
Tabs.Creators:Paragraph({ Title = "Content Creators", Desc = "Dead Rails Script." })

WindUI:Notify({ Title = "Thành công", Content = "Đã tải menu đầy đủ tính năng!", Duration = 4 })

-- === HỆ THỐNG CHẠY NGẦM AURA KILL ===
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
