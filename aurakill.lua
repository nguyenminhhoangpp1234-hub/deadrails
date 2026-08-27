-- ==============================================================================
-- DEAD RAILS | TRUE GLOBAL AURA KILL (QUÉT SẠCH 100% TOÀN BỘ QUÁI TRÊN MAP)
-- ==============================================================================

local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")
local LocalPlayer = Players.LocalPlayer

-- Xóa menu cũ nếu có
if CoreGui:FindFirstChild("GlobalAuraKillMenu") then
    CoreGui.GlobalAuraKillMenu:Destroy()
end

-- Tạo Giao Diện Menu
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "GlobalAuraKillMenu"
ScreenGui.Parent = CoreGui

local Frame = Instance.new("Frame")
Frame.Parent = ScreenGui
Frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Frame.Position = UDim2.new(0.5, -130, 0.5, -90)
Frame.Size = UDim2.new(0, 260, 0, 140)
Frame.Active = true
Frame.Draggable = true

local Title = Instance.new("TextLabel")
Title.Parent = Frame
Title.BackgroundColor3 = Color3.fromRGB(200, 30, 30)
Title.Size = UDim2.new(1, 0, 0, 35)
Title.Text = "DEAD RAILS - GLOBAL AURA KILL"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.SourceSansBold
Title.TextSize = 13

local ToggleBtn = Instance.new("TextButton")
ToggleBtn.Parent = Frame
ToggleBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
ToggleBtn.Position = UDim2.new(0, 10, 0, 45)
ToggleBtn.Size = UDim2.new(1, -20, 0, 40)
ToggleBtn.Text = "Global Aura: TẮT"
ToggleBtn.TextColor3 = Color3.fromRGB(255, 80, 80)
ToggleBtn.Font = Enum.Font.SourceSansBold
ToggleBtn.TextSize = 14

local CloseBtn = Instance.new("TextButton")
CloseBtn.Parent = Frame
CloseBtn.BackgroundColor3 = Color3.fromRGB(100, 30, 30)
CloseBtn.Position = UDim2.new(0, 10, 0, 95)
CloseBtn.Size = UDim2.new(1, -20, 0, 30)
CloseBtn.Text = "Đóng Menu"
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.Font = Enum.Font.SourceSansBold
CloseBtn.TextSize = 12

-- Trạng thái
local globalAuraState = false
ToggleBtn.MouseButton1Click:Connect(function()
    globalAuraState = not globalAuraState
    if globalAuraState then
        ToggleBtn.Text = "Global Aura: BẬT (CHẾT SẠCH)"
        ToggleBtn.TextColor3 = Color3.fromRGB(80, 255, 80)
        ToggleBtn.BackgroundColor3 = Color3.fromRGB(20, 90, 20)
    else
        ToggleBtn.Text = "Global Aura: TẮT"
        ToggleBtn.TextColor3 = Color3.fromRGB(255, 80, 80)
        ToggleBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    end
end)

CloseBtn.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

-- Logic càn quét toàn bộ map không giới hạn khoảng cách (Đi đến đâu quái chết ngả đến đó)
RunService.Heartbeat:Connect(function()
    if not globalAuraState then return end
    pcall(function()
        local char = LocalPlayer.Character
        
        -- Quét toàn bộ các đối tượng trong Workspace (kể cả quái spawn ở xa hoặc trong thư mục ẩn)
        for _, obj in ipairs(Workspace:GetDescendants()) do
            -- Kiểm tra nếu là Model không phải người chơi
            if obj:IsA("Model") and obj ~= char and not Players:GetPlayerFromCharacter(obj) then
                local humanoid = obj:FindFirstChildOfClass("Humanoid")
                if humanoid and humanoid.Health > 0 then
                    -- Ép máu về 0 và hủy thể lực/xác quái ngay lập tức
                    humanoid.Health = 0
                    humanoid.MaxHealth = 0
                    pcall(function()
                        humanoid:ChangeState(Enum.HumanoidState.Dead)
                        obj:BreakJoints()
                    end)
                end
            end
        end
    end)
end)
