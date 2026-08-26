--// DELTA UNIVERSAL v20.1 - COM HELICAR INTEGRADO
local Players=game:GetService("Players")local RunService=game:GetService("RunService")local Camera=workspace.CurrentCamera
local LocalPlayer=Players.LocalPlayer local UserInputService=game:GetService("UserInputService")local HttpService=game:GetService("HttpService")
local Character=LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local Humanoid=Character:WaitForChild("Humanoid",10)local RootPart=Character:WaitForChild("HumanoidRootPart",10)
local function EB()pcall(function()game:GetService("StarterGui"):SetCoreGuiEnabled(Enum.CoreGuiType.Backpack,true)end)end EB()
LocalPlayer.CharacterAdded:Connect(function(c)task.wait(1)EB()Character=c Humanoid=c:WaitForChild("Humanoid",10)RootPart=c:WaitForChild("HumanoidRootPart",10)end)
RunService.RenderStepped:Connect(EB)
local HUI=LocalPlayer:WaitForChild("PlayerGui")
if HUI:FindFirstChild("DeltaUniversal")then HUI.DeltaUniversal:Destroy()end
if HUI:FindFirstChild("HelicarUI")then HUI.HelicarUI:Destroy()end
local C={A=false,TO=false,WC=false,SF=false,TP="HumanoidRootPart",SM=0.5,MD=300,FS="Circle",FH=25,FB=25,LW=25,RW=25}
local Circle=Drawing.new("Circle")Circle.Thickness=2 Circle.Filled=false Circle.Visible=false Circle.Color=Color3.fromRGB(255,0,0)
local Square=Drawing.new("Square")Square.Thickness=2 Square.Filled=false Square.Visible=false Square.Color=Color3.fromRGB(255,0,0)
local espSize=2 local espTransparency=0.4 local espEnabled=true local espData={}
local function createESP(p)if p==LocalPlayer then return end local dot=Drawing.new("Circle")dot.Filled=true dot.Thickness=0 dot.Transparency=espTransparency dot.Visible=false 
local sl=Drawing.new("Text")sl.Text="/"sl.Size=16 sl.Center=true sl.Outline=true sl.Transparency=espTransparency sl.Visible=false 
espData[p]={dot=dot,slash=sl}RunService.RenderStepped:Connect(function()if not espEnabled then dot.Visible=false sl.Visible=false return end
local ch=p.Character if not ch then dot.Visible=false sl.Visible=false return end
local rt=ch:FindFirstChild("HumanoidRootPart")local hm=ch:FindFirstChildOfClass("Humanoid")if not rt or not hm then dot.Visible=false sl.Visible=false return end
local ps,v=Camera:WorldToViewportPoint(rt.Position)if v then local ds=(Camera.CFrame.Position-rt.Position).Magnitude local sr=math.clamp((espSize/ds)*1000,1,70)
dot.Radius=sr dot.Transparency=espTransparency if hm.Health<=0 then dot.Color=Color3.fromRGB(255,140,0)sl.Visible=false 
elseif LocalPlayer:IsFriendsWith(p.UserId)then dot.Color=Color3.fromRGB(0,255,0)sl.Color=Color3.fromRGB(0,255,0)sl.Visible=true 
else dot.Color=Color3.fromRGB(255,0,0)sl.Visible=false end dot.Position=Vector2.new(ps.X,ps.Y)sl.Position=Vector2.new(ps.X,ps.Y-(sr+50))dot.Visible=true 
else dot.Visible=false sl.Visible=false end end)end
for _,p in pairs(Players:GetPlayers())do createESP(p)end Players.PlayerAdded:Connect(createESP)

local Gui=Instance.new("ScreenGui",HUI)Gui.Name="DeltaUniversal"Gui.ResetOnSpawn=false Gui.IgnoreGuiInset=true
local MP=Instance.new("Frame",Gui)MP.Size=UDim2.fromScale(0.38,0.55)MP.Position=UDim2.fromScale(0.5,0.5)MP.AnchorPoint=Vector2.new(0.5,0.5)
MP.BackgroundColor3=Color3.fromRGB(18,18,24)MP.Active=true MP.Draggable=true MP.BorderSizePixel=0 MP.ClipsDescendants=true Instance.new("UICorner",MP).CornerRadius=UDim.new(0,12)
local TB=Instance.new("Frame",MP)TB.Size=UDim2.new(1,0,0,24)TB.BackgroundColor3=Color3.fromRGB(25,25,32)TB.BorderSizePixel=0 TB.ZIndex=10 Instance.new("UICorner",TB).CornerRadius=UDim.new(0,12)
local T=Instance.new("TextLabel",TB)T.Size=UDim2.new(1,-15,1,0)T.Position=UDim2.new(0,10,0,0)T.BackgroundTransparency=1 T.Text=" PAINEL"T.TextColor3=Color3.new(1,1,1)T.Font=Enum.Font.GothamBold T.TextSize=13 T.TextXAlignment=Enum.TextXAlignment.Left T.ZIndex=11
local V=Instance.new("TextLabel",TB)V.Size=UDim2.new(0,50,1,0)V.Position=UDim2.new(1,-55,0,0)V.BackgroundTransparency=1 V.Text="v20.1"V.TextColor3=Color3.fromRGB(140,140,160)V.Font=Enum.Font.GothamMedium V.TextSize=9 V.TextXAlignment=Enum.TextXAlignment.Right V.ZIndex=11
local MinimizeGlobalBtn=Instance.new("TextButton",TB)MinimizeGlobalBtn.Size=UDim2.new(0,20,0,20)MinimizeGlobalBtn.Position=UDim2.new(1,-25,0.5,-10)
MinimizeGlobalBtn.BackgroundTransparency=1 MinimizeGlobalBtn.Text="+"MinimizeGlobalBtn.TextColor3=Color3.fromRGB(200,200,200)
MinimizeGlobalBtn.Font=Enum.Font.GothamBold MinimizeGlobalBtn.TextSize=16 MinimizeGlobalBtn.AutoButtonColor=false MinimizeGlobalBtn.ZIndex=12
local isMenuMinimized=false local SM local Pages={}local LO=0 local activeTabIndex=1
local draggingBall=false local dragStartPos=nil local startPos=nil
MinimizeGlobalBtn.MouseButton1Click:Connect(function()isMenuMinimized=not isMenuMinimized if isMenuMinimized then if SM then SM.Visible=false end for _,pageData in ipairs(Pages)do pageData.page.Visible=false end
MP.ClipsDescendants=false T.Visible=false V.Visible=false MinimizeGlobalBtn.Size=UDim2.new(0,40,0,40)MinimizeGlobalBtn.Position=UDim2.new(0.5,-20,0.5,-20)
MinimizeGlobalBtn.BackgroundTransparency=0 MinimizeGlobalBtn.BackgroundColor3=Color3.fromRGB(25,25,32)MinimizeGlobalBtn.Text="-"
MinimizeGlobalBtn.Active=true MinimizeGlobalBtn.Draggable=false MinimizeGlobalBtn.ZIndex=100
for _,c in ipairs(MinimizeGlobalBtn:GetChildren())do if c:IsA("UICorner")then c:Destroy()end end Instance.new("UICorner",MinimizeGlobalBtn).CornerRadius=UDim.new(1,0)
MP.Size=UDim2.new(0,40,0,40)local corner=MP:FindFirstChildOfClass("UICorner")or Instance.new("UICorner",MP)corner.CornerRadius=UDim.new(1,0)
else if SM then SM.Visible=true end for i,pageData in ipairs(Pages)do pageData.page.Visible=(i==activeTabIndex)end
MP.ClipsDescendants=true T.Visible=true V.Visible=true MinimizeGlobalBtn.Size=UDim2.new(0,20,0,20)MinimizeGlobalBtn.Position=UDim2.new(1,-25,0.5,-10)
MinimizeGlobalBtn.BackgroundTransparency=1 MinimizeGlobalBtn.Text="+"MinimizeGlobalBtn.Active=false MinimizeGlobalBtn.Draggable=false MinimizeGlobalBtn.ZIndex=12
for _,c in ipairs(MinimizeGlobalBtn:GetChildren())do if c:IsA("UICorner")then c:Destroy()end end MP.Size=UDim2.fromScale(0.38,0.55)
local corner=MP:FindFirstChildOfClass("UICorner")or Instance.new("UICorner",MP)corner.CornerRadius=UDim.new(0,12)end end)
MinimizeGlobalBtn.InputBegan:Connect(function(input)if isMenuMinimized and(input.UserInputType==Enum.UserInputType.MouseButton1 or input.UserInputType==Enum.UserInputType.Touch)then draggingBall=true dragStartPos=input.Position startPos=MP.Position end end)
MinimizeGlobalBtn.InputEnded:Connect(function(input)if input.UserInputType==Enum.UserInputType.MouseButton1 or input.UserInputType==Enum.UserInputType.Touch then draggingBall=false end end)
UserInputService.InputChanged:Connect(function(input)if draggingBall and(input.UserInputType==Enum.UserInputType.MouseMovement or input.UserInputType==Enum.UserInputType.Touch)then local delta=input.Position-dragStartPos MP.Position=UDim2.new(startPos.X.Scale,startPos.X.Offset+delta.X,startPos.Y.Scale,startPos.Y.Offset+delta.Y)end end)

SM=Instance.new("ScrollingFrame",MP)SM.Size=UDim2.new(0,75,1,-24)SM.Position=UDim2.new(0,0,0,24)SM.BackgroundColor3=Color3.fromRGB(14,14,18)
SM.BorderSizePixel=0 SM.BackgroundTransparency=0 SM.ScrollBarThickness=0 SM.CanvasSize=UDim2.new(0,0,0,0)SM.ScrollingDirection=Enum.ScrollingDirection.Y
local smLayout=Instance.new("UIListLayout",SM)smLayout.Padding=UDim.new(0,2)
smLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()SM.CanvasSize=UDim2.new(0,0,0,smLayout.AbsoluteContentSize.Y+10)end)

local function CC(n,a)local b=Instance.new("TextButton",SM)b.Size=UDim2.new(1,-8,0,36)b.Position=UDim2.new(0,4,0,0)b.BackgroundColor3=a and Color3.fromRGB(35,35,45)or Color3.fromRGB(18,18,24)b.BackgroundTransparency=0 b.Text=n
b.TextColor3=a and Color3.new(1,1,1)or Color3.fromRGB(130,130,150)b.Font=Enum.Font.GothamMedium b.TextSize=10 b.BorderSizePixel=0 b.TextXAlignment=Enum.TextXAlignment.Center b.AutoButtonColor=false Instance.new("UICorner",b).CornerRadius=UDim.new(0,6)
local p=Instance.new("ScrollingFrame",MP)p.Size=UDim2.new(1,-83,1,-30)p.Position=UDim2.new(0,79,0,26)p.BackgroundTransparency=1 p.Visible=a p.LayoutOrder=#Pages
p.ScrollBarThickness=4 p.ScrollBarImageColor3=Color3.fromRGB(100,100,120)p.CanvasSize=UDim2.new(0,0,0,0)p.AutomaticCanvasSize=Enum.AutomaticSize.None
p.ScrollingDirection=Enum.ScrollingDirection.Y p.BorderSizePixel=0 p.ClipsDescendants=true local pageLayout=Instance.new("UIListLayout",p)pageLayout.Padding=UDim.new(0,6)pageLayout.SortOrder=Enum.SortOrder.LayoutOrder
local function updateCanvas()p.CanvasSize=UDim2.new(0,0,0,pageLayout.AbsoluteContentSize.Y+16)end
pageLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(updateCanvas)p.ChildAdded:Connect(function()task.defer(updateCanvas)end)p.ChildRemoved:Connect(function()task.defer(updateCanvas)end)
local pageIndex=#Pages+1 table.insert(Pages,{btn=b,page=p,index=pageIndex})
b.MouseButton1Click:Connect(function()activeTabIndex=pageIndex for _,x in ipairs(Pages)do x.btn.BackgroundColor3=Color3.fromRGB(18,18,24)x.btn.TextColor3=Color3.fromRGB(130,130,150)x.page.Visible=false end
b.BackgroundColor3=Color3.fromRGB(35,35,45)b.TextColor3=Color3.new(1,1,1)p.Visible=true updateCanvas()end)return p end

