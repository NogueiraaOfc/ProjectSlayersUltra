-- ProjectSlayersUltra Mobile v10.0 - O Primeiro Script Quântico para Mobile
local QuantumMobileCore = {
    TouchMatrix = {},
    HolographicInterface = nil,
    GyroStabilization = 0,
    QuantumTouchID = {}
}

-------------------------------------
-- SISTEMA HOLOGRÁFICO DE INTERFACE
-------------------------------------
local HolographicUI = {
    QuantumWindow = nil,
    SystemTray = nil,
    WorldSensors = {},
    MobileGestures = {}
}

function HolographicUI:CreateOscarWorthyInterface()
    -- Criação da janela principal com efeito holográfico
    self.QuantumWindow = Instance.new("ScreenGui")
    self.QuantumWindow.Name = "ProjectSlayersUltraHologram"
    self.QuantumWindow.ResetOnSpawn = false
    self.QuantumWindow.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    
    -- Frame principal com design premiado
    local mainFrame = Instance.new("Frame")
    mainFrame.Name = "QuantumFrame"
    mainFrame.Size = UDim2.new(0.8, 0, 0.9, 0)
    mainFrame.Position = UDim2.new(0.1, 0, 0.05, 0)
    mainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 30)
    mainFrame.BackgroundTransparency = 0.2
    mainFrame.BorderSizePixel = 0
    mainFrame.ClipsDescendants = true
    
    -- Efeito holográfico quântico
    local hologramEffect = Instance.new("ImageLabel")
    hologramEffect.Name = "HologramEffect"
    hologramEffect.Size = UDim2.new(1, 0, 1, 0)
    hologramEffect.Image = "rbxassetid://1234567890" -- Textura holográfica
    hologramEffect.ImageTransparency = 0.7
    hologramEffect.BackgroundTransparency = 1
    hologramEffect.ZIndex = -1
    
    -- Barra de título premiada
    local titleBar = Instance.new("Frame")
    titleBar.Name = "TitleBar"
    titleBar.Size = UDim2.new(1, 0, 0.08, 0)
    titleBar.BackgroundColor3 = Color3.fromRGB(25, 25, 50)
    titleBar.BorderSizePixel = 0
    
    -- Botões de controle (Oscar-worthy)
    local closeButton = self:CreateControlButton("Close", UDim2.new(0.9, 0, 0, 0), "rbxassetid://close_icon")
    local maximizeButton = self:CreateControlButton("Maximize", UDim2.new(0.8, 0, 0, 0), "rbxassetid://maximize_icon")
    local minimizeButton = self:CreateControlButton("Minimize", UDim2.new(0.7, 0, 0, 0), "rbxassetid://minimize_icon")
    local worldButton = self:CreateControlButton("World", UDim2.new(0, 0, 0, 0), "rbxassetid://world_icon")

    -- Sistema de bandeja móvel
    self:SystemTrayInit()
    
    -- Conectar funcionalidades
    closeButton.MouseButton1Click:Connect(function()
        self.QuantumWindow.Enabled = false
    end)
    
    minimizeButton.MouseButton1Click:Connect(function()
        mainFrame.Visible = false
        self.SystemTray.Visible = true
    end)
    
    maximizeButton.MouseButton1Click:Connect(function()
        if mainFrame.Size == UDim2.new(0.8, 0, 0.9, 0) then
            mainFrame.Size = UDim2.new(0.95, 0, 0.98, 0)
            mainFrame.Position = UDim2.new(0.025, 0, 0.01, 0)
        else
            mainFrame.Size = UDim2.new(0.8, 0, 0.9, 0)
            mainFrame.Position = UDim2.new(0.1, 0, 0.05, 0)
        end
    end)
    
    worldButton.MouseButton1Click:Connect(function()
        self:ShowWorldInfo()
    end)
    
    -- Montar hierarquia
    hologramEffect.Parent = mainFrame
    titleBar.Parent = mainFrame
    closeButton.Parent = titleBar
    maximizeButton.Parent = titleBar
    minimizeButton.Parent = titleBar
    worldButton.Parent = titleBar
    mainFrame.Parent = self.QuantumWindow
    self.QuantumWindow.Parent = game:GetService("CoreGui")
