-- Dead Rails Kill Aura - Ultra Compact Menu
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local UIListLayout = Instance.new("UIListLayout")
local ToggleBtn = Instance.new("TextButton")
local StatusLabel = Instance.new("TextLabel")

ScreenGui.Name = "KillAuraHub"
ScreenGui.Parent = game.CoreGui
ScreenGui.ResetOnSpawn = false

MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
MainFrame.BorderSizePixel = 0
MainFrame.Position = UDim2.new(0.05, 0, 0.25, 0)
MainFrame.Size = UDim2.new(0, 160, 0, 95)
MainFrame.Active = true
MainFrame.Draggable = true

UIListLayout.Parent = MainFrame
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Padding = UDim.new(0, 5)

ToggleBtn.Name = "ToggleBtn"
ToggleBtn.Parent = ScreenGui
ToggleBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
ToggleBtn.Position = UDim2.new(0.05, 0, 0.18, 0)
ToggleBtn.Size = UDim2.new(0, 90, 0, 28)
ToggleBtn.Font = Enum.Font.SourceSansBold
ToggleBtn.Text = "Menu Aura"
ToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleBtn.TextSize = 13
ToggleBtn.Active = true
ToggleBtn.Draggable = true

ToggleBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
end)

StatusLabel.Parent = MainFrame
StatusLabel.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
StatusLabel.Size = UDim2.new(0, 160, 0, 25)
StatusLabel.Font = Enum.Font.SourceSans
StatusLabel.Text = "Trạng thái: Tắt"
StatusLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
StatusLabel.TextSize = 13

local KillAuraBtn = Instance.new("TextButton")
KillAuraBtn.Parent = MainFrame
KillAuraBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
KillAuraBtn.Size = UDim2.new(0, 160, 0, 32)
KillAuraBtn.Font = Enum.Font.SourceSansBold
KillAuraBtn.Text = "Bật Kill Aura"
KillAuraBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
KillAuraBtn.TextSize = 13

local _G.KillAuraActive = false

KillAuraBtn.MouseButton1Click:Connect(function()
    _G.KillAuraActive = not _G.KillAuraActive
    if _G.KillAuraActive then
        KillAuraBtn.Text = "Tắt Kill Aura"
        KillAuraBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
        StatusLabel.Text = "Trạng thái: Đang bật"
        StatusLabel.TextColor3 = Color3.fromRGB(100, 255, 100)
    else
        KillAuraBtn.Text = "Bật Kill Aura"
        KillAuraBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        StatusLabel.Text = "Trạng thái: Tắt"
        StatusLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
    end
end)

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Workspace = game:GetService("Workspace")

task.spawn(function()
    while true do
        task.wait(0.1)
        if _G.KillAuraActive then
            pcall(function()
                for _, enemy in pairs(Workspace.Enemies:GetChildren()) do
                    if enemy:FindFirstChild("HumanoidRootPart") and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                        if (LocalPlayer.Character.HumanoidRootPart.Position - enemy.HumanoidRootPart.Position).Magnitude < 18 then
                            -- Gửi tín hiệu tấn công/đánh quái xung quanh
                            local tool = LocalPlayer.Character:FindFirstChildOfClass("Tool")
                            if tool then
                                tool:Activate()
                            end
                        end
                    end
                end
            end)
        end
    end
end)
