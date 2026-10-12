-- ============================================
--  МОБИЛЬНОЕ МЕНЮ v5 (телефон / планшет)
-- ============================================
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Очистка старых
for _, name in pairs({"ModernCheatMenu", "MainMenu", "SimpleMenu", "MobileMenu", "CheatMenu_v2", "CheatMenu_v3", "CheatMenu_v4", "CheatMenu_v5"}) do
	local old = playerGui:FindFirstChild(name)
	if old then old:Destroy() end
end
for _, v in pairs(workspace:GetDescendants()) do
	if v.Name == "CHEAT_HL" or v.Name == "CHEAT_BOX" then v:Destroy() end
end

local ACCENT = Color3.fromRGB(138, 43, 226)
local BG = Color3.fromRGB(18, 18, 22)
local SIDEBAR = Color3.fromRGB(24, 24, 30)
local ELEMENT = Color3.fromRGB(34, 34, 42)
local TEXT = Color3.fromRGB(240, 240, 245)
local SUBTEXT = Color3.fromRGB(150, 150, 160)

-- Определяем тип устройства
local isTouch = UserInputService.TouchEnabled

-- ============================================
-- GUI
-- ============================================
local gui = Instance.new("ScreenGui")
gui.Name = "CheatMenu_v5"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
gui.DisplayOrder = 2147483647
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
gui.Parent = playerGui

-- ============================================
-- 🔥 КНОПКА ОТКРЫТИЯ (крупная для пальца)
-- ============================================
local openBtn = Instance.new("TextButton")
openBtn.Name = "OpenBtn"
openBtn.Size = UDim2.new(0, 65, 0, 65)
openBtn.Position = UDim2.new(1, -80, 0, 100)
openBtn.BackgroundColor3 = ACCENT
openBtn.Text = "☰"
openBtn.TextColor3 = Color3.new(1, 1, 1)
openBtn.TextSize = 30
openBtn.Font = Enum.Font.GothamBold
openBtn.BorderSizePixel = 0
openBtn.Active = true
openBtn.Selectable = true
openBtn.AutoButtonColor = true
openBtn.ZIndex = 9999
openBtn.Parent = gui

Instance.new("UICorner", openBtn).CornerRadius = UDim.new(1, 0)

local strokeBtn = Instance.new("UIStroke", openBtn)
strokeBtn.Color = Color3.fromRGB(200, 150, 255)
strokeBtn.Thickness = 2.5

-- Перетаскивание кнопки (пальцем)
local btnDragging, btnMoved = false, false
local btnDragStart, btnStartPos
local tapTime = 0