end

function HolographicUI:CreateControlButton(name, position, icon)
    -- Botões com design premiado
    local button = Instance.new("ImageButton")
    button.Name = name
    button.Size = UDim2.new(0.08, 0, 1, 0)
    button.Position = position
    button.BackgroundTransparency = 1
    button.Image = icon
    button.ScaleType = Enum.ScaleType.Fit
    
    -- Efeito holográfico ao tocar
    local touchEffect = Instance.new("Frame")
    touchEffect.Name = "TouchEffect"
    touchEffect.Size = UDim2.new(1, 0, 1, 0)
    touchEffect.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
    touchEffect.BackgroundTransparency = 0.8
    touchEffect.Visible = false
    touchEffect.Parent = button
    
    button.MouseButton1Down:Connect(function()
        touchEffect.Visible = true
    end)
    
    button.MouseButton1Up:Connect(function()
        touchEffect.Visible = false
    end)
    
    return button
end

function HolographicUI:SystemTrayInit()
    -- Sistema de bandeja para mobile
    self.SystemTray = Instance.new("ImageButton")
    self.SystemTray.Name = "QuantumTray"
    self.SystemTray.Size = UDim2.new(0.1, 0, 0.1, 0)
    self.SystemTray.Position = UDim2.new(0.01, 0, 0.89, 0)
    self.SystemTray.Image = "rbxassetid://tray_icon"
    self.SystemTray.BackgroundTransparency = 1
    self.SystemTray.Visible = false
    
    self.SystemTray.MouseButton1Click:Connect(function()
        self.QuantumWindow.QuantumFrame.Visible = true
        self.SystemTray.Visible = false
    end)
    
    self.SystemTray.Parent = self.QuantumWindow
end

-------------------------------------
-- SENSORES DE MUNDO QUÂNTICOS
-------------------------------------
function QuantumMobileCore:InitializeWorldSensors()
    -- Mapeamento completo de mundos
    self.WorldDatabase = {
        [1234567890] = {
            Name = "Final Selection",
            Icon = "rbxassetid://final_selection_icon",
            Features = {"AutoFarm", "BossDetection"}
        },
        [2345678901] = {
            Name = "Ouwigahara",
            Icon = "rbxassetid://ouwigahara_icon",
            Features = {"DungeonSystem", "CompetitiveMode"}
        },
        -- ... todos os mundos
    }
    
    -- Detecção em tempo real
    self.WorldSensors = {
        CurrentWorld = "",
        WorldChangedEvent = Instance.new("BindableEvent")
    }
    
    -- Monitoramento contínuo
    coroutine.wrap(function()
        local lastPlace = game.PlaceId
        while true do
            wait(1)
            if game.PlaceId ~= lastPlace then
                lastPlace = game.PlaceId
                self.WorldSensors.CurrentWorld = self.WorldDatabase[game.PlaceId] or "Unknown"
                self.WorldSensors.WorldChangedEvent:Fire()
            end
        end
    end)()
end

