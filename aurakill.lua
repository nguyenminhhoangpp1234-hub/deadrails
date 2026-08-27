-- ==============================================================================
-- DEAD RAILS | DIRECT AURA KILL FIX
-- ==============================================================================

local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")
local LocalPlayer = Players.LocalPlayer

if CoreGui:FindFirstChild("FixedAuraMenu") then
    CoreGui.FixedAuraMenu:Destroy()
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "FixedAuraMenu"
ScreenGui.Parent = CoreGui

local Frame = Instance.new("Frame")
Frame.Parent = ScreenGui
Frame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
Frame.Position = UDim2.new(0.5, -120, 0.5, -70)
Frame.Size = UDim2.new(0, 240, 0, 110)
Frame.Active = true
Frame.Draggable = true

local ToggleBtn = Instance.new("TextButton")
ToggleBtn.Parent = Frame
ToggleBtn.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
ToggleBtn.Position = UDim2.new(0, 10, 0, 15)
ToggleBtn.Size = UDim2.new(1, -20, 0, 45)
ToggleBtn.Text = "Kill Aura: TẮT"
ToggleBtn.TextColor3 = Color3.fromRGB(255, 80, 80)
ToggleBtn.Font = Enum.Font.SourceSansBold
ToggleBtn.TextSize = 16

local CloseBtn = Instance.new("TextButton")
CloseBtn.Parent = Frame
CloseBtn.BackgroundColor3 = Color3.fromRGB(120, 30, 30)
CloseBtn.Position = UDim2.new(0, 10, 0, 70)
CloseBtn.Size = UDim2.new(1, -20, 0, 30)
CloseBtn.Text = "Tắt Menu"
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.Font = Enum.Font.SourceSansBold
CloseBtn.TextSize = 13

local active = false
ToggleBtn.MouseButton1Click:Connect(function()
    active = not active
    if active then
        ToggleBtn.Text = "Kill Aura: BẬT"
        ToggleBtn.TextColor3 = Color3.fromRGB(80, 255, 80)
    else
        ToggleBtn.Text = "Kill Aura: TẮT"
        ToggleBtn.TextColor3 = Color3.fromRGB(255, 80, 80)
    end
end)

CloseBtn.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

RunService.Heartbeat:Connect(function()
    if not active then return end
    pcall(function()
        for _, v in pairs(Workspace:GetDescendants()) do
            if v:IsA("Humanoid") and v.Parent ~= LocalPlayer.Character then
                -- Kiểm tra xem có phải quái hay không dựa vào team/character
                local p = Players:GetPlayerFromCharacter(v.Parent)
                if not p and v.Health > 0 then
                    v.Health = 0
                end
            end
        end
    end)
end)