local function SH(p,t)LO=LO+1 local h=Instance.new("TextLabel",p)h.Size=UDim2.new(1,0,0,16)h.LayoutOrder=LO h.BackgroundTransparency=1 h.Text=t:upper()h.TextColor3=Color3.fromRGB(120,120,150)h.Font=Enum.Font.GothamBold h.TextSize=9 h.TextXAlignment=Enum.TextXAlignment.Left end
local function TG(p,t,d,cb)LO=LO+1 local f=Instance.new("TextButton",p)f.Size=UDim2.new(1,0,0,28)f.LayoutOrder=LO f.BackgroundColor3=d and Color3.fromRGB(0,160,100)or Color3.fromRGB(28,28,36)f.BorderSizePixel=0 f.Text=""Instance.new("UICorner",f).CornerRadius=UDim.new(0,6)
local l=Instance.new("TextLabel",f)l.Size=UDim2.new(1,-36,1,0)l.Position=UDim2.new(0,8,0,0)l.BackgroundTransparency=1 l.Text=t l.TextColor3=Color3.new(1,1,1)l.Font=Enum.Font.GothamMedium l.TextSize=11 l.TextXAlignment=Enum.TextXAlignment.Left
local s=Instance.new("Frame",f)s.Size=UDim2.new(0,30,0,16)s.Position=UDim2.new(1,-34,0.5,-8)s.BackgroundColor3=d and Color3.fromRGB(255,255,255)or Color3.fromRGB(50,50,65)s.BorderSizePixel=0 Instance.new("UICorner",s).CornerRadius=UDim.new(1,0)
local k=Instance.new("Frame",s)k.Size=UDim2.new(0,12,0,12)k.Position=UDim2.new(0,d and 16 or 2,0.5,-6)k.BackgroundColor3=d and Color3.fromRGB(0,160,100)or Color3.fromRGB(150,150,160)k.BorderSizePixel=0 Instance.new("UICorner",k).CornerRadius=UDim.new(1,0)
local a=d local function u()f.BackgroundColor3=a and Color3.fromRGB(0,160,100)or Color3.fromRGB(28,28,36)s.BackgroundColor3=a and Color3.fromRGB(255,255,255)or Color3.fromRGB(50,50,65)k.Position=UDim2.new(0,a and 16 or 2,0.5,-6)k.BackgroundColor3=a and Color3.fromRGB(0,160,100)or Color3.fromRGB(150,150,160)end
f.MouseButton1Click:Connect(function()a=not a u()cb(a)end)end
local function IB(p,t,d,cb)LO=LO+1 local f=Instance.new("Frame",p)f.Size=UDim2.new(1,0,0,30)f.LayoutOrder=LO f.BackgroundColor3=Color3.fromRGB(28,28,36)f.BorderSizePixel=0 Instance.new("UICorner",f).CornerRadius=UDim.new(0,6)
local l=Instance.new("TextLabel",f)l.Size=UDim2.new(1,-50,1,0)l.Position=UDim2.new(0,8,0,0)l.BackgroundTransparency=1 l.Text=t l.TextColor3=Color3.fromRGB(220,220,230)l.Font=Enum.Font.GothamMedium l.TextSize=11 l.TextXAlignment=Enum.TextXAlignment.Left
local i=Instance.new("TextBox",f)i.Size=UDim2.new(0,45,0,22)i.Position=UDim2.new(1,-48,0.5,-11)i.BackgroundColor3=Color3.fromRGB(38,38,48)i.Text=tostring(d)i.TextColor3=Color3.fromRGB(100,200,150)i.Font=Enum.Font.GothamBold i.TextSize=11 i.ClearTextOnFocus=true i.BorderSizePixel=0 Instance.new("UICorner",i).CornerRadius=UDim.new(0,4)
i.FocusLost:Connect(function()local n=tonumber(i.Text)if n and n>=0 then cb(n)else i.Text=tostring(d)end end)end
local function AB(p,t,c,cb)LO=LO+1 local b=Instance.new("TextButton",p)b.Size=UDim2.new(1,0,0,30)b.LayoutOrder=LO b.BackgroundColor3=c b.BorderSizePixel=0 b.Text=t b.TextColor3=Color3.new(1,1,1)b.Font=Enum.Font.GothamBold b.TextSize=11 Instance.new("UICorner",b).CornerRadius=UDim.new(0,6)b.MouseButton1Click:Connect(cb)return b end

local ap=CC("AIMBOT",true)local ep=CC("ESP",false)local sp=CC("SINTONIA",false)local ip=CC("INTERAGIR",false)local cp=CC("HELICAR",false)local tp=CC("TLPRT",false)local bp=CC("BAN PLAYER",false)

-- AIMBOT
LO=0 SH(ap,"CORE")TG(ap,"Aimbot",false,function(v)C.A=v end)TG(ap,"Mostrar FOV",false,function(v)C.SF=v end)
IB(ap,"Raio/Altura",25,function(v)C.FH=v C.FB=v end)IB(ap,"Largura",25,function(v)C.LW=v C.RW=v end)
local btnSquare,btnCircle local function updateFormatButtons(selected)C.FS=selected local ac=Color3.fromRGB(0,160,100)local ic=Color3.fromRGB(28,28,36)if btnSquare then btnSquare.BackgroundColor3=selected=="Square"and ac or ic end if btnCircle then btnCircle.BackgroundColor3=selected=="Circle"and ac or ic end end
btnSquare=AB(ap,"FORMATO: QUADRADO",Color3.fromRGB(28,28,36),function()updateFormatButtons("Square")end)
btnCircle=AB(ap,"FORMATO: CÍRCULO",Color3.fromRGB(0,160,100),function()updateFormatButtons("Circle")end)
TG(ap,"Team Only",false,function(v)C.TO=v end)TG(ap,"Wall Check",false,function(v)C.WC=v end)
SH(ap,"PRECISÃO")IB(ap,"Suavidade",0.5,function(v)C.SM=v end)IB(ap,"Distância Máx",300,function(v)C.MD=v end)
local btnHRP,btnHead,btnTorso local function updateTargetButtons(selected)C.TP=selected local ac=Color3.fromRGB(0,160,100)local ic=Color3.fromRGB(35,35,45)if btnHRP then btnHRP.BackgroundColor3=selected=="HumanoidRootPart"and ac or ic end if btnHead then btnHead.BackgroundColor3=selected=="Head"and ac or ic end if btnTorso then btnTorso.BackgroundColor3=selected=="UpperTorso"and ac or ic end end
btnHRP=AB(ap,"Mirar em: HumanoidRootPart",Color3.fromRGB(0,160,100),function()updateTargetButtons("HumanoidRootPart")end)
btnHead=AB(ap,"Mirar em: Head",Color3.fromRGB(35,35,45),function()updateTargetButtons("Head")end)
btnTorso=AB(ap,"Mirar em: Torso",Color3.fromRGB(35,35,45),function()updateTargetButtons("UpperTorso")end)

-- ESP
LO=0 SH(ep,"CONTROLES")LO=LO+1 local epRow1=Instance.new("Frame",ep)epRow1.Size=UDim2.new(1,0,0,32)epRow1.BackgroundTransparency=1 epRow1.LayoutOrder=LO
local espToggleBtn=Instance.new("TextButton",epRow1)espToggleBtn.Size=UDim2.new(0.58,0,1,0)espToggleBtn.Text="LIGADO"espToggleBtn.BackgroundColor3=Color3.fromRGB(0,200,0)espToggleBtn.TextColor3=Color3.new(1,1,1)espToggleBtn.Font=Enum.Font.GothamBold espToggleBtn.TextSize=12 espToggleBtn.BorderSizePixel=0 Instance.new("UICorner",espToggleBtn).CornerRadius=UDim.new(0,6)
local espSizeBox=Instance.new("TextBox",epRow1)espSizeBox.Size=UDim2.new(0.38,0,1,0)espSizeBox.Position=UDim2.new(0.62,0,0,0)espSizeBox.Text="2"espSizeBox.PlaceholderText="Tam"espSizeBox.BackgroundColor3=Color3.fromRGB(40,40,50)espSizeBox.TextColor3=Color3.new(1,1,1)espSizeBox.Font=Enum.Font.Gotham espSizeBox.TextSize=12 espSizeBox.ClearTextOnFocus=false espSizeBox.BorderSizePixel=0 Instance.new("UICorner",espSizeBox).CornerRadius=UDim.new(0,6)
LO=LO+1 local epRow2=Instance.new("Frame",ep)epRow2.Size=UDim2.new(1,0,0,32)epRow2.BackgroundTransparency=1 epRow2.LayoutOrder=LO
local rejoinBtn=Instance.new("TextButton",epRow2)rejoinBtn.Size=UDim2.new(0.58,0,1,0)rejoinBtn.Text="REJOIN"rejoinBtn.BackgroundColor3=Color3.fromRGB(220,120,0)rejoinBtn.TextColor3=Color3.new(1,1,1)rejoinBtn.Font=Enum.Font.GothamBold rejoinBtn.TextSize=12 rejoinBtn.BorderSizePixel=0 Instance.new("UICorner",rejoinBtn).CornerRadius=UDim.new(0,6)
local espTransBox=Instance.new("TextBox",epRow2)espTransBox.Size=UDim2.new(0.38,0,1,0)espTransBox.Position=UDim2.new(0.62,0,0,0)espTransBox.Text="0.4"espTransBox.PlaceholderText="Trans"espTransBox.BackgroundColor3=Color3.fromRGB(40,40,50)espTransBox.TextColor3=Color3.new(1,1,1)espTransBox.Font=Enum.Font.Gotham espTransBox.TextSize=12 espTransBox.ClearTextOnFocus=false espTransBox.BorderSizePixel=0 Instance.new("UICorner",espTransBox).CornerRadius=UDim.new(0,6)
LO=LO+1 local espStatus=Instance.new("TextLabel",ep)espStatus.Size=UDim2.new(1,0,0,18)espStatus.LayoutOrder=LO espStatus.Text="Tamanho: 2"espStatus.TextColor3=Color3.fromRGB(180,180,200)espStatus.BackgroundTransparency=1 espStatus.Font=Enum.Font.Gotham espStatus.TextSize=10 espStatus.TextXAlignment=Enum.TextXAlignment.Left
espToggleBtn.MouseButton1Click:Connect(function()espEnabled=not espEnabled if espEnabled then espToggleBtn.Text="LIGADO"espToggleBtn.BackgroundColor3=Color3.fromRGB(0,200,0)else espToggleBtn.Text="DESLIGADO"espToggleBtn.BackgroundColor3=Color3.fromRGB(180,0,0)for _,d in pairs(espData)do if d.dot then d.dot.Visible=false end if d.slash then d.slash.Visible=false end end end end)
espSizeBox.FocusLost:Connect(function(entered)if entered then local v=tonumber(espSizeBox.Text)if v and v>0 and v<10 then espSize=v espStatus.Text="Tamanho: "..v else espSizeBox.Text=tostring(espSize)espStatus.Text="Inválido (0.01-9.9)"end end end)
espTransBox.FocusLost:Connect(function(entered)if entered then local v=tonumber(espTransBox.Text)if v and v>=0 and v<=1 then espTransparency=v espStatus.Text="Transparência: "..v for _,d in pairs(espData)do if d.dot then d.dot.Transparency=espTransparency end if d.slash then d.slash.Transparency=espTransparency end end else espTransBox.Text=tostring(espTransparency)espStatus.Text="Inválido (0-1)"end end end)
rejoinBtn.MouseButton1Click:Connect(function()game:GetService("TeleportService"):Teleport(game.PlaceId,LocalPlayer)end)

-- SINTONIA (COMPACTA)
LO=0 SH(sp,"SINTONIA")
LO=LO+1 local DistBox=Instance.new("TextBox",sp)DistBox.Size=UDim2.new(1,0,0,28)DistBox.LayoutOrder=LO DistBox.BackgroundColor3=Color3.fromRGB(35,35,45)DistBox.Text="10"DistBox.TextColor3=Color3.new(1,1,1)DistBox.PlaceholderText="Profundidade"DistBox.Font=Enum.Font.Gotham DistBox.TextSize=12 DistBox.ClearTextOnFocus=false Instance.new("UICorner",DistBox).CornerRadius=UDim.new(0,6)
LO=LO+1 local ToggleBtn=Instance.new("TextButton",sp)ToggleBtn.Size=UDim2.new(1,0,0,30)ToggleBtn.LayoutOrder=LO ToggleBtn.BackgroundColor3=Color3.fromRGB(40,180,40)ToggleBtn.Text="OFF"ToggleBtn.TextColor3=Color3.new(1,1,1)ToggleBtn.Font=Enum.Font.GothamBold ToggleBtn.TextSize=12 Instance.new("UICorner",ToggleBtn).CornerRadius=UDim.new(0,6)
LO=LO+1 local ToggleFlyBtn=Instance.new("TextButton",sp)ToggleFlyBtn.Size=UDim2.new(1,0,0,30)ToggleFlyBtn.LayoutOrder=LO ToggleFlyBtn.BackgroundColor3=Color3.fromRGB(35,35,45)ToggleFlyBtn.Text="ATIVAR VOO"ToggleFlyBtn.TextColor3=Color3.new(1,1,1)ToggleFlyBtn.Font=Enum.Font.GothamBold ToggleFlyBtn.TextSize=12 Instance.new("UICorner",ToggleFlyBtn).CornerRadius=UDim.new(0,6)
LO=LO+1 local StopBtn=Instance.new("TextButton",sp)StopBtn.Size=UDim2.new(1,0,0,30)StopBtn.LayoutOrder=LO StopBtn.BackgroundColor3=Color3.fromRGB(35,35,45)StopBtn.Text="STOP"StopBtn.TextColor3=Color3.new(1,1,1)StopBtn.Font=Enum.Font.GothamBold StopBtn.TextSize=12 Instance.new("UICorner",StopBtn).CornerRadius=UDim.new(0,6)
LO=LO+1 local NamesBtn=Instance.new("TextButton",sp)NamesBtn.Size=UDim2.new(1,0,0,30)NamesBtn.LayoutOrder=LO NamesBtn.BackgroundColor3=Color3.fromRGB(35,35,45)NamesBtn.Text="NAMES OFF"NamesBtn.TextColor3=Color3.new(1,1,1)NamesBtn.Font=Enum.Font.GothamBold NamesBtn.TextSize=12 Instance.new("UICorner",NamesBtn).CornerRadius=UDim.new(0,6)
LO=LO+1 local ReviveBtn=Instance.new("TextButton",sp)ReviveBtn.Size=UDim2.new(1,0,0,30)ReviveBtn.LayoutOrder=LO ReviveBtn.BackgroundColor3=Color3.fromRGB(180,50,50)ReviveBtn.Text="LIGAR REVIVE"ReviveBtn.TextColor3=Color3.new(1,1,1)ReviveBtn.Font=Enum.Font.GothamBold ReviveBtn.TextSize=12 Instance.new("UICorner",ReviveBtn).CornerRadius=UDim.new(0,6)
LO=LO+1 local ReviveStatus=Instance.new("TextLabel",sp)ReviveStatus.Size=UDim2.new(1,0,0,18)ReviveStatus.LayoutOrder=LO ReviveStatus.Text="Status: Desligado"ReviveStatus.TextColor3=Color3.fromRGB(180,180,200)ReviveStatus.BackgroundTransparency=1 ReviveStatus.Font=Enum.Font.Gotham ReviveStatus.TextSize=10 ReviveStatus.TextXAlignment=Enum.TextXAlignment.Left

