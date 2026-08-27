-- =================================================
-- DEAD RAILS AURA KILL MENU SCRIPT
-- =================================================

local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")
local LocalPlayer = Players.LocalPlayer

-- Xóa menu cũ nếu có để tránh bị trùng
if CoreGui:FindFirstChild("DeadRailsAuraMenu") then
    CoreGui.DeadRailsAuraMenu:Destroy()
end

-- Tạo giao diện Menu đơn giản, dễ nhìn trên Delta
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "DeadRailsAuraMenu"
ScreenGui.Parent = CoreGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
MainFrame.BorderSizePixel = 0
MainFrame.Position = UDim2.new(0.1, 0, 0.1, 0)
MainFrame.Size = UDim2.new(0, 220, 0, 130)
MainFrame.Active = true
MainFrame.Draggable = true -- Có thể giữ và kéo menu đi quanh màn hình

local Title = Instance.new("TextLabel")
Title.Parent = MainFrame
Title.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
Title.BorderSizePixel = 0
Title.Size = UDim2.new(1, 0, 0, 35)
Title.Font = Enum.Font.SourceSansBold
Title.Text = "Dead Rails - Aura Kill"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 16

local ToggleButton = Instance.new("TextButton")
ToggleButton.Parent = MainFrame
ToggleButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
ToggleButton.Position = UDim2.new(0.1, 0, 0.45, 0)
ToggleButton.Size = UDim2.new(0, 176, 0, 45)
ToggleButton.Font = Enum.Font.SourceSansBold
ToggleButton.Text = "Aura Kill: OFF"
ToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleButton.TextSize = 16

local auraEnabled = false

-- Bấm vào nút để Bật/Tắt
ToggleButton.MouseButton1Click:Connect(function()
    auraEnabled = not auraEnabled
    if auraEnabled then
        ToggleButton.Text = "Aura Kill: ON"
        ToggleButton.BackgroundColor3 = Color3.fromRGB(50, 200, 50)
    else
        ToggleButton.Text = "Aura Kill: OFF"
        ToggleButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
    end
end)

-- Vòng lặp chạy tính năng Aura Kill
local lastTick = 0
RunService.Heartbeat:Connect(function()
    if not auraEnabled then return end
    local currentTick = tick()
    if currentTick - lastTick < 0.05 then return end
    lastTick = currentTick

    pcall(function()
        local char = LocalPlayer.Character
        if not char then return end

        for _, v in pairs(Workspace:GetDescendants()) do
            if v:IsA("Model") and v ~= char then
                if not Players:GetPlayerFromCharacter(v) then
                    local nameL = v.Name:lower()
                    if not (nameL:find("player") or nameL:find("survivor") or nameL:find("merchant") or nameL:find("ally")) then
                        local hum = v:FindFirstChildOfClass("Humanoid")
                        local part = v:FindFirstChild("HumanoidRootPart") or v.PrimaryPart or v:FindFirstChild("Torso")
                        
                        if hum then
                            pcall(function()
                                hum.WalkSpeed = 0
                                hum.JumpPower = 0
                                hum:SetStateEnabled(Enum.HumanoidStateType.Running, false)
                                hum:SetStateEnabled(Enum.HumanoidStateType.Jumping, false)
                                hum:ChangeState(Enum.HumanoidStateType.Physics)
                            end)

                            hum.Health = -999999
                            hum.MaxHealth = 0

                            if part then
                                part.Velocity = Vector3.new(0, 0, 0)
                                part.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
                            end
                        end
                    end
                end
            end
        end
    end)
end)
