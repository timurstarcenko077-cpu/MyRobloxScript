-- ============================================
-- МЕНЮ В СТИЛЕ PULSE HUB / HEADSHOT + WH
-- ============================================
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local old = playerGui:FindFirstChild("ModernCheatMenu")
if old then old:Destroy() end

-- Удаляем старые ESP
for _, v in pairs(workspace:GetChildren()) do
	if v.Name == "ESP_Box" or v.Name == "ESP_Name" then v:Destroy() end
end

local ACCENT = Color3.fromRGB(138, 43, 226)
local BG = Color3.fromRGB(18, 18, 22)
local SIDEBAR = Color3.fromRGB(24, 24, 30)
local ELEMENT = Color3.fromRGB(32, 32, 40)
local TEXT = Color3.fromRGB(240, 240, 245)
local SUBTEXT = Color3.fromRGB(150, 150, 160)

local gui = Instance.new("ScreenGui")
gui.Name = "ModernCheatMenu"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
gui.Parent = playerGui

-- Кнопка открытия
local openBtn = Instance.new("TextButton")
openBtn.Size = UDim2.new(0, 50, 0, 50)
openBtn.Position = UDim2.new(0, 20, 0.5, -25)
openBtn.BackgroundColor3 = ACCENT
openBtn.Text = "☰"
openBtn.TextColor3 = TEXT
openBtn.TextSize = 24
openBtn.Font = Enum.Font.GothamBold
openBtn.BorderSizePixel = 0
openBtn.Parent = gui
Instance.new("UICorner", openBtn).CornerRadius = UDim.new(0, 12)

-- Главное окно
local main = Instance.new("Frame")
main.Size = UDim2.new(0, 560, 0, 380)
main.Position = UDim2.new(0.5, -280, 0.5, -190)
main.BackgroundColor3 = BG
main.BorderSizePixel = 0
main.Visible = false
main.Active = true
main.Parent = gui
Instance.new("UICorner", main).CornerRadius = UDim.new(0, 14)

local mainStroke = Instance.new("UIStroke", main)
mainStroke.Color = Color3.fromRGB(60, 60, 75)
mainStroke.Thickness = 1.5