-- ATALHO ALGEMA
LO=LO+1 SH(sp,"ATALHO ALGEMAS")LO=LO+1 local btnToggle=Instance.new("TextButton",sp)btnToggle.Size=UDim2.new(1,0,0,30)btnToggle.LayoutOrder=LO btnToggle.BackgroundColor3=Color3.fromRGB(200,50,50)btnToggle.Text="OFF ❌"btnToggle.TextColor3=Color3.fromRGB(255,255,255)btnToggle.TextSize=12 btnToggle.Font=Enum.Font.GothamBold Instance.new("UICorner",btnToggle).CornerRadius=UDim.new(0,6)
LO=LO+1 local btnTrava=Instance.new("TextButton",sp)btnTrava.Size=UDim2.new(1,0,0,30)btnTrava.LayoutOrder=LO btnTrava.BackgroundColor3=Color3.fromRGB(70,70,70)btnTrava.Text="TRAVAR OFF 🔓"btnTrava.TextColor3=Color3.fromRGB(255,255,255)btnTrava.TextSize=12 btnTrava.Font=Enum.Font.GothamBold Instance.new("UICorner",btnTrava).CornerRadius=UDim.new(0,6)
local btnRosa=Instance.new("TextButton",Gui)btnRosa.Name="BtnRosaAlgema"btnRosa.Size=UDim2.new(0,45,0,45)btnRosa.Position=UDim2.new(0.5,-22,0.7,0)btnRosa.BackgroundColor3=Color3.fromRGB(255,105,180)btnRosa.Text="🔗"btnRosa.TextSize=18 btnRosa.Visible=false btnRosa.Active=true btnRosa.Draggable=true btnRosa.ZIndex=150 Instance.new("UICorner",btnRosa).CornerRadius=UDim.new(1,0)
local ligado=false local travado=false
btnToggle.MouseButton1Click:Connect(function()ligado=not ligado if ligado then btnToggle.Text="ON ✔️"btnToggle.BackgroundColor3=Color3.fromRGB(40,167,69)btnRosa.Visible=true else btnToggle.Text="OFF ❌"btnToggle.BackgroundColor3=Color3.fromRGB(200,50,50)btnRosa.Visible=false end end)
btnTrava.MouseButton1Click:Connect(function()travado=not travado if travado then btnTrava.Text="TRAVAR ON 🔒"btnTrava.BackgroundColor3=Color3.fromRGB(217,130,43)btnRosa.Draggable=false else btnTrava.Text="TRAVAR OFF 🔓"btnTrava.BackgroundColor3=Color3.fromRGB(70,70,70)btnRosa.Draggable=true end end)
btnRosa.MouseButton1Click:Connect(function()pcall(function()local currentGui=Players.LocalPlayer:WaitForChild("PlayerGui")local executed=false for _,gui in ipairs(currentGui:GetChildren())do if gui:IsA("ScreenGui")then local algemarBtn=gui:FindFirstChild("Algemar",true)or gui:FindFirstChild("Cuff",true)if algemarBtn and algemarBtn:IsA("GuiButton")then if typeof(getconnections)=="function"then for _,conexao in ipairs(getconnections(algemarBtn.MouseButton1Click))do conexao:Fire()executed=true end for _,conexao in ipairs(getconnections(algemarBtn.Activated))do conexao:Fire()executed=true end end if not executed and firesignal then firesignal(algemarBtn.MouseButton1Click)executed=true end end end end if not executed then local char=LocalPlayer.Character local hrp=char and char:FindFirstChild("HumanoidRootPart")if hrp then for _,obj in ipairs(workspace:GetDescendants())do if obj:IsA("ProximityPrompt")and(obj.ActionText:lower():find("algemar")or obj.ObjectText:lower():find("algemar"))then if(hrp.Position-obj.Parent.Position).Magnitude<=15 then fireproximityprompt(obj)executed=true end end end end end end)end)

-- ATALHO DEITAR
LO=LO+1 SH(sp,"ATALHO DEITAR")LO=LO+1 local btnDeitarToggle=Instance.new("TextButton",sp)btnDeitarToggle.Size=UDim2.new(1,0,0,30)btnDeitarToggle.LayoutOrder=LO btnDeitarToggle.BackgroundColor3=Color3.fromRGB(200,50,50)btnDeitarToggle.Text="OFF ❌"btnDeitarToggle.TextColor3=Color3.fromRGB(255,255,255)btnDeitarToggle.TextSize=12 btnDeitarToggle.Font=Enum.Font.GothamBold Instance.new("UICorner",btnDeitarToggle).CornerRadius=UDim.new(0,6)
LO=LO+1 local btnDeitarTrava=Instance.new("TextButton",sp)btnDeitarTrava.Size=UDim2.new(1,0,0,30)btnDeitarTrava.LayoutOrder=LO btnDeitarTrava.BackgroundColor3=Color3.fromRGB(70,70,70)btnDeitarTrava.Text="TRAVAR OFF 🔓"btnDeitarTrava.TextColor3=Color3.fromRGB(255,255,255)btnDeitarTrava.TextSize=12 btnDeitarTrava.Font=Enum.Font.GothamBold Instance.new("UICorner",btnDeitarTrava).CornerRadius=UDim.new(0,6)
local btnDeitarFlutuante=Instance.new("TextButton",Gui)btnDeitarFlutuante.Name="BtnDeitarFlutuante"btnDeitarFlutuante.Size=UDim2.new(0,45,0,45)btnDeitarFlutuante.Position=UDim2.new(0.5,30,0.7,0)btnDeitarFlutuante.BackgroundColor3=Color3.fromRGB(138,43,226)btnDeitarFlutuante.Text="🛌"btnDeitarFlutuante.TextSize=18 btnDeitarFlutuante.Visible=false btnDeitarFlutuante.Active=true btnDeitarFlutuante.Draggable=true btnDeitarFlutuante.ZIndex=150 Instance.new("UICorner",btnDeitarFlutuante).CornerRadius=UDim.new(1,0)
local deitarLigado=false local deitarTravado=false
btnDeitarToggle.MouseButton1Click:Connect(function()deitarLigado=not deitarLigado if deitarLigado then btnDeitarToggle.Text="ON ✔️"btnDeitarToggle.BackgroundColor3=Color3.fromRGB(40,167,69)btnDeitarFlutuante.Visible=true else btnDeitarToggle.Text="OFF ❌"btnDeitarToggle.BackgroundColor3=Color3.fromRGB(200,50,50)btnDeitarFlutuante.Visible=false end end)
btnDeitarTrava.MouseButton1Click:Connect(function()deitarTravado=not deitarTravado if deitarTravado then btnDeitarTrava.Text="TRAVAR ON 🔒"btnDeitarTrava.BackgroundColor3=Color3.fromRGB(217,130,43)btnDeitarFlutuante.Draggable=false else btnDeitarTrava.Text="TRAVAR OFF 🔓"btnDeitarTrava.BackgroundColor3=Color3.fromRGB(70,70,70)btnDeitarFlutuante.Draggable=true end end)
btnDeitarFlutuante.MouseButton1Click:Connect(function()pcall(function()local currentGui=Players.LocalPlayer:WaitForChild("PlayerGui")local executed=false for _,gui in ipairs(currentGui:GetChildren())do if gui:IsA("ScreenGui")then local deitarBtn=gui:FindFirstChild("Deitar",true)or gui:FindFirstChild("Sleep",true)or gui:FindFirstChild("Deit",true)if deitarBtn and deitarBtn:IsA("GuiButton")then if typeof(getconnections)=="function"then for _,conexao in ipairs(getconnections(deitarBtn.MouseButton1Click))do conexao:Fire()executed=true end for _,conexao in ipairs(getconnections(deitarBtn.Activated))do conexao:Fire()executed=true end end if not executed and firesignal then firesignal(deitarBtn.MouseButton1Click)executed=true end end end end if not executed then local char=LocalPlayer.Character local hrp=char and char:FindFirstChild("HumanoidRootPart")if hrp then for _,obj in ipairs(workspace:GetDescendants())do if obj:IsA("ProximityPrompt")and(obj.ActionText:lower():find("deitar")or obj.ObjectText:lower():find("deitar")or obj.ActionText:lower():find("sleep"))then if(hrp.Position-obj.Parent.Position).Magnitude<=15 then fireproximityprompt(obj)executed=true end end end end end end)end)

local isReviveEnabled=false
ReviveBtn.MouseButton1Click:Connect(function()isReviveEnabled=not isReviveEnabled if isReviveEnabled then ReviveBtn.Text="DESLIGAR"ReviveBtn.BackgroundColor3=Color3.fromRGB(0,180,80)ReviveStatus.Text="Status: Ativo"local char=LocalPlayer.Character if char then local humanoid=char:FindFirstChildOfClass("Humanoid")if humanoid then pcall(function()humanoid.Health=humanoid.MaxHealth end)end end else ReviveBtn.Text="LIGAR REVIVE"ReviveBtn.BackgroundColor3=Color3.fromRGB(180,50,50)ReviveStatus.Text="Status: Desligado"end end)

local FloatContainer=Instance.new("Frame",Gui)FloatContainer.Name="FloatContainer"FloatContainer.Size=UDim2.new(0,130,0,65)FloatContainer.Position=UDim2.new(0.8,-150,0.5,-30)FloatContainer.BackgroundTransparency=1 FloatContainer.ZIndex=100 FloatContainer.Visible=false
local FloatingUpBtn=Instance.new("TextButton",FloatContainer)FloatingUpBtn.Size=UDim2.new(0,60,0,60)FloatingUpBtn.Position=UDim2.new(0,0,0,0)FloatingUpBtn.BackgroundColor3=Color3.fromRGB(40,100,200)FloatingUpBtn.Text="SUBIR"FloatingUpBtn.TextColor3=Color3.new(1,1,1)FloatingUpBtn.Font=Enum.Font.GothamBold FloatingUpBtn.TextSize=12 FloatingUpBtn.ZIndex=101 Instance.new("UICorner",FloatingUpBtn).CornerRadius=UDim.new(1,0)
local FloatingFwdBtn=Instance.new("TextButton",FloatContainer)FloatingFwdBtn.Size=UDim2.new(0,60,0,60)FloatingFwdBtn.Position=UDim2.new(0,70,0,0)FloatingFwdBtn.BackgroundColor3=Color3.fromRGB(40,180,40)FloatingFwdBtn.Text="FRENTE"FloatingFwdBtn.TextColor3=Color3.new(1,1,1)FloatingFwdBtn.Font=Enum.Font.GothamBold FloatingFwdBtn.TextSize=12 FloatingFwdBtn.ZIndex=101 Instance.new("UICorner",FloatingFwdBtn).CornerRadius=UDim.new(1,0)

