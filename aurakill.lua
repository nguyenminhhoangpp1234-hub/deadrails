                    -- ==============================================================================
-- DEAD RAILS | NATIVE MASTER MENU (CLEANED - ORIGINAL FAST AURA KILL)
-- ==============================================================================

local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")
local CoreGui = game:GetService("CoreGui")
local Camera = Workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer

-- Xóa menu cũ nếu có để tránh trùng lặp
if CoreGui:FindFirstChild("DeadRailsMasterNativeMenu") then
    CoreGui.DeadRailsMasterNativeMenu:Destroy()
end

-- Tạo ScreenGui chính
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "DeadRailsMasterNativeMenu"
ScreenGui.Parent = CoreGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- Khung Main Frame (Menu chính)
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
MainFrame.BorderSizePixel = 0
MainFrame.Position = UDim2.new(0.5, -220, 0.5, -170)
MainFrame.Size = UDim2.new(0, 440, 0, 340)
MainFrame.Active = true
MainFrame.Draggable = true

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 10)
UICorner.Parent = MainFrame

-- Tiêu đề Menu
local TitleLabel = Instance.new("TextLabel")
TitleLabel.Parent = MainFrame
TitleLabel.BackgroundColor3 = Color3.fromRGB(180, 40, 40)
TitleLabel.BorderSizePixel = 0
TitleLabel.Size = UDim2.new(1, 0, 0, 45)
TitleLabel.Font = Enum.Font.SourceSansBold
TitleLabel.Text = "DEAD RAILS - MASTER HUB VIP"
TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleLabel.TextSize = 18

local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 10)
TitleCorner.Parent = TitleLabel

-- Khu vực chứa các tính năng (ScrollingFrame)
local ScrollContainer = Instance.new("ScrollingFrame")
ScrollContainer.Parent = MainFrame
ScrollContainer.BackgroundTransparency = 1
ScrollContainer.Position = UDim2.new(0, 10, 0, 55)
ScrollContainer.Size = UDim2.new(1, -20, 1, -65)
ScrollContainer.CanvasSize = UDim2.new(0, 0, 0, 400)
ScrollContainer.ScrollBarThickness = 6

local UIListLayout = Instance.new("UIListLayout")
UIListLayout.Parent = ScrollContainer
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Padding = UDim.new(0, 8)

-- Biến cấu hình trạng thái
getgenv().MasterConfig = {
    Aimbot = false,
    AuraKill = false,
    FPSBoost = false
}

-- Hàm tạo nút bấm Bật/Tắt (Toggle) trực quan
local function CreateNativeToggle(name, callback)
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
    
    local state = false
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

-- Thêm các tính năng chính vào Menu Gốc
CreateNativeToggle("Aimbot Khóa Quái Vật (Tâm Màn Hình)", function(state)
    getgenv().MasterConfig.Aimbot = state
end)

CreateNativeToggle("Aura Kill (Càn quét quái tự động)", function(state)
    getgenv().MasterConfig.AuraKill = state
end)

CreateNativeToggle("Xóa Đồ Họa & Tăng FPS Siêu Mượt", function(state)
    getgenv().MasterConfig.FPSBoost = state
    if state then
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

-- Nút Đóng Menu
local CloseBtn = Instance.new("TextButton")
CloseBtn.Parent = ScrollContainer
CloseBtn.BackgroundColor3 = Color3.fromRGB(120, 30, 30)
CloseBtn.Size = UDim2.new(1, 0, 0, 38)
CloseBtn.Font = Enum.Font.SourceSansBold
CloseBtn.Text = "ĐÓNG / HỦY MENU"
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.TextSize = 15

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 6)
CloseCorner.Parent = CloseBtn

CloseBtn.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

print("🔥 DEAD RAILS CLEANED MENU LOADED SUCCESS!")


-- ==============================================================================
-- LOGIC XỬ LÝ NGẦM (AIMBOT & ORIGINAL AURA KILL)
-- ==============================================================================

local FOVCircle = Drawing.new("Circle")
FOVCircle.Visible = false
FOVCircle.Transparency = 0.7
FOVCircle.Color = Color3.fromRGB(255, 50, 50)
FOVCircle.Thickness = 1.5
FOVCircle.NumSides = 60
FOVCircle.Radius = 150
FOVCircle.Filled = false

RunService.RenderStepped:Connect(function()
    FOVCircle.Position = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
    FOVCircle.Visible = getgenv().MasterConfig.Aimbot

    if getgenv().MasterConfig.Aimbot then
        local centerScreen = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
        local closestTarget = nil
        local shortestDist = 150

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

-- Aura Kill chuẩn ban đầu (Càn quét tức thì không độ trễ)
RunService.Heartbeat:Connect(function()
    if not getgenv().MasterConfig.AuraKill then return end
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
