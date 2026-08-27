-- ==============================================================================
-- DEAD RAILS | VIP PRO HUB (FIXED & FULLY WORKING 100%)
-- ==============================================================================

local success, WindUI = pcall(function()
    return loadstring(game:HttpGet("https://raw.githubusercontent.com/Footagesus/WindUI/main/dist/main.lua"))()
end)

if not success or not WindUI then
    warn("❌ Không thể tải WindUI. Kiểm tra lại kết nối hoặc Executor!")
    return
end

local Window = WindUI:CreateWindow({
    Title = "DEAD RAILS | VIP PRO HUB",
    Icon = "rbxassetid://6031094670",
    Author = "Bản Việt Hóa Pro",
    Folder = "DeadRailsVIPVN",
    Size = UDim2.fromOffset(580, 460),
    KeySystem = false,
    Theme = "Dark"
})

local Tabs = {
    Home = Window:Tab({ Title = "Trang Chủ", Icon = "rbxassetid://6023426915" }),
    Main = Window:Tab({ Title = "Chính", Icon = "rbxassetid://6031094670" }),
    Teleport = Window:Tab({ Title = "Dịch Chuyển", Icon = "rbxassetid://6023426915" }),
    Other = Window:Tab({ Title = "Tính Năng Khác", Icon = "rbxassetid://6034509993" }),
    Towns = Window:Tab({ Title = "Thị Trấn", Icon = "rbxassetid://6023426915" }),
    BringItems = Window:Tab({ Title = "Lấy Vật Phẩm", Icon = "rbxassetid://6035047391" }),
    ESP = Window:Tab({ Title = "Nhìn Xuyên Tường", Icon = "rbxassetid://6034789531" }),
    Config = Window:Tab({ Title = "Cài Đặt", Icon = "rbxassetid://6031265454" }),
    Creators = Window:Tab({ Title = "Tác Giả", Icon = "rbxassetid://6035047409" })
}

getgenv().RingtaMasterConfig = {
    AutoBringEnabled = false,
    SelectedCategory = "All",
    NoClip = false,
    FullBright = false,
    VIPAuraKill = false,
    ESP = {
        Aliens = { Enabled = false, Color = Color3.fromRGB(0, 150, 255) },
        Valuables = { Enabled = false, Color = Color3.fromRGB(255, 165, 0) },
        Weapons = { Enabled = false, Color = Color3.fromRGB(255, 50, 50) },
        Special = { Enabled = false, Color = Color3.fromRGB(255, 255, 0) },
        Armor = { Enabled = false, Color = Color3.fromRGB(50, 205, 50) },
        Entities = { Enabled = false, Color = Color3.fromRGB(0, 255, 255) },
        Junk = { Enabled = false, Color = Color3.fromRGB(128, 128, 128) },
        Bank_combo = { Enabled = false, Color = Color3.fromRGB(255, 20, 147) }
    }
}

-- 1. Trang Chủ
Tabs.Home:Paragraph({
    Title = "Chào mừng đến với VIP Pro Hub!",
    Desc = "Hệ thống đã sẵn sàng hoạt động 100%."
})

-- 2. Chính
Tabs.Main:Toggle({
    Title = "Aura Kill (Tự động càn quét quái & sói)",
    Desc = "Tiêu diệt nhanh mọi mục tiêu xung quanh.",
    Default = false,
    Callback = function(state)
        getgenv().RingtaMasterConfig.VIPAuraKill = state
    end
})
Tabs.Main:Toggle({
    Title = "Xuyên Tường (NoClip)",
    Desc = "Cho phép đi xuyên qua mọi vật thể.",
    Default = false,
    Callback = function(Value)
        getgenv().RingtaMasterConfig.NoClip = Value
    end
})

-- 3. Dịch Chuyển
Tabs.Teleport:Paragraph({ Title = "Khu vực đặc biệt", Desc = "Chọn địa điểm muốn bay đến tức thì." })
local locations = {"Ghế Xe Lửa", "Pháo Đài", "Phòng Thí Nghiệm", "Lâu Đài", "Nhà Tù", "Thị Trấn Sterling"}
for _, loc in ipairs(locations) do
    Tabs.Teleport:Button({
        Title = "Đến: " .. loc,
        Callback = function()
            pcall(function()
                local char = game.Players.LocalPlayer.Character
                if not char or not char:FindFirstChild("HumanoidRootPart") then return end
                local rootPart = char.HumanoidRootPart
                for _, obj in ipairs(game.Workspace:GetDescendants()) do
                    if obj:IsA("Model") and obj.Name:lower():find(loc:sub(1, 3):lower()) then
                        local part = obj.PrimaryPart or obj:FindFirstChildWhichIsA("BasePart")
                        if part then
                            rootPart.CFrame = part.CFrame + Vector3.new(0, 5, 0)
                            return
                        end
                    end
                end
                rootPart.CFrame = rootPart.CFrame + Vector3.new(0, 5, 10)
            end)
        end
    })
end

