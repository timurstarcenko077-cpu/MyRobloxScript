-- ============================================
--  КРАСИВОЕ МЕНЮ v6 (телефон / планшет)
-- ============================================
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UIS = game:GetService("UserInputService")
local plr = Players.LocalPlayer
local pg = plr:WaitForChild("PlayerGui")

-- Очистка
for _, obj in pairs(pg:GetChildren()) do
	if obj.Name == "MyMenu" or obj.Name == "BeautyMenu" then
		obj:Destroy()
	end
end

-- 🎨 ЦВЕТА
local ACCENT = Color3.fromRGB(140, 60, 255)
local ACCENT2 = Color3.fromRGB(80, 180, 255)
local BG = Color3.fromRGB(15, 15, 22)
local BG2 = Color3.fromRGB(25, 20, 40)
local ELEMENT = Color3.fromRGB(30, 28, 45)
local TEXT = Color3.fromRGB(245, 245, 255)
local SUBTEXT = Color3.fromRGB(160, 160, 190)

local gui = Instance.new("ScreenGui")
gui.Name = "BeautyMenu"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
gui.DisplayOrder = 999999
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
gui.Parent = pg

-- ============================================
-- 🌈 ФОНОВОЕ СВЕЧЕНИЕ (декор)
-- ============================================
local glow = Instance.new("Frame")
glow.Size = UDim2.new(0, 300, 0, 300)
glow.Position = UDim2.new(1, -180, 0, 60)
glow.BackgroundColor3 = ACCENT
glow.BackgroundTransparency = 0.7
glow.BorderSizePixel = 0
glow.ZIndex = 1
glow.Parent = gui

local glowCorner = Instance.new("UICorner", glow)
glowCorner.CornerRadius = UDim.new(1, 0)

local glowGrad = Instance.new("UIGradient", glow)
glowGrad.Color = ColorSequence.new({
	ColorSequenceKeypoint.new(0, ACCENT),
	ColorSequenceKeypoint.new(1, ACCENT2)
})
glowGrad.Rotation = 45

TweenService:Create(glow, TweenInfo.new(3, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true), {
	BackgroundTransparency = 0.5,
	Size = UDim2.new(0, 350, 0, 350)
}):Play()

-- ============================================
-- ✨ КНОПКА "ОТКРЫТЬ" (с градиентом и свечением)
-- ============================================
local openBtn = Instance.new("TextButton")
openBtn.Size = UDim2.new(0, 120, 0, 55)
openBtn.Position = UDim2.new(1, -140, 0, 110)
openBtn.BackgroundColor3 = Color3.new(1, 1, 1)
openBtn.Text = "✦ ОТКРЫТЬ"
openBtn.TextColor3 = Color3.new(1, 1, 1)
openBtn.TextSize = 15
openBtn.Font = Enum.Font.GothamBold
openBtn.BorderSizePixel = 0
openBtn.Active = true
openBtn.ZIndex = 10000
openBtn.Parent = gui

local oc = Instance.new("UICorner", openBtn)
oc.CornerRadius = UDim.new(0, 14)

local og = Instance.new("UIGradient", openBtn)
og.Color = ColorSequence.new({
	ColorSequenceKeypoint.new(0, Color3.fromRGB(50, 220, 120)),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(80, 200, 255))
})
og.Rotation = 45

local oGlow = Instance.new("UIStroke", openBtn)
oGlow.Color = Color3.fromRGB(80, 255, 180)
oGlow.Thickness = 2
oGlow.Transparency = 0.4

-- ============================================
-- ✨ КНОПКА "ЗАКРЫТЬ"
-- ============================================
local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 120, 0, 55)
closeBtn.Position = UDim2.new(1, -140, 0, 175)
closeBtn.BackgroundColor3 = Color3.new(1, 1, 1)
closeBtn.Text = "✕ ЗАКРЫТЬ"
closeBtn.TextColor3 = Color3.new(1, 1, 1)
closeBtn.TextSize = 15
closeBtn.Font = Enum.Font.GothamBold
closeBtn.BorderSizePixel = 0
closeBtn.Active = true
closeBtn.ZIndex = 10000
closeBtn.Parent = gui

local cc = Instance.new("UICorner", closeBtn)
cc.CornerRadius = UDim.new(0, 14)

local cg = Instance.new("UIGradient", closeBtn)
cg.Color = ColorSequence.new({
	ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 80, 120)),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 150, 80))
})
cg.Rotation = 45

local cGlow = Instance.new("UIStroke", closeBtn)
cGlow.Color = Color3.fromRGB(255, 120, 120)
cGlow.Thickness = 2
cGlow.Transparency = 0.4

-- ============================================
-- 🎨 ГЛАВНОЕ МЕНЮ (с градиентом)
-- ============================================
local menu = Instance.new("Frame")
menu.Size = UDim2.new(0, 280, 0, 380)
menu.Position = UDim2.new(0.5, -140, 0.5, -190)
menu.BackgroundColor3 = BG
menu.BorderSizePixel = 0
menu.Visible = false
menu.Active = true
menu.ZIndex = 9998
menu.Parent = gui

