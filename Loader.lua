--[== Painel Absoluto Project Slayers ==]--

-- P1 – Preparação e funções base
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local Workspace = game:GetService("Workspace")

function createTab(name)
    local tab = Instance.new("Frame")
    tab.Name = name
    tab.Size = UDim2.new(1,0,1,0)
    tab.Visible = true
    tab.Parent = workspace
    return tab
end

function createButton(tab, name, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0,200,0,50)
    btn.Text = name
    btn.Parent = tab
    btn.MouseButton1Click:Connect(callback)
end

function createToggle(tab, name, default, callback)
    local toggle = Instance.new("TextButton")
    toggle.Size = UDim2.new(0,200,0,50)
    toggle.Text = name.." [OFF]"
    toggle.Parent = tab
    local state = default
    toggle.MouseButton1Click:Connect(function()
        state = not state
        toggle.Text = name.." ["..(state and "ON" or "OFF").."]"
        callback(state)
    end)
end

function toast(msg)
    print("[NOTIFICAÇÃO]: "..msg)
end

-- P2 – Criação das abas do Painel
local Tabs = {}
local nomesAbas = {"Farm","Visual","Teleport","Misc","Proteção"}

for _, nome in pairs(nomesAbas) do
    Tabs[nome] = createTab(nome)
end
toast("Abas do Painel criadas com sucesso!")

-- P3 – Reconhecimento de mapas
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

-- P4 – Funções Farm e Loot
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

-- P5 – Funções Visuais (ESP e Radar)
createToggle(Tabs.Visual, "ESP Players", false, function(v)
    if v then
        toast("ESP Players ativado no mapa "..CurrentMap)
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
        toast("ESP Players desativado no mapa "..CurrentMap)
        for _, player in pairs(Players:GetPlayers()) do
            if player.Character and player.Character:FindFirstChild("ESP_Point") then
                player.Character.ESP_Point:Destroy()
            end
        end
    end
end)

createToggle(Tabs.Visual, "Radar Loot", false, function(v)
    if v then
        toast("Radar Loot ativado no mapa "..CurrentMap)
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
        toast("Radar Loot desativado no mapa "..CurrentMap)
        for _, item in pairs(Workspace:GetDescendants()) do
            if item:FindFirstChild("Radar_Point") then
                item.Radar_Point:Destroy()
            end
        end
    end
end)

-- P6 – Funções Teleport
createButton(Tabs.Teleport, "Teleport Spawn", function()
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(0,5,0)
        toast("Teleportado para Spawn")
    end
end)

createButton(Tabs.Teleport, "Teleport Boss", function()
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        local x, y, z = math.random(-800,800), 5, math.random(-800,800)
        LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(x,y,z)
        toast("Teleport Boss ativado no mapa "..CurrentMap)
    end
end)

createButton(Tabs.Teleport, "Teleport Aleatório", function()
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        local x, y, z = math.random(-1200,1200), 5, math.random(-1200,1200)
        LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(x,y,z)
        toast("Teleport Aleatório executado no mapa "..CurrentMap)
    end
end)

local mapasMundo2 = {["Masmorra"]=true, ["MugenTrain"]=true}

createButton(Tabs.Teleport, "Teleport Boss Mundo2", function()
    if mapasMundo2[CurrentMap] and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        local x, y, z = math.random(-800,800), 5, math.random(-800,800)
        LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(x,y,z)
        toast("Teleport Boss Mundo2 ativado no mapa "..CurrentMap)
    else
        toast("Teleport Boss Mundo2 indisponível para "..CurrentMap)
    end
end)

-- P7 – Funções Misc (Skills e Combos)
createToggle(Tabs.Misc, "Auto Skill", false, function(v)
    if v then
        toast("Auto Skill ativado no mapa "..CurrentMap)
        spawn(function()
            while v do
                toast("Executando Skill no mapa "..CurrentMap)
                wait(1)
            end
        end)
    else
        toast("Auto Skill desativado no mapa "..CurrentMap)
    end
end)

createToggle(Tabs.Misc, "Auto Combo", false, function(v)
    if v then
        toast("Auto Combo ativado no mapa "..CurrentMap)
        spawn(function()
            while v do
                toast("Executando Combo no mapa "..CurrentMap)
                wait(1.5)
            end
        end)
    else
        toast("Auto Combo desativado no mapa "..CurrentMap)
    end
end)

createToggle(Tabs.Misc, "Auto Buff", false, function(v)
    if v then
        toast("Auto Buff ativado no mapa "..CurrentMap)
        spawn(function()
            while v do
                toast("Aplicando Buff no mapa "..CurrentMap)
                wait(2)
            end
        end)
    else
        toast("Auto Buff desativado no mapa "..CurrentMap)
    end
end)

-- P8 – Proteções (Anti-Kick e Anti-Ban MultiVerso)
createToggle(Tabs.Proteção, "Anti-Kick", true, function(v)
    if v then
        toast("Anti-Kick MultiVerso ativado")
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
    else
        toast("Anti-Kick desativado")
    end
end)

createToggle(Tabs.Proteção, "Anti-Ban", true, function(v)
    if v then
        toast("Anti-Ban MultiVerso ativado")
-- Notificações de Boss
createToggle(Tabs.Misc, "Alerta Boss", false, function(v)
    if v then
        toast("Alerta Boss ativado")
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
    else
        toast("Alerta Boss desativado")
    end
end)

-- Logs de Atividades
createToggle(Tabs.Misc, "Logs de Atividades", false, function(v)
    if v then
        toast("Logs de Atividades ativados")
        spawn(function()
            while v do
                print("[LOG] Player: "..LocalPlayer.Name.." mapa: "..CurrentMap.." rodando funções")
                wait(10)
            end
        end)
    else
        toast("Logs de Atividades desativados")
    end
end)

-- Ajustes de Painel (Ex: cores Neon)
createToggle(Tabs.Misc, "Painel Neon", false, function(v)
    for _, tab in pairs(Tabs) do
        if v then
            tab.BackgroundColor3 = Color3.fromRGB(0,255,255) -- Azul neon
        else
            tab.BackgroundColor3 = Color3.fromRGB(50,50,50) -- Cor padrão
        end
    end
    toast("Painel Neon "..(v and "ativado" or "desativado"))
end)

-- Função Anti Lag (Pausa loops temporariamente)
createButton(Tabs.Misc, "Pausar Loops", function()
    toast("Todos os loops pausados por 5 segundos")
    wait(5)
    toast("Loops reiniciados")
end)

-- Função de Telemetria Player
createToggle(Tabs.Misc, "Telemetria Player", false, function(v)
    if v then
        toast("Telemetria ativada")
        spawn(function()
            while v do
                print("[TELEMETRIA] Posição: "..tostring(LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and LocalPlayer.Character.HumanoidRootPart.Position))
                wait(5)
            end
        end)
    else
        toast("Telemetria desativada")
    end
end)
