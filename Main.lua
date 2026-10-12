-- ДВЕ КНОПКИ: ОТКРЫТЬ / ЗАКРЫТЬ
local plr = game.Players.LocalPlayer
local pg = plr:WaitForChild("PlayerGui")

local old = pg:FindFirstChild("MyMenu")
if old then old:Destroy() end

local gui = Instance.new("ScreenGui")
gui.Name = "MyMenu"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
gui.DisplayOrder = 999999
gui.Parent = pg

-- ============================================
-- КНОПКА "ОТКРЫТЬ" (справа сверху)
-- ============================================
local openBtn = Instance.new("TextButton")
openBtn.Size = UDim2.new(0, 100, 0, 50)
openBtn.Position = UDim2.new(1, -120, 0, 100)
openBtn.BackgroundColor3 = Color3.fromRGB(50, 200, 80)
openBtn.Text = "ОТКРЫТЬ"
openBtn.TextColor3 = Color3.new(1,1,1)
openBtn.TextSize = 14
openBtn.Font = Enum.Font.GothamBold
openBtn.BorderSizePixel = 0
openBtn.Active = true
openBtn.ZIndex = 10000
openBtn.Parent = gui

local oc = Instance.new("UICorner", openBtn)
oc.CornerRadius = UDim.new(0, 10)

-- ============================================
-- КНОПКА "ЗАКРЫТЬ" (под первой)
-- ============================================
local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 100, 0, 50)
closeBtn.Position = UDim2.new(1, -120, 0, 160)
closeBtn.BackgroundColor3 = Color3.fromRGB(220, 50, 60)
closeBtn.Text = "ЗАКРЫТЬ"
closeBtn.TextColor3 = Color3.new(1,1,1)
closeBtn.TextSize = 14
closeBtn.Font = Enum.Font.GothamBold
closeBtn.BorderSizePixel = 0
closeBtn.Active = true
closeBtn.ZIndex = 10000
closeBtn.Parent = gui

local cc = Instance.new("UICorner", closeBtn)
cc.CornerRadius = UDim.new(0, 10)

-- ============================================
-- МЕНЮ
-- ============================================
local menu = Instance.new("Frame")
menu.Size = UDim2.new(0, 260, 0, 320)
menu.Position = UDim2.new(0.5, -130, 0.5, -160)
menu.BackgroundColor3 = Color3.fromRGB(20, 20, 28)
menu.BorderSizePixel = 0
menu.Visible = false
menu.Active = true
menu.ZIndex = 9998
menu.Parent = gui

local mc = Instance.new("UICorner", menu)
mc.CornerRadius = UDim.new(0, 12)

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 45)
title.BackgroundColor3 = Color3.fromRGB(138, 43, 226)
title.Text = "МЕНЮ"
title.TextColor3 = Color3.new(1,1,1)
title.TextSize = 18
title.Font = Enum.Font.GothamBold
title.BorderSizePixel = 0
title.ZIndex = 9999
title.Parent = menu

local tc = Instance.new("UICorner", title)
tc.CornerRadius = UDim.new(0, 12)

-- ============================================
-- ОТКРЫТИЕ / ЗАКРЫТИЕ
-- ============================================
local function openMenu()
	menu.Visible = true
end

local function closeMenu()
	menu.Visible = false
end

-- Только Activated (лучший для телефона)
openBtn.Activated:Connect(openMenu)
closeBtn.Activated:Connect(closeMenu)

-- ============================================
-- ФУНКЦИЯ КНОПКИ МЕНЮ
-- ============================================
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
	b.ZIndex = 9999
	b.Parent = menu
	
	local bc = Instance.new("UICorner", b)
	bc.CornerRadius = UDim.new(0, 10)
	
	b.Activated:Connect(callback)
	return b
end

-- WH
local whOn = false
local whBtn
whBtn = makeBtn("WH: OFF", 55, function()
	whOn = not whOn
	whBtn.Text = "WH: " .. (whOn and "ON" or "OFF")
	whBtn.BackgroundColor3 = whOn and Color3.fromRGB(138,43,226) or Color3.fromRGB(45,45,60)
	
	if whOn then
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
	else
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
		if whOn then
			for _, p in pairs(game.Players:GetPlayers()) do
				if p ~= plr and p.Character then
					local hrp = p.Character:FindFirstChild("HumanoidRootPart")
					if hrp and not hrp:FindFirstChild("MY_BOX") then
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
end)

print("✅ Меню загружено!")
