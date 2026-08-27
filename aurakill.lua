local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

local lastTick = 0

local function RunAuraKill()
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
end

RunService.Heartbeat:Connect(function()
    local currentTick = tick()
    if currentTick - lastTick < 0.05 then return end
    lastTick = currentTick
    RunAuraKill()
end)
