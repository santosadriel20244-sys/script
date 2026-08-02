--[[
SUPERMAN FLY v28.5 + MULTI FOLLOW V16 (UNIFIED)
✔ Multi Follow com Network Ownership (Tenta funcionar para todos)
✔ Oscilação Extrema e Posição à Frente
✔ ESP, Names, Anti-Sit e Moto Controls integrados
]]

if not game:IsLoaded() then
	game.Loaded:Wait()
end

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local HttpService = game:GetService("HttpService")
local UserInputService = game:GetService("UserInputService")
local Camera = workspace.CurrentCamera

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid", 10)
local root = character:WaitForChild("HumanoidRootPart", 10)

local fileName = "KillButtonPos_" .. player.UserId .. ".txt"
local layoutFileName = "LayoutBotoesV25_" .. player.UserId .. ".txt"

if game.CoreGui:FindFirstChild("SupermanFly") then
	game.CoreGui.SupermanFly:Destroy()
	task.wait(0.1)
end

-- ==========================================
-- GUI SYSTEM
-- ==========================================
local gui = Instance.new("ScreenGui")
gui.Name = "SupermanFly"
gui.ResetOnSpawn = false

local sucessoGui, erroGui = pcall(function()
	gui.Parent = game.CoreGui
end)
if not sucessoGui then
	gui.Parent = player:WaitForChild("PlayerGui")
end

-- MENU PRINCIPAL
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0,160,0,525) -- Aumentado levemente para caber o novo botão
frame.Position = UDim2.new(0,20,0.2,0)
frame.BackgroundColor3 = Color3.fromRGB(25,25,25)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true
frame.Parent = gui
Instance.new("UICorner", frame).CornerRadius = UDim.new(0,12)

local menuConteudo = Instance.new("Frame")
menuConteudo.Size = UDim2.new(1, 0, 1, -24)
menuConteudo.Position = UDim2.new(0, 0, 0, 24)
menuConteudo.BackgroundTransparency = 1
menuConteudo.Parent = frame

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1,-30,0,22)
title.Position = UDim2.new(0,10,0,2)
title.BackgroundTransparency = 1
title.Text = "Super Fly v28.5 + MF"
title.TextColor3 = Color3.new(1,1,1)
title.TextXAlignment = Enum.TextXAlignment.Left
title.TextSize = 14
title.Font = Enum.Font.GothamBold
title.Parent = frame

local minimizarBtn = Instance.new("TextButton")
minimizarBtn.Size = UDim2.new(0, 20, 0, 20)
minimizarBtn.Position = UDim2.new(1, -25, 0, 3)
minimizarBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
minimizarBtn.Text = "-"
minimizarBtn.TextColor3 = Color3.new(1, 1, 1)
minimizarBtn.TextSize = 16
minimizarBtn.Font = Enum.Font.GothamBold
minimizarBtn.Parent = frame
Instance.new("UICorner", minimizarBtn).CornerRadius = UDim.new(0, 5)

local menuAberto = true
minimizarBtn.MouseButton1Click:Connect(function()
	menuAberto = not menuAberto
	if menuAberto then
		frame.Size = UDim2.new(0, 160, 0, 525)
		menuConteudo.Visible = true
		minimizarBtn.Text = "-"
		minimizarBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
	else
		frame.Size = UDim2.new(0, 160, 0, 26)
		menuConteudo.Visible = false
		minimizarBtn.Text = "+"
		minimizarBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 70)
	end
end)

-- BOTÕES EXISTENTES
local toggle = Instance.new("TextButton")
toggle.Size = UDim2.new(0,120,0,30)
toggle.Position = UDim2.new(0.5,-60,0,4)
toggle.BackgroundColor3 = Color3.fromRGB(40,40,40)
toggle.Text = "FLY OFF"
toggle.TextColor3 = Color3.new(1,1,1)
toggle.TextScaled = true
toggle.Font = Enum.Font.GothamBold
toggle.Parent = menuConteudo
Instance.new("UICorner", toggle)

local speedBox = Instance.new("TextBox")
speedBox.Size = UDim2.new(0,70,0,24)
speedBox.Position = UDim2.new(0,45,0,40)
speedBox.BackgroundColor3 = Color3.fromRGB(35,35,35)
speedBox.Text = "100"
speedBox.TextColor3 = Color3.new(1,1,1)
speedBox.TextScaled = true
speedBox.Font = Enum.Font.GothamBold
speedBox.Parent = menuConteudo
Instance.new("UICorner", speedBox)

local plusBtn = Instance.new("TextButton")
plusBtn.Size = UDim2.new(0,24,0,24)
plusBtn.Position = UDim2.new(0,120,0,40)
plusBtn.BackgroundColor3 = Color3.fromRGB(0,170,0)
plusBtn.Text = "+"
plusBtn.TextColor3 = Color3.new(1,1,1)
plusBtn.TextScaled = true
plusBtn.Font = Enum.Font.GothamBold
plusBtn.Parent = menuConteudo
Instance.new("UICorner", plusBtn)

local minusBtn = Instance.new("TextButton")
minusBtn.Size = UDim2.new(0,24,0,24)
minusBtn.Position = UDim2.new(0,15,0,40)
minusBtn.BackgroundColor3 = Color3.fromRGB(170,0,0)
minusBtn.Text = "-"
minusBtn.TextColor3 = Color3.new(1,1,1)
minusBtn.TextScaled = true
minusBtn.Font = Enum.Font.GothamBold
minusBtn.Parent = menuConteudo
Instance.new("UICorner", minusBtn)

local motoSpeedBox = Instance.new("TextBox")
motoSpeedBox.Size = UDim2.new(0,70,0,24)
motoSpeedBox.Position = UDim2.new(0,45,0,72)
motoSpeedBox.BackgroundColor3 = Color3.fromRGB(35,35,45)
motoSpeedBox.Text = "50"
motoSpeedBox.TextColor3 = Color3.fromRGB(180,255,180)
motoSpeedBox.TextScaled = true
motoSpeedBox.Font = Enum.Font.GothamBold
motoSpeedBox.Parent = menuConteudo
Instance.new("UICorner", motoSpeedBox)

local motoPlusBtn = Instance.new("TextButton")
motoPlusBtn.Size = UDim2.new(0,24,0,24)
motoPlusBtn.Position = UDim2.new(0,120,0,72)
motoPlusBtn.BackgroundColor3 = Color3.fromRGB(0,130,0)
motoPlusBtn.Text = "+"
motoPlusBtn.TextColor3 = Color3.new(1,1,1)
motoPlusBtn.TextScaled = true
motoPlusBtn.Font = Enum.Font.GothamBold
motoPlusBtn.Parent = menuConteudo
Instance.new("UICorner", motoPlusBtn)

local motoMinusBtn = Instance.new("TextButton")
motoMinusBtn.Size = UDim2.new(0,24,0,24)
motoMinusBtn.Position = UDim2.new(0,15,0,72)
motoMinusBtn.BackgroundColor3 = Color3.fromRGB(130,0,0)
motoMinusBtn.Text = "-"
motoMinusBtn.TextColor3 = Color3.new(1,1,1)
motoMinusBtn.TextScaled = true
motoMinusBtn.Font = Enum.Font.GothamBold
motoMinusBtn.Parent = menuConteudo
Instance.new("UICorner", motoMinusBtn)

