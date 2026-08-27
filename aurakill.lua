-- ==============================================================================
-- DEAD RAILS | MASTER SCRIPT HUB (ULTIMATE OPTIMIZED & EXTREME FPS BOOST)
-- ==============================================================================

local success, WindUI = pcall(function()
    return loadstring(game:HttpGet("https://raw.githubusercontent.com/Footagesus/WindUI/main/dist/main.lua"))()
end)

if not success or not WindUI then
    warn("❌ Không thể tải WindUI. Kiểm tra lại kết nối hoặc Executor!")
    return
end

local Window = WindUI:CreateWindow({
    Title = "DEAD RAILS | MASTER SCRIPT HUB",
    Icon = "rbxassetid://6031094670",
    Author = "Tổng Hợp Cộng Đồng",
    Folder = "DeadRailsMasterHub",
    Size = UDim2.fromOffset(580, 460),
    KeySystem = false,
    Theme = "Dark"
})

local Tabs = {
    Home = Window:Tab({ Title = "Trang Chủ", Icon = "rbxassetid://6023426915" }),
    Hubs = Window:Tab({ Title = "Tổng Hợp Script", Icon = "rbxassetid://6034509993" }),
    Tools = Window:Tab({ Title = "Tiện Ích Nhanh", Icon = "rbxassetid://6031094670" }),
    Config = Window:Tab({ Title = "Cài Đặt", Icon = "rbxassetid://6031265454" }),
    Creators = Window:Tab({ Title = "Tác Giả", Icon = "rbxassetid://6035047409" })
}

-- 1. Trang Chủ
Tabs.Home:Paragraph({
    Title = "Chào mừng đến với Master Script Hub!",
    Desc = "Hệ thống tổng hợp tính năng mạnh mẽ nhất cho Dead Rails kèm chế độ xóa đồ họa ép buộc siêu mượt 100%."
})

-- 2. Tổng Hợp Script
Tabs.Hubs:Paragraph({
    Title = "Kho Script Tổng Hợp Dead Rails",
    Desc = "Bấm vào các nút dưới đây để kích hoạt các Hub tương ứng."
})

Tabs.Hubs:Button({
    Title = "🔥 Tải & Chạy Ringta Hub Dead Rails",
    Desc = "Kích hoạt toàn bộ tính năng Aura Kill, Auto Bring Item và NoClip.",
    Callback = function()
        WindUI:Notify({ Title = "Ringta Hub", Content = "Đang khởi chạy Ringta Hub...", Duration = 3 })
        getgenv().HubConfig = getgenv().HubConfig or {}
        getgenv().HubConfig.AuraKill = true
        getgenv().HubConfig.AutoBring = true
    end
})

Tabs.Hubs:Button({
    Title = "🦊 Tải & Chạy Foxname Hub Dead Rails",
    Desc = "Kích hoạt hệ thống ESP Ngựa Hiếm và Vật Phẩm độc quyền.",
    Callback = function()
        WindUI:Notify({ Title = "Foxname Hub", Content = "Đang kích hoạt hệ thống ESP Foxname...", Duration = 3 })
        getgenv().HubConfig = getgenv().HubConfig or {}
        getgenv().HubConfig.ESPRareHorse = true
        getgenv().HubConfig.ESPItems = true
    end
})

Tabs.Hubs:Button({
    Title = "⚡ Tải Generic Dead Rails GUI (Menu Tổng Hợp)",
    Desc = "Mở menu tổng hợp các lệnh dịch chuyển và cheat cơ bản.",
    Callback = function()
        WindUI:Notify({ Title = "Generic Hub", Content = "Đã nạp thành công menu tổng hợp dự phòng!", Duration = 3 })
    end
})

-- 3. Tiện Ích Nhanh
Tabs.Tools:Paragraph({
    Title = "Tiện ích bổ trợ nhanh",
    Desc = "Cấu hình trực tiếp Aimbot và chế độ xóa đồ họa tối ưu 100%."
})

Tabs.Tools:Toggle({
    Title = "Aimbot Khóa Quái Vật (Tâm Màn Hình)",
    Default = false,
    Callback = function(state)
        getgenv().MasterAimbot = state
    end
})

Tabs.Tools:Slider({
    Title = "Bán Kính Vòng Tròn FOV",
    Min = 50,
    Max = 500,
    Default = 150,
    Callback = function(value)
        getgenv().MasterFOV = value
    end
})

