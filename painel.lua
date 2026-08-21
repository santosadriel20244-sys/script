-- // Sintonia RP - Versão Heli Pro (Com Botão Redondo, Sincronizado e Minimizar)
-- // Correção Definitiva do Sistema de Salvamento de Posição

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local HttpService = game:GetService("HttpService")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

if PlayerGui:FindFirstChild("SintoniaHeliUI") then
    PlayerGui.SintoniaHeliUI:Destroy()
end

local heliAtivo = false
local botoesTravados = false
local menuMinimizado = false
local connectionVoo = nil

_G.velVooMax = 60
_G.velSubMax = 40

local velocidadeAtualFrente = 0
local velocidadeAtualSubida = 0

-- Sistema de Salvamento em Arquivo (Posições em Pixels / Offset)
local fileName = "SintoniaHeli_Config.json"
local savedData = {
    posX_Heli = 200, posY_Heli = 200,
    posX_F = 400, posY_F = 300,
    posX_T = 400, posY_T = 360,
    posX_S = 460, posY_S = 300,
    posX_D = 460, posY_D = 360,
    vVoo = 60,
    vSub = 40
}

if writefile and readfile and isfile then
    if isfile(fileName) then
        local success, decoded = pcall(function()
            return HttpService:JSONDecode(readfile(fileName))
        end)
        if success and decoded then
            for k, v in pairs(decoded) do
                savedData[k] = v
            end
            print("[SintoniaHeli] Configurações carregadas com sucesso do arquivo!")
        end
    end
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "SintoniaHeliUI"
ScreenGui.Parent = PlayerGui
ScreenGui.ResetOnSpawn = false
ScreenGui.DisplayOrder = 99999

-- // MENU PRINCIPAL //
local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Name = "MainFrame"
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
MainFrame.Position = UDim2.new(0.5, -125, 0.4, -130)
MainFrame.Size = UDim2.new(0, 250, 0, 360)
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.ZIndex = 10
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 6)

-- Título do Menu
local TitleLabel = Instance.new("TextLabel", MainFrame)
TitleLabel.Size = UDim2.new(1, -40, 0, 30)
TitleLabel.Position = UDim2.new(0, 10, 0, 5)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Text = "SINTONIA RP - HELI"
TitleLabel.TextColor3 = Color3.new(1, 1, 1)
TitleLabel.TextSize = 13
TitleLabel.Font = Enum.Font.SourceSansBold
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
TitleLabel.ZIndex = 11

-- Botão de Minimizar (-)
local MinimizeBtn = Instance.new("TextButton", MainFrame)
MinimizeBtn.Size = UDim2.new(0, 25, 0, 25)
MinimizeBtn.Position = UDim2.new(1, -30, 0, 7)
MinimizeBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
MinimizeBtn.Text = "-"
MinimizeBtn.TextColor3 = Color3.new(1, 1, 1)
MinimizeBtn.TextSize = 16
MinimizeBtn.Font = Enum.Font.SourceSansBold
MinimizeBtn.ZIndex = 12
Instance.new("UICorner", MinimizeBtn).CornerRadius = UDim.new(0, 4)

local ToggleHeliBtn = Instance.new("TextButton", MainFrame)
ToggleHeliBtn.BackgroundColor3 = Color3.fromRGB(180, 40, 40)
ToggleHeliBtn.Size = UDim2.new(0.8, 0, 0, 40)
ToggleHeliBtn.Position = UDim2.new(0.1, 0, 0.15, 0)
ToggleHeliBtn.Text = "LIGAR HELI [OFF]"
ToggleHeliBtn.TextColor3 = Color3.new(1,1,1)
ToggleHeliBtn.ZIndex = 11
Instance.new("UICorner", ToggleHeliBtn).CornerRadius = UDim.new(0, 4)