local customDepth=10 local movementSpeed=24 local isUnderground=false local isFlyModeEnabled=false local isHoldingUp=false local isHoldingFwd=false local freezeEnabled=false local freezePosition=nil local namesEnabled=false local nameGuis={}local platformPart=nil local dynamicFloorPart=nil local anchorConnection=nil
local function createInvisiblePlatform(x,y,z)if platformPart then platformPart:Destroy()end platformPart=Instance.new("Part")platformPart.Name="DeltaUndergroundFloor"platformPart.Size=Vector3.new(50,1,50)platformPart.Position=Vector3.new(x,y,z)platformPart.Anchored=true platformPart.CanCollide=true platformPart.Transparency=1 platformPart.CastShadow=false platformPart.Parent=workspace end
local function destroyVisualFloor()if dynamicFloorPart then dynamicFloorPart:Destroy()dynamicFloorPart=nil end end
local function createVisualFloor(rootPart)destroyVisualFloor()dynamicFloorPart=Instance.new("Part")dynamicFloorPart.Name="DeltaVisualFloor"dynamicFloorPart.Size=Vector3.new(10,0.5,10)dynamicFloorPart.Anchored=false dynamicFloorPart.CanCollide=false dynamicFloorPart.Transparency=1 dynamicFloorPart.Color=Color3.fromRGB(0,0,0)dynamicFloorPart.Material=Enum.Material.Neon dynamicFloorPart.CastShadow=false dynamicFloorPart.Parent=rootPart end
local function resetCharacterPhysics()if not LocalPlayer.Character then return end local hum=LocalPlayer.Character:FindFirstChild("Humanoid")if hum then hum.WalkSpeed=16 hum.JumpPower=50 hum:SetStateEnabled(Enum.HumanoidStateType.Jumping,true)end end
StopBtn.MouseButton1Click:Connect(function()freezeEnabled=not freezeEnabled local root=LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")if freezeEnabled then StopBtn.Text="ON"StopBtn.BackgroundColor3=Color3.fromRGB(0,170,0)if root then freezePosition=root.Position root.Anchored=true end else StopBtn.Text="STOP"StopBtn.BackgroundColor3=Color3.fromRGB(35,35,45)freezePosition=nil if root then root.Anchored=false end end end)
local function createNameLabel(plr)if plr==LocalPlayer then return end if nameGuis[plr]then pcall(function()nameGuis[plr]:Destroy()end)nameGuis[plr]=nil end local billboard=Instance.new("BillboardGui")billboard.Size=UDim2.new(0,200,0,40)billboard.StudsOffsetWorldSpace=Vector3.new(0,3.5,0)billboard.AlwaysOnTop=true billboard.Parent=Gui local label=Instance.new("TextLabel",billboard)label.Size=UDim2.new(1,0,1,0)label.BackgroundTransparency=1 label.Text=plr.Name label.TextColor3=Color3.fromRGB(0,255,0)label.Font=Enum.Font.GothamBold label.TextSize=14 label.TextStrokeTransparency=0 label.TextStrokeColor3=Color3.fromRGB(0,0,0)nameGuis[plr]=billboard if plr.Character and plr.Character:FindFirstChild("Head")then billboard.Adornee=plr.Character.Head billboard.Enabled=true end end
local function removeNameTag(plr)if nameGuis[plr]then pcall(function()nameGuis[plr]:Destroy()end)nameGuis[plr]=nil end end
NamesBtn.MouseButton1Click:Connect(function()namesEnabled=not namesEnabled NamesBtn.Text=namesEnabled and"NAMES ON"or"NAMES OFF"NamesBtn.BackgroundColor3=namesEnabled and Color3.fromRGB(0,170,0)or Color3.fromRGB(35,35,45)if namesEnabled then for _,plr in pairs(Players:GetPlayers())do if plr~=LocalPlayer then createNameLabel(plr)end end else for _,plr in pairs(Players:GetPlayers())do removeNameTag(plr)end end end)
Players.PlayerAdded:Connect(function(newPlr)if namesEnabled and newPlr~=LocalPlayer then createNameLabel(newPlr)end end)Players.PlayerRemoving:Connect(function(plr)removeNameTag(plr)end)
local function toggleUnderground()local root=LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")local hum=LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid")if not root or not hum then return end if isUnderground then ToggleBtn.Text="OFF"ToggleBtn.BackgroundColor3=Color3.fromRGB(40,180,40)if anchorConnection then anchorConnection:Disconnect()anchorConnection=nil end resetCharacterPhysics()task.wait(0.1)if platformPart then platformPart:Destroy()platformPart=nil end root.CFrame=CFrame.new(root.Position.X,root.Position.Y+customDepth+5,root.Position.Z)isUnderground=false else ToggleBtn.Text="ON"ToggleBtn.BackgroundColor3=Color3.fromRGB(200,40,40)local targetY=root.Position.Y-customDepth createInvisiblePlatform(root.Position.X,targetY,root.Position.Z)task.wait(0.05)root.CFrame=CFrame.new(root.Position.X,targetY+3,root.Position.Z)hum.WalkSpeed=0 hum.JumpPower=0 hum:SetStateEnabled(Enum.HumanoidStateType.Jumping,false)anchorConnection=RunService.Heartbeat:Connect(function()if LocalPlayer.Character and platformPart then local currentRoot=LocalPlayer.Character:FindFirstChild("HumanoidRootPart")if currentRoot then platformPart.Position=Vector3.new(currentRoot.Position.X,platformPart.Position.Y,currentRoot.Position.Z)end end end)isUnderground=true end end
ToggleBtn.MouseButton1Click:Connect(toggleUnderground)
ToggleFlyBtn.MouseButton1Click:Connect(function()isFlyModeEnabled=not isFlyModeEnabled local root=LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")if isFlyModeEnabled then ToggleFlyBtn.Text="DESATIVAR VOO"ToggleFlyBtn.BackgroundColor3=Color3.fromRGB(40,180,40)FloatContainer.Visible=true if root then root.Anchored=true createVisualFloor(root)end if anchorConnection then anchorConnection:Disconnect()anchorConnection=nil end else ToggleFlyBtn.Text="ATIVAR VOO"ToggleFlyBtn.BackgroundColor3=Color3.fromRGB(35,35,45)FloatContainer.Visible=false if root then root.Anchored=false end destroyVisualFloor()isHoldingUp=false isHoldingFwd=false resetCharacterPhysics()end end)
FloatingUpBtn.InputBegan:Connect(function(input)if not isFlyModeEnabled then return end if input.UserInputType==Enum.UserInputType.MouseButton1 or input.UserInputType==Enum.UserInputType.Touch then isHoldingUp=true end end)FloatingUpBtn.InputEnded:Connect(function(input)if input.UserInputType==Enum.UserInputType.MouseButton1 or input.UserInputType==Enum.UserInputType.Touch then isHoldingUp=false end end)
FloatingFwdBtn.InputBegan:Connect(function(input)if not isFlyModeEnabled then return end if input.UserInputType==Enum.UserInputType.MouseButton1 or input.UserInputType==Enum.UserInputType.Touch then isHoldingFwd=true end end)FloatingFwdBtn.InputEnded:Connect(function(input)if input.UserInputType==Enum.UserInputType.MouseButton1 or input.UserInputType==Enum.UserInputType.Touch then isHoldingFwd=false end end)
DistBox.FocusLost:Connect(function()local val=tonumber(DistBox.Text)if val and val>0 then customDepth=val else DistBox.Text=tostring(customDepth)end end)
LocalPlayer.CharacterAdded:Connect(function()isUnderground=false isHoldingUp=false isHoldingFwd=false if anchorConnection then anchorConnection:Disconnect()anchorConnection=nil end if ToggleBtn then ToggleBtn.Text="OFF"ToggleBtn.BackgroundColor3=Color3.fromRGB(40,180,40)end if platformPart then platformPart:Destroy()platformPart=nil end if isFlyModeEnabled then local newRoot=LocalPlayer.Character:WaitForChild("HumanoidRootPart",5)if newRoot then newRoot.Anchored=true createVisualFloor(newRoot)end end end)

-- =============================================
-- HELICAR (INTEGRADO) - CORREÇÃO DEFINITIVA
-- =============================================
LO=0 SH(cp,"HELICAR")
local heliAtivo=false local botoesTravadosHeli=false local menuMinimizadoHeli=false local connectionVoo=nil _G.velVooMax=60
local fileName="Helicar_Config.json"

local savedDataHeli={
    posX_Heli=100, posY_Heli=400,
    posX_F=50, posY_F=500,
    posX_T=150, posY_T=500,
    vVoo=60
}

if writefile and readfile and isfile then
    if isfile(fileName) then
        local success,decoded=pcall(function()return HttpService:JSONDecode(readfile(fileName))end)
        if success and decoded then
            for k,v in pairs(decoded) do savedDataHeli[k]=v end
            _G.velVooMax = savedDataHeli.vVoo or 60
        end
    end
end

local MainFrameHeli=Instance.new("Frame",cp)
MainFrameHeli.Name="MainFrameHeli"
MainFrameHeli.BackgroundColor3=Color3.fromRGB(15,15,18)
MainFrameHeli.Size=UDim2.new(1,0,0,210)
MainFrameHeli.Active=true
MainFrameHeli.ZIndex=10
Instance.new("UICorner",MainFrameHeli).CornerRadius=UDim.new(0,5)

local StrokeHeli=Instance.new("UIStroke",MainFrameHeli)
StrokeHeli.Color=Color3.fromRGB(40,40,48)
StrokeHeli.Thickness=1

local TitleLabelHeli=Instance.new("TextLabel",MainFrameHeli)
TitleLabelHeli.Size=UDim2.new(1,-30,0,24)
TitleLabelHeli.Position=UDim2.new(0,8,0,3)
TitleLabelHeli.BackgroundTransparency=1
TitleLabelHeli.Text="HELICAR"
TitleLabelHeli.TextColor3=Color3.fromRGB(200,200,200)
TitleLabelHeli.TextSize=12
TitleLabelHeli.Font=Enum.Font.SourceSansBold
TitleLabelHeli.TextXAlignment=Enum.TextXAlignment.Left
TitleLabelHeli.ZIndex=11

local MinimizeBtnHeli=Instance.new("TextButton",MainFrameHeli)
MinimizeBtnHeli.Size=UDim2.new(0,20,0,20)
MinimizeBtnHeli.Position=UDim2.new(1,-24,0,5)
MinimizeBtnHeli.BackgroundColor3=Color3.fromRGB(30,30,38)
MinimizeBtnHeli.Text="-"
MinimizeBtnHeli.TextColor3=Color3.new(1,1,1)
MinimizeBtnHeli.TextSize=13
MinimizeBtnHeli.Font=Enum.Font.SourceSansBold
MinimizeBtnHeli.ZIndex=12
Instance.new("UICorner",MinimizeBtnHeli).CornerRadius=UDim.new(0,3)

local ToggleHeliBtn=Instance.new("TextButton",MainFrameHeli)
ToggleHeliBtn.BackgroundColor3=Color3.fromRGB(160,35,35)
ToggleHeliBtn.Size=UDim2.new(0.85,0,0,28)
ToggleHeliBtn.Position=UDim2.new(0.075,0,0.16,0)
ToggleHeliBtn.Text="LIGAR HELICAR [OFF]"
ToggleHeliBtn.TextColor3=Color3.new(1,1,1)
ToggleHeliBtn.TextSize=10
ToggleHeliBtn.Font=Enum.Font.SourceSansBold
ToggleHeliBtn.ZIndex=11
Instance.new("UICorner",ToggleHeliBtn).CornerRadius=UDim.new(0,4)

local SpeedBox=Instance.new("TextBox",MainFrameHeli)
SpeedBox.Size=UDim2.new(0.85,0,0,26)
SpeedBox.Position=UDim2.new(0.075,0,0.32,0)
SpeedBox.PlaceholderText="Velocidade Máxima"
SpeedBox.Text=tostring(savedDataHeli.vVoo)
SpeedBox.TextColor3=Color3.new(1,1,1)
SpeedBox.PlaceholderColor3=Color3.fromRGB(120,120,120)
SpeedBox.BackgroundColor3=Color3.fromRGB(22,22,28)
SpeedBox.TextSize=10
SpeedBox.ZIndex=11
Instance.new("UICorner",SpeedBox).CornerRadius=UDim.new(0,4)
SpeedBox.FocusLost:Connect(function()local val=tonumber(SpeedBox.Text)if val and val>0 then _G.velVooMax=val savedDataHeli.vVoo=val else SpeedBox.Text=tostring(_G.velVooMax)end end)

local LockControlesBtnHeli=Instance.new("TextButton",MainFrameHeli)
LockControlesBtnHeli.BackgroundColor3=Color3.fromRGB(45,45,55)
LockControlesBtnHeli.Size=UDim2.new(0.85,0,0,28)
LockControlesBtnHeli.Position=UDim2.new(0.075,0,0.53,0)
LockControlesBtnHeli.Text="TRAVAR BOTÕES [OFF]"
LockControlesBtnHeli.TextColor3=Color3.new(1,1,1)
LockControlesBtnHeli.TextSize=10
LockControlesBtnHeli.Font=Enum.Font.SourceSansBold
LockControlesBtnHeli.ZIndex=11
Instance.new("UICorner",LockControlesBtnHeli).CornerRadius=UDim.new(0,4)

local SalvarPosBtnHeli=Instance.new("TextButton",MainFrameHeli)
SalvarPosBtnHeli.BackgroundColor3=Color3.fromRGB(35,120,35)
SalvarPosBtnHeli.Size=UDim2.new(0.85,0,0,28)
SalvarPosBtnHeli.Position=UDim2.new(0.075,0,0.74,0)
SalvarPosBtnHeli.Text="SALVAR CONFIG"
SalvarPosBtnHeli.TextColor3=Color3.new(1,1,1)
SalvarPosBtnHeli.TextSize=10
SalvarPosBtnHeli.Font=Enum.Font.SourceSansBold
SalvarPosBtnHeli.ZIndex=11
Instance.new("UICorner",SalvarPosBtnHeli).CornerRadius=UDim.new(0,4)

MinimizeBtnHeli.MouseButton1Click:Connect(function()menuMinimizadoHeli=not menuMinimizadoHeli if menuMinimizadoHeli then MainFrameHeli:TweenSize(UDim2.new(1,0,0,30),Enum.EasingDirection.Out,Enum.EasingStyle.Quad,0.2,true)MinimizeBtnHeli.Text="+"ToggleHeliBtn.Visible=false LockControlesBtnHeli.Visible=false SalvarPosBtnHeli.Visible=false SpeedBox.Visible=false else MainFrameHeli:TweenSize(UDim2.new(1,0,0,210),Enum.EasingDirection.Out,Enum.EasingStyle.Quad,0.2,true)MinimizeBtnHeli.Text="-"ToggleHeliBtn.Visible=true LockControlesBtnHeli.Visible=true SalvarPosBtnHeli.Visible=true SpeedBox.Visible=true end end)

-- =============================================
-- GUI SEPARADO PARA OS BOTÕES DO HELICAR (ZIndex Máximo)
-- =============================================
local HeliGui=Instance.new("ScreenGui",HUI)
HeliGui.Name="HelicarUI"
HeliGui.ResetOnSpawn=false
HeliGui.IgnoreGuiInset=true
HeliGui.ZIndexBehavior=Enum.ZIndexBehavior.Sibling
HeliGui.DisplayOrder=999999

-- ControlFrame com ZIndex máximo
local ControlFrameHeli=Instance.new("Frame",HeliGui)
ControlFrameHeli.Name="ControlFrameHeli"
ControlFrameHeli.BackgroundTransparency=1
ControlFrameHeli.Size=UDim2.new(1,0,1,0)
ControlFrameHeli.Visible=true
ControlFrameHeli.ZIndex=999999

-- Botão HELI (SEMPRE VISÍVEL)
local HeliBolaBtn=Instance.new("TextButton",ControlFrameHeli)
HeliBolaBtn.Name="HeliBolaBtn"
HeliBolaBtn.BackgroundColor3=Color3.fromRGB(160,35,35)
HeliBolaBtn.Position=UDim2.new(0, savedDataHeli.posX_Heli or 100, 0, savedDataHeli.posY_Heli or 400)
HeliBolaBtn.Size=UDim2.new(0,45,0,45)
HeliBolaBtn.Text="HELI"
HeliBolaBtn.TextColor3=Color3.new(1,1,1)
HeliBolaBtn.TextSize=11
HeliBolaBtn.Font=Enum.Font.SourceSansBold
HeliBolaBtn.Active=true
HeliBolaBtn.Draggable=true
HeliBolaBtn.ZIndex=999999
HeliBolaBtn.Visible=true
Instance.new("UICorner",HeliBolaBtn).CornerRadius=UDim.new(1,0)

-- Função para criar botões F e T
local function criarBotaoHeli(nome,texto,posXKey,posYKey)
    local btn=Instance.new("TextButton",ControlFrameHeli)
    btn.Name=nome
    btn.BackgroundColor3=Color3.fromRGB(10,10,15)
    btn.BackgroundTransparency=0.4
    btn.Position=UDim2.new(0, savedDataHeli[posXKey] or 50, 0, savedDataHeli[posYKey] or 500)
    btn.Size=UDim2.new(0,45,0,45)
    btn.Text=texto
    btn.TextColor3=Color3.new(1,1,1)
    btn.TextSize=14
    btn.Font=Enum.Font.SourceSansBold
    btn.Active=true
    btn.Draggable=true
    btn.ZIndex=999999
    btn.Visible=false
    Instance.new("UICorner",btn).CornerRadius=UDim.new(0,8)
    return btn
end

local BtnF=criarBotaoHeli("BtnF","F","posX_F","posY_F")
local BtnT=criarBotaoHeli("BtnT","T","posX_T","posY_T")

local tempoSegurandoF=0 local velocidadeAtualFrente=0

local function atualizarEstadoHeli(estado)
    heliAtivo=estado
    local char=LocalPlayer.Character
    if heliAtivo then
        if char and char:FindFirstChild("Humanoid")then char.Humanoid.AutoRotate=false end
        ToggleHeliBtn.Text="DESLIGAR HELICAR [ON]"
        ToggleHeliBtn.BackgroundColor3=Color3.fromRGB(40,180,40)
        HeliBolaBtn.BackgroundColor3=Color3.fromRGB(35,140,35)
        BtnF.Visible=true
        BtnT.Visible=true
        local function getPartAlvo()
            if not char then return nil end
            local seat=char.Humanoid.SeatPart
            if seat and seat.Parent then return seat.Parent.PrimaryPart or seat end
            return char:FindFirstChild("HumanoidRootPart")
        end
        if not connectionVoo then
            connectionVoo=RunService.RenderStepped:Connect(function(dt)
                local alvo=getPartAlvo()
                if not alvo then return end
                local look=alvo.CFrame.LookVector
                local taxaSoltaRapida=250*dt
                local taxaFreioRapido=350*dt
                if _G.movF then
                    tempoSegurandoF=tempoSegurandoF+dt
                    local velAlvoDesejada=_G.velVooMax
                    if tempoSegurandoF>=1.0 then velAlvoDesejada=_G.velVooMax*1.45 end
                    local taxaAceleracao=70*dt
                    if velocidadeAtualFrente<velAlvoDesejada then
                        velocidadeAtualFrente=math.min(velocidadeAtualFrente+taxaAceleracao,velAlvoDesejada)
                    end
                else
                    tempoSegurandoF=0
                    local alvoTras=-_G.velVooMax
                    if _G.movT then
                        if velocidadeAtualFrente>alvoTras then
                            velocidadeAtualFrente=math.max(velocidadeAtualFrente-taxaFreioRapido,alvoTras)
                        end
                    else
                        if velocidadeAtualFrente>0 then
                            velocidadeAtualFrente=math.max(velocidadeAtualFrente-taxaSoltaRapida,0)
                        elseif velocidadeAtualFrente<0 then
                            velocidadeAtualFrente=math.min(velocidadeAtualFrente+taxaSoltaRapida,0)
                        end
                    end
                end
                local moveDir=Vector3.new(look.X,0,look.Z).Unit*math.abs(velocidadeAtualFrente)
                if velocidadeAtualFrente<0 then moveDir=-moveDir end
                if velocidadeAtualFrente~=0 or _G.movF or _G.movT then
                    alvo.AssemblyLinearVelocity=Vector3.new(moveDir.X,alvo.AssemblyLinearVelocity.Y,moveDir.Z)
                end
            end)
        end
    else
        if char and char:FindFirstChild("Humanoid")then char.Humanoid.AutoRotate=true end
        ToggleHeliBtn.Text="LIGAR HELICAR [OFF]"
        ToggleHeliBtn.BackgroundColor3=Color3.fromRGB(160,35,35)
        HeliBolaBtn.BackgroundColor3=Color3.fromRGB(160,35,35)
        BtnF.Visible=false
        BtnT.Visible=false
        if connectionVoo then connectionVoo:Disconnect()connectionVoo=nil end
        _G.movF=false _G.movT=false
        velocidadeAtualFrente=0
        tempoSegurandoF=0
    end
end

ToggleHeliBtn.MouseButton1Click:Connect(function()
    local novoEstado=not heliAtivo
    atualizarEstadoHeli(novoEstado)
end)

HeliBolaBtn.MouseButton1Click:Connect(function()
    atualizarEstadoHeli(not heliAtivo)
end)

SalvarPosBtnHeli.MouseButton1Click:Connect(function()
    savedDataHeli.posX_Heli=HeliBolaBtn.Position.X.Offset
    savedDataHeli.posY_Heli=HeliBolaBtn.Position.Y.Offset
    savedDataHeli.posX_F=BtnF.Position.X.Offset
    savedDataHeli.posY_F=BtnF.Position.Y.Offset
    savedDataHeli.posX_T=BtnT.Position.X.Offset
    savedDataHeli.posY_T=BtnT.Position.Y.Offset
    savedDataHeli.vVoo=_G.velVooMax
    if writefile then pcall(function()writefile(fileName,HttpService:JSONEncode(savedDataHeli))end)end
    SalvarPosBtnHeli.Text="SALVO!"
    task.wait(1.5)
    SalvarPosBtnHeli.Text="SALVAR CONFIG"
end)

-- CORREÇÃO: Botão de travar botoes INICIA EM "ON" (travado) e os botões começam não arrastáveis
botoesTravadosHeli = true  -- Inicia travado (ON)
HeliBolaBtn.Draggable = false
BtnF.Draggable = false
BtnT.Draggable = false
LockControlesBtnHeli.Text = "TRAVAR BOTÕES [ON]"
LockControlesBtnHeli.BackgroundColor3 = Color3.fromRGB(217,130,43) -- Cor laranja indicando ON

LockControlesBtnHeli.MouseButton1Click:Connect(function()
    botoesTravadosHeli=not botoesTravadosHeli
    HeliBolaBtn.Draggable=not botoesTravadosHeli
    BtnF.Draggable=not botoesTravadosHeli
    BtnT.Draggable=not botoesTravadosHeli
    if botoesTravadosHeli then
        LockControlesBtnHeli.Text="TRAVAR BOTÕES [ON]"
        LockControlesBtnHeli.BackgroundColor3=Color3.fromRGB(217,130,43)
    else
        LockControlesBtnHeli.Text="TRAVAR BOTÕES [OFF]"
        LockControlesBtnHeli.BackgroundColor3=Color3.fromRGB(45,45,55)
    end
end)

local function vincularHeli(btn,var)
    btn.MouseButton1Down:Connect(function()_G[var]=true end)
    btn.MouseButton1Up:Connect(function()_G[var]=false end)
    btn.MouseLeave:Connect(function()_G[var]=false end)
end
_G.movF=false _G.movT=false
vincularHeli(BtnF,"movF")
vincularHeli(BtnT,"movT")

-- INTERAGIR
LO=0 SH(ip,"INTERAÇÕES")local interactRange=10 local autoInteract=false local antiLagActive=false local isMinimized=false local lastCheck=0 local char=LocalPlayer.Character local hrp=char and char:FindFirstChild("HumanoidRootPart")
LocalPlayer.CharacterAdded:Connect(function(newChar)char=newChar hrp=newChar:WaitForChild("HumanoidRootPart")end)
local function interagir()if not hrp or not hrp.Parent then char=LocalPlayer.Character hrp=char and char:FindFirstChild("HumanoidRootPart")if not hrp then return end end for _,obj in ipairs(workspace:GetDescendants())do if not obj:IsA("BasePart")then continue end local prompt=obj:FindFirstChildOfClass("ProximityPrompt")if prompt and(hrp.Position-obj.Position).Magnitude<=interactRange then pcall(function()fireproximityprompt(prompt)end)end end end
local function toggleAntiLag(active)antiLagActive=active if active then game.Lighting.GlobalShadows=false game.Workspace.Terrain.WaterWaveSize=0 game.Workspace.Terrain.WaterWaveSpeed=0 else game.Lighting.GlobalShadows=true game.Workspace.Terrain.WaterWaveSize=4 game.Workspace.Terrain.WaterWaveSpeed=25 end end
LO=LO+1 local minimizeBtn=Instance.new("TextButton",ip)minimizeBtn.Size=UDim2.new(1,0,0,25)minimizeBtn.LayoutOrder=LO minimizeBtn.Text="▼ MINIMIZAR"minimizeBtn.BackgroundColor3=Color3.fromRGB(50,50,60)minimizeBtn.TextColor3=Color3.new(1,1,1)minimizeBtn.Font=Enum.Font.SourceSansBold minimizeBtn.TextSize=14 Instance.new("UICorner",minimizeBtn).CornerRadius=UDim.new(0,6)
LO=LO+1 local buttonsContainer=Instance.new("Frame",ip)buttonsContainer.Size=UDim2.new(1,0,0,65)buttonsContainer.LayoutOrder=LO buttonsContainer.BackgroundTransparency=1 buttonsContainer.Visible=true
local interactBtn=Instance.new("TextButton",buttonsContainer)interactBtn.Size=UDim2.new(1,0,0,30)interactBtn.Position=UDim2.new(0,0,0,0)interactBtn.Text="INTERAÇÃO: OFF"interactBtn.BackgroundColor3=Color3.fromRGB(40,40,50)interactBtn.TextColor3=Color3.new(1,1,1)interactBtn.Font=Enum.Font.SourceSansBold interactBtn.TextSize=16 Instance.new("UICorner",interactBtn).CornerRadius=UDim.new(0,6)
local antiLagBtn=Instance.new("TextButton",buttonsContainer)antiLagBtn.Size=UDim2.new(1,0,0,30)antiLagBtn.Position=UDim2.new(0,0,0,35)antiLagBtn.Text="ANTI-LAG: OFF"antiLagBtn.BackgroundColor3=Color3.fromRGB(40,40,50)antiLagBtn.TextColor3=Color3.new(1,1,1)antiLagBtn.Font=Enum.Font.SourceSansBold antiLagBtn.TextSize=16 Instance.new("UICorner",antiLagBtn).CornerRadius=UDim.new(0,6)
interactBtn.MouseButton1Click:Connect(function()autoInteract=not autoInteract interactBtn.Text=autoInteract and"INTERAÇÃO: ON"or"INTERAÇÃO: OFF"interactBtn.BackgroundColor3=autoInteract and Color3.fromRGB(0,170,255)or Color3.fromRGB(40,40,50)end)
antiLagBtn.MouseButton1Click:Connect(function()toggleAntiLag(not antiLagActive)antiLagBtn.Text=antiLagActive and"ANTI-LAG: ON"or"ANTI-LAG: OFF"antiLagBtn.BackgroundColor3=antiLagActive and Color3.fromRGB(0,200,100)or Color3.fromRGB(40,40,50)end)
minimizeBtn.MouseButton1Click:Connect(function()isMinimized=not isMinimized if isMinimized then buttonsContainer.Visible=false minimizeBtn.Text="▲ EXPANDIR"else buttonsContainer.Visible=true minimizeBtn.Text="▼ MINIMIZAR"end end)
RunService.Heartbeat:Connect(function()if autoInteract then if tick()-lastCheck>0.3 then interagir()lastCheck=tick()end end end)

-- TLPRT
LO=0 SH(tp,"PLAYERS LIST")local SIT_HEIGHT=2.5 local TRANSITION_SPEED=0.3 local FIXED_TP_HEIGHT=15
local isEmoteOn=false local currentOffset=0 local originalWalkSpeed=16 local originalJumpPower=50 local isAnchored=false local selectedBtn=nil
local espVisualCircle=Drawing.new("Circle")espVisualCircle.Thickness=2 espVisualCircle.Filled=false espVisualCircle.Color=Color3.fromRGB(255,0,0)espVisualCircle.Visible=false
local espVisualLine=Drawing.new("Line")espVisualLine.Thickness=1 espVisualLine.Color=Color3.fromRGB(255,0,0)espVisualLine.Visible=false
local espVisualTarget=nil local espVisualEnabled=false
RunService.RenderStepped:Connect(function()if espVisualEnabled and espVisualTarget and espVisualTarget.Character then local hrp=espVisualTarget.Character:FindFirstChild("HumanoidRootPart")if hrp then local pos,onScreen=Camera:WorldToViewportPoint(hrp.Position)if onScreen then espVisualCircle.Visible=true espVisualCircle.Radius=30 espVisualCircle.Position=Vector2.new(pos.X,pos.Y)espVisualLine.Visible=true espVisualLine.From=Vector2.new(Camera.ViewportSize.X/2,Camera.ViewportSize.Y/2)espVisualLine.To=Vector2.new(pos.X,pos.Y)else espVisualCircle.Visible=false espVisualLine.Visible=false end else espVisualCircle.Visible=false espVisualLine.Visible=false end else espVisualCircle.Visible=false espVisualLine.Visible=false end end)
local function cleanupCharacter()local Character=LocalPlayer.Character if not Character then return end local HRP=Character:FindFirstChild("HumanoidRootPart")local Humanoid=Character:FindFirstChildOfClass("Humanoid")if HRP then HRP.Anchored=false HRP.AssemblyLinearVelocity=Vector3.new(0,0,0)end if Humanoid then Humanoid.WalkSpeed=originalWalkSpeed Humanoid.JumpPower=originalJumpPower Humanoid.PlatformStand=false end currentOffset=0 isAnchored=false end
RunService.RenderStepped:Connect(function()local Character=LocalPlayer.Character if not Character then return end local HRP=Character:FindFirstChild("HumanoidRootPart")local Humanoid=Character:FindFirstChildOfClass("Humanoid")if not HRP or not Humanoid then return end Humanoid.PlatformStand=false if not isEmoteOn then if currentOffset>0 then currentOffset=math.max(currentOffset-TRANSITION_SPEED,0)local rayOrigin=HRP.Position local rayDirection=Vector3.new(0,-10,0)local rayParams=RaycastParams.new()rayParams.FilterType=Enum.RaycastFilterType.Blacklist rayParams.FilterDescendantsInstances={Character}local result=workspace:Raycast(rayOrigin,rayDirection,rayParams)if result then local groundY=result.Position.Y local targetY=groundY+(HRP.Size.Y/2)-currentOffset HRP.CFrame=CFrame.new(HRP.Position.X,targetY,HRP.Position.Z)*HRP.CFrame.Rotation end end return end if currentOffset<SIT_HEIGHT then currentOffset=math.min(currentOffset+TRANSITION_SPEED,SIT_HEIGHT)end if not isAnchored then HRP.Anchored=true isAnchored=true end Humanoid.WalkSpeed=0 Humanoid.JumpPower=0 local rayOrigin=HRP.Position local rayDirection=Vector3.new(0,-10,0)local rayParams=RaycastParams.new()rayParams.FilterType=Enum.RaycastFilterType.Blacklist rayParams.FilterDescendantsInstances={Character}local result=workspace:Raycast(rayOrigin,rayDirection,rayParams)if result then local groundY=result.Position.Y local targetY=groundY+(HRP.Size.Y/2)-currentOffset HRP.CFrame=CFrame.new(HRP.Position.X,targetY,HRP.Position.Z)*HRP.CFrame.Rotation else HRP.Anchored=true end end)
local function ResetButtonColors()if selectedBtn then selectedBtn.BackgroundColor3=Color3.fromRGB(255,255,255)selectedBtn=nil end end
local function TeleportTo(targetPlayer,btn)ResetButtonColors()btn.BackgroundColor3=Color3.fromRGB(0,255,0)selectedBtn=btn cleanupCharacter()if not targetPlayer or not targetPlayer.Character then return end local TargetRoot=targetPlayer.Character:FindFirstChild("HumanoidRootPart")local Character=LocalPlayer.Character local HRP=Character and Character:FindFirstChild("HumanoidRootPart")local Humanoid=Character and Character:FindFirstChildOfClass("Humanoid")if TargetRoot and HRP and Humanoid then isEmoteOn=true task.wait(0.5)HRP.CFrame=TargetRoot.CFrame*CFrame.new(0,FIXED_TP_HEIGHT,0)task.wait(0.2)local rayOrigin=HRP.Position local rayDirection=Vector3.new(0,-50,0)local rayParams=RaycastParams.new()rayParams.FilterType=Enum.RaycastFilterType.Blacklist rayParams.FilterDescendantsInstances={Character}local result=workspace:Raycast(rayOrigin,rayDirection,rayParams)if result then local groundY=result.Position.Y HRP.CFrame=CFrame.new(HRP.Position.X,groundY+(HRP.Size.Y/2)+2,HRP.Position.Z)*HRP.CFrame.Rotation end isEmoteOn=false cleanupCharacter()end end
LO=LO+1 local isListOpen=false local toggleListBtn=Instance.new("TextButton",tp)toggleListBtn.Size=UDim2.new(1,0,0,30)toggleListBtn.LayoutOrder=LO toggleListBtn.BackgroundColor3=Color3.fromRGB(0,160,100)toggleListBtn.BorderSizePixel=0 toggleListBtn.Text="ABRIR LISTA"toggleListBtn.TextColor3=Color3.new(1,1,1)toggleListBtn.Font=Enum.Font.GothamBold toggleListBtn.TextSize=11 Instance.new("UICorner",toggleListBtn).CornerRadius=UDim.new(0,6)
-- PLATAFORMA PÉ
local SAVE_FILE_NAME="PlatformFlyConfig_V10.6.json"local isSystemActive=false local isAutoFlyActive=false local isBtnDraggable=false local footPart=nil local updateConnection=nil local tpTask=nil
local FOOT_SIZE=Vector3.new(1.2,0.2,1.2)local OFFSET_Y=3.1 local DASH_DISTANCE=5 local INITIAL_JUMP_POWER=15 local TP_SPEED_DELAY=0.04
local savedBtnPosition={XScale=0.8,XOffset=0,YScale=0.5,YOffset=0}
local function loadSettings()if readfile and isfile and isfile(SAVE_FILE_NAME)then local success,result=pcall(function()return HttpService:JSONDecode(readfile(SAVE_FILE_NAME))end)if success and type(result)=="table"then if result.DashDistance then DASH_DISTANCE=result.DashDistance end if result.BtnPos then savedBtnPosition=result.BtnPos end if result.IsDraggable~=nil then isBtnDraggable=result.IsDraggable end end end end
local function saveSettings()if writefile then pcall(function()local data={DashDistance=DASH_DISTANCE,BtnPos=savedBtnPosition,IsDraggable=isBtnDraggable}writefile(SAVE_FILE_NAME,HttpService:JSONEncode(data))end)end end
loadSettings()
LO=LO+1 SH(tp,"PLATAFORMA PÉ V10.6")LO=LO+1 local PfToggleBtn=Instance.new("TextButton",tp)PfToggleBtn.Size=UDim2.new(1,0,0,26)PfToggleBtn.LayoutOrder=LO PfToggleBtn.BackgroundColor3=Color3.fromRGB(180,40,40)PfToggleBtn.Text="SISTEMA: OFF"PfToggleBtn.TextColor3=Color3.fromRGB(255,255,255)PfToggleBtn.Font=Enum.Font.GothamBold PfToggleBtn.TextSize=10 PfToggleBtn.BorderSizePixel=0 PfToggleBtn.AutoButtonColor=false Instance.new("UICorner",PfToggleBtn).CornerRadius=UDim.new(0,6)
LO=LO+1 local PfLockBtn=Instance.new("TextButton",tp)PfLockBtn.Size=UDim2.new(1,0,0,26)PfLockBtn.LayoutOrder=LO PfLockBtn.BackgroundColor3=isBtnDraggable and Color3.fromRGB(0,160,255)or Color3.fromRGB(60,60,80)PfLockBtn.Text=isBtnDraggable and"BOTÃO: MÓVEL"or"BOTÃO: TRAVADO"PfLockBtn.TextColor3=Color3.fromRGB(255,255,255)PfLockBtn.Font=Enum.Font.GothamBold PfLockBtn.TextSize=10 PfLockBtn.BorderSizePixel=0 PfLockBtn.AutoButtonColor=false Instance.new("UICorner",PfLockBtn).CornerRadius=UDim.new(0,6)
IB(tp,"DISTÂNCIA TP",DASH_DISTANCE,function(v)DASH_DISTANCE=v saveSettings()end)
local CircleBtn=Instance.new("TextButton",Gui)CircleBtn.Name="CircleFlyBtn"CircleBtn.Size=UDim2.new(0,65,0,65)CircleBtn.Position=UDim2.new(savedBtnPosition.XScale,savedBtnPosition.XOffset,savedBtnPosition.YScale,savedBtnPosition.YOffset)CircleBtn.BackgroundColor3=Color3.fromRGB(60,60,80)CircleBtn.Text="VOAR\n[OFF]"CircleBtn.TextColor3=Color3.fromRGB(255,255,255)CircleBtn.Font=Enum.Font.GothamBold CircleBtn.TextSize=11 CircleBtn.Visible=false CircleBtn.Active=true CircleBtn.Draggable=isBtnDraggable CircleBtn.ZIndex=10 Instance.new("UICorner",CircleBtn).CornerRadius=UDim.new(1,0)local CircleStroke=Instance.new("UIStroke",CircleBtn)CircleStroke.Thickness=2 CircleStroke.Color=Color3.fromRGB(255,255,255)
CircleBtn:GetPropertyChangedSignal("Position"):Connect(function()local pos=CircleBtn.Position savedBtnPosition={XScale=pos.X.Scale,XOffset=pos.X.Offset,YScale=pos.Y.Scale,YOffset=pos.Y.Offset}saveSettings()end)
local function createFootPart()if footPart then footPart:Destroy()end footPart=Instance.new("Part")footPart.Name="CustomFootPlatform"footPart.Size=FOOT_SIZE footPart.Transparency=0.3 footPart.Color=Color3.fromRGB(0,255,150)footPart.Material=Enum.Material.Neon footPart.Anchored=true footPart.CanCollide=true footPart.CastShadow=false footPart.Parent=workspace end
local function destroyFootPart()if footPart then footPart:Destroy()footPart=nil end end
local function liftCharacter()local char=LocalPlayer.Character if char then local root=char:FindFirstChild("HumanoidRootPart")if root then root.CFrame=root.CFrame+Vector3.new(0,INITIAL_JUMP_POWER,0)end end end
local function startTracking()if updateConnection then updateConnection:Disconnect()end updateConnection=RunService.RenderStepped:Connect(function()if not isSystemActive or isAutoFlyActive then return end local char=LocalPlayer.Character if char then local root=char:FindFirstChild("HumanoidRootPart")if root and footPart then local targetY=root.Position.Y-OFFSET_Y footPart.CFrame=CFrame.new(root.Position.X,targetY,root.Position.Z)end end end)end
local function calculateMoveVector()local char=LocalPlayer.Character if not char then return Vector3.new(0,0,0)end local root=char:FindFirstChild("HumanoidRootPart")if not root then return Vector3.new(0,0,0)end local charForward=root.CFrame.LookVector local flatCharLook=Vector3.new(charForward.X,0,charForward.Z)if flatCharLook.Magnitude>0 then flatCharLook=flatCharLook.Unit end local cameraVerticalPitch=Camera.CFrame.LookVector.Y local combinedDirection=Vector3.new(flatCharLook.X,cameraVerticalPitch,flatCharLook.Z)if combinedDirection.Magnitude>0 then return combinedDirection.Unit else return root.CFrame.LookVector end end
local function executeSequencedTp()local char=LocalPlayer.Character if not char then return end local root=char:FindFirstChild("HumanoidRootPart")if not root then return end root.Anchored=true if footPart then footPart.CanCollide=false footPart.CFrame=CFrame.new(0,-1000,0)end task.wait(0.01)local moveDirection=calculateMoveVector()local newPosition=root.Position+(moveDirection*DASH_DISTANCE)local flatLook=Vector3.new(moveDirection.X,0,moveDirection.Z)if flatLook.Magnitude>0 then root.CFrame=CFrame.new(newPosition,newPosition+flatLook.Unit)else root.CFrame=CFrame.new(newPosition)end if footPart then footPart.CFrame=CFrame.new(newPosition.X,newPosition.Y-OFFSET_Y,newPosition.Z)footPart.CanCollide=true end root.Anchored=false end
local function updateFlyLoopState()if isAutoFlyActive and isSystemActive then CircleBtn.Text="VOAR\n[ON]"CircleBtn.BackgroundColor3=Color3.fromRGB(0,160,255)if not tpTask then tpTask=task.spawn(function()while isAutoFlyActive and isSystemActive do executeSequencedTp()task.wait(TP_SPEED_DELAY)end tpTask=nil end)end else CircleBtn.Text="VOAR\n[OFF]"CircleBtn.BackgroundColor3=Color3.fromRGB(60,60,80)local char=LocalPlayer.Character if char then local root=char:FindFirstChild("HumanoidRootPart")if root then root.Anchored=false end end if footPart then footPart.CanCollide=true end end end
PfLockBtn.MouseButton1Click:Connect(function()isBtnDraggable=not isBtnDraggable CircleBtn.Draggable=isBtnDraggable if isBtnDraggable then PfLockBtn.Text="BOTÃO: MÓVEL"PfLockBtn.BackgroundColor3=Color3.fromRGB(0,160,255)else PfLockBtn.Text="BOTÃO: TRAVADO"PfLockBtn.BackgroundColor3=Color3.fromRGB(60,60,80)end saveSettings()end)
CircleBtn.MouseButton1Click:Connect(function()if not isSystemActive then return end isAutoFlyActive=not isAutoFlyActive updateFlyLoopState()end)
PfToggleBtn.MouseButton1Click:Connect(function()isSystemActive=not isSystemActive if isSystemActive then PfToggleBtn.Text="SISTEMA: ON"PfToggleBtn.BackgroundColor3=Color3.fromRGB(0,180,80)CircleBtn.Visible=true liftCharacter()createFootPart()startTracking()else PfToggleBtn.Text="SISTEMA: OFF"PfToggleBtn.BackgroundColor3=Color3.fromRGB(180,40,40)isAutoFlyActive=false CircleBtn.Visible=false updateFlyLoopState()if updateConnection then updateConnection:Disconnect()updateConnection=nil end destroyFootPart()end end)
LocalPlayer.CharacterAdded:Connect(function()if isSystemActive then task.wait(0.5)liftCharacter()createFootPart()startTracking()end end)
LO=LO+1 local mainListWrapper=Instance.new("Frame",tp)mainListWrapper.Size=UDim2.new(1,0,0,0)mainListWrapper.AutomaticSize=Enum.AutomaticSize.Y mainListWrapper.BackgroundTransparency=1 mainListWrapper.LayoutOrder=LO mainListWrapper.Visible=false
local mlwLayout=Instance.new("UIListLayout",mainListWrapper)mlwLayout.Padding=UDim.new(0,6)mlwLayout.SortOrder=Enum.SortOrder.LayoutOrder
local searchBoxTP=Instance.new("TextBox",mainListWrapper)searchBoxTP.Size=UDim2.new(1,0,0,26)searchBoxTP.BackgroundColor3=Color3.fromRGB(35,35,45)searchBoxTP.PlaceholderText="Pesquisar jogador..."searchBoxTP.Text=""searchBoxTP.TextColor3=Color3.fromRGB(255,255,255)searchBoxTP.PlaceholderColor3=Color3.fromRGB(150,150,150)searchBoxTP.Font=Enum.Font.Gotham searchBoxTP.TextSize=11 searchBoxTP.ClearTextOnFocus=false searchBoxTP.BorderSizePixel=0 Instance.new("UICorner",searchBoxTP).CornerRadius=UDim.new(0,6)
local playerListContainer=Instance.new("Frame",mainListWrapper)playerListContainer.Size=UDim2.new(1,0,0,0)playerListContainer.AutomaticSize=Enum.AutomaticSize.Y playerListContainer.BackgroundTransparency=1
local plcLayout=Instance.new("UIListLayout",playerListContainer)plcLayout.Padding=UDim.new(0,6)plcLayout.SortOrder=Enum.SortOrder.LayoutOrder
toggleListBtn.MouseButton1Click:Connect(function()isListOpen=not isListOpen mainListWrapper.Visible=isListOpen if isListOpen then toggleListBtn.Text="FECHAR LISTA"toggleListBtn.BackgroundColor3=Color3.fromRGB(180,40,40)else toggleListBtn.Text="ABRIR LISTA"toggleListBtn.BackgroundColor3=Color3.fromRGB(0,160,100)end end)
local function ToggleEspVisual(player,btn)if espVisualTarget==player then espVisualTarget=nil espVisualEnabled=false btn.Text="ESP"btn.BackgroundColor3=Color3.fromRGB(255,255,255)if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid")then Camera.CameraSubject=LocalPlayer.Character:FindFirstChild("Humanoid")end else espVisualTarget=player espVisualEnabled=true btn.Text="ESP ON"btn.BackgroundColor3=Color3.fromRGB(0,255,0)if player.Character and player.Character:FindFirstChild("Humanoid")then Camera.CameraSubject=player.Character:FindFirstChild("Humanoid")end for _,child in pairs(playerListContainer:GetChildren())do if child:IsA("Frame")and child.Name=="PlayerItem"then for _,sub in pairs(child:GetChildren())do if sub:IsA("TextButton")and sub.Text=="ESP ON"and sub~=btn then sub.Text="ESP"sub.BackgroundColor3=Color3.fromRGB(255,255,255)end end end end end end
local function UpdatePlayerList()for _,child in pairs(playerListContainer:GetChildren())do if child:IsA("Frame")and child.Name=="PlayerItem"then child:Destroy()end end local plrs=Players:GetPlayers()table.sort(plrs,function(a,b)return a.Name:lower()<b.Name:lower()end)local filterText=searchBoxTP.Text:lower()local itemLO=0 for _,p in ipairs(plrs)do if p~=LocalPlayer then if filterText==""or string.find(p.Name:lower(),filterText)then itemLO=itemLO+1 local Item=Instance.new("Frame",playerListContainer)Item.Name="PlayerItem"Item.Size=UDim2.new(1,0,0,26)Item.BackgroundColor3=Color3.fromRGB(28,28,36)Item.BorderSizePixel=0 Item.LayoutOrder=itemLO Instance.new("UICorner",Item).CornerRadius=UDim.new(0,6)
local NameLbl=Instance.new("TextLabel",Item)NameLbl.Size=UDim2.new(1,-85,1,0)NameLbl.Position=UDim2.new(0,6,0,0)NameLbl.BackgroundTransparency=1 NameLbl.Text=p.Name NameLbl.TextColor3=Color3.new(1,1,1)NameLbl.Font=Enum.Font.Gotham NameLbl.TextSize=11 NameLbl.TextXAlignment=Enum.TextXAlignment.Left
local EspBtn=Instance.new("TextButton",Item)EspBtn.Size=UDim2.new(0,36,0,20)EspBtn.Position=UDim2.new(1,-76,0.5,-10)EspBtn.Text=(espVisualTarget==p and espVisualEnabled)and"ESP ON"or"ESP"EspBtn.BackgroundColor3=(espVisualTarget==p and espVisualEnabled)and Color3.fromRGB(0,255,0)or Color3.fromRGB(255,255,255)EspBtn.TextColor3=Color3.new(0,0,0)EspBtn.Font=Enum.Font.GothamBold EspBtn.TextSize=10 Instance.new("UICorner",EspBtn).CornerRadius=UDim.new(0,4)EspBtn.MouseButton1Click:Connect(function()ToggleEspVisual(p,EspBtn)end)
local TPBtn=Instance.new("TextButton",Item)TPBtn.Size=UDim2.new(0,36,0,20)TPBtn.Position=UDim2.new(1,-36,0.5,-10)TPBtn.Text="TP"TPBtn.BackgroundColor3=Color3.fromRGB(255,255,255)TPBtn.TextColor3=Color3.new(0,0,0)TPBtn.Font=Enum.Font.GothamBold Instance.new("UICorner",TPBtn).CornerRadius=UDim.new(0,4)TPBtn.MouseButton1Click:Connect(function()TeleportTo(p,TPBtn)end)end end end end
searchBoxTP:GetPropertyChangedSignal("Text"):Connect(UpdatePlayerList)Players.PlayerAdded:Connect(UpdatePlayerList)Players.PlayerRemoving:Connect(UpdatePlayerList)UpdatePlayerList()

-- BAN PLAYER
LO=0 SH(bp,"ESPECTAR & CARRO")local modoDescidaAtivo=false local posicaoInicialAtivacao=nil local conexaoPlayerRemovido=nil local jogadorEspectado=nil local jogadorPerseguidoCarro=nil local conexaoLoop=nil local botoesRegistrados={}
local ultimoTempoAlternancia=0 local estadoToggleAutomatico=true
local BtnDescida=Instance.new("TextButton",bp)BtnDescida.Size=UDim2.new(1,0,0,28)BtnDescida.LayoutOrder=LO LO=LO+1 BtnDescida.BackgroundColor3=Color3.fromRGB(180,50,50)BtnDescida.Text="Descer e Voltar: OFF"BtnDescida.TextColor3=Color3.fromRGB(255,255,255)BtnDescida.TextSize=11 BtnDescida.Font=Enum.Font.GothamBold Instance.new("UICorner",BtnDescida).CornerRadius=UDim.new(0,6)
BtnDescida.MouseButton1Click:Connect(function()modoDescidaAtivo=not modoDescidaAtivo if modoDescidaAtivo then BtnDescida.Text="Descer e Voltar: ON"BtnDescida.BackgroundColor3=Color3.fromRGB(40,180,40)else BtnDescida.Text="Descer e Voltar: OFF"BtnDescida.BackgroundColor3=Color3.fromRGB(180,50,50)end end)
local BtnVoltarInicio=Instance.new("TextButton",bp)BtnVoltarInicio.Size=UDim2.new(1,0,0,28)BtnVoltarInicio.LayoutOrder=LO LO=LO+1 BtnVoltarInicio.BackgroundColor3=Color3.fromRGB(40,100,180)BtnVoltarInicio.Text="Salto e Voltar ao Início"BtnVoltarInicio.TextColor3=Color3.fromRGB(255,255,255)BtnVoltarInicio.TextSize=11 BtnVoltarInicio.Font=Enum.Font.GothamBold Instance.new("UICorner",BtnVoltarInicio).CornerRadius=UDim.new(0,6)
local function resetarConexoes()if conexaoLoop then conexaoLoop:Disconnect()conexaoLoop=nil end if conexaoPlayerRemovido then conexaoPlayerRemovido:Disconnect()conexaoPlayerRemovido=nil end Camera.CameraType=Enum.CameraType.Custom if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid")then Camera.CameraSubject=LocalPlayer.Character.Humanoid end end
local function pararTudoEVoltar()resetarConexoes()for _,dados in pairs(botoesRegistrados)do dados.bEsp.Text="Esp: OFF"dados.bEsp.BackgroundColor3=Color3.fromRGB(180,50,50)dados.bCar.Text="Car: OFF"dados.bCar.BackgroundColor3=Color3.fromRGB(180,50,50)end jogadorEspectado=nil jogadorPerseguidoCarro=nil if posicaoInicialAtivacao then local charLocal=LocalPlayer.Character if charLocal then local seat=charLocal:FindFirstChildWhichIsA("Humanoid",true)and charLocal:FindFirstChildWhichIsA("Humanoid",true).SeatPart local objetoParaMover=seat and seat.Parent or charLocal local cframeAlto=posicaoInicialAtivacao+Vector3.new(0,15,0)if objetoParaMover.PrimaryPart then objetoParaMover:SetPrimaryPartCFrame(cframeAlto)elseif objetoParaMover:FindFirstChild("HumanoidRootPart")then objetoParaMover.HumanoidRootPart.CFrame=cframeAlto end task.wait(0.15)if objetoParaMover.PrimaryPart then objetoParaMover:SetPrimaryPartCFrame(posicaoInicialAtivacao)elseif objetoParaMover:FindFirstChild("HumanoidRootPart")then objetoParaMover.HumanoidRootPart.CFrame=posicaoInicialAtivacao end end end end
BtnVoltarInicio.MouseButton1Click:Connect(function()pararTudoEVoltar()end)
local SearchBoxBan=Instance.new("TextBox",bp)SearchBoxBan.Size=UDim2.new(1,0,0,26)SearchBoxBan.LayoutOrder=LO LO=LO+1 SearchBoxBan.BackgroundColor3=Color3.fromRGB(35,35,45)SearchBoxBan.TextColor3=Color3.fromRGB(255,255,255)SearchBoxBan.PlaceholderText="Pesquisar jogador..."SearchBoxBan.Text=""SearchBoxBan.TextSize=11 SearchBoxBan.Font=Enum.Font.Gotham SearchBoxBan.ClearTextOnFocus=false SearchBoxBan.BorderSizePixel=0 Instance.new("UICorner",SearchBoxBan).CornerRadius=UDim.new(0,6)
local playerScrollBan=Instance.new("ScrollingFrame",bp)playerScrollBan.Size=UDim2.new(1,0,0,180)playerScrollBan.LayoutOrder=LO LO=LO+1 playerScrollBan.BackgroundColor3=Color3.fromRGB(20,20,26)playerScrollBan.BorderSizePixel=0 playerScrollBan.CanvasSize=UDim2.new(0,0,0,0)playerScrollBan.ScrollingDirection=Enum.ScrollingDirection.Y playerScrollBan.ScrollBarThickness=4 Instance.new("UICorner",playerScrollBan).CornerRadius=UDim.new(0,6)
local banListLayout=Instance.new("UIListLayout",playerScrollBan)banListLayout.Padding=UDim.new(0,4)banListLayout.SortOrder=Enum.SortOrder.LayoutOrder
banListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()playerScrollBan.CanvasSize=UDim2.new(0,0,0,banListLayout.AbsoluteContentSize.Y)end)
local function filtrarJogadoresBan(textoDigitado)local termo=string.lower(textoDigitado)for player,dados in pairs(botoesRegistrados)do if player and player.Parent then local nomePlayer=string.lower(player.Name)if termo==""or string.find(nomePlayer,termo)then dados.frame.Visible=true else dados.frame.Visible=false end end end end
SearchBoxBan:GetPropertyChangedSignal("Text"):Connect(function()filtrarJogadoresBan(SearchBoxBan.Text)end)
local function desativarColisao(objeto)for _,parte in ipairs(objeto:GetDescendants())do if parte:IsA("BasePart")then parte.CanCollide=false end end end
local function criarLinhaBan(player)if player==LocalPlayer then return end local Frame=Instance.new("Frame",playerScrollBan)Frame.Size=UDim2.new(1,0,0,26)Frame.BackgroundColor3=Color3.fromRGB(40,40,50)Frame.BorderSizePixel=0 Instance.new("UICorner",Frame).CornerRadius=UDim.new(0,4)
local Nome=Instance.new("TextLabel",Frame)Nome.Size=UDim2.new(1,-115,1,0)Nome.Position=UDim2.new(0,6,0,0)Nome.BackgroundTransparency=1 Nome.Text=player.Name Nome.TextColor3=Color3.fromRGB(255,255,255)Nome.TextSize=11 Nome.TextXAlignment=Enum.TextXAlignment.Left Nome.Font=Enum.Font.Gotham
local BEsp=Instance.new("TextButton",Frame)BEsp.Size=UDim2.new(0,52,0,20)BEsp.Position=UDim2.new(1,-110,0.5,-10)BEsp.BackgroundColor3=Color3.fromRGB(180,50,50)BEsp.Text="Esp: OFF"BEsp.TextColor3=Color3.fromRGB(255,255,255)BEsp.TextSize=10 BEsp.Font=Enum.Font.GothamBold Instance.new("UICorner",BEsp).CornerRadius=UDim.new(0,4)
local BCar=Instance.new("TextButton",Frame)BCar.Size=UDim2.new(0,52,0,20)BCar.Position=UDim2.new(1,-54,0.5,-10)BCar.BackgroundColor3=Color3.fromRGB(180,50,50)BCar.Text="Car: OFF"BCar.TextColor3=Color3.fromRGB(255,255,255)BCar.TextSize=10 BCar.Font=Enum.Font.GothamBold Instance.new("UICorner",BCar).CornerRadius=UDim.new(0,4)
BEsp.MouseButton1Click:Connect(function()for _,dados in pairs(botoesRegistrados)do dados.bEsp.Text="Esp: OFF"dados.bEsp.BackgroundColor3=Color3.fromRGB(180,50,50)dados.bCar.Text="Car: OFF"dados.bCar.BackgroundColor3=Color3.fromRGB(180,50,50)end if jogadorEspectado==player then resetarConexoes()jogadorEspectado=nil jogadorPerseguidoCarro=nil else resetarConexoes()jogadorEspectado=player jogadorPerseguidoCarro=nil BEsp.Text="Esp: ON"BEsp.BackgroundColor3=Color3.fromRGB(40,180,40)conexaoLoop=RunService.RenderStepped:Connect(function()if player.Character and player.Character:FindFirstChild("Humanoid")then Camera.CameraSubject=player.Character.Humanoid end end)end end)
BCar.MouseButton1Click:Connect(function()for _,dados in pairs(botoesRegistrados)do dados.bEsp.Text="Esp: OFF"dados.bEsp.BackgroundColor3=Color3.fromRGB(180,50,50)dados.bCar.Text="Car: OFF"dados.bCar.BackgroundColor3=Color3.fromRGB(180,50,50)end if jogadorPerseguidoCarro==player then pararTudoEVoltar()else resetarConexoes()jogadorPerseguidoCarro=player jogadorEspectado=nil ultimoTempoAlternancia=tick()estadoToggleAutomatico=true local charLocal=LocalPlayer.Character if charLocal then local seat=charLocal:FindFirstChildWhichIsA("Humanoid",true)and charLocal:FindFirstChildWhichIsA("Humanoid",true).SeatPart local objetoParaMover=seat and seat.Parent or charLocal if objetoParaMover.PrimaryPart then posicaoInicialAtivacao=objetoParaMover.PrimaryPart.CFrame elseif objetoParaMover:FindFirstChild("HumanoidRootPart")then posicaoInicialAtivacao=objetoParaMover.HumanoidRootPart.CFrame end local cframePulo=posicaoInicialAtivacao+Vector3.new(0,6,0)if objetoParaMover.PrimaryPart then objetoParaMover:SetPrimaryPartCFrame(cframePulo)elseif objetoParaMover:FindFirstChild("HumanoidRootPart")then objetoParaMover.HumanoidRootPart.CFrame=cframePulo end end BCar.Text="Car: ON"BCar.BackgroundColor3=Color3.fromRGB(40,180,40)conexaoPlayerRemovido=Players.PlayerRemoving:Connect(function(playerSaindo)if playerSaindo==player then pararTudoEVoltar()end end)conexaoLoop=RunService.Heartbeat:Connect(function()local charLocal=LocalPlayer.Character if not charLocal then return end local seat=charLocal:FindFirstChildWhichIsA("Humanoid",true)and charLocal:FindFirstChildWhichIsA("Humanoid",true).SeatPart local objetoParaMover=seat and seat.Parent or charLocal desativarColisao(objetoParaMover)if tick()-ultimoTempoAlternancia>=3.0 then ultimoTempoAlternancia=tick()estadoToggleAutomatico=not estadoToggleAutomatico end if player.Character and player.Character:FindFirstChild("HumanoidRootPart")then local alvoCFrame=player.Character.HumanoidRootPart.CFrame local deslocamentoAltura=-10 if modoDescidaAtivo and estadoToggleAutomatico then deslocamentoAltura=-50 else deslocamentoAltura=-10 end local cframeFinal=alvoCFrame*CFrame.Angles(math.rad(-100),0,0)+Vector3.new(0,deslocamentoAltura,0)if objetoParaMover.PrimaryPart then objetoParaMover:SetPrimaryPartCFrame(cframeFinal)elseif objetoParaMover:FindFirstChild("HumanoidRootPart")then objetoParaMover.HumanoidRootPart.CFrame=cframeFinal end end end)end end)
botoesRegistrados[player]={frame=Frame,bEsp=BEsp,bCar=BCar}filtrarJogadoresBan(SearchBoxBan.Text)end
local function removerLinhaBan(player)if botoesRegistrados[player]then if jogadorEspectado==player or jogadorPerseguidoCarro==player then pararTudoEVoltar()end botoesRegistrados[player].frame:Destroy()botoesRegistrados[player]=nil end end
for _,p in ipairs(Players:GetPlayers())do criarLinhaBan(p)end Players.PlayerAdded:Connect(criarLinhaBan)Players.PlayerRemoving:Connect(removerLinhaBan)

