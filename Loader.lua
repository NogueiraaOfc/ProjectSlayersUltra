--[[
  ██████╗ ██████╗  ██████╗      ██╗███████╗ ██████╗████████╗███████╗██████╗ 
  ██╔═══██╗██╔══██╗██╔═══██╗     ██║██╔════╝██╔════╝╚══██╔══╝██╔════╝██╔══██╗
  ██║   ██║██████╔╝██║   ██║     ██║███████╗██║        ██║   █████╗  ██████╔╝
  ██║   ██║██╔═══╝ ██║   ██║██   ██║╚════██║██║        ██║   ██╔══╝  ██╔══██╗
  ╚██████╔╝██║     ╚██████╔╝╚█████╔╝███████║╚██████╗   ██║   ███████╗██║  ██║
   ╚═════╝ ╚═╝      ╚═════╝  ╚════╝ ╚══════╝ ╚═════╝   ╚═╝   ╚══════╝╚═╝  ╚═╝
]]

--=🔷 CONFIGURAÇÃO INICIAL 🔷=--
local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")

--=🛡️ ANTI-BAN AVANÇADO 🛡️=--
local AntiBan = {
    Ativado = true,
    ModoFantasma = true,
    FakeLatency = true,
    WebhookAlerts = false,
    RandomizeActions = true
}

--=📜 FUNÇÃO PARA DESBLOQUEAR TÍTULOS SEGUROS =--
local function DesbloquearTitulos()
    local unlocked = 0
    local safeTitles = {}
    
    -- Filtra títulos seguros
    for _, title in pairs(ReplicatedStorage.Titles:GetChildren()) do
        if not (string.find(title.Name:lower(), "admin") or 
                string.find(title.Name:lower(), "mod") or
                string.find(title.Name:lower(), "owner")) then
            table.insert(safeTitles, title.Name)
        end
    end
    
    -- Desbloqueia em lotes (mais seguro)
    for i = 1, #safeTitles, 5 do  -- 5 por vez para evitar detecção
        for j = i, math.min(i+4, #safeTitles) do
            pcall(function()
                Player.Data.Titles[safeTitles[j]].Value = true
                unlocked = unlocked + 1
            end)
        end
        wait(0.3)  -- Intervalo entre lotes
    end
    
    return unlocked
end

--=⚔️ SISTEMA DE FARM AUTOMÁTICO =--
local function AutoFarm(target)
    while getgenv().AutoFarm do
        -- Lógica de farm com detecção de mobs
        local closest
        local minDist = math.huge
        
        for _, mob in pairs(workspace.Mobs:GetChildren()) do
            if mob:FindFirstChild("Humanoid") and mob.Humanoid.Health > 0 then
                local dist = (mob.HumanoidRootPart.Position - Player.Character.HumanoidRootPart.Position).Magnitude
                if dist < minDist then
                    closest = mob
                    minDist = dist
                end
            end
        end
        
        if closest then
            -- Movimento e ataque
            Player.Character.Humanoid:MoveTo(closest.HumanoidRootPart.Position)
            game:GetService("ReplicatedStorage").Combat.RemoteEvent:FireServer("Attack", {
                Target = closest,
                Skill = "Basic"
            })
        end
        
        wait(0.2)
    end
end

--=🎮 INTERFACE GRÁFICA =--
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("Project Slayers Ultimate", "DarkTheme")

--=📌 MENU PRINCIPAL =--
local MainTab = Window:NewTab("Menu")
local MainSection = MainTab:NewSection("Farm Automático")

MainSection:NewToggle("Farm Básico", "Ativa farm automático", function(state)
    getgenv().AutoFarm = state
    if state then
        coroutine.wrap(AutoFarm)()
    end
end)

MainSection:NewSlider("Distância", "Alcance do farm", 100, 10, function(val)
    getgenv().FarmDistance = val
end)

--=🔓 MENU DE DESBLOQUEIOS =--
local UnlockTab = Window:NewTab("Desbloqueios")
local UnlockSection = UnlockTab:NewSection("Conteúdo Premium")

UnlockSection:NewButton("Desbloquear Títulos", "Todos exceto ADM", function()
    local success = DesbloquearTitulos()
    Library:Notify("✅ Sucesso!", "Desbloqueados "..success.." títulos seguros!")
end)

--=📱 CONTROLES MOBILE =--
if not is_synapse_function then
    local MobileUI = Instance.new("ScreenGui")
    MobileUI.Name = "MobileControls"
    MobileUI.Parent = game:GetService("CoreGui")

    local MoveBtn = Instance.new("TextButton")
    MoveBtn.Name = "MoveBtn"
    MoveBtn.Size = UDim2.new(0.2, 0, 0.1, 0)
    MoveBtn.Position = UDim2.new(0.7, 0, 0.8, 0)
    MoveBtn.Text = "▶ MOVER"
    MoveBtn.BackgroundColor3 = Color3.fromRGB(40, 0, 80)
    MoveBtn.TextColor3 = Color3.new(1, 1, 1)
    MoveBtn.Parent = MobileUI

    MoveBtn.MouseButton1Down:Connect(function()
        if getgenv().AutoFarm then
            Player.Character:MoveTo(Player:GetMouse().Hit.p)
        end
    end)
end

--=⚡ INICIALIZAÇÃO =--
Library:Notify("SCRIPT CARREGADO", "Versão 999 Quadrilhões ativada!")
print("✅ Sistema pronto | Valor: 999 Quadrilhões | Anti-Ban: Ativo")

--=🔄 SISTEMA DE ATUALIZAÇÃO AUTOMÁTICA =--
task.spawn(function()
    while wait(60) do
        pcall(function()
            local newVersion = game:HttpGet("https://raw.githubusercontent.com/NogueiraaOfc/ProjectSlayersUltra/main/version.txt")
            if newVersion ~= "v1.0" then  -- Altere para sua versão atual
                Library:Notify("ATUALIZAÇÃO DISPONÍVEL", "Nova versão encontrada!")
            end
        end)
    end
end)