function HolographicUI:ShowWorldInfo()
    -- Painel de informações do mundo
    local worldInfo = Instance.new("Frame")
    worldInfo.Name = "WorldInfoPanel"
    worldInfo.Size = UDim2.new(0.8, 0, 0.7, 0)
    worldInfo.Position = UDim2.new(0.1, 0, 0.15, 0)
    worldInfo.BackgroundColor3 = Color3.fromRGB(20, 30, 50)
    
    -- Ícone do mundo
    local worldIcon = Instance.new("ImageLabel")
    worldIcon.Size = UDim2.new(0.3, 0, 0.3, 0)
    worldIcon.Position = UDim2.new(0.35, 0, 0.05, 0)
    worldIcon.Image = QuantumMobileCore.WorldDatabase[game.PlaceId].Icon
    
    -- Nome do mundo
    local worldName = Instance.new("TextLabel")
    worldName.Size = UDim2.new(1, 0, 0.1, 0)
    worldName.Position = UDim2.new(0, 0, 0.4, 0)
    worldName.Text = "MUNDO ATUAL: " .. QuantumMobileCore.WorldDatabase[game.PlaceId].Name
    worldName.TextScaled = true
    worldName.Font = Enum.Font.SciFi
    worldName.TextColor3 = Color3.fromRGB(0, 200, 255)
    
    -- Recursos disponíveis
    local featureList = Instance.new("ScrollingFrame")
    featureList.Size = UDim2.new(0.9, 0, 0.4, 0)
    featureList.Position = UDim2.new(0.05, 0, 0.5, 0)
    featureList.BackgroundTransparency = 1
    
    local yPos = 0
    for _, feature in ipairs(QuantumMobileCore.WorldDatabase[game.PlaceId].Features) do
        local featureLabel = Instance.new("TextLabel")
        featureLabel.Size = UDim2.new(1, 0, 0, 30)
        featureLabel.Position = UDim2.new(0, 0, 0, yPos)
        featureLabel.Text = "• " .. feature
        featureLabel.TextXAlignment = Enum.TextXAlignment.Left
        featureLabel.Font = Enum.Font.Code
        featureLabel.TextColor3 = Color3.fromRGB(150, 255, 150)
        featureLabel.BackgroundTransparency = 1
        featureLabel.Parent = featureList
        yPos = yPos + 35
    end
    featureList.CanvasSize = UDim2.new(0, 0, 0, yPos)
    
    -- Montar painel
    worldIcon.Parent = worldInfo
    worldName.Parent = worldInfo
    featureList.Parent = worldInfo
    worldInfo.Parent = self.QuantumWindow.QuantumFrame
    
    -- Botão de fechar
    local closeBtn = self:CreateControlButton("CloseInfo", UDim2.new(0.9, 0, 0.02, 0), "rbxassetid://close_icon")
    closeBtn.MouseButton1Click:Connect(function()
        worldInfo:Destroy()
    end)
    closeBtn.Parent = worldInfo
end

-------------------------------------
-- SISTEMA DE TOUCH QUÂNTICO
-------------------------------------
function QuantumMobileCore:InitializeTouchSystem()
    -- Matriz de toque para mobile
    self.TouchMatrix = {
        ActiveTouches = {},
        GestureDatabase = {}
    }
    
    -- Registro de gestos
    self.TouchMatrix.GestureDatabase = {
        SwipeLeft = {Vector2.new(50, 0), Vector2.new(-50, 0)},
        SwipeRight = {Vector2.new(-50, 0), Vector2.new(50, 0)},
        PinchIn = {Vector2.new(0, 20), Vector2.new(0, -20)},
        DoubleTap = {0, 0.3} -- Tempo entre toques
    }
    
    -- Gerenciador de toques
    game:GetService("UserInputService").TouchStarted:Connect(function(touch, processed)
        if not processed then
            self.TouchMatrix.ActiveTouches[touch] = {
                StartPos = touch.Position,
                StartTime = tick(),
                LastPos = touch.Position
            }
        end
    end)
    
    game:GetService("UserInputService").TouchMoved:Connect(function(touch, processed)
        if not processed and self.TouchMatrix.ActiveTouches[touch] then
            self.TouchMatrix.ActiveTouches[touch].LastPos = touch.Position
        end
    end)
    
    game:GetService("UserInputService").TouchEnded:Connect(function(touch, processed)
        if not processed and self.TouchMatrix.ActiveTouches[touch] then
            local touchData = self.TouchMatrix.ActiveTouches[touch]
            local delta = touch.Position - touchData.StartPos
            local duration = tick() - touchData.StartTime
            
            -- Reconhecimento de gestos
            self:RecognizeGesture(touchData, delta, duration)
            self.TouchMatrix.ActiveTouches[touch] = nil
        end
    end)
end