local function btnInputBegan(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 
	or input.UserInputType == Enum.UserInputType.Touch then
		btnDragging = true
		btnMoved = false
		btnDragStart = input.Position
		btnStartPos = openBtn.Position
		tapTime = tick()
	end
end

local function btnInputChanged(input)
	if btnDragging and (input.UserInputType == Enum.UserInputType.MouseMovement 
	or input.UserInputType == Enum.UserInputType.Touch) then
		local delta = input.Position - btnDragStart
		if math.abs(delta.X) > 8 or math.abs(delta.Y) > 8 then
			btnMoved = true
		end
		openBtn.Position = UDim2.new(
			btnStartPos.X.Scale, btnStartPos.X.Offset + delta.X,
			btnStartPos.Y.Scale, btnStartPos.Y.Offset + delta.Y
		)
	end
end

openBtn.InputBegan:Connect(btnInputBegan)
UserInputService.InputChanged:Connect(btnInputChanged)

-- ============================================
-- ГЛАВНОЕ ОКНО (адаптивное под экран)
-- ============================================
local main
local toggleMenu

local function endBtnInput(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 
	or input.UserInputType == Enum.UserInputType.Touch then
		if btnDragging and not btnMoved and (tick() - tapTime) < 0.5 then
			if toggleMenu then toggleMenu() end
		end
		btnDragging = false
	end
end

UserInputService.InputEnded:Connect(endBtnInput)

-- ============================================
-- АДАПТИВНЫЕ РАЗМЕРЫ ПОД ЭКРАН
-- ============================================
local viewport = workspace.CurrentCamera.ViewportSize
local isSmall = viewport.X < 800          -- телефон
local isTablet = viewport.X >= 800        -- планшет

local menuSize, menuPos
if isSmall then
	-- Телефон: занимает почти весь экран
	menuSize = UDim2.new(1, -20, 1, -60)
	menuPos = UDim2.new(0, 10, 0, 50)
else
	-- Планшет / ПК: фиксированное окно
	menuSize = UDim2.new(0, 560, 0, 400)
	menuPos = UDim2.new(0.5, -280, 0.5, -200)
end

main = Instance.new("Frame")
main.Name = "Main"
main.Size = menuSize
main.Position = menuPos
main.BackgroundColor3 = BG
main.BorderSizePixel = 0
main.Visible = false
main.Active = true
main.ZIndex = 9998
main.Parent = gui
Instance.new("UICorner", main).CornerRadius = UDim.new(0, 12)

local mainStroke = Instance.new("UIStroke", main)
mainStroke.Color = Color3.fromRGB(70, 70, 90)
mainStroke.Thickness = 1.5

-- ============================================
-- ПЕРЕТАСКИВАНИЕ ОКНА (за заголовок)
-- ============================================
local dragging = false
local dragStart, startPos

-- ============================================
-- ЗАГОЛОВОК С КНОПКОЙ X
-- ============================================
local titleBar = Instance.new("Frame")
titleBar.Size = UDim2.new(1, 0, 0, 42)
titleBar.BackgroundColor3 = SIDEBAR
titleBar.BorderSizePixel = 0
titleBar.ZIndex = 9999
titleBar.Active = true
titleBar.Parent = main
Instance.new("UICorner", titleBar).CornerRadius = UDim.new(0, 12)

local titleFix = Instance.new("Frame")
titleFix.Size = UDim2.new(1, 0, 0, 15)
titleFix.Position = UDim2.new(0, 0, 1, -15)
titleFix.BackgroundColor3 = SIDEBAR
titleFix.BorderSizePixel = 0
titleFix.ZIndex = 9999
titleFix.Parent = titleBar

local titleText = Instance.new("TextLabel")
titleText.Size = UDim2.new(1, -60, 1, 0)
titleText.Position = UDim2.new(0, 15, 0, 0)
titleText.BackgroundTransparency = 1
titleText.Text = "⚡ CHEAT MENU"
titleText.TextColor3 = ACCENT
titleText.Font = Enum.Font.GothamBold
titleText.TextSize = 16
titleText.TextXAlignment = Enum.TextXAlignment.Left
titleText.ZIndex = 10000
titleText.Parent = titleBar

-- Кнопка X (крупная для пальца)
local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 34, 0, 34)
closeBtn.Position = UDim2.new(1, -42, 0.5, -17)
closeBtn.BackgroundColor3 = Color3.fromRGB(220, 50, 60)
closeBtn.Text = "✕"
closeBtn.TextColor3 = Color3.new(1,1,1)
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextSize = 18
closeBtn.BorderSizePixel = 0
closeBtn.ZIndex = 10000
closeBtn.Active = true
closeBtn.Parent = titleBar
Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(0, 8)

closeBtn.MouseButton1Click:Connect(function()
	main.Visible = false
end)
closeBtn.Activated:Connect(function()
	main.Visible = false
end)

-- Перетаскивание за заголовок (пальцем)
titleBar.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		dragging = true
		dragStart = input.Position
		startPos = main.Position
	end
end)

UserInputService.InputChanged:Connect(function(input)
	if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
		local delta = input.Position - dragStart
		main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
	end
end)