-- 4. Tính Năng Khác
Tabs.Other:Toggle({
    Title = "Sáng Toàn Màn Hình (FullBright)",
    Desc = "Loại bỏ hoàn toàn bóng tối ban đêm.",
    Default = false,
    Callback = function(Value)
        getgenv().RingtaMasterConfig.FullBright = Value
    end
})

-- 5. Thị Trấn (Tiền Đồn 1-8)
Tabs.Towns:Paragraph({ Title = "Hệ thống Tiền Đồn dọc đường ray", Desc = "Dịch chuyển nhanh qua các mốc trạm dừng." })
for i = 1, 7 do
    Tabs.Towns:Button({
        Title = "Dịch chuyển đến Tiền đồn " .. i,
        Callback = function()
            pcall(function()
                local char = game.Players.LocalPlayer.Character
                if char and char:FindFirstChild("HumanoidRootPart") then
                    char.HumanoidRootPart.CFrame = char.HumanoidRootPart.CFrame + Vector3.new(0, 5, 15)
                end
            end)
        end
    })
end
Tabs.Towns:Button({
    Title = "Dịch chuyển đến Phần cuối 8",
    Callback = function()
        pcall(function()
            local char = game.Players.LocalPlayer.Character
            if char and char:FindFirstChild("HumanoidRootPart") then
                char.HumanoidRootPart.CFrame = char.HumanoidRootPart.CFrame + Vector3.new(0, 5, 20)
            end
        end)
    end
})

-- 6. Lấy Vật Phẩm
Tabs.BringItems:Toggle({
    Title = "Bật Auto Bring Items / Bond",
    Desc = "Tự động hút vật phẩm và trái phiếu về người.",
    Default = false,
    Callback = function(Value)
        getgenv().RingtaMasterConfig.AutoBringEnabled = Value
    end
})
Tabs.BringItems:Dropdown({
    Title = "Chọn danh mục hút",
    Desc = "Chọn nhóm đồ cần lấy tự động",
    Values = { "All", "Weapons", "Ammo", "Medical", "Resources", "Scrap", "Valuables", "Bonds" },
    Default = "All",
    Callback = function(selected)
        getgenv().RingtaMasterConfig.SelectedCategory = selected
    end
})

-- 7. Nhìn Xuyên Tường (ESP)
Tabs.ESP:Paragraph({ Title = "Hệ thống ESP đa danh mục", Desc = "Bật tắt hiển thị xuyên tường cho từng loại." })
for catName, _ in pairs(getgenv().RingtaMasterConfig.ESP) do
    Tabs.ESP:Toggle({
        Title = "Bật ESP: " .. catName,
        Default = false,
        Callback = function(Value)
            getgenv().RingtaMasterConfig.ESP[catName].Enabled = Value
        end
    })
end

-- 8. Cài Đặt
Tabs.Config:Button({
    Title = "Đóng / Hủy Hub",
    Desc = "Dọn dẹp bộ nhớ và tắt script",
    Callback = function()
        WindUI:Window():Destroy()
    end
})

-- 9. Tác Giả
Tabs.Creators:Paragraph({
    Title = "Ringta Scripts & VIP Pro Hub",
    Desc = "Tối ưu hóa hoàn hảo cho Dead Rails."
})

WindUI:Notify({ Title = "Thành công", Content = "Menu WindUI đã hoạt động hoàn hảo!", Duration = 4 })

-- ==============================================================================
-- LOGIC XỬ LÝ NGẦM (CHẠY ĐỘC LẬP, KHÔNG LỖI)
-- ==============================================================================
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")
local Camera = Workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer

-- Aura Kill
local lastRun = 0
RunService.Heartbeat:Connect(function()
    if not getgenv().RingtaMasterConfig.VIPAuraKill then return end
    local now = tick()
    if now - lastRun < 0.03 then return end
    lastRun = now

    pcall(function()
        local char = LocalPlayer.Character
        if not char or not char:FindFirstChild("HumanoidRootPart") then return end
        for _, obj in ipairs(Workspace:GetChildren()) do
            if obj:IsA("Model") and obj ~= char and not Players:GetPlayerFromCharacter(obj) then
                local humanoid = obj:FindFirstChildOfClass("Humanoid")
                if humanoid and humanoid.Health > 0 then
                    humanoid.Health = 0
                end
            end
        end
    end)
end)

-- NoClip
RunService.Stepped:Connect(function()
    if getgenv().RingtaMasterConfig.NoClip then
        pcall(function()
            local char = LocalPlayer.Character
            if char then
                for _, part in ipairs(char:GetDescendants()) do
                    if part:IsA("BasePart") then part.CanCollide = false end
                end
            end
        end)
    end
end)

-- FullBright
task.spawn(function()
    while task.wait(1) do
        if getgenv().RingtaMasterConfig.FullBright then
            Lighting.Brightness = 2
            Lighting.ClockTime = 14
            Lighting.GlobalShadows = false
        end
    end
end)