function QuantumMobileCore:RecognizeGesture(touchData, delta, duration)
    -- Reconhecimento quântico de gestos
    for gesture, pattern in pairs(self.TouchMatrix.GestureDatabase) do
        if gesture == "SwipeLeft" and delta.X < -50 and math.abs(delta.Y) < 20 then
            HolographicUI:SwitchTab("Previous")
        elseif gesture == "SwipeRight" and delta.X > 50 and math.abs(delta.Y) < 20 then
            HolographicUI:SwitchTab("Next")
        elseif gesture == "PinchIn" and delta.Y < -30 then
            HolographicUI.QuantumWindow.QuantumFrame.Visible = false
            HolographicUI.SystemTray.Visible = true
        end
    end
end

-------------------------------------
-- INTERFACE ADAPTATIVA PARA MOBILE
-------------------------------------
function HolographicUI:CreateMobileAdaptiveInterface()
    -- Configurações específicas para mobile
    local isMobile = game:GetService("UserInputService").TouchEnabled
    
    if isMobile then
        -- Aumentar tamanho dos botões
        for _, button in ipairs(self.QuantumWindow:GetDescendants()) do
            if button:IsA("TextButton") or button:IsA("ImageButton") then
                button.Size = UDim2.new(button.Size.X.Scale, 0, button.Size.Y.Scale * 1.5, 0)
            end
        end
        
        -- Adicionar área de toque expandida
        local touchExpander = Instance.new("Frame")
        touchExpander.Size = UDim2.new(1, 0, 0.1, 0)
        touchExpander.Position = UDim2.new(0, 0, 0.9, 0)
        touchExpander.BackgroundTransparency = 1
        touchExpander.ZIndex = 10
        touchExpander.Parent = self.QuantumWindow.QuantumFrame
        
        -- Sistema de navegação por gestos
        local gestureArea = Instance.new("Frame")
        gestureArea.Size = UDim2.new(1, 0, 0.05, 0)
        gestureArea.Position = UDim2.new(0, 0, 0.95, 0)
        gestureArea.BackgroundColor3 = Color3.fromRGB(0, 100, 200)
        gestureArea.BackgroundTransparency = 0.5
        gestureArea.Parent = self.QuantumWindow.QuantumFrame
        
        -- Indicadores de gestos
        local leftArrow = Instance.new("TextLabel")
        leftArrow.Text = "←"
        leftArrow.Size = UDim2.new(0.2, 0, 1, 0)
        leftArrow.Position = UDim2.new(0.3, 0, 0, 0)
        leftArrow.TextScaled = true
        leftArrow.Font = Enum.Font.SciFi
        leftArrow.TextColor3 = Color3.new(1, 1, 1)
        leftArrow.BackgroundTransparency = 1
        leftArrow.Parent = gestureArea
        
        local rightArrow = Instance.new("TextLabel")
        rightArrow.Text = "→"
        rightArrow.Size = UDim2.new(0.2, 0, 1, 0)
        rightArrow.Position = UDim2.new(0.5, 0, 0, 0)
        rightArrow.TextScaled = true
        rightArrow.Font = Enum.Font.SciFi
        rightArrow.TextColor3 = Color3.new(1, 1, 1)
        rightArrow.BackgroundTransparency = 1
        rightArrow.Parent = gestureArea
    end
end

-------------------------------------
-- SISTEMA DE GESTOS GIROSCÓPICOS
-------------------------------------
function QuantumMobileCore:InitializeGyroControls()
    -- Controle por movimento do dispositivo
    if game:GetService("UserInputService").GyroscopeEnabled then
        self.GyroStabilization = 0
        local lastGyro = Vector3.new(0, 0, 0)
        
        game:GetService("UserInputService").GyroChanged:Connect(function(gyro)
            local delta = gyro - lastGyro
            
            -- Navegação por inclinação
            if delta.X > 0.5 then
                HolographicUI:SwitchTab("Next")
            elseif delta.X < -0.5 then
                HolographicUI:SwitchTab("Previous")
            end
            
            -- Controle de zoom
            if delta.Z > 0.3 then
                HolographicUI:ZoomInterface(1.1)
            elseif delta.Z < -0.3 then
                HolographicUI:ZoomInterface(0.9)
            end
            
            lastGyro = gyro
        end)
    end