local function criarInput(pos, placeholder, chaveValor, varGlobal)
    local box = Instance.new("TextBox", MainFrame)
    box.Size = UDim2.new(0.8, 0, 0, 35)
    box.Position = UDim2.new(0.1, 0, pos, 0)
    box.PlaceholderText = placeholder
    box.Text = tostring(savedData[chaveValor])
    box.TextColor3 = Color3.new(1,1,1)
    box.BackgroundColor3 = Color3.fromRGB(40, 40, 48)
    box.ZIndex = 11
    Instance.new("UICorner", box).CornerRadius = UDim.new(0, 4)
    _G[varGlobal] = savedData[chaveValor]
    
    box.FocusLost:Connect(function()
        local val = tonumber(box.Text)
        if val then
            _G[varGlobal] = val
            savedData[chaveValor] = val
        end
    end)
    return box
end

criarInput(0.30, "Máx. Vel. Frente/Tras", "vVoo", "velVooMax")
criarInput(0.44, "Máx. Vel. Subida/Descida", "vSub", "velSubMax")

local LockControlesBtn = Instance.new("TextButton", MainFrame)
LockControlesBtn.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
LockControlesBtn.Size = UDim2.new(0.8, 0, 0, 40)
LockControlesBtn.Position = UDim2.new(0.1, 0, 0.60, 0)
LockControlesBtn.Text = "TRAVAR BOTÕES [OFF]"
LockControlesBtn.TextColor3 = Color3.new(1,1,1)
LockControlesBtn.ZIndex = 11
Instance.new("UICorner", LockControlesBtn).CornerRadius = UDim.new(0, 4)

local SalvarPosBtn = Instance.new("TextButton", MainFrame)
SalvarPosBtn.BackgroundColor3 = Color3.fromRGB(40, 140, 40)
SalvarPosBtn.Size = UDim2.new(0.8, 0, 0, 35)
SalvarPosBtn.Position = UDim2.new(0.1, 0, 0.75, 0)
SalvarPosBtn.Text = "SALVAR CONFIGURAÇÕES"
SalvarPosBtn.TextColor3 = Color3.new(1,1,1)
SalvarPosBtn.ZIndex = 11
Instance.new("UICorner", SalvarPosBtn).CornerRadius = UDim.new(0, 4)

-- Lógica do Botão Minimizar
MinimizeBtn.MouseButton1Click:Connect(function()
    menuMinimizado = not menuMinimizado
    if menuMinimizado then
        MainFrame:TweenSize(UDim2.new(0, 250, 0, 40), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.2, true)
        MinimizeBtn.Text = "+"
        ToggleHeliBtn.Visible = false
        LockControlesBtn.Visible = false
        SalvarPosBtn.Visible = false
        for _, child in ipairs(MainFrame:GetChildren()) do
            if child:IsA("TextBox") then
                child.Visible = false
            end
        end
    else
        MainFrame:TweenSize(UDim2.new(0, 250, 0, 360), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.2, true)
        MinimizeBtn.Text = "-"
        ToggleHeliBtn.Visible = true
        LockControlesBtn.Visible = true
        SalvarPosBtn.Visible = true
        for _, child in ipairs(MainFrame:GetChildren()) do
            if child:IsA("TextBox") then
                child.Visible = true
            end
        end
    end
end)

-- // FRAME DOS CONTROLES //
local ControlFrame = Instance.new("Frame", ScreenGui)
ControlFrame.Name = "ControlFrame"
ControlFrame.BackgroundTransparency = 1
ControlFrame.Size = UDim2.new(1, 0, 1, 0)
ControlFrame.Visible = false 
ControlFrame.ZIndex = 999

-- Bola Redonda e Arrastável de Ligar/Desligar na Tela
local HeliBolaBtn = Instance.new("TextButton", ControlFrame)
HeliBolaBtn.Name = "HeliBolaBtn"
HeliBolaBtn.BackgroundColor3 = Color3.fromRGB(180, 40, 40)
HeliBolaBtn.AnchorPoint = Vector2.new(0, 0)
HeliBolaBtn.Position = UDim2.new(0, savedData.posX_Heli, 0, savedData.posY_Heli)
HeliBolaBtn.Size = UDim2.new(0, 50, 0, 50)
HeliBolaBtn.Text = "HELI"
HeliBolaBtn.TextColor3 = Color3.new(1,1,1)
HeliBolaBtn.TextSize = 12
HeliBolaBtn.Active = true
HeliBolaBtn.Draggable = true
HeliBolaBtn.ZIndex = 1001
Instance.new("UICorner", HeliBolaBtn).CornerRadius = UDim.new(1, 0)