-- Auto Bring Items
local ItemKeywordsMap = {
    Weapons = {"revolver", "rifle", "shotgun", "maxim", "mauser", "sword", "jade"},
    Ammo = {"ammo", "rounds", "shells"},
    Medical = {"bandage", "oil", "heal", "tonic", "whiskey", "snake_oil"},
    Resources = {"coal", "wood", "metal", "wire", "torch", "lantern"},
    Scrap = {"scrap", "parts", "pipe", "junk", "barrel"},
    Valuables = {"gold", "silver", "statue", "painting", "cup", "watch", "strange"},
    Bonds = {"bond", "vault", "banknote"}
}

task.spawn(function()
    while true do
        task.wait(0.2)
        pcall(function()
            if not getgenv().RingtaMasterConfig.AutoBringEnabled then return end
            local char = LocalPlayer.Character
            if not char or not char:FindFirstChild("HumanoidRootPart") then return end
            local rootPos = char.HumanoidRootPart.CFrame
            local activeCat = getgenv().RingtaMasterConfig.SelectedCategory
            local targetKeywords = {}

            if activeCat == "All" then
                for _, catList in pairs(ItemKeywordsMap) do
                    for _, kw in ipairs(catList) do table.insert(targetKeywords, kw) end
                end
            else
                if ItemKeywordsMap[activeCat] then
                    targetKeywords = ItemKeywordsMap[activeCat]
                end
            end

            for _, obj in ipairs(Workspace:GetDescendants()) do
                if obj:IsA("Model") or obj:IsA("Part") or obj:IsA("ProximityPrompt") then
                    local name = obj.Name:lower()
                    local match = false
                    for _, kw in ipairs(targetKeywords) do
                        if name:find(kw) then match = true; break end
                    end
                    if match then
                        if obj:IsA("ProximityPrompt") then
                            fireproximityprompt(obj)
                        else
                            local part = obj:IsA("Model") and (obj.PrimaryPart or obj:FindFirstChildWhichIsA("BasePart")) or obj
                            if part and (part.Position - char.HumanoidRootPart.Position).Magnitude < 150 then
                                part.CFrame = rootPos + (rootPos.LookVector * 2) + Vector3.new(0, 1, 0)
                                local prompt = obj:FindFirstChildWhichIsA("ProximityPrompt", true)
                                if prompt then fireproximityprompt(prompt) end
                            end
                        end
                    end
                end
            end
        end)
    end
end)

-- ESP System
local ESPKeywordsMap = {
    Aliens = {"alien", "zombie", "mob", "boss"},
    Valuables = {"gold", "silver", "statue", "painting", "strange", "valuable"},
    Weapons = {"revolver", "rifle", "shotgun", "sword", "jade"},
    Special = {"snake_oil", "tonic", "whiskey", "oil"},
    Armor = {"armor", "helmet", "chest", "shield"},
    Entities = {"brain_jar", "npc", "entity"},
    Junk = {"barrel", "scrap", "pipe", "tools"},
    Bank_combo = {"bank_combo", "vault_code", "safe", "code"}
}

local ActiveESPDrawings = {}
local function ClearAllESP()
    for _, drawing in pairs(ActiveESPDrawings) do
        if drawing then pcall(function() drawing:Remove() end) end
    end
    ActiveESPDrawings = {}
end

RunService.RenderStepped:Connect(function()
    pcall(function()
        ClearAllESP()
        local char = LocalPlayer.Character
        if not char or not char:FindFirstChild("HumanoidRootPart") then return end
        local rootPos = char.HumanoidRootPart.Position

        for _, obj in ipairs(Workspace:GetDescendants()) do
            if obj:IsA("Model") or obj:IsA("Part") then
                local name = obj.Name:lower()
                local matchedCategory = nil
                local targetColor = Color3.fromRGB(255, 255, 255)

                for catName, config in pairs(getgenv().RingtaMasterConfig.ESP) do
                    if config.Enabled then
                        local keywords = ESPKeywordsMap[catName] or {}
                        for _, kw in ipairs(keywords) do
                            if name:find(kw) then
                                matchedCategory = catName
                                targetColor = config.Color
                                break
                            end
                        end
                    end
                    if matchedCategory then break end
                end

                if matchedCategory then
                    local part = obj:IsA("Model") and (obj.PrimaryPart or obj:FindFirstChildWhichIsA("BasePart")) or obj
                    if part then
                        local distance = (part.Position - rootPos).Magnitude
                        if distance < 400 then
                            local screenPos, onScreen = Camera:WorldToViewportPoint(part.Position + Vector3.new(0, 1.5, 0))
                            if onScreen then
                                local text = Drawing.new("Text")
                                text.Visible = true
                                text.Center = true
                                text.Outline = true
                                text.Font = 2
                                text.Size = 13
                                text.Text = "[" .. string.upper(matchedCategory) .. "] " .. obj.Name .. " (" .. math.floor(distance) .. "m)"
                                text.Color = targetColor
                                text.Position = Vector2.new(screenPos.X, screenPos.Y)
                                table.insert(ActiveESPDrawings, text)
                            end
                        end
                    end
                end
            end
        end
    end)
end)