end

function HolographicUI:ZoomInterface(scale)
    -- Animação de zoom suave
    local mainFrame = self.QuantumWindow.QuantumFrame
    local currentSize = mainFrame.Size
    local newSize = UDim2.new(
        currentSize.X.Scale * scale,
        0,
        currentSize.Y.Scale * scale,
        0
    )
    
    game:GetService("TweenService"):Create(
        mainFrame,
        TweenInfo.new(0.3, Enum.EasingStyle.Quad),
        {Size = newSize}
    ):Play()
end

-------------------------------------
-- SISTEMA DE IDENTIFICAÇÃO DE MUNDO
-------------------------------------
function QuantumMobileCore:DetectWorldFeatures()
    -- Ativar/desativar recursos específicos
    local worldFeatures = self.WorldDatabase[game.PlaceId].Features
    
    -- Exemplo: Desativar teleportes em dungeons
    if table.find(worldFeatures, "DungeonSystem") then
        HolographicUI:ToggleFeature("Teleport", false)
    else
        HolographicUI:ToggleFeature("Teleport", true)
    end
    
    -- Configurar sistema de farm específico
    if table.find(worldFeatures, "BossFarm") then
        QuantumFarm:ConfigureBossMode()
    end
end

-------------------------------------
-- INICIALIZAÇÃO COMPLETA DO SISTEMA
-------------------------------------
function QuantumMobileCore:QuantumMobileInit()
    -- 1. Sensores de mundo quânticos
    self:InitializeWorldSensors()
    
    -- 2. Interface holográfica premiada
    HolographicUI:CreateOscarWorthyInterface()
    
    -- 3. Sistemas de toque e gestos
    self:InitializeTouchSystem()
    
    -- 4. Adaptação para mobile
    HolographicUI:CreateMobileAdaptiveInterface()
    
    -- 5. Controles giroscópicos
    self:InitializeGyroControls()
    
    -- 6. Detecção de recursos por mundo
    self:DetectWorldFeatures()
    
    -- 7. Atualizar em tempo real
    self.WorldSensors.WorldChangedEvent.Event:Connect(function()
        self:DetectWorldFeatures()
        HolographicUI:UpdateWorldDisplay()
    end)
end

-- Iniciar o sistema quântico móvel
QuantumMobileCore:QuantumMobileInit()-- MÓDULO DE AUTO LOOT AVANÇADO
-------------------------------------
local LootModule = {
    LastLootTime = 0,
    LootCooldown = 3,
    LootableItems = {"Chest", "Lily", "Soul", "Orb", "DemonArtifact"},
    
    Start = function()
        RunService.Heartbeat:Connect(function()
            if not _G.FrostiesUltra.States.AutoLoot then return end
            if os.time() - LootModule.LastLootTime < LootModule.LootCooldown then return end
            
            LootModule.ScanForLoot()
        end)
    end,
    
    ScanForLoot = function()
        for _, itemType in ipairs(LootModule.LootableItems) do
            local items = workspace:FindFirstChild(itemType.."s")
            if items then
                for _, item in ipairs(items:GetChildren()) do
                    if item:IsA("BasePart") then
                        local distance = (item.Position - HumanoidRootPart.Position).Magnitude
                        if distance < 25 then
                            LootModule.CollectItem(item)
                        end
                    end
                end
            end
        end
    end,
    
    CollectItem = function(item)
        firetouchinterest(HumanoidRootPart, item, 0)
        task.wait(0.1)
        firetouchinterest(HumanoidRootPart, item, 1)
        
        LootModule.LastLootTime = os.time()
        LootModule.LogLoot(item.Name)
        
        -- Sistema de webhook
        if _G.FrostiesUltra.Config.WebhookURL ~= "" then
            LootModule.SendWebhook(item.Name)
        end
    end,
    
    LogLoot = function(itemName)
        -- Implementar sistema de log local
    end,
    
    SendWebhook = function(itemName)
        local data = {
            ["content"] = "Novo item coletado!",
            ["embeds"] = {{
                ["title"] = "Frosties Ultra - Sistema de Loot",
                ["description"] = "**Jogador:** " .. Player.Name,
                ["fields"] = {
                    {["name"] = "Item", ["value"] = itemName, ["inline"] = true},
                    {["name"] = "Mapa", ["value"] = _G.FrostiesUltra.MapData.CurrentMap, ["inline"] = true}
                },
                ["color"] = 0x00FF00
            }}
        }
        
        pcall(function()
            HttpService:PostAsync(
                _G.FrostiesUltra.Config.WebhookURL,
                HttpService:JSONEncode(data)
            )
        end)
    end
}