local mc = Instance.new("UICorner", menu)
mc.CornerRadius = UDim.new(0, 18)

local menuGrad = Instance.new("UIGradient", menu)
menuGrad.Color = ColorSequence.new({
	ColorSequenceKeypoint.new(0, BG),
	ColorSequenceKeypoint.new(1, BG2)
})
menuGrad.Rotation = 135

local menuStroke = Instance.new("UIStroke", menu)
menuStroke.Color = ACCENT
menuStroke.Thickness = 1.5
menuStroke.Transparency = 0.3

-- ============================================
-- 🎨 ЗАГОЛОВОК (с градиентом и анимацией)
-- ============================================
local header = Instance.new("Frame")
header.Size = UDim2.new(1, 0, 0, 55)
header.BackgroundColor3 = Color3.new(1, 1, 1)
header.BorderSizePixel = 0
header.ZIndex = 9999
header.Parent = menu

local hc = Instance.new("UICorner", header)
hc.CornerRadius = UDim.new(0, 18)

local hFix = Instance.new("Frame", header)
hFix.Size = UDim2.new(1, 0, 0, 20)
hFix.Position = UDim2.new(0, 0, 1, -20)
hFix.BackgroundColor3 = Color3.new(1, 1, 1)
hFix.BorderSizePixel = 0
hFix.ZIndex = 9999

local hGrad = Instance.new("UIGradient", header)
hGrad.Color = ColorSequence.new({
	ColorSequenceKeypoint.new(0, ACCENT),
	ColorSequenceKeypoint.new(1, ACCENT2)
})
hGrad.Rotation = 45

local hGradFix = Instance.new("UIGradient", hFix)
hGradFix.Color = hGrad.Color
hGradFix.Rotation = 45

local headerText = Instance.new("TextLabel")
headerText.Size = UDim2.new(1, -20, 1, 0)
headerText.Position = UDim2.new(0, 18, 0, 0)
headerText.BackgroundTransparency = 1
headerText.Text = "⚡ CHEAT MENU"
headerText.TextColor3 = Color3.new(1, 1, 1)
headerText.TextSize = 20
headerText.Font = Enum.Font.GothamBold
headerText.TextXAlignment = Enum.TextXAlignment.Left
headerText.ZIndex = 10000
headerText.Parent = header

-- Анимация градиента в заголовке
task.spawn(function()
	while header.Parent do
		for i = 0, 360, 5 do
			if not header.Parent then break end
			hGrad.Rotation = i
			hGradFix.Rotation = i
			task.wait(0.05)
		end
	end
end)

-- ============================================
-- 🔥 ФУНКЦИЯ АНИМАЦИИ НАЖАТИЯ
-- ============================================
local function pressAnim(btn)
	local origSize = btn.Size
	TweenService:Create(btn, TweenInfo.new(0.1), {
		Size = UDim2.new(origSize.X.Scale, origSize.X.Offset - 4, origSize.Y.Scale, origSize.Y.Offset - 4)
	}):Play()
	task.wait(0.1)
	TweenService:Create(btn, TweenInfo.new(0.1), {
		Size = origSize
	}):Play()
end

-- ============================================
-- ОТКРЫТИЕ / ЗАКРЫТИЕ с анимацией
-- ============================================
local function openMenu()
	menu.Visible = true
	menu.Size = UDim2.new(0, 0, 0, 0)
	menu.Position = UDim2.new(0.5, 0, 0.5, 0)
	TweenService:Create(menu, TweenInfo.new(0.35, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
		Size = UDim2.new(0, 280, 0, 380),
		Position = UDim2.new(0.5, -140, 0.5, -190)
	}):Play()
end

local function closeMenu()
	local t = TweenService:Create(menu, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
		Size = UDim2.new(0, 0, 0, 0),
		Position = UDim2.new(0.5, 0, 0.5, 0)
	})
	t:Play()
	t.Completed:Connect(function()
		menu.Visible = false
	end)
end

openBtn.Activated:Connect(function()
	pressAnim(openBtn)
	openMenu()
end)

closeBtn.Activated:Connect(function()
	pressAnim(closeBtn)
	closeMenu()
end)