local espBtn = Instance.new("TextButton")
espBtn.Size = UDim2.new(0,120,0,22)
espBtn.Position = UDim2.new(0.5,-60,0,104)
espBtn.BackgroundColor3 = Color3.fromRGB(40,40,40)
espBtn.Text = "ESP OFF"
espBtn.TextColor3 = Color3.new(1,1,1)
espBtn.TextScaled = true
espBtn.Font = Enum.Font.GothamBold
espBtn.Parent = menuConteudo
Instance.new("UICorner", espBtn)

local nameBtn = Instance.new("TextButton")
nameBtn.Size = UDim2.new(0,120,0,22)
nameBtn.Position = UDim2.new(0.5,-60,0,130)
nameBtn.BackgroundColor3 = Color3.fromRGB(40,40,40)
nameBtn.Text = "NAMES OFF"
nameBtn.TextColor3 = Color3.new(1,1,1)
nameBtn.TextScaled = true
nameBtn.Font = Enum.Font.GothamBold
nameBtn.Parent = menuConteudo
Instance.new("UICorner", nameBtn)

local freezeBtn = Instance.new("TextButton")
freezeBtn.Size = UDim2.new(0,60,0,22)
freezeBtn.Position = UDim2.new(0.5,-30,0,156)
freezeBtn.BackgroundColor3 = Color3.fromRGB(40,40,40)
freezeBtn.Text = "STOP"
freezeBtn.TextColor3 = Color3.new(1,1,1)
freezeBtn.TextScaled = true
freezeBtn.Font = Enum.Font.GothamBold
freezeBtn.Parent = menuConteudo
Instance.new("UICorner", freezeBtn)

local carCatchBtn = Instance.new("TextButton")
carCatchBtn.Size = UDim2.new(0,130,0,24)
carCatchBtn.Position = UDim2.new(0.5,-65,0,182)
carCatchBtn.BackgroundColor3 = Color3.fromRGB(0, 100, 200)
carCatchBtn.Text = "PEGA CARRO"
carCatchBtn.TextColor3 = Color3.new(1,1,1)
carCatchBtn.TextScaled = true
carCatchBtn.Font = Enum.Font.GothamBold
carCatchBtn.Parent = menuConteudo
Instance.new("UICorner", carCatchBtn)

local carThrowBtn = Instance.new("TextButton")
carThrowBtn.Size = UDim2.new(0,130,0,24)
carThrowBtn.Position = UDim2.new(0.5,-65,0,210)
carThrowBtn.BackgroundColor3 = Color3.fromRGB(200, 100, 0)
carThrowBtn.Text = "LANÇA CARRO"
carThrowBtn.TextColor3 = Color3.new(1,1,1)
carThrowBtn.TextScaled = true
carThrowBtn.Font = Enum.Font.GothamBold
carThrowBtn.Parent = menuConteudo
Instance.new("UICorner", carThrowBtn)

local killToggleBtn = Instance.new("TextButton")
killToggleBtn.Size = UDim2.new(0,130,0,24)
killToggleBtn.Position = UDim2.new(0.5,-65,0,238)
killToggleBtn.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
killToggleBtn.Text = "KILL TELEPORT"
killToggleBtn.TextColor3 = Color3.new(1,1,1)
killToggleBtn.TextScaled = true
killToggleBtn.Font = Enum.Font.GothamBold
killToggleBtn.Parent = menuConteudo
Instance.new("UICorner", killToggleBtn)

local moveToggleBtn = Instance.new("TextButton")
moveToggleBtn.Size = UDim2.new(0,120,0,18)
moveToggleBtn.Position = UDim2.new(0.5,-60,0,266)
moveToggleBtn.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
moveToggleBtn.Text = "MOVER KILL: OFF"
moveToggleBtn.TextColor3 = Color3.new(1,1,1)
moveToggleBtn.TextScaled = true
moveToggleBtn.Font = Enum.Font.GothamBold
moveToggleBtn.Parent = menuConteudo
Instance.new("UICorner", moveToggleBtn)

local antiSitToggleBtn = Instance.new("TextButton")
antiSitToggleBtn.Size = UDim2.new(0,120,0,18)
antiSitToggleBtn.Position = UDim2.new(0.5,-60,0,288)
antiSitToggleBtn.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
antiSitToggleBtn.Text = "ANTI SIT: OFF"
antiSitToggleBtn.TextColor3 = Color3.new(1,1,1)
antiSitToggleBtn.TextScaled = true
antiSitToggleBtn.Font = Enum.Font.GothamBold
antiSitToggleBtn.Parent = menuConteudo
Instance.new("UICorner", antiSitToggleBtn)

local motoToggleBtn = Instance.new("TextButton")
motoToggleBtn.Size = UDim2.new(0,120,0,24)
motoToggleBtn.Position = UDim2.new(0.5,-60,0,310)
motoToggleBtn.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
motoToggleBtn.Text = "MOTO CONTROLES"
motoToggleBtn.TextColor3 = Color3.new(1,1,1)
motoToggleBtn.TextScaled = true
motoToggleBtn.Font = Enum.Font.GothamBold
motoToggleBtn.Parent = menuConteudo
Instance.new("UICorner", motoToggleBtn)

local layoutToggleBtn = Instance.new("TextButton")
layoutToggleBtn.Size = UDim2.new(0, 120, 0, 30)
layoutToggleBtn.Position = UDim2.new(0.5, -60, 0, 344)
layoutToggleBtn.BackgroundColor3 = Color3.fromRGB(100, 0, 100)
layoutToggleBtn.Text = "EDIT: OFF"
layoutToggleBtn.TextColor3 = Color3.new(1,1,1)
layoutToggleBtn.TextSize = 14
layoutToggleBtn.Font = Enum.Font.GothamBold
layoutToggleBtn.Parent = menuConteudo
Instance.new("UICorner", layoutToggleBtn)

-- ✅ NOVO BOTÃO MULTI FOLLOW
local multiFollowBtn = Instance.new("TextButton")
multiFollowBtn.Size = UDim2.new(0, 120, 0, 24)
multiFollowBtn.Position = UDim2.new(0.5, -60, 0, 378)
multiFollowBtn.BackgroundColor3 = Color3.fromRGB(0, 100, 100)
multiFollowBtn.Text = "MULTI FOLLOW"
multiFollowBtn.TextColor3 = Color3.new(1,1,1)
multiFollowBtn.TextScaled = true
multiFollowBtn.Font = Enum.Font.GothamBold
multiFollowBtn.Parent = menuConteudo
Instance.new("UICorner", multiFollowBtn)

-- HUD KILL
local hudKillActionBtn = Instance.new("TextButton")
hudKillActionBtn.Size = UDim2.new(0, 55, 0, 55)
local carregouSucesso = false
local posicaoSalva = nil
if readfile and pcall(function() return readfile(fileName) end) then
	pcall(function()
		posicaoSalva = HttpService:JSONDecode(readfile(fileName))
		carregouSucesso = true
	end)