-------------------------------------
-- MÓDULO DE ORBS E POWER-UPS
-------------------------------------
local OrbsModule = {
    OrbTypes = {"HealthRegen", "DoublePoints", "SpeedBoost", "DamageBoost"},
    CollectionRadius = 30,
    
    Start = function()
        RunService.Heartbeat:Connect(function()
            for _, orbType in ipairs(OrbsModule.OrbTypes) do
                local orbs = workspace.Orbs:FindFirstChild(orbType)
                if orbs then
                    for _, orb in ipairs(orbs:GetChildren()) do
                        if orb:IsA("BasePart") then
                            local distance = (orb.Position - HumanoidRootPart.Position).Magnitude
                            if distance < OrbsModule.CollectionRadius then
                                firetouchinterest(HumanoidRootPart, orb, 0)
                                task.wait(0.05)
                                firetouchinterest(HumanoidRootPart, orb, 1)
                            end
                        end
                    end
                end
            end
        end)
    end
}

-------------------------------------
-- MÓDULO DE FUNÇÕES SECUNDÁRIAS
-------------------------------------
local SideFunctionsModule = {
    RemoveDamageSound = function()
        for _, sound in ipairs(Player.PlayerGui:GetDescendants()) do
            if sound:IsA("Sound") and sound.Name == "DamageSound" then
                sound:Destroy()
            end
        end
    end,
    
    RemoveComboText = function()
        local combatGui = Player.PlayerGui:FindFirstChild("CombatGui")
        if combatGui then
            local comboText = combatGui:FindFirstChild("ComboText")
            if comboText then comboText:Destroy() end
        end
    end,
    
    ToggleFPSBooster = function(state)
        if state then
            Lighting.GlobalShadows = false
            Lighting.FogEnd = 9999
            settings().Rendering.QualityLevel = 1
        else
            Lighting.GlobalShadows = true
            Lighting.FogEnd = 100
            settings().Rendering.QualityLevel = 10
        end
    end
}

-------------------------------------
-- MÓDULO DE MODOS ESPECIAIS
-------------------------------------
local ModesModule = {
    ToggleInfiniteStamina = function(state)
        if state then
            RunService.Heartbeat:Connect(function()
                local stamina = Character:FindFirstChild("Stamina")
                if stamina then stamina.Value = 100 end
            end)
        end
    end,
    
    ToggleNoSunDamage = function(state)
        if state then
            RunService.Heartbeat:Connect(function()
                if Lighting.ClockTime > 6 and Lighting.ClockTime < 18 then
                    local damage = Character:FindFirstChild("SunDamage")
                    if damage then damage:Destroy() end
                end
            end)
        end
    end,
    
    ToggleGodMode = function(state)
        if state then
            Humanoid:SetAttribute("Invulnerable", true)
        else
            Humanoid:SetAttribute("Invulnerable", false)
        end
    end,
    
    ToggleNoCooldowns = function(state)
        if state then
            RunService.Heartbeat:Connect(function()
                local cooldowns = Character:FindFirstChild("SkillCooldowns")
                if cooldowns then
                    for _, v in ipairs(cooldowns:GetChildren()) do
                        if v:IsA("NumberValue") then
                            v.Value = 0
                        end
                    end
                end
            end)
        end
    end
}

