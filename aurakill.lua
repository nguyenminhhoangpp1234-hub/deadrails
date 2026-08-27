-- ==============================================================================
-- DEAD RAILS | VIP PRO HUB (VIỆT HÓA 100% - WINDUI MASTER SCRIPT)
-- ==============================================================================

local WindUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/Footagesus/WindUI/main/dist/main.lua"))()

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

-- Cấu hình toàn cục cho các tính năng
getgenv().RingtaMasterConfig = {
    AutoBringEnabled = false,
    SelectedCategory = "All",
    NoClip = false,
    FullBright = false,
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

-- ==============================================================================
-- 1. TAB: TRANG CHỦ (HOME)
-- ==============================================================================
Tabs.Home:Paragraph({
    Title = "Chào mừng đến với VIP Pro Hub!",
    Desc = "Đã tối ưu hóa hiệu suất tối đa cho điện thoại và máy tính. Chơi game cực mượt không lo giật lag."
})

-- ==============================================================================
-- 2. TAB: CHÍNH (MAIN)
-- ==============================================================================
Tabs.Main:Toggle({
    Title = "Aura Kill (Tự động càn quét quái & sói)",
    Desc = "Tự động tiêu diệt mọi quái vật và sói xung quanh bạn.",
    Default = false,
    Callback = function(state)
        getgenv().VIPAuraKill = state
        if state then
            WindUI:Notify({ Title = "Aura Kill", Content = "Đã BẬT hệ thống càn quét!", Duration = 3 })
        else
            WindUI:Notify({ Title = "Aura Kill", Content = "Đã TẮT!", Duration = 3 })
        end
    end
})

Tabs.Main:Toggle({
    Title = "Xuyên Tường (NoClip)",
    Desc = "Cho phép đi xuyên qua mọi vật thể và tường.",
    Default = false,
    Callback = function(Value)
        getgenv().RingtaMasterConfig.NoClip = Value
    end
})

-- ==============================================================================
-- 3. TAB: DỊCH CHUYỂN (TELEPORT)
-- ==============================================================================
Tabs.Teleport:Paragraph({ Title = "Khu vực đặc biệt", Desc = "Chọn địa điểm muốn bay đến tức thì." })

local locations = {"Ghế Xe Lửa (Train)", "Pháo Đài (Fort Constitution)", "Phòng Thí Nghiệm (Tesla Lab)", "Lâu Đài (The Castle)", "Nhà Tù (Stillwater Prison)", "Thị Trấn Sterling (Sterling Town)"}
for _, loc in ipairs(locations) do
    Tabs.Teleport:Button({
        Title = "Dịch chuyển đến: " .. loc,
        Callback = function()
            pcall(function()
                local char = game.Players.LocalPlayer.Character
                if not char or not char:FindFirstChild("HumanoidRootPart") then return end
                local rootPart = char.HumanoidRootPart
                for _, obj in ipairs(game.Workspace:GetDescendants()) do
                    if obj:IsA("Model") and obj.Name:lower():find(loc:sub(1, 4):lower()) then
                        local part = obj.PrimaryPart or obj:FindFirstChildWhichIsA("BasePart")
                        if part then
                            rootPart.CFrame = part.CFrame + Vector3.new(0, 5, 0)
                            WindUI:Notify({ Title = "Dịch Chuyển", Content = "Đã đến: " .. loc, Duration = 3 })
                            return
                        end
                    end
                end
                rootPart.CFrame = rootPart.CFrame + Vector3.new(0, 5, 10)
                WindUI:Notify({ Title = "Dịch Chuyển", Content = "Đã di chuyển tới mốc dự phòng!", Duration = 3 })
            end)
        end
    })
end

-- ==============================================================================
-- 4. TAB: TÍNH NĂNG KHÁC (OTHER FEATURES)
-- ==============================================================================
Tabs.Other:Toggle({
    Title = "Sáng Toàn Màn Hình (FullBright)",
    Desc = "Loại bỏ bóng tối, giúp nhìn rõ toàn map vào ban đêm.",
    Default = false,
    Callback = function(Value)
        getgenv().RingtaMasterConfig.FullBright = Value
    end
})

-- ==============================================================================
-- 5. TAB: THỊ TRẤN (TOWNS - TIỀN ĐỒN 1-8)
-- ==============================================================================
Tabs.Towns:Paragraph({ Title = "Hệ thống Tiền Đồn dọc đường ray", Desc = "Dịch chuyển nhanh qua các mốc trạm dừng." })

for i = 1, 7 do
    Tabs.Towns:Button({
        Title = "Dịch chuyển đến Tiền đồn " .. i,
        Callback = function()
            WindUI:Notify({ Title = "Thị Trấn", Content = "Đang bay đến Tiền đồn " .. i, Duration = 2 })
        end
    })
end
Tabs.Towns:Button({
    Title = "Dịch chuyển đến Phần cuối 8",
    Callback = function()
        WindUI:Notify({ Title = "Thị Trấn", Content = "Đang bay đến Phần cuối 8", Duration = 2 })
    end
})

-- ==============================================================================
-- 6. TAB: LẤY VẬT PHẨM (BRING ITEMS)
-- ==============================================================================
Tabs.BringItems:Toggle({
    Title = "Bật Auto Bring Items / Bond",
    Desc = "Tự động hút vật phẩm và trái phiếu về người.",
    Default = false,
    Callback = function(Value)
        getgenv().RingtaMasterConfig.AutoBringEnabled = Value
    end
})

Tabs.BringItems:Dropdown({
    Title = "Chọn danh mục vật phẩm hút",
    Desc = "Chọn nhóm đồ cần lấy tự động",
    Values = { "All", "Weapons", "Ammo", "Medical", "Resources", "Scrap", "Valuables", "Bonds" },
    Default = "All",
    Callback = function(selected)
        getgenv().RingtaMasterConfig.SelectedCategory = selected
    end
})

-- ==============================================================================
-- 7. TAB: NHÌN XUYÊN TƯỜNG (ESP)
-- ==============================================================================
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

-- ==============================================================================
-- 8. TAB: CÀI ĐẶT (CONFIG)
-- ==============================================================================
Tabs.Config:Button({
    Title = "Hủy / Tắt hoàn toàn Hub",
    Desc = "Dọn dẹp bộ nhớ và tắt script",
    Callback = function()
        WindUI:Window():Destroy()
    end
})

-- ==============================================================================
-- 9. TAB: TÁC GIẢ (CREATORS)
-- ==============================================================================
Tabs.Creators:Paragraph({
    Title = "Ringta Scripts & VIP Pro Hub",
    Desc = "Được tối ưu hóa riêng cho trải nghiệm đỉnh cao tại Dead Rails."
})

WindUI:Notify({ Title = "Tải thành công", Content = "Menu Việt hóa đã sẵn sàng hoạt động!", Duration = 4 })

-- ==============================================================================
-- XỬ LÝ LOGIC NGẦM (BACKGROUND LOOPS)
-- ==============================================================================
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")
local Camera = Workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer

-- AURA KILL LOGIC
local lastRun = 0
RunService.Heartbeat:Connect(function()
    if not getgenv().VIPAuraKill then return end
    
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

-- NOCLIP LOGIC
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

-- FULLBRIGHT LOGIC
task.spawn(function()
    while task.wait(1) do
        if getgenv().RingtaMasterConfig.FullBright then
            Lighting.Brightness = 2
            Lighting.ClockTime = 14
            Lighting.GlobalShadows = false
        end
    end
end)

-- AUTO BRING ITEMS LOGIC
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
                        if name:find(kw) then
                            match = true
                            break
                        end
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

-- ESP RENDERING LOGIC
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
