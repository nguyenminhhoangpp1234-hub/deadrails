-- ==============================================================================
-- ULTIMATE PRO HUB | AIMBOT, ESP & AURA KILL (NATIVE UI - 100% HOẠT ĐỘNG)
-- ==============================================================================

local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")
local UserInputService = game:GetService("UserInputService")
local Camera = Workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer

-- Xóa menu cũ nếu có
if CoreGui:FindFirstChild("UltimateProHub") then
    CoreGui.UltimateProHub:Destroy()
end

-- Tạo ScreenGui chính
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "UltimateProHub"
ScreenGui.Parent = CoreGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- Khung Main Menu
local MainFrame = Instance.new("Frame")
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
MainFrame.BorderSizePixel = 0
MainFrame.Position = UDim2.new(0.5, -220, 0.5, -180)
MainFrame.Size = UDim2.new(0, 440, 0, 360)
MainFrame.Active = true
MainFrame.Draggable = true

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 10)
UICorner.Parent = MainFrame

-- Thanh Tiêu Đề
local TitleLabel = Instance.new("TextLabel")
TitleLabel.Parent = MainFrame
TitleLabel.BackgroundColor3 = Color3.fromRGB(180, 30, 30)
TitleLabel.BorderSizePixel = 0
TitleLabel.Size = UDim2.new(1, 0, 0, 45)
TitleLabel.Font = Enum.Font.SourceSansBold
TitleLabel.Text = "🔥 ULTIMATE PRO HUB - VIP EDITION"
TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleLabel.TextSize = 18

local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 10)
TitleCorner.Parent = TitleLabel

-- Khu vực chứa tính năng (Scrolling)
local ScrollContainer = Instance.new("ScrollingFrame")
ScrollContainer.Parent = MainFrame
ScrollContainer.BackgroundTransparency = 1
ScrollContainer.Position = UDim2.new(0, 10, 0, 55)
ScrollContainer.Size = UDim2.new(1, -20, 1, -65)
ScrollContainer.CanvasSize = UDim2.new(0, 0, 0, 450)
ScrollContainer.ScrollBarThickness = 6

local UIListLayout = Instance.new("UIListLayout")
UIListLayout.Parent = ScrollContainer
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Padding = UDim.new(0, 8)

-- Cấu hình trạng thái tính năng
getgenv().HubConfig = {
    Aimbot = false,
    AimbotFOV = 150,
    AuraKill = false,
    ESPPlayer = false,
    ESPNPC = false
}

-- Vẽ vòng tròn FOV trên màn hình
local FOVCircle = Drawing.new("Circle")
FOVCircle.Visible = false
FOVCircle.Transparency = 0.7
FOVCircle.Color = Color3.fromRGB(255, 255, 255)
FOVCircle.Thickness = 1.5
FOVCircle.NumSides = 60
FOVCircle.Radius = getgenv().HubConfig.AimbotFOV
FOVCircle.Filled = false

-- Hàm tạo nút Toggle
local function CreateToggle(name, defaultVal, callback)
    local btn = Instance.new("TextButton")
    btn.Parent = ScrollContainer
    btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    btn.Size = UDim2.new(1, 0, 0, 38)
    btn.Font = Enum.Font.SourceSansBold
    btn.Text = name .. ": [TẮT]"
    btn.TextColor3 = Color3.fromRGB(255, 80, 80)
    btn.TextSize = 15
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = btn
    
    local state = defaultVal
    btn.MouseButton1Click:Connect(function()
        state = not state
        if state then
            btn.Text = name .. ": [BẬT]"
            btn.TextColor3 = Color3.fromRGB(80, 255, 80)
            btn.BackgroundColor3 = Color3.fromRGB(30, 90, 30)
        else
            btn.Text = name .. ": [TẮT]"
            btn.TextColor3 = Color3.fromRGB(255, 80, 80)
            btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        end
        callback(state)
    end)
end

-- Thêm các tính năng vào menu
CreateToggle("Aimbot Dính Mục Tiêu", false, function(state)
    getgenv().HubConfig.Aimbot = state
    FOVCircle.Visible = state
end)

CreateToggle("Aura Kill (Càn quét tự động)", false, function(state)
    getgenv().HubConfig.AuraKill = state
end)