local function criarBotao(nome, texto, posXKey, posYKey)
    local btn = Instance.new("TextButton", ControlFrame)
    btn.Name = nome
    btn.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    btn.BackgroundTransparency = 0.4
    btn.AnchorPoint = Vector2.new(0, 0)
    btn.Position = UDim2.new(0, savedData[posXKey], 0, savedData[posYKey])
    btn.Size = UDim2.new(0, 50, 0, 50)
    btn.Text = texto
    btn.TextColor3 = Color3.new(1,1,1)
    btn.Active = true
    btn.Draggable = true
    btn.ZIndex = 1000
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 8)
    return btn
end

local BtnF = criarBotao("BtnF", "F", "posX_F", "posY_F")
local BtnT = criarBotao("BtnT", "T", "posX_T", "posY_T")
local BtnSubir = criarBotao("BtnSubir", "S", "posX_S", "posY_S")
local BtnDescer = criarBotao("BtnDescer", "D", "posX_D", "posY_D")

local function atualizarEstadoHeli(estado)
    heliAtivo = estado
    local char = LocalPlayer.Character
    
    if heliAtivo then
        if char and char:FindFirstChild("Humanoid") then
            char.Humanoid.AutoRotate = false
        end
        ToggleHeliBtn.Text = "DESLIGAR HELI [ON]"
        HeliBolaBtn.BackgroundColor3 = Color3.fromRGB(40, 180, 40)
        
        local rootPart = char and char:FindFirstChild("HumanoidRootPart")
        if rootPart and not connectionVoo then
            connectionVoo = RunService.RenderStepped:Connect(function(dt)
                local look = rootPart.CFrame.LookVector
                local taxaAcel = 250 * dt 
                
                local alvoFrente = 0
                if _G.movF then alvoFrente = _G.velVooMax elseif _G.movT then alvoFrente = -_G.velVooMax end
                
                if velocidadeAtualFrente < alvoFrente then
                    velocidadeAtualFrente = math.min(velocidadeAtualFrente + taxaAcel, alvoFrente)
                elseif velocidadeAtualFrente > alvoFrente then
                    velocidadeAtualFrente = math.max(velocidadeAtualFrente - taxaAcel, alvoFrente)
                else
                    if not _G.movF and not _G.movT then
                        if velocidadeAtualFrente > 0 then velocidadeAtualFrente = math.max(0, velocidadeAtualFrente - taxaAcel)
                        elseif velocidadeAtualFrente < 0 then velocidadeAtualFrente = math.min(0, velocidadeAtualFrente + taxaAcel) end
                    end
                end
                
                local alvoSubida = 0
                if _G.sub then alvoSubida = _G.velSubMax elseif _G.desc then alvoSubida = -_G.velSubMax end
                
                if velocidadeAtualSubida < alvoSubida then
                    velocidadeAtualSubida = math.min(velocidadeAtualSubida + taxaAcel, alvoSubida)
                elseif velocidadeAtualSubida > alvoSubida then
                    velocidadeAtualSubida = math.max(velocidadeAtualSubida - taxaAcel, alvoSubida)
                else
                    if not _G.sub and not _G.desc then
                        if velocidadeAtualSubida > 0 then velocidadeAtualSubida = math.max(0, velocidadeAtualSubida - taxaAcel)
                        elseif velocidadeAtualSubida < 0 then velocidadeAtualSubida = math.min(0, velocidadeAtualSubida + taxaAcel) end
                    end
                end
                
                local velX = look.X * math.abs(velocidadeAtualFrente) * (velocidadeAtualFrente >= 0 and 1 or -1)
                local velZ = look.Z * math.abs(velocidadeAtualFrente) * (velocidadeAtualFrente >= 0 and 1 or -1)
                local velY = 2 + velocidadeAtualSubida
                
                rootPart.Velocity = Vector3.new(velX, velY, velZ)
            end)
        end
    else
        if char and char:FindFirstChild("Humanoid") then
            char.Humanoid.AutoRotate = true
        end
        ToggleHeliBtn.Text = "LIGAR HELI [OFF]"
        HeliBolaBtn.BackgroundColor3 = Color3.fromRGB(180, 40, 40)
        
        if connectionVoo then connectionVoo:Disconnect(); connectionVoo = nil end
        velocidadeAtualFrente = 0
        velocidadeAtualSubida = 0
        _G.movF = false; _G.movT = false; _G.sub = false; _G.desc = false
    end