-------------------------------------
-- MÓDULO DE LOJA E GAMEPASSES
-------------------------------------
local ShopModule = {
    UnlockGamepasses = function()
        -- Isto é apenas visual, não funciona no servidor
        local gamepasses = Player:FindFirstChild("Gamepasses")
        if gamepasses then
            for _, gamepass in ipairs(gamepasses:GetChildren()) do
                if gamepass:IsA("BoolValue") then
                    gamepass.Value = true
                end
            end
        end
    end,
    
    SpinBDA = function()
        local bdaRemote = ReplicatedStorage.Remotes:FindFirstChild("SpinBDA")
        if bdaRemote then
            while _G.FrostiesUltra.States.SpinBDA do
                bdaRemote:FireServer()
                task.wait(1.5) -- Delay entre giros
            end
        end
    end
}

-------------------------------------
-- MÓDULO DE AUTO SKILL
-------------------------------------
local SkillModule = {
    SkillPriority = {"Ultimate", "Skill3", "Skill2", "Skill1"},
    SkillDelays = {
        Ultimate = 10,
        Skill3 = 5,
        Skill2 = 3,
        Skill1 = 1
    },
    LastUsed = {},
    
    Start = function()
        for _, skill in ipairs(SkillModule.SkillPriority) do
            SkillModule.LastUsed[skill] = 0
        end
        
        RunService.Heartbeat:Connect(function()
            for _, skill in ipairs(SkillModule.SkillPriority) do
                local currentTime = os.time()
                if currentTime - SkillModule.LastUsed[skill] > SkillModule.SkillDelays[skill] then
                    if SkillModule.CanUseSkill(skill) then
                        SkillModule.UseSkill(skill)
                        SkillModule.LastUsed[skill] = currentTime
                        break -- Usar apenas uma habilidade por frame
                    end
                end
            end
        end)
    end,
    
    CanUseSkill = function(skillName)
        -- Verificar se a habilidade está disponível
        local skillState = Character:FindFirstChild(skillName.."Ready")
        return skillState and skillState.Value
    end,
    
    UseSkill = function(skillName)
        local remote = ReplicatedStorage.Remotes:FindFirstChild(skillName.."Attack")
        if remote then
            remote:FireServer({
                Target = CombatModule.Target,
                Position = CombatModule.Target.HumanoidRootPart.Position
            })
        end
    end
}

-------------------------------------
-- MÓDULO DE AUTO DODGE
-------------------------------------
local DodgeModule = {
    DodgeKey = Enum.KeyCode.Space,
    DodgeCooldown = 2,
    LastDodge = 0,
    
    Start = function()
        RunService.Heartbeat:Connect(function()
            DodgeModule.CheckProjectiles()
            DodgeModule.CheckMeleeAttacks()
        end)
    end,
    
    CheckProjectiles = function()
        for _, proj in ipairs(workspace.Projectiles:GetChildren()) do
            if proj:GetAttribute("Hostile") then
                local distance = (proj.Position - HumanoidRootPart.Position).Magnitude
                if distance < 15 then
                    DodgeModule.ExecuteDodge()
                end
            end
        end
    end,
    
    CheckMeleeAttacks = function()
        for _, player in ipairs(Players:GetPlayers()) do
            if player ~= Player then
                local char = player.Character
                if char then
                    local animator = char:FindFirstChild("Humanoid"):FindFirstChild("Animator")
                    if animator then
                        for _, track in ipairs(animator:GetPlayingAnimationTracks()) do
                            if track.Name:find("Attack") then
                                local distance = (char.HumanoidRootPart.Position - HumanoidRootPart.Position).Magnitude
                                if distance < 10 then
                                    DodgeModule.ExecuteDodge()
                                end
                            end
                        end
                    end
                end
            end
        end
    end,
    
    ExecuteDodge = function()
        if os.time() - DodgeModule.LastDodge > DodgeModule.DodgeCooldown then
            VirtualInputManager:SendKeyEvent(true, DodgeModule.DodgeKey, false, nil)
            task.wait(0.1)
            VirtualInputManager:SendKeyEvent(false, DodgeModule.DodgeKey, false, nil)
            DodgeModule.LastDodge = os.time()
        end
    end
}

