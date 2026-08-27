-- Dead Rails Kill Aura Hub (Always Visible - Delta Optimized)
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local UIListLayout = Instance.new("UIListLayout")
local TopBar = Instance.new("Frame")
local TitleLabel = Instance.new("TextLabel")
local StatusLabel = Instance.new("TextLabel")
local KillAuraBtn = Instance.new("TextButton")

ScreenGui.Name = "KillAuraHub"
ScreenGui.Parent = game.CoreGui
ScreenGui.ResetOnSpawn = false

MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
MainFrame.BorderSizePixel = 0
MainFrame.Position = UDim2.new(0.05, 0, 0.2, 0)
MainFrame.Size = UDim2.new(0, 160, 0, 95)
MainFrame.Visible = true
MainFrame.Active = true
MainFrame.Draggable = true

TopBar.Name = "TopBar"
TopBar.Parent = MainFrame
TopBar.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
TopBar.BorderSizePixel = 0
TopBar.Size = UDim2.new(0, 160, 0, 26)

TitleLabel.Name = "TitleLabel"
TitleLabel.Parent = TopBar
TitleLabel.BackgroundTransparency = 1
TitleLabel.Position = UDim2.new(0, 8, 0, 0)
TitleLabel.Size = UDim2.new(0, 144, 0, 26)
TitleLabel.Font = Enum.Font.SourceSansBold
TitleLabel.Text = "Dead Rails Kill Aura"
TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleLabel.TextSize = 13
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left

UIListLayout.Parent = MainFrame
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Padding = UDim.new(0, 4)

StatusLabel.Parent = MainFrame
StatusLabel.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
StatusLabel.BorderSizePixel = 0
StatusLabel.Size = UDim2.new(0, 160, 0, 26)
StatusLabel.Font = Enum.Font.SourceSans
StatusLabel.Text = "Trạng thái: Tắt"
StatusLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
StatusLabel.TextSize = 13

KillAuraBtn.Parent = MainFrame
KillAuraBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
KillAuraBtn.BorderSizePixel = 0
KillAuraBtn.Size = UDim2.new(0, 160, 0, 32)
KillAuraBtn.Font = Enum.Font.SourceSansBold
KillAuraBtn.Text = "Bật Kill Aura"
KillAuraBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
KillAuraBtn.TextSize = 13

local KillAuraActive = false

KillAuraBtn.MouseButton1Click:Connect(function()
    KillAuraActive = not KillAuraActive
    if KillAuraActive then
        KillAuraBtn.Text = "Tắt Kill Aura"
        KillAuraBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
        StatusLabel.Text = "Trạng thái: Đang bật"
        StatusLabel.TextColor3 = Color3.fromRGB(100, 255, 100)
    else
        KillAuraBtn.Text = "Bật Kill Aura"
        KillAuraBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
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
        if KillAuraActive then
            pcall(function()
                if Workspace:FindFirstChild("Enemies") then
                    for _, enemy in pairs(Workspace.Enemies:GetChildren()) do
                        if enemy:FindFirstChild("HumanoidRootPart") and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                            if (LocalPlayer.Character.HumanoidRootPart.Position - enemy.HumanoidRootPart.Position).Magnitude < 18 then
                                local tool = LocalPlayer.Character:FindFirstChildOfClass("Tool")
                                if tool then
                                    tool:Activate()
                                end
                            end
                        end
                    end
                end
            end)
        end
    end
end)
