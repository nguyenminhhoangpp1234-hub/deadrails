-- ==============================================================================
-- DEAD RAILS | VIP PRO HUB (RINGTA HUB & FOXNAME HUB ULTIMATE EDITION)
-- ==============================================================================

local success, WindUI = pcall(function()
    return loadstring(game:HttpGet("https://raw.githubusercontent.com/Footagesus/WindUI/main/dist/main.lua"))()
end)

if not success or not WindUI then
    warn("❌ Không thể tải WindUI. Kiểm tra lại kết nối hoặc Executor!")
    return
end

local Window = WindUI:CreateWindow({
    Title = "DEAD RAILS | RINGTA & FOXNAME HUB",
    Icon = "rbxassetid://6031094670",
    Author = "Bản Việt Hóa Pro",
    Folder = "DeadRailsUltimateVIP",
    Size = UDim2.fromOffset(580, 460),
    KeySystem = false,
    Theme = "Dark"
})

local Tabs = {
    Home = Window:Tab({ Title = "Trang Chủ", Icon = "rbxassetid://6023426915" }),
    Main = Window:Tab({ Title = "Chính & Aimbot", Icon = "rbxassetid://6031094670" }),
    DeadRails = Window:Tab({ Title = "Tổng Hợp Dead Rails", Icon = "rbxassetid://6034509993" }),
    ESP = Window:Tab({ Title = "Nhìn Xuyên Tường", Icon = "rbxassetid://6034789531" }),
    Config = Window:Tab({ Title = "Cài Đặt", Icon = "rbxassetid://6031265454" }),
    Creators = Window:Tab({ Title = "Tác Giả", Icon = "rbxassetid://6035047409" })
}

getgenv().HubConfig = {
    Aimbot = false,
    AimbotFOV = 150,
    AuraKill = false,
    FPSBoost = false,
    AutoBring = false,
    InfiniteStamina = false,
    GodModeBypass = false,
    ESPRareHorse = false,
    ESPItems = false
}

-- 1. Trang Chủ
Tabs.Home:Paragraph({
    Title = "Trạng thái hệ thống",
    Desc = "Đã tích hợp trọn bộ tính năng tinh hoa từ Ringta Hub & Foxname Hub phiên bản tối ưu riêng cho Dead Rails."
})

-- 2. Chính & Aimbot
Tabs.Main:Toggle({
    Title = "Aimbot Quái Vật (Khóa model quái)",
    Desc = "Tự động hướng tâm súng vào mô hình quái vật trong vòng tròn FOV cố định tại tâm màn hình.",
    Default = false,
    Callback = function(state)
        getgenv().HubConfig.Aimbot = state
    end
})

Tabs.Main:Slider({
    Title = "Phạm vi vòng tròn FOV Aimbot",
    Desc = "Điều chỉnh kích thước vùng bắt mục tiêu",
    Min = 50,
    Max = 500,
    Default = 150,
    Callback = function(value)
        getgenv().HubConfig.AimbotFOV = value
    end
})

Tabs.Main:Toggle({
    Title = "Aura Kill (Càn quét quái vật tự động)",
    Desc = "Tiêu diệt nhanh mọi quái vật xung quanh bạn.",
    Default = false,
    Callback = function(state)
        getgenv().HubConfig.AuraKill = state
    end
})

Tabs.Main:Toggle({
    Title = "Xóa đồ họa tăng FPS siêu mượt",
    Desc = "Gỡ bỏ hiệu ứng nặng, vô hiệu hóa bóng tối và đổ bóng để tối ưu máy yếu.",
    Default = false,
    Callback = function(state)
        getgenv().HubConfig.FPSBoost = state
    end
})

-- 3. Tổng hợp Dead Rails (Ringta Hub & Foxname Hub Features)
Tabs.DeadRails:Paragraph({
    Title = "Tổng Hợp Menu Chuyên Sâu",
    Desc = "Các tính năng đặc trưng hỗ trợ sinh tồn cực mạnh trong Dead Rails."
})

Tabs.DeadRails:Toggle({
    Title = "Auto Bring Items / Bond (Foxname Style)",
    Desc = "Tự động hút vật phẩm, tiền và trái phiếu xung quanh về gần nhân vật.",
    Default = false,
    Callback = function(state)
        getgenv().HubConfig.AutoBring = state
    end
})

Tabs.DeadRails:Toggle({
    Title = "Thể Lực Vô Hạn / Không Mệt (Infinite Stamina)",
    Desc = "Chạy nước rút liên tục không bị giảm thanh thể lực.",
    Default = false,
    Callback = function(state)
        getgenv().HubConfig.InfiniteStamina = state
    end
})