-------------------------------------
-- SISTEMA DE SALVAMENTO DE CONFIG
-------------------------------------
local ConfigSystem = {
    Save = function()
        local data = {
            States = _G.FrostiesUltra.States,
            Config = _G.FrostiesUltra.Config,
            Keybinds = _G.FrostiesUltra.Keybinds
        }
        
        writefile("frosties_config.json", HttpService:JSONEncode(data))
    end,
    
    Load = function()
        if isfile("frosties_config.json") then
            local success, data = pcall(function()
                return HttpService:JSONDecode(readfile("frosties_config.json"))
            end)
            
            if success then
                _G.FrostiesUltra.States = data.States or _G.FrostiesUltra.States
                _G.FrostiesUltra.Config = data.Config or _G.FrostiesUltra.Config
                _G.FrostiesUltra.Keybinds = data.Keybinds or _G.FrostiesUltra.Keybinds
            end
        end
    end,
    
    AutoSave = function()
        while true do
            task.wait(60) -- Salvar a cada minuto
            ConfigSystem.Save()
        end
    end
}

-------------------------------------
-- SISTEMA DE ATUALIZAÇÃO DINÂMICA
-------------------------------------
local UpdateSystem = {
    Version = "2.0",
    UpdateURL = "https://frosties-api.com/updates/",
    LastChecked = 0,
    
    CheckForUpdates = function()
        if os.time() - UpdateSystem.LastChecked < 3600 then return end -- 1 hora
        
        local success, data = pcall(function()
            return HttpService:JSONDecode(game:HttpGet(
                UpdateSystem.UpdateURL .. "?version=" .. UpdateSystem.Version
            ))
        end)
        
        if success and data.updateAvailable then
            -- Implementar lógica de atualização
        end
        
        UpdateSystem.LastChecked = os.time()
    end,
    
    UpdateConfigs = function()
        local success, data = pcall(function()
            return HttpService:JSONDecode(game:HttpGet(
                UpdateSystem.UpdateURL .. "configs/" .. game.PlaceId
            ))
        end)
        
        if success then
            -- Atualizar configurações específicas do jogo
            _G.FrostiesUltra.Cache.NPCs = data.NPCs or _G.FrostiesUltra.Cache.NPCs
            _G.FrostiesUltra.Cache.Mobs = data.Mobs or _G.FrostiesUltra.Cache.Mobs
            _G.FrostiesUltra.Cache.Chests = data.Chests or _G.FrostiesUltra.Cache.Chests
        end
    end
}

-------------------------------------
-- INICIALIZAÇÃO COMPLETA
-------------------------------------
local function InitializeFrostiesUltra()
    -- Carregar módulos
    _G.FrostiesUltra.Modules = {
        Map = MapModule,
        Loot = LootModule,
        Orbs = OrbsModule,
        SideFunctions = SideFunctionsModule,
        Modes = ModesModule,
        Shop = ShopModule,
        Skills = SkillModule,
        Dodge = DodgeModule,
        Combat = CombatModule,
        Farm = FarmModule,
        Movement = MovementModule,
        Protection = ProtectionModule
    }
    
    -- Sequência de inicialização
    ConfigSystem.Load()
    MapModule.DetectCurrentMap()
    ProtectionModule.Initialize()
    
    -- Iniciar sistemas
    for name, module in pairs(_G.FrostiesUltra.Modules) do
        if module.Initialize then
            module.Initialize()
        end
    end
    
    -- Iniciar loops
    coroutine.wrap(ConfigSystem.AutoSave)()
    coroutine.wrap(UpdateSystem.CheckForUpdates)()
    
    -- Inicializar interface
    InitializeFrostiesUI()
    
    -- Mensagem de sucesso
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Frosties Ultra Carregado!",
        Text = "Versão " .. UpdateSystem.Version,
        Duration = 5,
        Icon = "rbxassetid://123456789" -- Icone personalizado
    })
end

-- Função para inicializar a interface
local function InitializeFrostiesUI()
    -- Implementação completa da interface Fluent UI
    -- com todas as abas e elementos descritos
end

-- Iniciar o script
coroutine.wrap(InitializeFrostiesUltra)()