UserInputService.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		dragging = false
	end
end)

-- ============================================
-- САЙДБАР (сверху для телефона, слева для планшета)
-- ============================================
local sidebar, content

if isSmall then
	-- ТЕЛЕФОН: горизонтальные вкладки сверху
	sidebar = Instance.new("Frame")
	sidebar.Size = UDim2.new(1, 0, 0, 50)
	sidebar.Position = UDim2.new(0, 0, 0, 42)
	sidebar.BackgroundColor3 = SIDEBAR
	sidebar.BorderSizePixel = 0
	sidebar.ZIndex = 9998
	sidebar.Parent = main
	
	local holder = Instance.new("Frame")
	holder.Size = UDim2.new(1, -10, 1, -6)
	holder.Position = UDim2.new(0, 5, 0, 3)
	holder.BackgroundTransparency = 1
	holder.ZIndex = 9999
	holder.Parent = sidebar
	local hl = Instance.new("UIListLayout", holder)
	hl.FillDirection = Enum.FillDirection.Horizontal
	hl.Padding = UDim.new(0, 5)
	hl.SortOrder = Enum.SortOrder.LayoutOrder
	hl.VerticalAlignment = Enum.VerticalAlignment.Center
	
	content = Instance.new("Frame")
	content.Size = UDim2.new(1, -16, 1, -110)
	content.Position = UDim2.new(0, 8, 0, 100)
	content.BackgroundTransparency = 1
	content.ZIndex = 9998
	content.Parent = main
else
	-- ПЛАНШЕТ: вертикальный сайдбар слева
	sidebar = Instance.new("Frame")
	sidebar.Size = UDim2.new(0, 150, 1, -42)
	sidebar.Position = UDim2.new(0, 0, 0, 42)
	sidebar.BackgroundColor3 = SIDEBAR
	sidebar.BorderSizePixel = 0
	sidebar.ZIndex = 9998
	sidebar.Parent = main
	Instance.new("UICorner", sidebar).CornerRadius = UDim.new(0, 10)
	
	local holder = Instance.new("Frame")
	holder.Size = UDim2.new(1, -12, 1, -12)
	holder.Position = UDim2.new(0, 6, 0, 6)
	holder.BackgroundTransparency = 1
	holder.ZIndex = 9999
	holder.Parent = sidebar
	local hl = Instance.new("UIListLayout", holder)
	hl.Padding = UDim.new(0, 6)
	hl.SortOrder = Enum.SortOrder.LayoutOrder
	holder.Name = "TabHolder"
	
	content = Instance.new("Frame")
	content.Size = UDim2.new(1, -170, 1, -54)
	content.Position = UDim2.new(0, 160, 0, 46)
	content.BackgroundTransparency = 1
	content.ZIndex = 9998
	content.Parent = main
end

-- ============================================
-- СКРОЛЛ
-- ============================================
local scroll = Instance.new("ScrollingFrame")
scroll.Size = UDim2.new(1, 0, 1, 0)
scroll.BackgroundTransparency = 1
scroll.BorderSizePixel = 0
scroll.ScrollBarThickness = 6
scroll.ScrollBarImageColor3 = ACCENT
scroll.CanvasSize = UDim2.new(0, 0, 0, 0)
scroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
scroll.ScrollingDirection = Enum.ScrollingDirection.Y
scroll.ElasticBehavior = Enum.ElasticBehavior.WhenScrollable
scroll.ZIndex = 9999
scroll.Parent = content
local scrollLayout = Instance.new("UIListLayout", scroll)
scrollLayout.Padding = UDim.new(0, 8)
scrollLayout.SortOrder = Enum.SortOrder.LayoutOrder

-- ============================================
-- ЭЛЕМЕНТЫ UI (крупные для пальца)
-- ============================================
local ELEMENT_HEIGHT = isTouch and 48 or 38
local BUTTON_HEIGHT = isTouch and 48 or 38
local SLIDER_HEIGHT = isTouch and 62 or 50