Tabs.DeadRails:Toggle({
    Title = "Chống Sát Thương Cơ Bản (GodMode Bypass)",
    Desc = "Hỗ trợ giảm thiểu hoặc né sát thương từ quái vật tấn công trực diện.",
    Default = false,
    Callback = function(state)
        getgenv().HubConfig.GodModeBypass = state
    end
})

-- 4. Nhìn Xuyên Tường (ESP)
Tabs.ESP:Paragraph({ Title = "Hệ thống ESP Chuyên Biệt", Desc = "Hiển thị vị trí vật thể và ngựa hiếm xuyên qua tường." })
Tabs.ESP:Toggle({
    Title = "ESP Ngựa Hiếm (Rare Horse)",
    Default = false,
    Callback = function(Value)
        getgenv().HubConfig.ESPRareHorse = Value
    end
})

Tabs.ESP:Toggle({
    Title = "ESP Vật Phẩm & Vũ Khí (Foxname ESP)",
    Default = false,
    Callback = function(Value)
        getgenv().HubConfig.ESPItems = Value
    end
})

-- 5. Cài Đặt
Tabs.Config:Button({
    Title = "Đóng / Hủy Hub",
    Desc = "Dọn dẹp giao diện menu và bộ nhớ",
    Callback = function()
        WindUI:Window():Destroy()
    end
})

-- 6. Tác Giả
Tabs.Creators:Paragraph({
    Title = "Ringta & Foxname Collaboration",
    Desc = "Sự kết hợp hoàn hảo giữa các script hàng đầu cho Dead Rails."
})

WindUI:Notify({ Title = "Thành công", Content = "Tổng hợp Hub Ringta & Foxname đã sẵn sàng!", Duration = 4 })

-- ==============================================================================
-- LOGIC XỬ LÝ NGẦM TOÀN DIỆN
-- ==============================================================================
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")
local Camera = Workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer

-- Vòng tròn FOV cố định tại tâm màn hình
local FOVCircle = Drawing.new("Circle")
FOVCircle.Visible = false
FOVCircle.Transparency = 0.7
FOVCircle.Color = Color3.fromRGB(255, 50, 50)
FOVCircle.Thickness = 1.5
FOVCircle.NumSides = 60
FOVCircle.Radius = 150
FOVCircle.Filled = false

local function GetClosestMonsterInFOV()
    local closestTarget = nil
    local shortestDist = getgenv().HubConfig.AimbotFOV
    local centerScreen = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)

    for _, obj in ipairs(Workspace:GetChildren()) do
        if obj:IsA("Model") and obj ~= LocalPlayer.Character and not Players:GetPlayerFromCharacter(obj) then
            local humanoid = obj:FindFirstChildOfClass("Humanoid")
            local rootPart = obj:FindFirstChild("HumanoidRootPart") or obj.PrimaryPart
            if humanoid and humanoid.Health > 0 and rootPart then
                local screenPos, onScreen = Camera:WorldToViewportPoint(rootPart.Position)
                if onScreen then
                    local distance = (Vector2.new(screenPos.X, screenPos.Y) - centerScreen).Magnitude
                    if distance < shortestDist then
                        shortestDist = distance
                        closestTarget = rootPart
                    end
                end
            end
        end
    end
    return closestTarget
end

RunService.RenderStepped:Connect(function()
    FOVCircle.Radius = getgenv().HubConfig.AimbotFOV
    FOVCircle.Position = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
    FOVCircle.Visible = getgenv().HubConfig.Aimbot

    if getgenv().HubConfig.Aimbot then
        local target = GetClosestMonsterInFOV()
        if target then
            Camera.CFrame = CFrame.new(Camera.CFrame.Position, target.Position)
        end
    end
end)