-- Перетаскивание
local dragging, dragStart, startPos
main.InputBegan:Connect(function(input)
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

-- Сайдбар
local sidebar = Instance.new("Frame")
sidebar.Size = UDim2.new(0, 150, 1, 0)
sidebar.BackgroundColor3 = SIDEBAR
sidebar.BorderSizePixel = 0
sidebar.Parent = main
Instance.new("UICorner", sidebar).CornerRadius = UDim.new(0, 14)

local logo = Instance.new("TextLabel")
logo.Size = UDim2.new(1, 0, 0, 50)
logo.BackgroundTransparency = 1
logo.Text = "⚡ PULSE"
logo.TextColor3 = ACCENT
logo.Font = Enum.Font.GothamBold
logo.TextSize = 20
logo.Parent = sidebar

local tabHolder = Instance.new("Frame")
tabHolder.Size = UDim2.new(1, -20, 1, -70)
tabHolder.Position = UDim2.new(0, 10, 0, 55)
tabHolder.BackgroundTransparency = 1
tabHolder.Parent = sidebar
Instance.new("UIListLayout", tabHolder).Padding = UDim.new(0, 6)

-- Контент
local content = Instance.new("Frame")
content.Size = UDim2.new(1, -160, 1, -20)
content.Position = UDim2.new(0, 155, 0, 10)
content.BackgroundTransparency = 1
content.Parent = main

local pageTitle = Instance.new("TextLabel")
pageTitle.Size = UDim2.new(1, 0, 0, 30)
pageTitle.BackgroundTransparency = 1
pageTitle.Text = "MAIN"
pageTitle.TextColor3 = TEXT
pageTitle.Font = Enum.Font.GothamBold
pageTitle.TextSize = 18
pageTitle.TextXAlignment = Enum.TextXAlignment.Left
pageTitle.Parent = content

local scroll = Instance.new("ScrollingFrame")
scroll.Size = UDim2.new(1, 0, 1, -40)
scroll.Position = UDim2.new(0, 0, 0, 35)
scroll.BackgroundTransparency = 1
scroll.BorderSizePixel = 0
scroll.ScrollBarThickness = 3
scroll.ScrollBarImageColor3 = ACCENT
scroll.CanvasSize = UDim2.new(0, 0, 0, 0)
scroll.Parent = content
local scrollList = Instance.new("UIListLayout", scroll)
scrollList.Padding = UDim.new(0, 8)

-- ============================================
-- ЭЛЕМЕНТЫ UI
-- ============================================
local function createToggle(name, default, callback)
	local frame = Instance.new("Frame")
	frame.Size = UDim2.new(1, -10, 0, 36)
	frame.BackgroundColor3 = ELEMENT
	frame.BorderSizePixel = 0
	frame.Parent = scroll
	Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 8)

	local label = Instance.new("TextLabel")
	label.Size = UDim2.new(1, -70, 1, 0)
	label.Position = UDim2.new(0, 12, 0, 0)
	label.BackgroundTransparency = 1
	label.Text = name
	label.TextColor3 = TEXT
	label.Font = Enum.Font.GothamMedium
	label.TextSize = 14
	label.TextXAlignment = Enum.TextXAlignment.Left
	label.Parent = frame

	local switch = Instance.new("TextButton")
	switch.Size = UDim2.new(0, 44, 0, 22)
	switch.Position = UDim2.new(1, -54, 0.5, -11)
	switch.BackgroundColor3 = default and ACCENT or Color3.fromRGB(50, 50, 60)
	switch.Text = ""
	switch.BorderSizePixel = 0
	switch.AutoButtonColor = false
	switch.Parent = frame
	Instance.new("UICorner", switch).CornerRadius = UDim.new(1, 0)

	local circle = Instance.new("Frame")
	circle.Size = UDim2.new(0, 18, 0, 18)
	circle.Position = default and UDim2.new(1, -20, 0.5, -9) or UDim2.new(0, 2, 0.5, -9)
	circle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	circle.BorderSizePixel = 0
	circle.Parent = switch
	Instance.new("UICorner", circle).CornerRadius = UDim.new(1, 0)

	local state = default
	switch.MouseButton1Click:Connect(function()
		state = not state
		TweenService:Create(switch, TweenInfo.new(0.2), {BackgroundColor3 = state and ACCENT or Color3.fromRGB(50, 50, 60)}):Play()
		TweenService:Create(circle, TweenInfo.new(0.2), {Position = state and UDim2.new(1, -20, 0.5, -9) or UDim2.new(0, 2, 0.5, -9)}):Play()
		callback(state)
	end)
end

local function createButton(name, callback)
	local btn = Instance.new("TextButton")
	btn.Size = UDim2.new(1, -10, 0, 36)
	btn.BackgroundColor3 = ELEMENT
	btn.Text = name
	btn.TextColor3 = TEXT
	btn.Font = Enum.Font.GothamMedium
	btn.TextSize = 14
	btn.BorderSizePixel = 0
	btn.AutoButtonColor = false
	btn.Parent = scroll
	Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 8)
	btn.MouseEnter:Connect(function()
		TweenService:Create(btn, TweenInfo.new(0.15), {BackgroundColor3 = ACCENT}):Play()
	end)
	btn.MouseLeave:Connect(function()
		TweenService:Create(btn, TweenInfo.new(0.15), {BackgroundColor3 = ELEMENT}):Play()
	end)
	btn.MouseButton1Click:Connect(callback)
end

