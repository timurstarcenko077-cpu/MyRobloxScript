-- ПРОСТОЕ МЕНЮ ДЛЯ ТЕЛЕФОНА
local plr = game.Players.LocalPlayer
local pg = plr:WaitForChild("PlayerGui")

-- Удаляем старое
local old = pg:FindFirstChild("MyMenu")
if old then old:Destroy() end

-- GUI
local gui = Instance.new("ScreenGui")
gui.Name = "MyMenu"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
gui.DisplayOrder = 999999
gui.Parent = pg

-- Кнопка открытия
local btn = Instance.new("TextButton")
btn.Size = UDim2.new(0, 65, 0, 65)
btn.Position = UDim2.new(1, -85, 0, 100)
btn.BackgroundColor3 = Color3.fromRGB(138, 43, 226)
btn.Text = "M"
btn.TextColor3 = Color3.new(1,1,1)
btn.TextSize = 28
btn.Font = Enum.Font.GothamBold
btn.BorderSizePixel = 0
btn.Active = true
btn.Parent = gui

local c = Instance.new("UICorner", btn)
c.CornerRadius = UDim.new(1, 0)

-- Меню
local menu = Instance.new("Frame")
menu.Size = UDim2.new(0, 260, 0, 320)
menu.Position = UDim2.new(0.5, -130, 0.5, -160)
menu.BackgroundColor3 = Color3.fromRGB(20, 20, 28)
menu.BorderSizePixel = 0
menu.Visible = false
menu.Active = true
menu.Parent = gui

local mc = Instance.new("UICorner", menu)
mc.CornerRadius = UDim.new(0, 12)

-- Заголовок
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 45)
title.BackgroundColor3 = Color3.fromRGB(138, 43, 226)
title.Text = "МЕНЮ"
title.TextColor3 = Color3.new(1,1,1)
title.TextSize = 18
title.Font = Enum.Font.GothamBold
title.BorderSizePixel = 0
title.Parent = menu

local tc = Instance.new("UICorner", title)
tc.CornerRadius = UDim.new(0, 12)

-- Открытие/закрытие
btn.MouseButton1Click:Connect(function()
	menu.Visible = not menu.Visible
end)
btn.Activated:Connect(function()
	menu.Visible = not menu.Visible
end)

-- Функция кнопки
local function makeBtn(text, y, callback)
	local b = Instance.new("TextButton")
	b.Size = UDim2.new(1, -20, 0, 48)
	b.Position = UDim2.new(0, 10, 0, y)
	b.BackgroundColor3 = Color3.fromRGB(45, 45, 60)
	b.Text = text
	b.TextColor3 = Color3.new(1,1,1)
	b.TextSize = 15
	b.Font = Enum.Font.GothamMedium
	b.BorderSizePixel = 0
	b.Active = true
	b.Parent = menu
	
	local bc = Instance.new("UICorner", b)
	bc.CornerRadius = UDim.new(0, 10)
	
	b.MouseButton1Click:Connect(callback)
	b.Activated:Connect(callback)
	return b
end

-- WH
local whOn = false
local whBtn

local function clearWH()
	for _, p in pairs(game.Players:GetPlayers()) do
		if p ~= plr and p.Character then
			local hl = p.Character:FindFirstChild("MY_HL")
			if hl then hl:Destroy() end
			local hrp = p.Character:FindFirstChild("HumanoidRootPart")
			if hrp then
				local bx = hrp:FindFirstChild("MY_BOX")
				if bx then bx:Destroy() end
			end
		end
	end
end

local function applyWH()
	for _, p in pairs(game.Players:GetPlayers()) do
		if p ~= plr and p.Character then
			local char = p.Character
			local hrp = char:FindFirstChild("HumanoidRootPart")
			if hrp then
				if not char:FindFirstChild("MY_HL") then
					local hl = Instance.new("Highlight")
					hl.Name = "MY_HL"
					hl.FillColor = Color3.fromRGB(255, 0, 0)
					hl.OutlineColor = Color3.new(1,1,1)
					hl.FillTransparency = 0.5
					hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
					hl.Adornee = char
					hl.Parent = char
				end
				if not hrp:FindFirstChild("MY_BOX") then
					local box = Instance.new("BoxHandleAdornment")
					box.Name = "MY_BOX"
					box.Size = Vector3.new(4, 6, 2)
					box.Adornee = hrp
					box.AlwaysOnTop = true
					box.ZIndex = 5
					box.Transparency = 0.5
					box.Color3 = Color3.fromRGB(255, 0, 0)
					box.Parent = hrp
				end
			end
		end
	end
end

whBtn = makeBtn("WH: OFF", 55, function()
	whOn = not whOn
	whBtn.Text = "WH: " .. (whOn and "ON" or "OFF")
	whBtn.BackgroundColor3 = whOn and Color3.fromRGB(138,43,226) or Color3.fromRGB(45,45,60)
	if whOn then applyWH() else clearWH() end
end)

-- Speed
local speeds = {16, 50, 100, 150}
local sIdx = 1
local spdBtn
spdBtn = makeBtn("SPEED: 16", 113, function()
	sIdx = sIdx + 1
	if sIdx > #speeds then sIdx = 1 end
	local s = speeds[sIdx]
	spdBtn.Text = "SPEED: " .. s
	if plr.Character then
		local h = plr.Character:FindFirstChildOfClass("Humanoid")
		if h then h.WalkSpeed = s end
	end
end)

-- Jump
local jumps = {50, 100, 150, 200}
local jIdx = 1
local jmpBtn
jmpBtn = makeBtn("JUMP: 50", 171, function()
	jIdx = jIdx + 1
	if jIdx > #jumps then jIdx = 1 end
	local j = jumps[jIdx]
	jmpBtn.Text = "JUMP: " .. j
	if plr.Character then
		local h = plr.Character:FindFirstChildOfClass("Humanoid")
		if h then
			h.UseJumpPower = true
			h.JumpPower = j
		end
	end
end)

-- Inf Jump
local infJump = false
local infBtn
infBtn = makeBtn("INF JUMP: OFF", 229, function()
	infJump = not infJump
	infBtn.Text = "INF JUMP: " .. (infJump and "ON" or "OFF")
	infBtn.BackgroundColor3 = infJump and Color3.fromRGB(138,43,226) or Color3.fromRGB(45,45,60)
end)

game:GetService("UserInputService").JumpRequest:Connect(function()
	if infJump and plr.Character then
		local h = plr.Character:FindFirstChildOfClass("Humanoid")
		if h then h:ChangeState(Enum.HumanoidStateType.Jumping) end
	end
end)

-- Автообновление WH
spawn(function()
	while wait(1) do
		if whOn then pcall(applyWH) end
	end
end)

print("✅ Меню загружено!")
