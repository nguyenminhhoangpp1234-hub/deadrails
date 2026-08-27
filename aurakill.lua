-- ==============================================================================
-- DEAD RAILS SCRIPT - RINGTA HUB MASTER SCRIPT (CHUẨN FORM GIAO DIỆN)
-- ==============================================================================

local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")
local Camera = Workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer

-- CẤU HÌNH TOÀN DIỆN CHO CÁC TÍNH NĂNG TRÊN MENU
getgenv().RingtaMasterConfig = {
    AutoBringEnabled = false,
    SelectedCategory = "All", -- Nhóm vật phẩm: Weapons, Ammo, Medical, Resources, Scrap, Valuables, Bonds, All
    NoClip = false,
    FullBright = false,
    ESP = {
        Aliens = { Enabled = false, Color = Color3.fromRGB(0, 150, 255) },       -- Aliens ESP
        Valuables = { Enabled = false, Color = Color3.fromRGB(255, 165, 0) },    -- Valuables ESP
        Weapons = { Enabled = false, Color = Color3.fromRGB(255, 50, 50) },      -- Weapons ESP
        Special = { Enabled = false, Color = Color3.fromRGB(255, 255, 0) },      -- Special ESP
        Armor = { Enabled = false, Color = Color3.fromRGB(50, 205, 50) },        -- Armor ESP
        Entities = { Enabled = false, Color = Color3.fromRGB(0, 255, 255) },     -- Entities ESP
        Junk = { Enabled = false, Color = Color3.fromRGB(128, 128, 128) },       -- Junk ESP
        Bank_combo = { Enabled = false, Color = Color3.fromRGB(255, 20, 147) }   -- Bank_combo ESP
    }
}

-- Từ khóa cho Tab [Bring Items] (Mang Vật Phẩm)
local ItemKeywordsMap = {
    Weapons = {"revolver", "rifle", "shotgun", "maxim", "mauser", "sword", "jade"},
    Ammo = {"ammo", "rounds", "shells"},
    Medical = {"bandage", "oil", "heal", "tonic", "whiskey", "snake_oil"},
    Resources = {"coal", "wood", "metal", "wire", "torch", "lantern"},
    Scrap = {"scrap", "parts", "pipe", "junk", "barrel"},
    Valuables = {"gold", "silver", "statue", "painting", "cup", "watch", "strange"},
    Bonds = {"bond", "vault", "banknote"}
}

-- Từ khóa cho Tab [ESP] (Nhìn Xuyên Tường)
local ESPKeywordsMap = {
    Aliens = {"alien", "zombie", "mob", "boss"},
    Valuables = {"gold", "silver", "statue", "painting", "strange", "valuable"},
    Weapons = {"revolver", "rifle", "shotgun", "sword", "jade"},
    Special = {"snake_oil", "tonic", "whiskey", "oil"},
    Armor = {"armor", "helmet", "chest", "shield"},
    Entities = {"brain_jar", "npc", "entity"},
    Junk = {"barrel", "scrap", "pipe", "tools"},
    Bank_combo = {"bank_combo", "vault_code", "safe", "code"}
}

-- 1. [Bring Items] Tự động hút vật phẩm & Trái phiếu (Bond) về người
task.spawn(function()
    while true do
        task.wait(0.2)
        pcall(function()
            if not getgenv().RingtaMasterConfig.AutoBringEnabled then return end
            local char = LocalPlayer.Character
            if not char or not char:FindFirstChild("HumanoidRootPart") then return end
            local rootPos = char.HumanoidRootPart.CFrame

            local activeCat = getgenv().RingtaMasterConfig.SelectedCategory
            local targetKeywords = {}

            if activeCat == "All" then
                for _, catList in pairs(ItemKeywordsMap) do
                    for _, kw in ipairs(catList) do table.insert(targetKeywords, kw) end
                end
            else
                if ItemKeywordsMap[activeCat] then
                    targetKeywords = ItemKeywordsMap[activeCat]
                end
            end

            for _, obj in ipairs(Workspace:GetDescendants()) do
                if obj:IsA("Model") or obj:IsA("Part") or obj:IsA("ProximityPrompt") then
                    local name = obj.Name:lower()
                    local match = false

                    for _, kw in ipairs(targetKeywords) do
                        if name:find(kw) then
                            match = true
                            break
                        end
                    end

                    if match then
                        if obj:IsA("ProximityPrompt") then
                            fireproximityprompt(obj)
                        else
                            local part = obj:IsA("Model") and (obj.PrimaryPart or obj:FindFirstChildWhichIsA("BasePart")) or obj
                            if part and (part.Position - char.HumanoidRootPart.Position).Magnitude < 150 then
                                part.CFrame = rootPos + (rootPos.LookVector * 2) + Vector3.new(0, 1, 0)
                                local prompt = obj:FindFirstChildWhichIsA("ProximityPrompt", true)
                                if prompt then fireproximityprompt(prompt) end
                            end
                        end
                    end
                end
            end
        end)
    end
end)