local function createToggle(name, default, callback)
	local frame = Instance.new("Frame")
	frame.Size = UDim2.new(1, -8, 0, ELEMENT_HEIGHT)
	frame.BackgroundColor3 = ELEMENT
	frame.BorderSizePixel = 0
	frame.ZIndex = 9999
	frame.Parent = scroll
	Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 10)

	local label = Instance.new("TextLabel")
	label.Size = UDim2.new(1, -85, 1, 0)
	label.Position = UDim2.new(0, 15, 0, 0)
	label.BackgroundTransparency = 1
	label.Text = name
	label.TextColor3 = TEXT
	label.Font = Enum.Font.GothamMedium
	label.TextSize = 15
	label.TextXAlignment = Enum.TextXAlignment.Left
	label.ZIndex = 9999
	label.Parent = frame

	local switch = Instance.new("TextButton")
	switch.Size = UDim2.new(0, 56, 0, 28)
	switch.Position = UDim2.new(1, -70, 0.5, -14)
	switch.BackgroundColor3 = default and ACCENT or Color3.fromRGB(55, 55, 68)
	switch.Text = ""
	switch.BorderSizePixel = 0
	switch.AutoButtonColor = false
	switch.ZIndex = 9999
	switch.Active = true
	switch.Parent = frame
	Instance.new("UICorner", switch).CornerRadius = UDim.new(1, 0)

	local circle = Instance.new("Frame")
	circle.Size = UDim2.new(0, 22, 0, 22)
	circle.Position = default and UDim2.new(1, -25, 0.5, -11) or UDim2.new(0, 3, 0.5, -11)
	circle.BackgroundColor3 = Color3.new(1, 1, 1)
	circle.BorderSizePixel = 0
	circle.ZIndex = 9999
	circle.Parent = switch
	Instance.new("UICorner", circle).CornerRadius = UDim.new(1, 0)

	local state = default
	local function toggle()
		state = not state
		TweenService:Create(switch, TweenInfo.new(0.15), {BackgroundColor3 = state and ACCENT or Color3.fromRGB(55, 55, 68)}):Play()
		TweenService:Create(circle, TweenInfo.new(0.15), {Position = state and UDim2.new(1, -25, 0.5, -11) or UDim2.new(0, 3, 0.5, -11)}):Play()
		pcall(callback, state)
	end
	switch.MouseButton1Click:Connect(toggle)
	switch.Activated:Connect(toggle)
end

local function createButton(name, callback)
	local btn = Instance.new("TextButton")
	btn.Size = UDim2.new(1, -8, 0, BUTTON_HEIGHT)
	btn.BackgroundColor3 = ELEMENT
	btn.Text = name
	btn.TextColor3 = TEXT
	btn.Font = Enum.Font.GothamMedium
	btn.TextSize = 15
	btn.BorderSizePixel = 0
	btn.AutoButtonColor = true
	btn.ZIndex = 9999
	btn.Active = true
	btn.Parent = scroll
	Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 10)

	local function fire()
		pcall(callback)
	end
	btn.MouseButton1Click:Connect(fire)
	btn.Activated:Connect(fire)
end

