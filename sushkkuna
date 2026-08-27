-- ==============================================================================
-- DEAD RAILS | KILL AURA MENU (BẢN ĐẦU TIÊN TỪ GITHUB)
-- ==============================================================================

local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")
local LocalPlayer = Players.LocalPlayer

-- Xóa menu cũ nếu đã tồn tại để tránh bị trùng
if CoreGui:FindFirstChild("FirstGithubKillAura") then
    CoreGui.FirstGithubKillAura:Destroy()
end

-- Tạo GUI cơ bản giống hệt bản đầu tiên
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "FirstGithubKillAura"
ScreenGui.Parent = CoreGui

local Frame = Instance.new("Frame")
Frame.Parent = ScreenGui
Frame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
Frame.Position = UDim2.new(0.5, -125, 0.5, -75)
Frame.Size = UDim2.new(0, 250, 0, 110)
Frame.Active = true
Frame.Draggable = true

local Title = Instance.new("TextLabel")
Title.Parent = Frame
Title.BackgroundColor3 = Color3.fromRGB(150, 30, 30)
Title.Size = UDim2.new(1, 0, 0, 30)
Title.Text = "DEAD RAILS - KILL AURA"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.SourceSansBold
Title.TextSize = 14

local ToggleBtn = Instance.new("TextButton")
ToggleBtn.Parent = Frame
ToggleBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
ToggleBtn.Position = UDim2.new(0, 10, 0, 40)
ToggleBtn.Size = UDim2.new(1, -20, 0, 30)
ToggleBtn.Text = "Kill Aura: TẮT"
ToggleBtn.TextColor3 = Color3.fromRGB(255, 100, 100)
ToggleBtn.Font = Enum.Font.SourceSansBold
ToggleBtn.TextSize = 13

local CloseBtn = Instance.new("TextButton")
CloseBtn.Parent = Frame
CloseBtn.BackgroundColor3 = Color3.fromRGB(100, 30, 30)
CloseBtn.Position = UDim2.new(0, 10, 0, 75)
CloseBtn.Size = UDim2.new(1, -20, 0, 25)
CloseBtn.Text = "Đóng Menu"
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.Font = Enum.Font.SourceSansBold
CloseBtn.TextSize = 12

-- Trạng thái Kill Aura
local auraState = false
ToggleBtn.MouseButton1Click:Connect(function()
    auraState = not auraState
    if auraState then
        ToggleBtn.Text = "Kill Aura: BẬT"
        ToggleBtn.TextColor3 = Color3.fromRGB(100, 255, 100)
    else
        ToggleBtn.Text = "Kill Aura: TẮT"
        ToggleBtn.TextColor3 = Color3.fromRGB(255, 100, 100)
    end
end)

CloseBtn.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

-- Logic Kill Aura gốc chạy ngầm
RunService.Heartbeat:Connect(function()
    if not auraState then return end
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