-- ============================================
-- 🎨 ФУНКЦИЯ СОЗДАНИЯ КРАСИВОЙ КНОПКИ
-- ============================================
local function makeBtn(text, y, callback)
	local b = Instance.new("TextButton")
	b.Size = UDim2.new(1, -24, 0, 52)
	b.Position = UDim2.new(0, 12, 0, y)
	b.BackgroundColor3 = ELEMENT
	b.Text = text
	b.TextColor3 = TEXT
	b.TextSize = 15
	b.Font = Enum.Font.GothamSemibold
	b.BorderSizePixel = 0
	b.AutoButtonColor = false
	b.Active = true
	b.ZIndex = 9999
	b.Parent = menu
	
	local bc = Instance.new("UICorner", b)
	bc.CornerRadius = UDim.new(0, 12)
	
	local bStroke = Instance.new("UIStroke", b)
	bStroke.Color = ACCENT
	bStroke.Thickness = 1
	bStroke.Transparency = 0.6
	
	-- Анимация наведения/нажатия
	b.MouseEnter:Connect(function()
		TweenService:Create(b, TweenInfo.new(0.15), {
			BackgroundColor3 = Color3.fromRGB(50, 40, 75)
		}):Play()
		TweenService:Create(bStroke, TweenInfo.new(0.15), {
			Transparency = 0.2
		}):Play()
	end)
	b.MouseLeave:Connect(function()
		TweenService:Create(b, TweenInfo.new(0.15), {
			BackgroundColor3 = ELEMENT
		}):Play()
		TweenService:Create(bStroke, TweenInfo.new(0.15), {
			Transparency = 0.6
		}):Play()
	end)
	
	b.Activated:Connect(function()
		pressAnim(b)
		callback()
	end)
	
	return b
end

-- ============================================
-- 🎯 ФУНКЦИИ
-- ============================================
-- WH
local whOn = false
local whBtn
whBtn = makeBtn("🎯 WH: OFF", 70, function()
	whOn = not whOn
	whBtn.Text = "🎯 WH: " .. (whOn and "ON" or "OFF")
	whBtn.BackgroundColor3 = whOn and ACCENT or ELEMENT
	
	if whOn then
		for _, p in pairs(Players:GetPlayers()) do
			if p ~= plr and p.Character then
				local char = p.Character
				local hrp = char:FindFirstChild("HumanoidRootPart")
				if hrp then
					if not char:FindFirstChild("MY_HL") then
						local hl = Instance.new("Highlight")
						hl.Name = "MY_HL"
						hl.FillColor = Color3.fromRGB(255, 60, 60)
						hl.OutlineColor = Color3.new(1,1,1)
						hl.FillTransparency = 0.5
						hl.OutlineTransparency = 0
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
						box.Color3 = Color3.fromRGB(255, 60, 60)
						box.Parent = hrp
					end
				end
			end
		end
	else
		for _, p in pairs(Players:GetPlayers()) do
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
local speeds = {16, 50, 100, 150, 200}
local sIdx = 1
local spdBtn
spdBtn = makeBtn("⚡ SPEED: 16", 130, function()
	sIdx = sIdx + 1
	if sIdx > #speeds then sIdx = 1 end
	local s = speeds[sIdx]
	spdBtn.Text = "⚡ SPEED: " .. s
	if plr.Character then
		local h = plr.Character:FindFirstChildOfClass("Humanoid")
		if h then h.WalkSpeed = s end
	end
end)

-- Jump
local jumps = {50, 100, 150, 200, 300}
local jIdx = 1
local jmpBtn
jmpBtn = makeBtn("🦘 JUMP: 50", 190, function()
	jIdx = jIdx + 1
	if jIdx > #jumps then jIdx = 1 end
	local j = jumps[jIdx]
	jmpBtn.Text = "🦘 JUMP: " .. j
	if plr.Character then
		local h = plr.Character:FindFirstChildOfClass("Humanoid")
		if h then
			h.UseJumpPower = true
			h.JumpPower = j
		end
	end
end)

-- Infinite Jump
local infJump = false
local infBtn
infBtn = makeBtn("🌀 INF JUMP: OFF", 250, function()
	infJump = not infJump
	infBtn.Text = "🌀 INF JUMP: " .. (infJump and "ON" or "OFF")
	infBtn.BackgroundColor3 = infJump and ACCENT or ELEMENT
end)

-- Reset
local resetBtn = makeBtn("🔄 RESET", 310, function()
	if plr.Character then
		plr.Character:BreakJoints()
	end
end)

-- Красный градиент для Reset
local rg = Instance.new("UIGradient", resetBtn)
rg.Color = ColorSequence.new({
	ColorSequenceKeypoint.new(0, Color3.fromRGB(180, 40, 60)),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(230, 80, 100))
})
rg.Rotation = 45

-- ============================================
-- Обработчики
-- ============================================
UIS.JumpRequest:Connect(function()
	if infJump and plr.Character then
		local h = plr.Character:FindFirstChildOfClass("Humanoid")
		if h then h:ChangeState(Enum.HumanoidStateType.Jumping) end
	end
end)

spawn(function()
	while wait(1) do
		if whOn then
			for _, p in pairs(Players:GetPlayers()) do
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
						box.Color3 = Color3.fromRGB(255, 60, 60)
						box.Parent = hrp
					end
				end
			end
		end
	end
end)

print("✅ Красивое меню загружено!")