end
if carregouSucesso and posicaoSalva and posicaoSalva.X and posicaoSalva.Y then
	hudKillActionBtn.Position = UDim2.new(posicaoSalva.X.Scale, posicaoSalva.X.Offset, posicaoSalva.Y.Scale, posicaoSalva.Y.Offset)
else
	hudKillActionBtn.Position = UDim2.new(1, -190, 1, -65)
end
hudKillActionBtn.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
hudKillActionBtn.Text = "KILL"
hudKillActionBtn.TextColor3 = Color3.new(1, 1, 1)
hudKillActionBtn.TextScaled = true
hudKillActionBtn.Font = Enum.Font.GothamBold
hudKillActionBtn.Visible = false
hudKillActionBtn.Parent = gui
Instance.new("UICorner", hudKillActionBtn).CornerRadius = UDim.new(1, 0)

local lockCamBtn = Instance.new("TextButton")
lockCamBtn.Size = UDim2.new(0, 50, 0, 50)
lockCamBtn.Position = UDim2.new(1, -70, 0.35, 0)
lockCamBtn.BackgroundColor3 = Color3.fromRGB(30,30,30)
lockCamBtn.Text = "🔓"
lockCamBtn.TextSize = 25
lockCamBtn.Visible = false
lockCamBtn.Parent = gui
Instance.new("UICorner", lockCamBtn).CornerRadius = UDim.new(1,0)

local function criarBotaoDirecional(text, defaultPos, bgCol)
	local b = Instance.new("TextButton")
	b.Size = UDim2.new(0, 55, 0, 55)
	b.Position = defaultPos
	b.BackgroundColor3 = bgCol or Color3.fromRGB(0, 150, 70)
	b.Text = text
	b.TextColor3 = Color3.new(1, 1, 1)
	b.TextSize = 22
	b.Font = Enum.Font.GothamBold
	b.Visible = false
	b.Parent = gui
	Instance.new("UICorner", b)
	return b
end

local motoUpBtn       = criarBotaoDirecional("↑ ALT", UDim2.new(0, 35, 1, -150))
local motoDownBtn     = criarBotaoDirecional("↓ ALT", UDim2.new(0, 35, 1, -85))
local motoForwardBtn  = criarBotaoDirecional("↑", UDim2.new(1, -120, 1, -150))
local motoBackwardBtn = criarBotaoDirecional("↓", UDim2.new(1, -120, 1, -85))
local motoLeftBtn     = criarBotaoDirecional("←", UDim2.new(1, -180, 1, -115)) 
local motoRightBtn    = criarBotaoDirecional("→", UDim2.new(1, -60, 1, -115))  
local flyForwardBtn  = criarBotaoDirecional("↑", UDim2.new(1, -105, 0.55, 0), Color3.fromRGB(25, 25, 25))
local flyUpBtn       = criarBotaoDirecional("⬆", UDim2.new(1, -105, 0.55, 55), Color3.fromRGB(25, 25, 25))
local flyLeftBtn     = criarBotaoDirecional("←", UDim2.new(1, -150, 0.55, 55), Color3.fromRGB(25, 25, 25))
local flyRightBtn    = criarBotaoDirecional("→", UDim2.new(1, -60, 0.55, 55), Color3.fromRGB(25, 25, 25))
for _, fb in pairs({flyForwardBtn, flyUpBtn, flyLeftBtn, flyRightBtn}) do fb.TextSize = 20 end

local carregouLayout = false
local layoutSalvo = nil
if readfile and pcall(function() return readfile(layoutFileName) end) then
	pcall(function()
		layoutSalvo = HttpService:JSONDecode(readfile(layoutFileName))
		carregouLayout = true
	end)
end

local listaMotoBotoes = {
	M_Up = motoUpBtn, M_Down = motoDownBtn, 
	M_Forward = motoForwardBtn, M_Backward = motoBackwardBtn,
	M_Left = motoLeftBtn, M_Right = motoRightBtn
}
local listaFlyBotoes = {
	F_Forward = flyForwardBtn, F_Up = flyUpBtn, F_Left = flyLeftBtn, F_Right = flyRightBtn
}

if carregouLayout and layoutSalvo then
	for chave, btn in pairs(listaMotoBotoes) do
		if layoutSalvo[chave] then
			btn.Position = UDim2.new(layoutSalvo[chave].X.Scale, layoutSalvo[chave].X.Offset, layoutSalvo[chave].Y.Scale, layoutSalvo[chave].Y.Offset)
		end
	end
	for chave, btn in pairs(listaFlyBotoes) do
		if layoutSalvo[chave] then
			btn.Position = UDim2.new(layoutSalvo[chave].X.Scale, layoutSalvo[chave].X.Offset, layoutSalvo[chave].Y.Scale, layoutSalvo[chave].Y.Offset)
		end
	end
end

-- ==========================================
-- MULTI FOLLOW SYSTEM (V16 INTEGRATED)
-- ==========================================
local listFrame = Instance.new("Frame")
listFrame.Size = UDim2.new(0, 280, 0, 250) 
listFrame.Position = UDim2.new(0, 200, 0.2, 0)
listFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
listFrame.BorderSizePixel = 0
listFrame.Visible = false
listFrame.Parent = gui
Instance.new("UICorner", listFrame).CornerRadius = UDim.new(0, 10)
listFrame.Active = true
listFrame.Draggable = true

local listTitle = Instance.new("TextLabel")
listTitle.Size = UDim2.new(1, -30, 0, 25)
listTitle.Position = UDim2.new(0, 10, 0, 2)
listTitle.BackgroundTransparency = 1
listTitle.Text = "Jogadores (Incluindo Você)"
listTitle.TextColor3 = Color3.new(1, 1, 1)
listTitle.TextXAlignment = Enum.TextXAlignment.Left
listTitle.TextSize = 14
listTitle.Font = Enum.Font.GothamBold
listTitle.Parent = listFrame

local closeListBtn = Instance.new("TextButton")
closeListBtn.Size = UDim2.new(0, 20, 0, 20)
closeListBtn.Position = UDim2.new(1, -25, 0, 3)
closeListBtn.BackgroundColor3 = Color3.fromRGB(170, 0, 0)
closeListBtn.Text = "X"
closeListBtn.TextColor3 = Color3.new(1, 1, 1)
closeListBtn.TextSize = 14
closeListBtn.Font = Enum.Font.GothamBold
closeListBtn.Parent = listFrame
Instance.new("UICorner", closeListBtn).CornerRadius = UDim.new(0, 5)

local scrollFrame = Instance.new("ScrollingFrame")
scrollFrame.Size = UDim2.new(1, -10, 1, -35)
scrollFrame.Position = UDim2.new(0, 5, 0, 30)
scrollFrame.BackgroundTransparency = 1
scrollFrame.ScrollBarThickness = 5
scrollFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
scrollFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
scrollFrame.Parent = listFrame

local uiListLayout = Instance.new("UIListLayout")
uiListLayout.SortOrder = Enum.SortOrder.LayoutOrder
uiListLayout.Padding = UDim.new(0, 4)
uiListLayout.Parent = scrollFrame