-- 2. [Teleport / Towns] Dịch chuyển chính xác đến Tiền đồn (1-8) và công trình đặc biệt
getgenv().RingtaTeleportToLocation = function(locationKey)
    pcall(function()
        local char = LocalPlayer.Character
        if not char or not char:FindFirstChild("HumanoidRootPart") then return end
        local rootPart = char.HumanoidRootPart
        local targetCFrame = nil

        local query = tostring(locationKey):lower()
        local outpostNum = query:match("%d+")

        for _, obj in ipairs(Workspace:GetDescendants()) do
            if obj:IsA("Model") or obj:IsA("Part") then
                local name = obj.Name:lower()
                local matched = false

                if outpostNum then
                    if (name:find("outpost") or name:find("station") or name:find("town") or name:find("checkpoint")) and name:find(outpostNum) then
                        matched = true
                    end
                else
                    if name:find(query) or name:find("tesla") or name:find("castle") or name:find("prison") or name:find("fort") then
                        matched = true
                    end
                end

                if matched then
                    local part = obj:IsA("Model") and (obj.PrimaryPart or obj:FindFirstChildWhichIsA("BasePart")) or obj
                    if part then
                        targetCFrame = part.CFrame + Vector3.new(0, 5, 0)
                        break
                    end
                end
            end
        end

        if targetCFrame then
            rootPart.CFrame = targetCFrame
        else
            rootPart.CFrame = rootPart.CFrame + Vector3.new(0, 5, 10)
        end
    end)
end

-- 3. [Other Features] Xuyên tường (NoClip) & Sáng toàn màn hình (FullBright)
RunService.Stepped:Connect(function()
    if getgenv().RingtaMasterConfig.NoClip then
        pcall(function()
            local char = LocalPlayer.Character
            if char then
                for _, part in ipairs(char:GetDescendants()) do
                    if part:IsA("BasePart") then part.CanCollide = false end
                end
            end
        end)
    end
end)

task.spawn(function()
    while task.wait(1) do
        if getgenv().RingtaMasterConfig.FullBright then
            Lighting.Brightness = 2
            Lighting.ClockTime = 14
            Lighting.GlobalShadows = false
        end
    end
end)

-- 4. [ESP] Hệ thống Nhìn Xuyên Tường Đa Danh Mục (Mượt mà, nhẹ máy)
local ActiveESPDrawings = {}

local function ClearAllESP()
    for _, drawing in pairs(ActiveESPDrawings) do
        if drawing then
            pcall(function() drawing:Remove() end)
        end
    end
    ActiveESPDrawings = {}
end

RunService.RenderStepped:Connect(function()
    pcall(function()
        ClearAllESP()

        local char = LocalPlayer.Character
        if not char or not char:FindFirstChild("HumanoidRootPart") then return end
        local rootPos = char.HumanoidRootPart.Position

        for _, obj in ipairs(Workspace:GetDescendants()) do
            if obj:IsA("Model") or obj:IsA("Part") then
                local name = obj.Name:lower()
                local matchedCategory = nil
                local targetColor = Color3.fromRGB(255, 255, 255)

                for catName, config in pairs(getgenv().RingtaMasterConfig.ESP) do
                    if config.Enabled then
                        local keywords = ESPKeywordsMap[catName] or {}
                        for _, kw in ipairs(keywords) do
                            if name:find(kw) then
                                matchedCategory = catName
                                targetColor = config.Color
                                break
                            end
                        end
                    end
                    if matchedCategory then break end
                end

                if matchedCategory then
                    local part = obj:IsA("Model") and (obj.PrimaryPart or obj:FindFirstChildWhichIsA("BasePart")) or obj
                    if part then
                        local distance = (part.Position - rootPos).Magnitude
                        if distance < 400 then
                            local screenPos, onScreen = Camera:WorldToViewportPoint(part.Position + Vector3.new(0, 1.5, 0))
                            if onScreen then
                                local text = Drawing.new("Text")
                                text.Visible = true
                                text.Center = true
                                text.Outline = true
                                text.Font = 2
                                text.Size = 13
                                text.Text = "[" .. string.upper(matchedCategory) .. "] " .. obj.Name .. " (" .. math.floor(distance) .. "m)"
                                text.Color = targetColor
                                text.Position = Vector2.new(screenPos.X, screenPos.Y)
                                
                                table.insert(ActiveESPDrawings, text)
                            end
                        end
                    end
                end
            end
        end
    end)
end)

print("🔥 RINGTA SCRIPTS MASTER LOADED 100% SUCCESS!")