RunService.RenderStepped:Connect(function()if isFlyModeEnabled then local char=LocalPlayer.Character if char then local root=char:FindFirstChild("HumanoidRootPart")if root then local camCFrame=Camera.CFrame local moveDir=Vector3.new(0,0,0)if isHoldingUp then moveDir=moveDir+Vector3.new(0,1,0)end if isHoldingFwd then moveDir=moveDir+camCFrame.LookVector end root.CFrame=root.CFrame+(moveDir*(movementSpeed*0.05))end end end if freezeEnabled and freezePosition then local root=LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")if root then root.CFrame=CFrame.new(freezePosition)end end end)

local function IV(tp,ch)if not C.WC then return true end local o=Camera.CFrame.Position local d=(tp-o)local p=RaycastParams.new()p.FilterType=Enum.RaycastFilterType.Blacklist local ig={LocalPlayer.Character}local h=ch:FindFirstChildOfClass("Humanoid")if h and h.SeatPart then table.insert(ig,h.SeatPart)if h.SeatPart.Parent then table.insert(ig,h.SeatPart.Parent)end end p.FilterDescendantsInstances=ig local r=workspace:Raycast(o,d,p)if r then return r.Instance:IsDescendantOf(ch)end return false end
local function GTP(ch)local h=ch:FindFirstChildOfClass("Humanoid")if h and h.SeatPart then return h.SeatPart.Position+((h.SeatPart.AssemblyLinearVelocity or Vector3.zero)*0.15)end if C.TP=="Head"then local hd=ch:FindFirstChild("Head")if hd then return hd.Position end elseif C.TP=="UpperTorso"then local ut=ch:FindFirstChild("UpperTorso")if ut then return ut.Position end local t=ch:FindFirstChild("Torso")if t then return t.Position end elseif C.TP=="HumanoidRootPart"then local r=ch:FindFirstChild("HumanoidRootPart")if r then return r.Position end end local hd=ch:FindFirstChild("Head")if hd then return hd.Position end local ut=ch:FindFirstChild("UpperTorso")if ut then return ut.Position end local t=ch:FindFirstChild("Torso")if t then return t.Position end local lt=ch:FindFirstChild("LowerTorso")if lt then return lt.Position end local r=ch:FindFirstChild("HumanoidRootPart")if r then return r.Position end return nil end
local function GCT()local cl,sh=nil,math.huge local cn=Vector2.new(Camera.ViewportSize.X/2,Camera.ViewportSize.Y/2)local cp=Camera.CFrame.Position local maxDist=tonumber(C.MD)or 300 for _,pl in ipairs(Players:GetPlayers())do if pl~=LocalPlayer and pl.Character then if C.TO and pl.Team==LocalPlayer.Team then continue end local hm=pl.Character:FindFirstChildOfClass("Humanoid")local hr=pl.Character:FindFirstChild("HumanoidRootPart")if not hr or(hr.Position-cp).Magnitude>maxDist then continue end local ps=GTP(pl.Character)if hm and hm.Health>0 and ps and IV(ps,pl.Character)then local sc,on=Camera:WorldToViewportPoint(ps)if on then local sp=Vector2.new(sc.X,sc.Y)local df=(sp-cn).Magnitude local vt=false if C.FS=="Circle"then vt=df<=C.FH else local dx=math.abs(sp.X-cn.X)local dy=math.abs(sp.Y-cn.Y)vt=dx<=(C.LW or 80)and dy<=(C.FH or 80)end if vt and df<sh then sh=df cl=pl end end end end end return cl end
RunService.RenderStepped:Connect(function()local cn=Vector2.new(Camera.ViewportSize.X/2,Camera.ViewportSize.Y/2)local targetFound=false if C.A then local t=GCT()if t and t.Character then targetFound=true local ps=GTP(t.Character)if ps then local tc=CFrame.new(Camera.CFrame.Position,ps)Camera.CFrame=Camera.CFrame:Lerp(tc,math.clamp(C.SM,0.01,1))end end end if C.SF then local dynamicColor=targetFound and Color3.fromRGB(0,255,0)or Color3.fromRGB(255,0,0)if C.FS=="Circle"then Circle.Visible=true Square.Visible=false Circle.Position=cn Circle.Radius=C.FH Circle.Color=dynamicColor else Square.Visible=true Circle.Visible=false Square.Size=Vector2.new((C.LW or 80)*2,(C.FH or 80)*2)Square.Position=Vector2.new(cn.X-(C.LW or 80),cn.Y-(C.FH or 80))Square.Color=dynamicColor end else Circle.Visible=false Square.Visible=false end end)