local followSlots = {}
for i = 1, 4 do
    followSlots[i] = { 
        target = nil, 
        enabled = false, 
        savedPosition = nil, 
        targetObject = nil,
        btnRef = nil,
        assignedSeat = nil 
    }
end

local function getSafePrimaryPart(model)
    if not model then return nil end
    if model.PrimaryPart then return model.PrimaryPart end
    local hrp = model:FindFirstChild("HumanoidRootPart")
    if hrp and hrp:IsA("BasePart") then return hrp end
    for _, part in pairs(model:GetDescendants()) do
        if part:IsA("BasePart") and (part.Name:lower():find("chassis") or part.Name:lower():find("body")) then
            return part
        end
    end
    return model:FindFirstChildWhichIsA("BasePart")
end

local function unanchorVehicle(model)
    if not model then return end
    for _, part in pairs(model:GetDescendants()) do
        if part:IsA("BasePart") then pcall(function() part.Anchored = false end) end
    end
end

local function returnToSavedPosition(slotIndex)
    local slot = followSlots[slotIndex]
    
    if slot.savedPosition and slot.targetObject then
        pcall(function()
            if slot.targetObject:IsA("Model") then
                unanchorVehicle(slot.targetObject)
            end
            
            if slot.targetObject:IsA("BasePart") then 
                slot.targetObject.CFrame = slot.savedPosition
                slot.targetObject.Velocity = Vector3.zero
                slot.targetObject.RotVelocity = Vector3.zero
            elseif slot.targetObject:IsA("Model") then 
                local pp = getSafePrimaryPart(slot.targetObject)
                if pp then 
                    pp.CFrame = slot.savedPosition
                    if pp.Velocity then pp.Velocity = Vector3.zero end
                    if pp.RotVelocity then pp.RotVelocity = Vector3.zero end
                end
            end
        end)
    end
    
    slot.savedPosition = nil
    slot.targetObject = nil
    slot.assignedSeat = nil
    
    if slot.btnRef then
        slot.btnRef.Text = "OFF"
        slot.btnRef.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    end
    slot.enabled = false
    slot.target = nil
end

local function toggleSlot(slotIndex, btn, plr)
    local slot = followSlots[slotIndex]
    slot.btnRef = btn 
    
    if slot.enabled and slot.target == plr then
        returnToSavedPosition(slotIndex)
        
    else
        slot.target = plr
        slot.enabled = true
        
        local currentSeat = humanoid.SeatPart
        local detectedObj = nil
        
        local seatAlreadyTaken = false
        for i = 1, 4 do
            if i ~= slotIndex and followSlots[i].enabled and followSlots[i].assignedSeat == currentSeat then
                seatAlreadyTaken = true
                break
            end
        end
        
        if currentSeat and currentSeat:IsA("VehicleSeat") and not seatAlreadyTaken then
            detectedObj = currentSeat:FindFirstAncestorOfClass("Model")
            slot.assignedSeat = currentSeat
            if detectedObj then unanchorVehicle(detectedObj) end
        else
            detectedObj = root
            slot.assignedSeat = nil
        end
        
        slot.targetObject = detectedObj
        
        if slot.targetObject then
            pcall(function()
                if slot.targetObject:IsA("BasePart") then slot.savedPosition = slot.targetObject.CFrame
                elseif slot.targetObject:IsA("Model") then 
                    local pp = getSafePrimaryPart(slot.targetObject)
                    if pp then slot.savedPosition = pp.CFrame end
                end
            end)
        end
        
        -- TP Inicial
        if plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") and slot.targetObject then
            pcall(function()
                local targetPos = plr.Character.HumanoidRootPart.Position + Vector3.new(5, 5, 0)
                if slot.targetObject:IsA("BasePart") then slot.targetObject.CFrame = CFrame.new(targetPos)
                elseif slot.targetObject:IsA("Model") then 
                    local pp = getSafePrimaryPart(slot.targetObject)
                    if pp then pp.CFrame = CFrame.new(targetPos) end
                end
            end)
        end
        
        btn.Text = "ON"
        btn.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
    end
end

local function addPlayerToList(plr)
    for _, child in pairs(scrollFrame:GetChildren()) do
        if child:IsA("Frame") and child:FindFirstChildWhichIsA("TextLabel") then
            if child:FindFirstChildWhichIsA("TextLabel").Text == plr.Name then return end
        end
    end

    local itemFrame = Instance.new("Frame")
    itemFrame.Size = UDim2.new(1, 0, 0, 30)
    itemFrame.BackgroundTransparency = 1
    itemFrame.Parent = scrollFrame

    local nameLabel = Instance.new("TextLabel")
    nameLabel.Size = UDim2.new(1, -165, 1, 0)
    nameLabel.BackgroundTransparency = 1
    nameLabel.Text = plr.Name
    nameLabel.TextColor3 = Color3.new(1, 1, 1)
    nameLabel.TextXAlignment = Enum.TextXAlignment.Left
    nameLabel.TextSize = 14
    nameLabel.Font = Enum.Font.GothamBold
    nameLabel.Parent = itemFrame

    local btnContainer = Instance.new("Frame")
    btnContainer.Size = UDim2.new(0, 160, 1, 0)
    btnContainer.Position = UDim2.new(1, -160, 0, 0)
    btnContainer.BackgroundTransparency = 1
    btnContainer.Parent = itemFrame

    local btnLayout = Instance.new("UIListLayout")
    btnLayout.FillDirection = Enum.FillDirection.Horizontal
    btnLayout.SortOrder = Enum.SortOrder.LayoutOrder
    btnLayout.Padding = UDim.new(0, 4)
    btnLayout.Parent = btnContainer

    for i = 1, 4 do
        local slot = followSlots[i]
        local isActive = (slot.enabled and slot.target == plr)
        
        local initialText = isActive and "ON" or "OFF"
        local initialColor = isActive and Color3.fromRGB(0, 170, 0) or Color3.fromRGB(40, 40, 40)

        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(0, 38, 1, 0)
        btn.BackgroundColor3 = initialColor
        btn.Text = initialText
        btn.TextColor3 = Color3.new(1, 1, 1)
        btn.TextSize = 10
        btn.Font = Enum.Font.GothamBold
        btn.Parent = btnContainer
        Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 4)
        
        slot.btnRef = btn
        btn.MouseButton1Click:Connect(function()
            toggleSlot(i, btn, plr)
        end)
    end
end

local function removePlayerFromList(plr)
    for _, child in pairs(scrollFrame:GetChildren()) do
        if child:IsA("Frame") and child:FindFirstChildWhichIsA("TextLabel") then
            if child:FindFirstChildWhichIsA("TextLabel").Text == plr.Name then
                child:Destroy()
                break
            end
        end
    end
    
    for i = 1, 4 do
        local slot = followSlots[i]
        if slot.target == plr then
            returnToSavedPosition(i)
        end
    end
end

local function updatePlayerList()
    for _, child in pairs(scrollFrame:GetChildren()) do
        if child:IsA("Frame") then child:Destroy() end
    end
    for _, plr in pairs(Players:GetPlayers()) do addPlayerToList(plr) end