local function createSlider(name, min, max, default, callback)
	local frame = Instance.new("Frame")
	frame.Size = UDim2.new(1, -8, 0, SLIDER_HEIGHT)
	frame.BackgroundColor3 = ELEMENT
	frame.BorderSizePixel = 0
	frame.ZIndex = 9999
	frame.Parent = scroll
	Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 10)

	local label = Instance.new("TextLabel")
	label.Size = UDim2.new(1, -20, 0, 24)
	label.Position = UDim2.new(0, 14, 0, 6)
	label.BackgroundTransparency = 1
	label.Text = name .. ": " .. default
	label.TextColor3 = TEXT
	label.Font = Enum.Font.GothamMedium
	label.TextSize = 14
	label.TextXAlignment = Enum.TextXAlignment.Left
	label.ZIndex = 9999
	label.Parent = frame

	-- Крупная зона касания для пальца
	local barBg = Instance.new("Frame")
	barBg.Size = UDim2.new(1, -28, 0, 12)
	barBg.Position = UDim2.new(0, 14, 1, -22)
	barBg.BackgroundColor3 = Color3.fromRGB(55, 55, 68)
	barBg.BorderSizePixel = 0
	barBg.ZIndex = 9999
	barBg.Parent = frame
	Instance.new("UICorner", barBg).CornerRadius = UDim.new(1, 0)

	local fill = Instance.new("Frame")
	fill.Size = UDim2.new((default - min) / (max - min), 0, 1, 0)
	fill.BackgroundColor3 = ACCENT
	fill.BorderSizePixel = 0
	fill.ZIndex = 9999
	fill.Parent = barBg
	Instance.new("UICorner", fill).CornerRadius = UDim.new(1, 0)

	-- Кружочек на слайдере
	local knob = Instance.new("Frame")
	knob.Size = UDim2.new(0, 20, 0, 20)
	knob.Position = UDim2.new((default - min) / (max - min), -10, 0.5, -10)
	knob.BackgroundColor3 = Color3.new(1, 1, 1)
	knob.BorderSizePixel = 0
	knob.ZIndex = 10000
	knob.Parent = barBg
	Instance.new("UICorner", knob).CornerRadius = UDim.new(1, 0)

	local draggingSlider = false
	local function update(input)
		local pos = math.clamp((input.Position.X - barBg.AbsolutePosition.X) / barBg.AbsoluteSize.X, 0, 1)
		local value = math.floor(min + (max - min) * pos)
		fill.Size = UDim2.new(pos, 0, 1, 0)
		knob.Position = UDim2.new(pos, -10, 0.5, -10)
		label.Text = name .. ": " .. value
		pcall(callback, value)
	end

	barBg.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			draggingSlider = true
			update(input)
		end
	end)
	UserInputService.InputChanged:Connect(function(input)
		if draggingSlider and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
			update(input)
		end
	end)
	UserInputService.InputEnded:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			draggingSlider = false
		end
	end)
end

local function createLabel(text)
	local label = Instance.new("TextLabel")
	label.Size = UDim2.new(1, -8, 0, 26)
	label.BackgroundTransparency = 1
	label.Text = text
	label.TextColor3 = SUBTEXT
	label.Font = Enum.Font.GothamBold
	label.TextSize = 12
	label.TextXAlignment = Enum.TextXAlignment.Left
	label.ZIndex = 9999
	label.Parent = scroll
end

-- ============================================
-- ВКЛАДКИ
-- ============================================
local function clearContent()
	for _, v in pairs(scroll:GetChildren()) do
		if not v:IsA("UIListLayout") then v:Destroy() end
	end
end

local function createTab(name, order, builder)
	local tab = Instance.new("TextButton")
	if isSmall then
		tab.Size = UDim2.new(0, 80, 1, -8)
	else
		tab.Size = UDim2.new(1, 0, 0, 36)
	end
	tab.BackgroundColor3 = Color3.fromRGB(32, 32, 40)
	tab.Text = name
	tab.TextColor3 = SUBTEXT
	tab.Font = Enum.Font.GothamMedium
	tab.TextSize = 14
	tab.BorderSizePixel = 0
	tab.LayoutOrder = order
	tab.AutoButtonColor = false
	tab.ZIndex = 9999
	tab.Active = true
	tab.Parent = isSmall and sidebar:FindFirstChildOfClass("Frame") or sidebar:FindFirstChild("TabHolder")
	Instance.new("UICorner", tab).CornerRadius = UDim.new(0, 8)

	local function switchTo()
		for _, t in pairs(tab.Parent:GetChildren()) do
			if t:IsA("TextButton") then
				t.BackgroundColor3 = Color3.fromRGB(32, 32, 40)
				t.TextColor3 = SUBTEXT
			end
		end
		tab.BackgroundColor3 = ACCENT
		tab.TextColor3 = Color3.new(1, 1, 1)
		clearContent()
		pcall(builder)
	end

	tab.MouseButton1Click:Connect(switchTo)
	tab.Activated:Connect(switchTo)
	return tab