local function createSlider(name, min, max, default, callback)
	local frame = Instance.new("Frame")
	frame.Size = UDim2.new(1, -10, 0, 50)
	frame.BackgroundColor3 = ELEMENT
	frame.BorderSizePixel = 0
	frame.Parent = scroll
	Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 8)

	local label = Instance.new("TextLabel")
	label.Size = UDim2.new(1, -20, 0, 20)
	label.Position = UDim2.new(0, 12, 0, 4)
	label.BackgroundTransparency = 1
	label.Text = name .. ": " .. default
	label.TextColor3 = TEXT
	label.Font = Enum.Font.GothamMedium
	label.TextSize = 13
	label.TextXAlignment = Enum.TextXAlignment.Left
	label.Parent = frame

	local barBg = Instance.new("Frame")
	barBg.Size = UDim2.new(1, -24, 0, 6)
	barBg.Position = UDim2.new(0, 12, 1, -14)
	barBg.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
	barBg.BorderSizePixel = 0
	barBg.Parent = frame
	Instance.new("UICorner", barBg).CornerRadius = UDim.new(1, 0)

	local fill = Instance.new("Frame")
	fill.Size = UDim2.new((default - min) / (max - min), 0, 1, 0)
	fill.BackgroundColor3 = ACCENT
	fill.BorderSizePixel = 0
	fill.Parent = barBg
	Instance.new("UICorner", fill).CornerRadius = UDim.new(1, 0)

	local draggingSlider = false
	local function update(input)
		local pos = math.clamp((input.Position.X - barBg.AbsolutePosition.X) / barBg.AbsoluteSize.X, 0, 1)
		local value = math.floor(min + (max - min) * pos)
		fill.Size = UDim2.new(pos, 0, 1, 0)
		label.Text = name .. ": " .. value
		callback(value)
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
	label.Size = UDim2.new(1, -10, 0, 25)
	label.BackgroundTransparency = 1
	label.Text = text
	label.TextColor3 = SUBTEXT
	label.Font = Enum.Font.GothamBold
	label.TextSize = 12
	label.TextXAlignment = Enum.TextXAlignment.Left
	label.Parent = scroll
end

-- ============================================
-- ВКЛАДКИ
-- ============================================
local tabs = {}
local function clearContent()
	for _, v in pairs(scroll:GetChildren()) do
		if not v:IsA("UIListLayout") then v:Destroy() end
	end
end

local function createTab(name, order, builder)
	local tab = Instance.new("TextButton")
	tab.Size = UDim2.new(1, 0, 0, 36)
	tab.BackgroundColor3 = Color3.fromRGB(30, 30, 38)
	tab.Text = "  " .. name
	tab.TextColor3 = SUBTEXT
	tab.Font = Enum.Font.GothamMedium
	tab.TextSize = 14
	tab.TextXAlignment = Enum.TextXAlignment.Left
	tab.BorderSizePixel = 0
	tab.LayoutOrder = order
	tab.AutoButtonColor = false
	tab.Parent = tabHolder
	Instance.new("UICorner", tab).CornerRadius = UDim.new(0, 8)

	tab.MouseButton1Click:Connect(function()
		for _, t in pairs(tabHolder:GetChildren()) do
			if t:IsA("TextButton") then
				TweenService:Create(t, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(30, 30, 38), TextColor3 = SUBTEXT}):Play()
			end
		end
		TweenService:Create(tab, TweenInfo.new(0.15), {BackgroundColor3 = ACCENT, TextColor3 = TEXT}):Play()
		pageTitle.Text = string.upper(name)
		clearContent()
		builder()
	end)
	return tab
end

-- ============================================
-- 🎯 WH (WallHack / ESP)
-- ============================================
local espEnabled = false
local espBoxes = false
local espNames = false
local espTracers = false

local function createESP(target)
	if target == player then return end
	
	local function applyESP(char)
		if not char then return end
		
		local highlight = Instance.new("Highlight")
		highlight.Name = "ESP_Highlight"
		highlight.FillColor = Color3.fromRGB(255, 0, 0)
		highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
		highlight.FillTransparency = 0.5
		highlight.OutlineTransparency = 0
		highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
		highlight.Parent = char
	end
	
	if target.Character then
		applyESP(target.Character)
	end
	
	target.CharacterAdded:Connect(function(char)
		task.wait(0.5)
		if espEnabled then
			applyESP(char)
		end
	end)