end

multiFollowBtn.MouseButton1Click:Connect(function()
    listFrame.Visible = not listFrame.Visible
    if listFrame.Visible then updatePlayerList() end
end)

closeListBtn.MouseButton1Click:Connect(function() listFrame.Visible = false end)
Players.PlayerAdded:Connect(function(plr) if listFrame.Visible then addPlayerToList(plr) end end)
Players.PlayerRemoving:Connect(removePlayerFromList)

humanoid:GetPropertyChangedSignal("SeatPart"):Connect(function()
    local currentSeat = humanoid.SeatPart
    for i = 1, 4 do
        local slot = followSlots[i]
        if slot.enabled and slot.assignedSeat == currentSeat and currentSeat == nil then
            slot.assignedSeat = nil
        end
    end
end)

player.CharacterAdded:Connect(function(char)
    character = char
    humanoid = char:WaitForChild("Humanoid", 10)
    root = char:WaitForChild("HumanoidRootPart", 10)
    
    humanoid:GetPropertyChangedSignal("SeatPart"):Connect(function()
        local currentSeat = humanoid.SeatPart
        for i = 1, 4 do
            local slot = followSlots[i]
            if slot.enabled and slot.assignedSeat == currentSeat and currentSeat == nil then
                slot.assignedSeat = nil
            end
        end
    end)

    for i = 1, 4 do
        local slot = followSlots[i]
        if slot.enabled and slot.targetObject and not slot.targetObject:IsA("Model") then
             slot.targetObject = root
        else
             returnToSavedPosition(i)
        end
    end
end)

-- ==========================================
-- VARIAVEIS GLOBAIS DO SCRIPT ORIGINAL
-- ==========================================
local flying = false
local killSystemEnabled = false
local canMoveButton = false
local canMoveLayout = false
local antiSitEnabled = false
local espEnabled = false
local namesEnabled = false
local freezeEnabled = false
local isTeleporting = false
local motoEnabled = false
local camLockEnabled = false

local bodyVelocity
local bodyGyro
local freezePosition
local motoTargetHeight = 0
local motoHeightConstraint = nil
local atualMotoVelocidade = 0 
local tempoSegurandoBotao = 0

_G.holdForward, _G.holdBackward, _G.holdUp, _G.holdDown, _G.holdLeft, _G.holdRight = false, false, false, false, false, false
local isTouchingScreen = false

UserInputService.TouchStarted:Connect(function(_, processed) if not processed then isTouchingScreen = true end end)
UserInputService.TouchEnded:Connect(function(_, _) isTouchingScreen = false end)

local highlights = {}
local tracers = {}
local nameGuis = {}

-- FUNÇÕES DE LIMPEZA E CRIAÇÃO ESP/NAMES

local function removeESP(plr)
	if highlights[plr] then 
		pcall(function() highlights[plr]:Destroy() end) 
		highlights[plr] = nil 
	end
	if tracers[plr] then 
		pcall(function() tracers[plr]:Remove() end) 
		tracers[plr] = nil 
	end
end

local function removeNameTag(plr)
	if nameGuis[plr] then 
		pcall(function() nameGuis[plr]:Destroy() end) 
		nameGuis[plr] = nil 
	end
end

local function createESP(plr)
	if plr == player then return end
	removeESP(plr)
	
	local function apply()
		if not plr.Character or not plr.Character:FindFirstChild("HumanoidRootPart") then return end
		removeESP(plr)
		
		local h = Instance.new("Highlight")
		h.FillColor = Color3.fromRGB(255,0,0)
		h.OutlineColor = Color3.fromRGB(255,255,255)
		h.FillTransparency = 0.5
		h.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
		h.Parent = plr.Character
		highlights[plr] = h

		local line = Drawing.new("Line")
		line.Visible = false
		line.Thickness = 2
		line.Color = Color3.fromRGB(0,70,255)
		line.ZIndex = 2
		tracers[plr] = line
	end
	
	apply()
	plr.CharacterAdded:Connect(function() 
		task.wait(0.5) 
		if espEnabled then apply() end 
	end)
end

Players.PlayerAdded:Connect(function(plr)
	task.wait(1)
	if espEnabled then createESP(plr) end
end)

local function createNameLabel(plr)
	if plr == player then return end
	removeNameTag(plr)
	
	local billboard = Instance.new("BillboardGui")
	billboard.Size = UDim2.new(0, 200, 0, 40)
	billboard.StudsOffsetWorldSpace = Vector3.new(0, 3.5, 0)
	billboard.AlwaysOnTop = true
	billboard.Parent = gui
	
	local label = Instance.new("TextLabel")
	label.Size = UDim2.new(1, 0, 1, 0)
	label.BackgroundTransparency = 1
	label.Text = plr.Name
	label.TextColor3 = Color3.fromRGB(0, 255, 0)
	label.Font = Enum.Font.GothamBold
	label.TextSize = 14
	label.TextStrokeTransparency = 0
	label.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
	label.Parent = billboard
	
	nameGuis[plr] = billboard
	
	plr.CharacterAdded:Connect(function()
		if namesEnabled and nameGuis[plr] then
			if plr.Character and plr.Character:FindFirstChild("Head") then
				nameGuis[plr].Adornee = plr.Character.Head
				nameGuis[plr].Enabled = true
			end
		end
	end)
end

Players.PlayerRemoving:Connect(function(plr)
	removeESP(plr)
	removeNameTag(plr)
end)

-----------------------------------------------------------------------
-- CONEXÕES DOS BOTÕES ORIGINAIS
-----------------------------------------------------------------------

espBtn.MouseButton1Click:Connect(function()
	espEnabled = not espEnabled
	espBtn.Text = espEnabled and "ESP ON" or "ESP OFF"
	espBtn.BackgroundColor3 = espEnabled and Color3.fromRGB(0,170,0) or Color3.fromRGB(40,40,40)
	if espEnabled then 
		for _,p in pairs(Players:GetPlayers()) do createESP(p) end 
	else 
		for _,p in pairs(Players:GetPlayers()) do removeESP(p) end 
	end
end)

nameBtn.MouseButton1Click:Connect(function()
	namesEnabled = not namesEnabled
	nameBtn.Text = namesEnabled and "NAMES ON" or "NAMES OFF"
	nameBtn.BackgroundColor3 = namesEnabled and Color3.fromRGB(0,170,0) or Color3.fromRGB(40,40,40)
	if namesEnabled then
		for _, plr in pairs(Players:GetPlayers()) do 
			if plr ~= player then createNameLabel(plr) end
		end
	else 
		for _, plr in pairs(Players:GetPlayers()) do removeNameTag(plr) end 
	end
end)

plusBtn.MouseButton1Click:Connect(function() speedBox.Text = tostring((tonumber(speedBox.Text) or 100) + 100) end)
minusBtn.MouseButton1Click:Connect(function() speedBox.Text = tostring(math.max(0, (tonumber(speedBox.Text) or 100) - 100)) end)
motoPlusBtn.MouseButton1Click:Connect(function() motoSpeedBox.Text = tostring((tonumber(motoSpeedBox.Text) or 50) + 10) end)
motoMinusBtn.MouseButton1Click:Connect(function() motoSpeedBox.Text = tostring(math.max(0, (tonumber(motoSpeedBox.Text) or 50) - 10)) end)