end

-- ============================================
-- WH / ESP
-- ============================================
local espOn = false
local espList = {}

local function clearESP()
	for _, obj in pairs(espList) do
		if obj and obj.Parent then obj:Destroy() end
	end
	espList = {}
end

local function applyESP(plr)
	if plr == player or not plr.Character then return end
	local char = plr.Character
	local hrp = char:FindFirstChild("HumanoidRootPart")
	if not hrp then return end

	if not char:FindFirstChild("CHEAT_HL") then
		local hl = Instance.new("Highlight")
		hl.Name = "CHEAT_HL"
		hl.FillColor = Color3.fromRGB(255, 0, 0)
		hl.OutlineColor = Color3.new(1, 1, 1)
		hl.FillTransparency = 0.5
		hl.OutlineTransparency = 0
		hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
		hl.Adornee = char
		hl.Parent = char
		table.insert(espList, hl)
	end

	if not hrp:FindFirstChild("CHEAT_BOX") then
		local box = Instance.new("BoxHandleAdornment")
		box.Name = "CHEAT_BOX"
		box.Size = Vector3.new(4, 6, 2)
		box.Adornee = hrp
		box.AlwaysOnTop = true
		box.ZIndex = 5
		box.Transparency = 0.5
		box.Color3 = Color3.fromRGB(255, 0, 0)
		box.Parent = hrp
		table.insert(espList, box)
	end
end

local function updateESP()
	if not espOn then return end
	for _, plr in pairs(Players:GetPlayers()) do
		pcall(applyESP, plr)
	end
end

task.spawn(function()
	while task.wait(0.5) do
		if espOn then updateESP() end
	end
end)

Players.PlayerAdded:Connect(function(plr)
	if espOn then
		plr.CharacterAdded:Connect(function()
			task.wait(1)
			if espOn then pcall(applyESP, plr) end
		end)
	end
end)

-- ============================================
-- ФУНКЦИИ ЧИТА
-- ============================================
local infJump = false
UserInputService.JumpRequest:Connect(function()
	if infJump and player.Character then
		local hum = player.Character:FindFirstChildOfClass("Humanoid")
		if hum then hum:ChangeState(Enum.HumanoidStateType.Jumping) end
	end
end)

-- ============================================
-- ВКЛАДКИ
-- ============================================
createTab("Main", 1, function()
	createLabel("ПЕРСОНАЖ")
	createSlider("Speed", 16, 300, 16, function(v)
		if player.Character then
			local hum = player.Character:FindFirstChildOfClass("Humanoid")
			if hum then hum.WalkSpeed = v end
		end
	end)
	createSlider("Jump", 50, 500, 50, function(v)
		if player.Character then
			local hum = player.Character:FindFirstChildOfClass("Humanoid")
			if hum then
				hum.JumpPower = v
				hum.UseJumpPower = true
			end
		end
	end)
	createToggle("Infinite Jump", false, function(s) infJump = s end)
	createButton("Reset Character", function()
		if player.Character then player.Character:BreakJoints() end
	end)
end)

createTab("Visual", 2, function()
	createLabel("🎯 WH / ESP")
	createToggle("WH (WallHack)", false, function(s)
		espOn = s
		if s then updateESP() else clearESP() end
	end)
	createLabel("ВИЗУАЛ")
	createToggle("Fullbright", false, function(s)
		game.Lighting.Ambient = s and