end

local function setESPState(state)
	espEnabled = state
	for _, p in pairs(Players:GetPlayers()) do
		if p ~= player and p.Character then
			local hl = p.Character:FindFirstChild("ESP_Highlight")
			if state and not hl then
				createESP(p)
			elseif not state and hl then
				hl:Destroy()
			end
		end
	end
end

-- Обработка новых игроков
Players.PlayerAdded:Connect(function(p)
	if espEnabled then
		createESP(p)
	end
end)

Players.PlayerRemoving:Connect(function(p)
	if p.Character then
		local hl = p.Character:FindFirstChild("ESP_Highlight")
		if hl then hl:Destroy() end
	end
end)

-- ============================================
-- ФУНКЦИИ
-- ============================================
local infJump = false
UserInputService.JumpRequest:Connect(function()
	if infJump and player.Character and player.Character:FindFirstChild("Humanoid") then
		player.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
	end
end)

-- Вкладка Main
createTab("Main", 1, function()
	createLabel("ПЕРСОНАЖ")
	createSlider("Speed", 16, 200, 16, function(v)
		if player.Character and player.Character:FindFirstChild("Humanoid") then
			player.Character.Humanoid.WalkSpeed = v
		end
	end)
	createSlider("Jump", 50, 300, 50, function(v)
		if player.Character and player.Character:FindFirstChild("Humanoid") then
			player.Character.Humanoid.JumpPower = v
		end
	end)
	createToggle("Infinite Jump", false, function(s) infJump = s end)
	createButton("Reset Character", function()
		player.Character:BreakJoints()
	end)
end)

-- Вкладка Visual (с WH)
createTab("Visual", 2, function()
	createLabel("🎯 WH / ESP")
	createToggle("WH (WallHack)", false, function(s)
		setESPState(s)
	end)
	createLabel("ВИЗУАЛ")
	createToggle("Fullbright", false, function(s)
		game.Lighting.Ambient = s and Color3.fromRGB(255,255,255) or Color3.fromRGB(70,70,70)
		game.Lighting.OutdoorAmbient = s and Color3.fromRGB(255,255,255) or Color3.fromRGB(70,70,70)
	end)
	createToggle("No Fog", false, function(s)
		game.Lighting.FogEnd = s and 100000 or 1000
	end)
end)

-- Вкладка Combat
createTab("Combat", 3, function()
	createLabel("БОЙ")
	createToggle("Kill Aura", false, function(s) print("Kill Aura:", s) end)
	createToggle("Aimbot", false, function(s) print("Aimbot:", s) end)
	createSlider("FOV", 30, 360, 90, function(v) print("FOV:", v) end)
end)

-- Вкладка Misc
createTab("Misc", 4, function()
	createLabel("РАЗНОЕ")
	createButton("Rejoin", function()
		game:GetService("TeleportService"):Teleport(game.PlaceId, player)
	end)
	createButton("Copy Job ID", function()
		if setclipboard then setclipboard(game.JobId) end
	end)
end)

-- Открыть первую вкладку
for _, t in pairs(tabHolder:GetChildren()) do
	if t:IsA("TextButton") and t.LayoutOrder == 1 then
		t.MouseButton1Click:Fire()
	end
end

-- Открытие/закрытие
local opened = false
openBtn.MouseButton1Click:Connect(function()
	opened = not opened
	main.Visible = opened
	if opened then
		main.Size = UDim2.new(0, 0, 0, 0)
		TweenService:Create(main, TweenInfo.new(0.3, Enum.EasingStyle.Back), {
			Size = UDim2.new(0, 560, 0, 380)
		}):Play()
	end
end)