local function startFly()
	if bodyVelocity or bodyGyro then return end
	bodyVelocity = Instance.new("BodyVelocity", root)
	bodyVelocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
	bodyVelocity.Velocity = Vector3.zero
	
	bodyGyro = Instance.new("BodyGyro", root)
	bodyGyro.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
	bodyGyro.P = 10000
	bodyGyro.CFrame = root.CFrame
end

local function stopFly()
	if bodyVelocity then bodyVelocity:Destroy() bodyVelocity = nil end
	if bodyGyro then bodyGyro:Destroy() bodyGyro = nil end
	if motoHeightConstraint then motoHeightConstraint:Destroy() motoHeightConstraint = nil end
	_G.holdForward, _G.holdBackward, _G.holdUp, _G.holdDown, _G.holdLeft, _G.holdRight = false, false, false, false, false, false
	atualMotoVelocidade = 0
	tempoSegurandoBotao = 0
end

freezeBtn.MouseButton1Click:Connect(function()
	freezeEnabled = not freezeEnabled
	freezeBtn.Text = freezeEnabled and "ON" or "STOP"
	freezeBtn.BackgroundColor3 = freezeEnabled and Color3.fromRGB(0,170,0) or Color3.fromRGB(40,40,40)
	if freezeEnabled then 
		freezePosition = root.Position 
		if bodyVelocity then bodyVelocity.Velocity = Vector3.zero end
	end
end)

carCatchBtn.MouseButton1Click:Connect(function()
	local assento = nil
	for _, obj in pairs(workspace:GetDescendants()) do
		if obj:IsA("VehicleSeat") then if (root.Position - obj.Position).Magnitude < 40 then assento = obj break end end
	end
	if assento then root.CFrame = assento.CFrame; task.wait(0.08); assento:Sit(humanoid) end
end)

carThrowBtn.MouseButton1Click:Connect(function()
	local assentoAtivo = humanoid.SeatPart
	if assentoAtivo and assentoAtivo:IsA("VehicleSeat") then
		local localDoLancamento = root.CFrame
		local estavaVoando = flying 
		stopFly()
		local forcaFinal = Camera.CFrame.LookVector * math.max(250, (tonumber(speedBox.Text) or 100) * 3.2)
		local modeloCarro = assentoAtivo.Parent
		if modeloCarro then
			for _, p in pairs(modeloCarro:GetDescendants()) do if p:IsA("BasePart") then p.Anchored = false; p.AssemblyLinearVelocity = forcaFinal end end
		else assentoAtivo.Anchored = false; assentoAtivo.AssemblyLinearVelocity = forcaFinal end
		task.spawn(function()
			task.wait(0.05); humanoid.Sit = false; task.wait(0.01); root.AssemblyLinearVelocity = Vector3.zero; root.CFrame = localDoLancamento
			if estavaVoando then startFly() end
		end)
	end
end)

killToggleBtn.MouseButton1Click:Connect(function()
	killSystemEnabled = not killSystemEnabled
	killToggleBtn.Text = killSystemEnabled and "KILL TELEPORT ON" or "KILL TELEPORT OFF"
	killToggleBtn.BackgroundColor3 = killSystemEnabled and Color3.fromRGB(0, 170, 0) or Color3.fromRGB(0,0,0)
	hudKillActionBtn.Visible = killSystemEnabled
end)

moveToggleBtn.MouseButton1Click:Connect(function()
	canMoveButton = not canMoveButton
	moveToggleBtn.Text = canMoveButton and "MOVER KILL: ON" or "MOVER KILL: OFF"
	moveToggleBtn.BackgroundColor3 = canMoveButton and Color3.fromRGB(0, 170, 0) or Color3.fromRGB(0, 0, 0)
	hudKillActionBtn.Active = canMoveButton
	hudKillActionBtn.Draggable = canMoveButton
	if not canMoveButton and writefile then
		pcall(function()
			local pos = hudKillActionBtn.Position
			local dados = {X = {Scale = pos.X.Scale, Offset = pos.X.Offset}, Y = {Scale = pos.Y.Scale, Offset = pos.Y.Offset}}
			writefile(fileName, HttpService:JSONEncode(dados))
		end)
	end
end)

layoutToggleBtn.MouseButton1Click:Connect(function()
	canMoveLayout = not canMoveLayout
	layoutToggleBtn.Text = canMoveLayout and "EDIT: ON" or "EDIT: OFF"
	layoutToggleBtn.BackgroundColor3 = canMoveLayout and Color3.fromRGB(0, 170, 0) or Color3.fromRGB(100, 0, 100)
	
	for chave, btn in pairs(listaMotoBotoes) do
		btn.Active = canMoveLayout
		btn.Draggable = canMoveLayout
		if canMoveLayout then
			btn.Visible = true
		else
			btn.Visible = motoEnabled
		end
	end
	
	if canMoveLayout then
		for _, fBtn in pairs(listaFlyBotoes) do fBtn.Visible = false end
	else
		if flying then
			for _, fBtn in pairs(listaFlyBotoes) do fBtn.Visible = true end
		end
	end
	
	if not canMoveLayout and writefile then
		pcall(function()
			local layoutDados = {}
			for chave, btn in pairs(listaMotoBotoes) do
				local bp = btn.Position
				layoutDados[chave] = {X = {Scale = bp.X.Scale, Offset = bp.X.Offset}, Y = {Scale = bp.Y.Scale, Offset = bp.Y.Offset}}
			end
			for chave, btn in pairs(listaFlyBotoes) do
				local bp = btn.Position
				layoutDados[chave] = {X = {Scale = bp.X.Scale, Offset = bp.X.Offset}, Y = {Scale = bp.Y.Scale, Offset = bp.Y.Offset}}
			end
			writefile(layoutFileName, HttpService:JSONEncode(layoutDados))
		end)
	end
end)

antiSitToggleBtn.MouseButton1Click:Connect(function()
	antiSitEnabled = not antiSitEnabled
	antiSitToggleBtn.Text = antiSitEnabled and "ANTI SIT: ON" or "ANTI SIT: OFF"
	antiSitToggleBtn.BackgroundColor3 = antiSitEnabled and Color3.fromRGB(0, 170, 0) or Color3.fromRGB(0,0,0)
	
	if antiSitEnabled and humanoid then 
		humanoid.Sit = false 
	end
end)