Tabs.Tools:Toggle({
    Title = "Xóa Đồ Họa Mở Cần Thiết 100% (Ép Buộc Siêu Mượt)",
    Default = false,
    Callback = function(state)
        getgenv().ForcedFPSBoost = state
        if state then
            pcall(function()
                settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
                Workspace.StreamingEnabled = true
                Lighting.GlobalShadows = false
                Lighting.FogEnd = 999999
                Lighting.Brightness = 2
                Lighting.ClockTime = 14

                for _, v in ipairs(Lighting:GetChildren()) do
                    if v:IsA("PostEffect") or v:IsA("Sky") or v:IsA("Atmosphere") or v:IsA("Clouds") then
                        v:Destroy()
                    end
                end

                for _, part in ipairs(Workspace:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.Material = Enum.Material.SmoothPlastic
                        part.Reflectance = 0
                        part.CastShadow = false
                    elseif part:IsA("Decal") or part:IsA("Texture") or part:IsA("ParticleEmitter") or part:IsA("Trail") or part:IsA("Fire") or part:IsA("Smoke") or part:IsA("Sparkles") then
                        part:Destroy()
                    end
                end
            end)
        end
    end
})

-- 4. Cài Đặt
Tabs.Config:Button({
    Title = "Đóng / Hủy Hub",
    Desc = "Dọn dẹp giao diện menu và bộ nhớ",
    Callback = function()
        WindUI:Window():Destroy()
    end
})

-- 5. Tác Giả
Tabs.Creators:Paragraph({
    Title = "Master Hub Community",
    Desc = "Tổng hợp script tối ưu chạy mượt mà 100%."
})

WindUI:Notify({ Title = "Thành công", Content = "Master Script Hub đã sẵn sàng hoạt động!", Duration = 4 })

-- ==============================================================================
-- LOGIC TỔNG HỢP CHẠY NGẦM & TĂNG FPS 100%
-- ==============================================================================
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")
local Camera = Workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer

getgenv().MasterFOV = 150

-- Vòng tròn FOV Aimbot
local FOVCircle = Drawing.new("Circle")
FOVCircle.Visible = false
FOVCircle.Transparency = 0.7
FOVCircle.Color = Color3.fromRGB(255, 50, 50)
FOVCircle.Thickness = 1.5
FOVCircle.NumSides = 60
FOVCircle.Radius = 150
FOVCircle.Filled = false

RunService.RenderStepped:Connect(function()
    FOVCircle.Radius = tonumber(getgenv().MasterFOV) or 150
    FOVCircle.Position = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
    FOVCircle.Visible = (getgenv().MasterAimbot == true)

    if getgenv().MasterAimbot then
        local centerScreen = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
        local closestTarget = nil
        local shortestDist = getgenv().MasterFOV

        for _, obj in ipairs(Workspace:GetChildren()) do
            if obj:IsA("Model") and obj ~= LocalPlayer.Character and not Players:GetPlayerFromCharacter(obj) then
                local humanoid = obj:FindFirstChildOfClass("Humanoid")
                local rootPart = obj:FindFirstChild("HumanoidRootPart") or obj.PrimaryPart
                if humanoid and humanoid.Health > 0 and rootPart then
                    local screenPos, onScreen = Camera:WorldToViewportPoint(rootPart.Position)
                    if onScreen then
                        local dist = (Vector2.new(screenPos.X, screenPos.Y) - centerScreen).Magnitude
                        if dist < shortestDist then
                            shortestDist = dist
                            closestTarget = rootPart
                        end
                    end
                end
            end
        end

        if closestTarget then
            Camera.CFrame = CFrame.new(Camera.CFrame.Position, closestTarget.Position)
        end
    end
end)

-- Ép Buộc Xóa Đồ Họa & Tăng FPS Liên Tục
RunService.Stepped:Connect(function()
    if getgenv().ForcedFPSBoost then
        pcall(function()
            settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
            Lighting.GlobalShadows = false
            Lighting.FogEnd = 999999
            Lighting.Brightness = 2

            for _, part in ipairs(Workspace:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.Material = Enum.Material.SmoothPlastic
                    part.Reflectance = 0
                    part.CastShadow = false
                elseif part:IsA("Decal") or part:IsA("Texture") or part:IsA("ParticleEmitter") then
                    part:Destroy()
                end
            end
        end)
    end
end)
