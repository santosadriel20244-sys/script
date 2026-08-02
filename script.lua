local Players = game:GetService("Players")
local lp = Players.LocalPlayer

local function add(p)
	if p == lp then return end
	
	local function char(c)
		local h = c:FindFirstChild("Head")
		if not h then return end
		
		if h:FindFirstChild("e") then return end
		
		local b = Instance.new("BillboardGui", h)
		b.Name = "e"
		b.Size = UDim2.new(0,40,0,40)
		b.AlwaysOnTop = true
		b.Adornee = h
		
		local t = Instance.new("TextLabel", b)
		t.Size = UDim2.new(1,0,1,0)
		t.BackgroundTransparency = 1
		t.Text = "●"
		t.TextColor3 = Color3.fromRGB(255,0,0)
		t.TextScaled = true
	end
	
	if p.Character then char(p.Character) end
	p.CharacterAdded:Connect(char)
end

for _,p in ipairs(Players:GetPlayers()) do
	add(p)
end

Players.PlayerAdded:Connect(add)