hudKillActionBtn.MouseButton1Click:Connect(function()
	if isTeleporting or not killSystemEnabled or canMoveButton then return end
	local backpack = player:FindFirstChild("Backpack")
	if not backpack then return end
	local item = backpack:FindFirstChildOfClass("Tool")
	if not item then return end
	
	isTeleporting = true
	local oldCFrame = root.CFrame
	local estavaVoando = flying
	
	humanoid:EquipTool(item)
	task.wait(0.05)
	if estavaVoando then stopFly() end
	
	local zonaMortePosicao = Vector3.new(root.Position.X, -450, root.Position.Z)
	root.CFrame = CFrame.new(zonaMortePosicao)
	root.AssemblyLinearVelocity = Vector3.zero
	
	local travaSeguranca = Instance.new("BodyVelocity")
	travaSeguranca.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
	travaSeguranca.Velocity = Vector3.zero
	travaSeguranca.Parent = root
	
	local ferramentaEquipada = character:FindFirstChildOfClass("Tool")
	if ferramentaEquipada then
		ferramentaEquipada:Activate()
		task.wait(0.35)
		ferramentaEquipada.Parent = backpack
	end
	
	task.wait(0.1)
	travaSeguranca:Destroy()
	root.AssemblyLinearVelocity = Vector3.zero
	root.CFrame = oldCFrame
	
	if estavaVoando then startFly() end
	isTeleporting = false
end)

toggle.MouseButton1Click:Connect(function()
	flying = not flying
	if flying and motoEnabled then 
		motoEnabled = false
		motoToggleBtn.Text = "MOTO CONTROLES"
		motoToggleBtn.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
		for _, b in pairs(listaMotoBotoes) do b.Visible = false end
		lockCamBtn.Visible = false
	end
	toggle.Text = flying and "FLY ON" or "FLY OFF"
	toggle.BackgroundColor3 = flying and Color3.fromRGB(0,170,0) or Color3.fromRGB(40,40,40)
	
	if flying then
		if not canMoveLayout then for _, fBtn in pairs(listaFlyBotoes) do fBtn.Visible = true end end
		startFly() 
	else 
		if not canMoveLayout then for _, fBtn in pairs(listaFlyBotoes) do fBtn.Visible = false end end
		stopFly() 
	end
end)

motoToggleBtn.MouseButton1Click:Connect(function()
	motoEnabled = not motoEnabled
	if motoEnabled then
		if flying then 
			flying = false
			toggle.Text = "FLY OFF"
			toggle.BackgroundColor3 = Color3.fromRGB(40,40,40)
			for _, fBtn in pairs(listaFlyBotoes) do fBtn.Visible = false end
		end
		stopFly()
		
		motoTargetHeight = root.Position.Y
		motoHeightConstraint = Instance.new("BodyPosition", root)
		motoHeightConstraint.MaxForce = Vector3.new(0, math.huge, 0)
		motoHeightConstraint.D = 400
		motoHeightConstraint.P = 6000
		motoHeightConstraint.Position = Vector3.new(0, motoTargetHeight, 0)
		
		motoToggleBtn.Text = "MOTO: ATIVA"
		motoToggleBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
		
		if not canMoveLayout then for _, b in pairs(listaMotoBotoes) do b.Visible = true end end
		lockCamBtn.Visible = true
	else
		motoToggleBtn.Text = "MOTO CONTROLES"
		motoToggleBtn.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
		if not canMoveLayout then for _, b in pairs(listaMotoBotoes) do b.Visible = false end end
		lockCamBtn.Visible = false
		camLockEnabled = false
		lockCamBtn.Text = "🔓"
		stopFly()
	end
end)

lockCamBtn.MouseButton1Click:Connect(function()
	camLockEnabled = not camLockEnabled
	lockCamBtn.Text = camLockEnabled and "🔒" or ""
	lockCamBtn.BackgroundColor3 = camLockEnabled and Color3.fromRGB(0, 170, 0) or Color3.fromRGB(30, 30, 30)
end)

local function vincularAcaoBotao(btn, varAlvo)
	btn.MouseButton1Down:Connect(function() 
		if not canMoveLayout then 
			_G[varAlvo] = true 
			if varAlvo == "holdDown" and motoHeightConstraint then
				motoHeightConstraint:Destroy()
				motoHeightConstraint = nil
			end
		end 
	end)
	btn.MouseButton1Up:Connect(function() 
		_G[varAlvo] = false 
		
		if varAlvo == "holdForward" or varAlvo == "holdBackward" then
			tempoSegurandoBotao = 0
			atualMotoVelocidade = 0
		end
		
		if flying and varAlvo == "holdUp" and bodyVelocity then 
			bodyVelocity.Velocity = Vector3.zero 
		end 
		if varAlvo == "holdDown" and motoEnabled and not motoHeightConstraint then
			motoTargetHeight = root.Position.Y
			motoHeightConstraint = Instance.new("BodyPosition", root)
			motoHeightConstraint.MaxForce = Vector3.new(0, math.huge, 0)
			motoHeightConstraint.D = 400
			motoHeightConstraint.P = 6000
			motoHeightConstraint.Position = Vector3.new(0, motoTargetHeight, 0)
		end
	end)
end

vincularAcaoBotao(flyForwardBtn, "holdForward")
vincularAcaoBotao(flyUpBtn, "holdUp")
vincularAcaoBotao(flyLeftBtn, "holdLeft")
vincularAcaoBotao(flyRightBtn, "holdRight")

vincularAcaoBotao(motoForwardBtn, "holdForward")
vincularAcaoBotao(motoBackwardBtn, "holdBackward")
vincularAcaoBotao(motoUpBtn, "holdUp")
vincularAcaoBotao(motoDownBtn, "holdDown")
vincularAcaoBotao(motoLeftBtn, "holdLeft")
vincularAcaoBotao(motoRightBtn, "holdRight")

-- ==========================================
-- LOOP PRINCIPAL UNIFICADO
-- ==========================================
local timeOffset = 0