end

ToggleHeliBtn.MouseButton1Click:Connect(function()
    local novoEstado = not heliAtivo
    ControlFrame.Visible = novoEstado
    atualizarEstadoHeli(novoEstado)
end)

HeliBolaBtn.MouseButton1Click:Connect(function()
    atualizarEstadoHeli(not heliAtivo)
end)

SalvarPosBtn.MouseButton1Click:Connect(function()
    savedData.posX_Heli = HeliBolaBtn.AbsolutePosition.X
    savedData.posY_Heli = HeliBolaBtn.AbsolutePosition.Y
    
    savedData.posX_F = BtnF.AbsolutePosition.X
    savedData.posY_F = BtnF.AbsolutePosition.Y
    savedData.posX_T = BtnT.AbsolutePosition.X
    savedData.posY_T = BtnT.AbsolutePosition.Y
    savedData.posX_S = BtnSubir.AbsolutePosition.X
    savedData.posY_S = BtnSubir.AbsolutePosition.Y
    savedData.posX_D = BtnDescer.AbsolutePosition.X
    savedData.posY_D = BtnDescer.AbsolutePosition.Y
    
    savedData.vVoo = _G.velVooMax
    savedData.vSub = _G.velSubMax

    HeliBolaBtn.Position = UDim2.new(0, savedData.posX_Heli, 0, savedData.posY_Heli)
    BtnF.Position = UDim2.new(0, savedData.posX_F, 0, savedData.posY_F)
    BtnT.Position = UDim2.new(0, savedData.posX_T, 0, savedData.posY_T)
    BtnSubir.Position = UDim2.new(0, savedData.posX_S, 0, savedData.posY_S)
    BtnDescer.Position = UDim2.new(0, savedData.posX_D, 0, savedData.posY_D)

    if writefile then
        local success, err = pcall(function()
            writefile(fileName, HttpService:JSONEncode(savedData))
        end)
        if success then
            print("[SintoniaHeli] Posições salvas com sucesso no arquivo JSON!")
        else
            warn("[SintoniaHeli] Erro ao salvar arquivo: " .. tostring(err))
        end
    else
        warn("[SintoniaHeli] Seu executor não suporta writefile!")
    end

    SalvarPosBtn.Text = "TUDO SALVO COM SUCESSO!"
    task.wait(1.5)
    SalvarPosBtn.Text = "SALVAR CONFIGURAÇÕES"
end)

LockControlesBtn.MouseButton1Click:Connect(function()
    botoesTravados = not botoesTravados
    HeliBolaBtn.Draggable = not botoesTravados
    BtnF.Draggable = not botoesTravados
    BtnT.Draggable = not botoesTravados
    BtnSubir.Draggable = not botoesTravados
    BtnDescer.Draggable = not botoesTravados
    LockControlesBtn.Text = botoesTravados and "TRAVAR BOTÕES [ON]" or "TRAVAR BOTÕES [OFF]"
end)

local function vincular(btn, var)
    btn.MouseButton1Down:Connect(function() _G[var] = true end)
    btn.MouseButton1Up:Connect(function() _G[var] = false end)
    btn.MouseLeave:Connect(function() _G[var] = false end)
end
_G.movF = false; _G.movT = false; _G.sub = false; _G.desc = false
vincular(BtnF, "movF"); vincular(BtnT, "movT"); vincular(BtnSubir, "sub"); vincular(BtnDescer, "desc")