CreateToggle("ESP Người Trốn (Players)", false, function(state)
    getgenv().HubConfig.ESPPlayer = state
end)

CreateToggle("ESP NPC / Quái Vật", false, function(state)
    getgenv().HubConfig.ESPNPC = state
end)


-- ==============================================================================
-- 1. AIMBOT LOGIC (DÍNH MỤC TIÊU TRONG FOV)
-- ==============================================================================
local function GetClosestPlayerInFOV()
    local closestTarget = nil
    local shortestDist = getgenv().HubConfig.AimbotFOV
    local mousePos = UserInputService:GetMouseLocation()

    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("Head") then
            local char = player.Character
            local humanoid = char:FindFirstChildOfClass("Humanoid")
            if humanoid and humanoid.Health > 0 then
                local head = char.Head
                local screenPos, onScreen = Camera:WorldToViewportPoint(head.Position)
                if onScreen then
                    local distance = (Vector2.new(screenPos.X, screenPos.Y) - mousePos).Magnitude
                    if distance < shortestDist then
                        shortestDist = distance
                        closestTarget = head
                    end
                end
            end
        end
    end
    return closestTarget
end

RunService.RenderStepped:Connect(function()
    FOVCircle.Position = UserInputService:GetMouseLocation()
    FOVCircle.Radius = getgenv().HubConfig.AimbotFOV

    if getgenv().HubConfig.Aimbot then
        local target = GetClosestPlayerInFOV()
        if target then
            Camera.CFrame = CFrame.new(Camera.CFrame.Position, target.Position)
        end
    end
end)


-- ==============================================================================
-- 2. AURA KILL LOGIC
-- ==============================================================================
RunService.Heartbeat:Connect(function()
    if not getgenv().HubConfig.AuraKill then return end
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


-- ==============================================================================
-- 3. ESP HỆ THỐNG (PLAYER & NPC)
-- ==============================================================================
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
    -- Xử lý ESP Player (Người trốn)
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer then
            local char = player.Character
            if char and char:FindFirstChild("HumanoidRootPart") and getgenv().HubConfig.ESPPlayer then
                local rootPart = char.HumanoidRootPart
                local screenPos, onScreen = Camera:WorldToViewportPoint(rootPart.Position)
                
                if not ESPStorage[player] then
                    local text = Drawing.new("Text")
                    text.Visible = false
                    text.Center = true
                    text.Outline = true
                    text.Size = 14
                    text.Color = Color3.fromRGB(0, 200, 255)
                    ESPStorage[player] = {text}
                end

                local text = ESPStorage[player][1]
                if onScreen then
                    text.Text = "[PLAYER] " .. player.Name
                    text.Position = Vector2.new(screenPos.X, screenPos.Y - 20)
                    text.Visible = true
                else
                    text.Visible = false
                end
            else
                RemoveESP(player)
            end
        end
    end

    -- Xử lý ESP NPC / Quái vật
    for _, obj in ipairs(Workspace:GetChildren()) do
        if obj:IsA("Model") and not Players:GetPlayerFromCharacter(obj) then
            local humanoid = obj:FindFirstChildOfClass("Humanoid")
            local rootPart = obj:FindFirstChild("HumanoidRootPart") or obj.PrimaryPart
            
            if humanoid and rootPart and getgenv().HubConfig.ESPNPC then
                local screenPos, onScreen = Camera:WorldToViewportPoint(rootPart.Position)
                
                if not ESPStorage[obj] then
                    local text = Drawing.new("Text")
                    text.Visible = false
                    text.Center = true
                    text.Outline = true
                    text.Size = 14
                    text.Color = Color3.fromRGB(255, 50, 50)
                    ESPStorage[obj] = {text}
                end

                local text = ESPStorage[obj][1]
                if onScreen then
                    text.Text = "[NPC/MOB] " .. obj.Name
                    text.Position = Vector2.new(screenPos.X, screenPos.Y - 20)
                    text.Visible = true
                else
                    text.Visible = false
                end
            else
                if not getgenv().HubConfig.ESPNPC then
                    RemoveESP(obj)
                end
            end
        end
    end
end)

print("🔥 ULTIMATE PRO HUB LOADED 100% SUCCESS!")