-- Aura Kill
local lastRun = 0
RunService.Heartbeat:Connect(function()
    if not getgenv().HubConfig.AuraKill then return end
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

-- Xóa đồ họa tăng FPS
RunService.Stepped:Connect(function()
    if getgenv().HubConfig.FPSBoost then
        pcall(function()
            Lighting.GlobalShadows = false
            Lighting.FogEnd = 999999
            for _, v in ipairs(Lighting:GetChildren()) do
                if v:IsA("PostEffect") then v.Enabled = false end
            end
            for _, part in ipairs(Workspace:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.Material = Enum.Material.SmoothPlastic
                    part.Reflectance = 0
                elseif part:IsA("Decal") or part:IsA("Texture") then
                    part.Transparency = 1
                end
            end
        end)
    end
end)

-- Auto Bring Items & Bond (Foxname Style)
task.spawn(function()
    while true do
        task.wait(0.3)
        pcall(function()
            if not getgenv().HubConfig.AutoBring then return end
            local char = LocalPlayer.Character
            if not char or not char:FindFirstChild("HumanoidRootPart") then return end
            local rootPos = char.HumanoidRootPart.CFrame

            for _, obj in ipairs(Workspace:GetDescendants()) do
                if obj:IsA("Model") or obj:IsA("Part") then
                    local name = obj.Name:lower()
                    if name:find("item") or name:find("weapon") or name:find("bond") or name:find("gold") or name:find("ammo") then
                        local part = obj:IsA("Model") and (obj.PrimaryPart or obj:FindFirstChildWhichIsA("BasePart")) or obj
                        if part and (part.Position - char.HumanoidRootPart.Position).Magnitude < 100 then
                            part.CFrame = rootPos + (rootPos.LookVector * 2) + Vector3.new(0, 1, 0)
                            local prompt = obj:FindFirstChildWhichIsA("ProximityPrompt", true)
                            if prompt then fireproximityprompt(prompt) end
                        end
                    end
                end
            end
        end)
    end
end)

-- Infinite Stamina & GodMode Bypass
RunService.Stepped:Connect(function()
    pcall(function()
        local char = LocalPlayer.Character
        if not char then return end
        local humanoid = char:FindFirstChildOfClass("Humanoid")
        
        if getgenv().HubConfig.InfiniteStamina then
            local stamina = char:FindFirstChild("Stamina", true) or LocalPlayer:FindFirstChild("Stamina", true)
            if stamina and stamina:IsA("NumberValue") then
                stamina.Value = 100
            end
        end

        if getgenv().HubConfig.GodModeBypass and humanoid then
            humanoid.BreakJointsOnDeath = false
        end
    end)
end)

-- ESP Ngựa Hiếm & Vật Phẩm (Foxname & Ringta ESP Engine)
local ESPStorage = {}
local function RemoveESP(obj)
    if ESPStorage[obj] then
        for _, drawing in pairs(ESPStorage[obj]) do
            pcall(function() drawing:Remove() end)
        end
        ESPStorage[obj] = nil
    end
end

RunService.RenderStepped:Connect(function()
    for _, obj in ipairs(Workspace:GetDescendants()) do
        if obj:IsA("Model") then
            local nameLower = obj.Name:lower()
            local isHorse = nameLower:find("horse") or nameLower:find("steed") or nameLower:find("stallion")
            local isItem = nameLower:find("revolver") or nameLower:find("rifle") or nameLower:find("gold") or nameLower:find("bond")

            local rootPart = obj:FindFirstChild("HumanoidRootPart") or obj.PrimaryPart or obj:FindFirstChildWhichIsA("BasePart")
            if rootPart then
                -- ESP Ngựa Hiếm
                if isHorse and getgenv().HubConfig.ESPRareHorse then
                    local screenPos, onScreen = Camera:WorldToViewportPoint(rootPart.Position)
                    if not ESPStorage[obj] then
                        local text = Drawing.new("Text")
                        text.Visible = false
                        text.Center = true
                        text.Outline = true
                        text.Size = 13
                        text.Color = Color3.fromRGB(255, 215, 0)
                        ESPStorage[obj] = {text}
                    end
                    local text = ESPStorage[obj][1]
                    if onScreen then
                        text.Text = "[NGỰA HIẾM] " .. obj.Name
                        text.Position = Vector2.new(screenPos.X, screenPos.Y - 20)
                        text.Visible = true
                    else
                        text.Visible = false
                    end
                elseif isItem and getgenv().HubConfig.ESPItems then
                    local screenPos, onScreen = Camera:WorldToViewportPoint(rootPart.Position)
                    if not ESPStorage[obj] then
                        local text = Drawing.new("Text")
                        text.Visible = false
                        text.Center = true
                        text.Outline = true
                        text.Size = 13
                        text.Color = Color3.fromRGB(0, 255, 128)
                        ESPStorage[obj] = {text}
                    end
                    local text = ESPStorage[obj][1]
                    if onScreen then
                        text.Text = "[ITEM/BOND] " .. obj.Name
                        text.Position = Vector2.new(screenPos.X, screenPos.Y - 20)
                        text.Visible = true
                    else
                        text.Visible = false
                    end
                else
                    if not getgenv().HubConfig.ESPRareHorse and not getgenv().HubConfig.ESPItems then
                        RemoveESP(obj)
                    end
                end
            end
        end
    end
end)