RunService.RenderStepped:Connect(function(deltaTime)
	Camera.CameraType = Enum.CameraType.Custom
	timeOffset = timeOffset + deltaTime

	if not isTouchingScreen and (motoEnabled or flying) then
		Camera.CameraType = Enum.CameraType.Track
		Camera.CameraType = Enum.CameraType.Custom
	end

	-- ESP LINES
	for plr, line in pairs(tracers) do
		if plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
			local enemyRoot = plr.Character.HumanoidRootPart
			local pos, visible = Camera:WorldToViewportPoint(enemyRoot.Position)
			
			if pos.Z > 0 and ((visible) or (highlights[plr] and highlights[plr].Parent)) then
				line.Visible = true
				line.From = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y) 
				line.To = Vector2.new(pos.X, pos.Y)
			else
				line.Visible = false
			end
		else 
			line.Visible = false 
		end
	end

	if namesEnabled then
		for _, plr in pairs(Players:GetPlayers()) do
			if plr ~= player and plr.Character and plr.Character:FindFirstChild("Head") then
				if not nameGuis[plr] then createNameLabel(plr) end
				if nameGuis[plr] then
					nameGuis[plr].Adornee = plr.Character.Head
					nameGuis[plr].Enabled = true
				end
			end
		end
	end

	if antiSitEnabled and humanoid and root and not isTeleporting then
		if humanoid.Sit then
			task.defer(function()
				if humanoid and humanoid.Sit then
					humanoid.Sit = false
				end
			end)
		end
	end

	if freezeEnabled and root and not humanoid.SeatPart and not isTeleporting then
		root.AssemblyLinearVelocity = Vector3.zero
		root.CFrame = CFrame.new(freezePosition)
		humanoid.Sit = false
		return
	end

	-- ==========================================
	-- MULTI FOLLOW LOOP (V16)
	-- ==========================================
	for i = 1, 4 do
        local slot = followSlots[i]
        if slot.enabled and slot.target and slot.target.Character then
            local targetHRP = slot.target.Character:FindFirstChild("HumanoidRootPart")
            if not targetHRP then continue end
            
            -- Detecção de pulo
            if slot.assignedSeat and humanoid.SeatPart ~= slot.assignedSeat then
                -- Não desativa, apenas limpa o assento atribuído para permitir Network Ownership
                slot.assignedSeat = nil
            end
            
            if slot.targetObject then
                -- ✅ FORÇAR NETWORK OWNERSHIP
                pcall(function()
                    if slot.targetObject:IsA("BasePart") then
                        slot.targetObject:SetNetworkOwner(player)
                    elseif slot.targetObject:IsA("Model") then
                        local pp = getSafePrimaryPart(slot.targetObject)
                        if pp then pp:SetNetworkOwner(player) end
                    end
                end)

                local heightOffset = (slot.targetObject == root) and 8 or 6
                
                -- ✅ OSCILAÇÃO EXTREMA
                local oscillation = math.sin(timeOffset * 40) * 8 
                
                -- ✅ POSIÇÃO À FRENTE DO INIMIGO
                local forwardOffset = targetHRP.CFrame.LookVector * -6 
                
                local targetPos = targetHRP.Position + forwardOffset + Vector3.new(0, heightOffset + oscillation, 0)
                
                pcall(function()
                    if slot.targetObject:IsA("BasePart") then
                        slot.targetObject.CFrame = CFrame.new(targetPos)
                        slot.targetObject.Velocity = Vector3.zero
                        slot.targetObject.RotVelocity = Vector3.zero
                    elseif slot.targetObject:IsA("Model") then
                        local pp = getSafePrimaryPart(slot.targetObject)
                        if pp then 
                            pp.CFrame = CFrame.new(targetPos)
                            if pp.Velocity then pp.Velocity = Vector3.zero end
                            if pp.RotVelocity then pp.RotVelocity = Vector3.zero end
                        end
                    end
                end)
            end
        end
    end

	-- MOTO LOGIC
	if motoEnabled then
		if not root then return end
		local mSpeed = tonumber(motoSpeedBox.Text) or 50
		root.AssemblyAngularVelocity = Vector3.zero

		if _G.holdUp then
			if not motoHeightConstraint then
				motoTargetHeight = root.Position.Y
				motoHeightConstraint = Instance.new("BodyPosition", root)
				motoHeightConstraint.MaxForce = Vector3.new(0, math.huge, 0)
				motoHeightConstraint.D = 400
				motoHeightConstraint.P = 6000
			end
			motoHeightConstraint.MaxForce = Vector3.new(0, math.huge, 0)
			motoTargetHeight = motoTargetHeight + 0.6
		elseif _G.holdDown then
			if motoHeightConstraint then 
				motoHeightConstraint:Destroy() 
				motoHeightConstraint = nil 
			end
			root.AssemblyLinearVelocity = Vector3.new(root.AssemblyLinearVelocity.X, -180, root.AssemblyLinearVelocity.Z)
		else
			if not _G.holdUp and not _G.holdDown then
				if not motoHeightConstraint then
					motoTargetHeight = root.Position.Y
					motoHeightConstraint = Instance.new("BodyPosition", root)
					motoHeightConstraint.MaxForce = Vector3.new(0, math.huge, 0)
					motoHeightConstraint.D = 400
					motoHeightConstraint.P = 6000
				end
				motoHeightConstraint.MaxForce = Vector3.new(0, math.huge, 0)
				motoTargetHeight = root.Position.Y
			end
		end
		
		if motoHeightConstraint then motoHeightConstraint.Position = Vector3.new(0, motoTargetHeight, 0) end

		if _G.holdLeft then
			root.CFrame *= CFrame.Angles(0, math.rad(8.0), 0)
		elseif _G.holdRight then
			root.CFrame *= CFrame.Angles(0, math.rad(-8.0), 0)
		end

		local look = Camera.CFrame.LookVector
		local targetLook = Vector3.new(look.X, 0, look.Z).Unit
		
		if camLockEnabled then
			root.CFrame = CFrame.lookAt(root.Position, root.Position + targetLook)
			Camera.Focus = root.CFrame
		else
			local _, ry, _ = root.CFrame:ToOrientation()
			root.CFrame = CFrame.new(root.Position) * CFrame.fromOrientation(0, ry, 0)
		end
		
		if _G.holdForward or _G.holdBackward then
			tempoSegurandoBotao = tempoSegurandoBotao + deltaTime
			atualMotoVelocidade = math.min(mSpeed, tempoSegurandoBotao * 35)
		else
			tempoSegurandoBotao = 0
			atualMotoVelocidade = 0
		end
		
		if _G.holdForward then
			local direcaoVetor = camLockEnabled and targetLook or root.CFrame.LookVector
			root.AssemblyLinearVelocity = Vector3.new(direcaoVetor.X * atualMotoVelocidade, root.AssemblyLinearVelocity.Y, direcaoVetor.Z * atualMotoVelocidade)
		elseif _G.holdBackward then
			local direcaoVetor = camLockEnabled and targetLook or root.CFrame.LookVector
			root.AssemblyLinearVelocity = Vector3.new(direcaoVetor.X * -atualMotoVelocidade, root.AssemblyLinearVelocity.Y, direcaoVetor.Z * -atualMotoVelocidade)
		else
			root.AssemblyLinearVelocity = Vector3.new(0, root.AssemblyLinearVelocity.Y, 0)
		end

	-- FLY LOGIC
	elseif flying and bodyVelocity and bodyGyro and not isTeleporting then
		if not root then return end
		root.AssemblyAngularVelocity = Vector3.zero
		local speed = tonumber(speedBox.Text) or 100
		
		if _G.holdLeft then root.CFrame *= CFrame.Angles(0, math.rad(-3), 0) end
		if _G.holdRight then root.CFrame *= CFrame.Angles(0, math.rad(3), 0) end
		
		if _G.holdUp then 
			bodyVelocity.Velocity = Vector3.new(0, speed, 0)
			bodyGyro.CFrame = root.CFrame
		elseif _G.holdForward then 
			bodyVelocity.Velocity = Camera.CFrame.LookVector * speed
			bodyGyro.CFrame = CFrame.lookAt(root.Position, root.Position + Camera.CFrame.LookVector) * CFrame.Angles(math.rad(-75),0,0)
		else 
			bodyVelocity.Velocity = Vector3.zero
			bodyGyro.CFrame = CFrame.lookAt(root.Position, root.Position + Camera.CFrame.LookVector) 
		end
	end
end)

player.CharacterAdded:Connect(function(char)
	character = char; humanoid = char:WaitForChild("Humanoid", 10); root = char:WaitForChild("HumanoidRootPart", 10)
	if flying then startFly() end
end)
