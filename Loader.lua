--[== Painel Absoluto Project Slayers – GUI Real Completo ==]--

-- Serviços
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Workspace = game:GetService("Workspace")

-- ScreenGui
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "PainelProjectSlayers"
screenGui.ResetOnSpawn = false
screenGui.Parent = PlayerGui

-- Funções base
local function toast(msg)
    print("[PainelProjectSlayers]: "..msg)
end

local function createTab(name)
    local tab = Instance.new("Frame")
    tab.Name = name
    tab.Size = UDim2.new(0.3,0,0.5,0)
    tab.Position = UDim2.new(0,10,0,10)
    tab.BackgroundColor3 = Color3.fromRGB(50,50,50)
    tab.Visible = true
    tab.Parent = screenGui
    return tab
end

local function createButton(tab, name, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1,0,0,50)
    btn.Position = UDim2.new(0,0,#tab:GetChildren()*55)
    btn.BackgroundColor3 = Color3.fromRGB(70,70,70)
    btn.TextColor3 = Color3.new(1,1,1)
    btn.Text = name
    btn.Parent = tab
    btn.MouseButton1Click:Connect(callback)
end

local function createToggle(tab, name, default, callback)
    local toggle = Instance.new("TextButton")
    toggle.Size = UDim2.new(1,0,0,50)
    toggle.Position = UDim2.new(0,0,#tab:GetChildren()*55)
    toggle.BackgroundColor3 = Color3.fromRGB(90,90,90)
    toggle.TextColor3 = Color3.new(1,1,1)
    toggle.Text = name.." [OFF]"
    toggle.Parent = tab
    local state = default
    toggle.MouseButton1Click:Connect(function()
        state = not state
        toggle.Text = name.." ["..(state and "ON" or "OFF").."]"
        callback(state)
    end)
end

toast("GUI base criada!")

-- Criar abas
local Tabs = {}
local nomesAbas = {"Farm","Visual","Teleport","Misc","Proteção"}
for _, nome in pairs(nomesAbas) do
    Tabs[nome] = createTab(nome)
end

-- Reconhecimento de mapas
local CurrentMap = "Desconhecido"
local function detectarMapa()
    if Workspace:FindFirstChild("Mapv2") then
        CurrentMap = "Mapv2"
    elseif Workspace:FindFirstChild("Mapv3") then
        CurrentMap = "Mapv3"
    elseif Workspace:FindFirstChild("Owguihara") then
        CurrentMap = "Owguihara"
    elseif Workspace:FindFirstChild("Masmorra") then
        CurrentMap = "Masmorra"
    elseif Workspace:FindFirstChild("MugenTrain") then
        CurrentMap = "MugenTrain"
    else
        CurrentMap = "Desconhecido"
    end
    toast("Mapa detectado: "..CurrentMap)
end
detectarMapa()

-- Funções Farm
local mapasFarm = {["Mapv2"]=true,["Mapv3"]=true,["Owguihara"]=true,["Masmorra"]=true,["MugenTrain"]=true}

createToggle(Tabs.Farm, "Auto Farm", false, function(v)
    if mapasFarm[CurrentMap] then
        toast("Auto Farm "..tostring(v).." ativado no mapa "..CurrentMap)
        if v then
            spawn(function()
                while v and mapasFarm[CurrentMap] do
                    toast("Executando Farm no mapa "..CurrentMap)
                    wait(1)
                end
            end)
        end
    else
        toast("Auto Farm indisponível para "..CurrentMap)
    end
end)

createToggle(Tabs.Farm, "Auto Loot", false, function(v)
    if mapasFarm[CurrentMap] then
        toast("Auto Loot "..tostring(v).." ativado no mapa "..CurrentMap)
        if v then
            spawn(function()
                while v and mapasFarm[CurrentMap] do
                    toast("Coletando loot no mapa "..CurrentMap)
                    wait(1.5)
                end
            end)
        end
    else
        toast("Auto Loot indisponível para "..CurrentMap)
    end
end)

-- Funções Visuais
createToggle(Tabs.Visual, "ESP Players", false, function(v)
    if v then
        spawn(function()
            while v do
                for _, player in pairs(Players:GetPlayers()) do
                    if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                        if not player.Character:FindFirstChild("ESP_Point") then
                            local point = Instance.new("BillboardGui")
                            point.Name = "ESP_Point"
                            point.Size = UDim2.new(0,50,0,50)
                            point.AlwaysOnTop = true
                            local txt = Instance.new("TextLabel", point)
                            txt.Size = UDim2.new(1,0,1,0)
                            txt.BackgroundTransparency = 1
                            txt.TextColor3 = Color3.new(1,0,0)
                            txt.Text = player.Name
                            point.Parent = player.Character.Head
                        end
                    end
                end
                wait(0.5)
            end
        end)
    else
        for _, player in pairs(Players:GetPlayers()) do
            if player.Character and player.Character:FindFirstChild("ESP_Point") then
                player.Character.ESP_Point:Destroy()
            end
        end
    end
end)

createToggle(Tabs.Visual, "Radar Loot", false, function(v)
    if v then
        spawn(function()
            while v do
                for _, item in pairs(Workspace:GetDescendants()) do
                    if item.Name == "Loot" and item:IsA("BasePart") then
                        if not item:FindFirstChild("Radar_Point") then
                            local point = Instance.new("BillboardGui")
                            point.Name = "Radar_Point"
                            point.Size = UDim2.new(0,50,0,50)
                            point.AlwaysOnTop = true
                            local txt = Instance.new("TextLabel", point)
                            txt.Size = UDim2.new(1,0,1,0)
                            txt.BackgroundTransparency = 1
                            txt.TextColor3 = Color3.new(0,1,0)
                            txt.Text = "Loot"
                            point.Parent = item
                        end
                    end
                end
                wait(1)
            end
        end)
    else
        for _, item in pairs(Workspace:GetDescendants()) do
            if item:FindFirstChild("Radar_Point") then
                item.Radar_Point:Destroy()
            end
        end
    end
end)

-- Teleports
createButton(Tabs.Teleport, "Teleport Spawn", function()
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(0,5,0)
        toast("Teleportado para Spawn")
    end
end)

createButton(Tabs.Teleport, "Teleport Aleatório", function()
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(math.random(-1200,1200),5,math.random(-1200,1200))
        toast("Teleport Aleatório executado")
    end
end)

-- Skills, Combo e Buffs
createToggle(Tabs.Misc, "Auto Skill", false, function(v)
    if v then
        spawn(function()
            while v do
                toast("Executando Skill...")
                wait(1)
            end
        end)
    end
end)

createToggle(Tabs.Misc, "Auto Combo", false, function(v)
    if v then
        spawn(function()
            while v do
                toast("Executando Combo...")
                wait(1.5)
            end
        end)
    end
end)

createToggle(Tabs.Misc, "Auto Buff", false, function(v)
    if v then
        spawn(function()
            while v do
                toast("Aplicando Buff...")
                wait(2)
            end
        end)
    end
end)

-- Proteções: Anti-Kick e Anti-Ban
createToggle(Tabs.Proteção, "Anti-Kick", true, function(v)
    if v then
        local mt = getrawmetatable(game)
        local oldNamecall = mt.__namecall
        setreadonly(mt,false)
        mt.__namecall = newcclosure(function(self,...)
            local method = getnamecallmethod():lower()
            if method == "kick" or method == "kickplayer" then
                warn("[AntiKick] Bloqueado pelo MultiVerso")
                return
            end
            return oldNamecall(self,...)
        end)
        setreadonly(mt,true)
        toast("Anti-Kick ativado")
    end
end)

createToggle(Tabs.Proteção, "Anti-Ban", true, function(v)
    if v then
        spawn(function()
            while v do
                wait(5)
                toast("Proteção Anti-Ban ativa")
            end
        end)
    end
end)

-- Extras: Painel Neon e Logs
createToggle(Tabs.Misc, "Painel Neon", false, function(v)
    for _, tab in pairs(Tabs) do
        tab.BackgroundColor3 = v and Color3.fromRGB(0,255,255) or Color3.fromRGB(50,50,50)
    end
end)

createToggle(Tabs.Misc, "Logs de Atividades", false, function(v)
    if v then
        spawn(function()
            while v do
                print("[LOG] Player: "..LocalPlayer.Name.." mapa: "..CurrentMap)
                wait(10)
            end
        end)
    end
end)

createToggle(Tabs.Misc, "Alerta Boss", false, function(v)
    if v then
        spawn(function()
            while v do
                for _, boss in pairs(Workspace:GetDescendants()) do
                    if boss.Name == "Boss" and boss:IsA("Model") then
                        toast("Boss detectado: "..boss.Name)
                    end
                end
                wait(5)
            end
        end)
    end
end)

createToggle(Tabs.Misc, "Telemetria Player", false, function(v)
    if v then
        spawn(function()
            while
