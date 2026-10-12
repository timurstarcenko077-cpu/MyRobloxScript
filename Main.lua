-- ============================================
--  ОБНОВЛЁННОЕ МЕНЮ v2 (упрощённое и надёжное)
-- ============================================
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Очистка старых меню и ESP
for _, name in pairs({"ModernCheatMenu", "MainMenu", "SimpleMenu", "MobileMenu", "CheatMenu_v2"}) do
	local old = playerGui:FindFirstChild(name)
	if old then old:Destroy() end
end
for _, v in pairs(workspace:GetDescendants()) do
	if v.Name == "CHEAT_ESP" or v.Name == "ESP_Box" then v:Destroy() end
end

-- Цвета
local ACCENT = Color3.fromRGB(138, 43, 226)
local BG = Color3.fromRGB(18, 18, 22)
local SIDEBAR = Color3.fromRGB(24, 24, 30)
local ELEMENT = Color3.fromRGB(34, 34, 42)
local TEXT = Color3.fromRGB(240, 240, 245)
local SUBTEXT = Color3.fromRGB(150, 150, 160)

-- ============================================
-- GUI
-- ============================================
local gui = Instance.new("ScreenGui")
gui.Name = "CheatMenu_v2"
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
openBtn.TextColor3 = Color3.new(1, 1, 1)
openBtn.TextSize = 24
openBtn.Font = Enum.Font.GothamBold
openBtn.BorderSizePixel = 0
openBtn.Active = true
openBtn.Parent = gui
Instance.new("UICorner", openBtn).CornerRadius = UDim.new(1, 0)

-- Главное окно
local main = Instance.new("Frame")
main.Size = UDim2.new(0, 520, 0, 360)
main.Position = UDim2.new(0.5, -260, 0.5, -180)
main.BackgroundColor3 = BG
main.BorderSizePixel = 0
main.Visible = false
main.Active = true
main.Parent = gui
Instance.new("UICorner", main).CornerRadius = UDim.new(0, 12)

local mainStroke = Instance.new("UIStroke", main)
mainStroke.Color = Color3.fromRGB(70, 70, 90)
mainStroke.Thickness = 1.5

-- Перетаскивание
local dragging = false
local dragStart, startPos

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
sidebar.Size = UDim2.new(0, 140, 1, 0)
sidebar.BackgroundColor3 = SIDEBAR
sidebar.BorderSizePixel = 0
sidebar.Parent = main
Instance.new("UICorner", sidebar).CornerRadius = UDim.new(0, 12)

local logo = Instance.new("TextLabel")
logo.Size = UDim2.new(1, 0, 0, 45)
logo.BackgroundTransparency = 1
logo.Text = "⚡ PULSE"
logo.TextColor3 = ACCENT
logo.Font = Enum.Font.GothamBold
logo.TextSize = 18
logo.Parent = sidebar

local tabHolder = Instance.new("Frame")
tabHolder.Size = UDim2.new(1, -16, 1, -60)
tabHolder.Position = UDim2.new(0, 8, 0, 50)
tabHolder.BackgroundTransparency = 1
tabHolder.Parent = sidebar
local tabLayout = Instance.new("UIListLayout", tabHolder)
tabLayout.Padding = UDim.new(0, 5)

-- Контент
local content = Instance.new("Frame")
content.Size = UDim2.new(1, -150, 1, -20)
content.Position = UDim2.new(0, 145, 0, 10)
content.BackgroundTransparency = 1
content.Parent = main

local pageTitle = Instance.new("TextLabel")
pageTitle.Size = UDim2.new(1, 0, 0, 28)
pageTitle.BackgroundTransparency = 1
pageTitle.Text = "MAIN"
pageTitle.TextColor3 = TEXT
pageTitle.Font = Enum.Font.GothamBold
pageTitle.TextSize = 16
pageTitle.TextXAlignment = Enum.TextXAlignment.Left
pageTitle.Parent = content

local scroll = Instance.new("ScrollingFrame")
scroll.Size = UDim2.new(1, 0, 1, -34)
scroll.Position = UDim2.new(0, 0, 0, 32)
scroll.BackgroundTransparency = 1
scroll.BorderSizePixel = 0
scroll.ScrollBarThickness = 3
scroll.ScrollBarImageColor3 = ACCENT
scroll.CanvasSize = UDim2.new(0, 0, 0, 0)
scroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
scroll.Parent = content
local scrollLayout = Instance.new("UIListLayout", scroll)
scrollLayout.Padding = UDim.new(0, 6)
scrollLayout.SortOrder = Enum.SortOrder.LayoutOrder

-- ============================================
-- ЭЛЕМЕНТЫ
-- ============================================
local function createToggle(name, default, callback)
	local frame = Instance.new("Frame")
	frame.Size = UDim2.new(1, -8, 0, 34)
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
	label.TextSize = 13
	label.TextXAlignment = Enum.TextXAlignment.Left
	label.Parent = frame

	local switch = Instance.new("TextButton")
	switch.Size = UDim2.new(0, 42, 0, 20)
	switch.Position = UDim2.new(1, -52, 0.5, -10)
	switch.BackgroundColor3 = default and ACCENT or Color3.fromRGB(50, 50, 62)
	switch.Text = ""
	switch.BorderSizePixel = 0
	switch.AutoButtonColor = false
	switch.Active = true
	switch.Parent = frame
	Instance.new("UICorner", switch).CornerRadius = UDim.new(1, 0)

	local circle = Instance.new("Frame")
	circle.Size = UDim2.new(0, 16, 0, 16)
	circle.Position = default and UDim2.new(1, -18, 0.5, -8) or UDim2.new(0, 2, 0.5, -8)
	circle.BackgroundColor3 = Color3.new(1, 1, 1)
	circle.BorderSizePixel = 0
	circle.Parent = switch
	Instance.new("UICorner", circle).CornerRadius = UDim.new(1, 0)

	local state = default
	switch.MouseButton1Click:Connect(function()
		state = not state
		TweenService:Create(switch, TweenInfo.new(0.15), {BackgroundColor3 = state and ACCENT or Color3.fromRGB(50, 50, 62)}):Play()
		TweenService:Create(circle, TweenInfo.new(0.15), {Position = state and UDim2.new(1, -18, 0.5, -8) or UDim2.new(0, 2, 0.5, -8)}):Play()
		local ok, err = pcall(callback, state)
		if not ok then warn("[CheatMenu] Ошибка в toggle:", err) end
	end)
end

local function createButton(name, callback)
	local btn = Instance.new("TextButton")
	btn.Size = UDim2.new(1, -8, 0, 34)
	btn.BackgroundColor3 = ELEMENT
	btn.Text = name
	btn.TextColor3 = TEXT
	btn.Font = Enum.Font.GothamMedium
	btn.TextSize = 13
	btn.BorderSizePixel = 0
	btn.AutoButtonColor = false
	btn.Active = true
	btn.Parent = scroll
	Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 8)

	btn.MouseEnter:Connect(function()
		TweenService:Create(btn, TweenInfo.new(0.15), {BackgroundColor3 = ACCENT}):Play()
	end)
	btn.MouseLeave:Connect(function()
		TweenService:Create(btn, TweenInfo.new(0.15), {BackgroundColor3 = ELEMENT}):Play()
	end)
	btn.MouseButton1Click:Connect(function()
		local ok, err = pcall(callback)
		if not ok then warn("[CheatMenu] Ошибка в кнопке:", err) end
	end)
end

local function createSlider(name, min, max, default, callback)
	local frame = Instance.new("Frame")
	frame.Size = UDim2.new(1, -8, 0, 48)
	frame.BackgroundColor3 = ELEMENT
	frame.BorderSizePixel = 0
	frame.Parent = scroll
	Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 8)

	local label = Instance.new("TextLabel")
	label.Size = UDim2.new(1, -20, 0, 18)
	label.Position = UDim2.new(0, 10, 0, 4)
	label.BackgroundTransparency = 1
	label.Text = name .. ": " .. default
	label.TextColor3 = TEXT
	label.Font = Enum.Font.GothamMedium
	label.TextSize = 12
	label.TextXAlignment = Enum.TextXAlignment.Left
	label.Parent = frame

	local barBg = Instance.new("Frame")
	barBg.Size = UDim2.new(1, -20, 0, 6)
	barBg.Position = UDim2.new(0, 10, 1, -13)
	barBg.BackgroundColor3 = Color3.fromRGB(50, 50, 62)
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
		local ok, err = pcall(callback, value)
		if not ok then warn("[CheatMenu] Ошибка в слайдере:", err) end
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
	label.Size = UDim2.new(1, -8, 0, 22)
	label.BackgroundTransparency = 1
	label.Text = text
	label.TextColor3 = SUBTEXT
	label.Font = Enum.Font.GothamBold
	label.TextSize = 11
	label.TextXAlignment = Enum.TextXAlignment.Left
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
	tab.Size = UDim2.new(1, 0, 0, 34)
	tab.BackgroundColor3 = Color3.fromRGB(32, 32, 40)
	tab.Text = "  " .. name
	tab.TextColor3 = SUBTEXT
	tab.Font = Enum.Font.GothamMedium
	tab.TextSize = 13
	tab.TextXAlignment = Enum.TextXAlignment.Left
	tab.BorderSizePixel = 0
	tab.LayoutOrder = order
	tab.AutoButtonColor = false
	tab.Active = true
	tab.Parent = tabHolder
	Instance.new("UICorner", tab).CornerRadius = UDim.new(0, 7)

	tab.MouseButton1Click:Connect(function()
		for _, t in pairs(tabHolder:GetChildren()) do
			if t:IsA("TextButton") then
				TweenService:Create(t, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(32, 32, 40), TextColor3 = SUBTEXT}):Play()
			end
		end
		TweenService:Create(tab, TweenInfo.new(0.15), {BackgroundColor3 = ACCENT, TextColor3 = Color3.new(1, 1, 1)}):Play()
		pageTitle.Text = string.upper(name)
		clearContent()
		local ok, err = pcall(builder)
		if not ok then warn("[CheatMenu] Ошибка вкладки:", err) end
	end)
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
	if plr == player then return end
	if not plr.Character then return end
	local char = plr.Character
	local hrp = char:FindFirstChild("HumanoidRootPart")
	if not hrp then return end

	-- Highlight
	local hl = char:FindFirstChild("CHEAT_HL")
	if not hl then
		hl = Instance.new("Highlight")
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

	-- Box (для надёжности)
	local box = hrp:FindFirstChild("CHEAT_BOX")
	if not box then
		box = Instance.new("BoxHandleAdornment")
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

-- Автообновление ESP
task.spawn(function()
	while task.wait(0.5) do
		if espOn then updateESP() end
	end
end)

-- Новые игроки
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
		if s then
			updateESP()
		else
			clearESP()
		end
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

createTab("Combat", 3, function()
	createLabel("БОЙ")
	createToggle("Kill Aura", false, function(s) print("Kill Aura:", s) end)
	createToggle("Aimbot", false, function(s) print("Aimbot:", s) end)
	createSlider("FOV", 30, 360, 90, function(v) print("FOV:", v) end)
end)

createTab("Misc", 4, function()
	createLabel("РАЗНОЕ")
	createButton("Rejoin", function()
		game:GetService("TeleportService"):Teleport(game.PlaceId, player)
	end)
	createButton("Copy Job ID", function()
		if setclipboard then setclipboard(game.JobId) end
	end)
	createButton("Print Info", function()
		print("PlaceId:", game.PlaceId)
		print("JobId:", game.JobId)
		print("Игроков:", #Players:GetPlayers())
	end)
end)

-- Открыть первую вкладку
task.wait(0.1)
for _, t in pairs(tabHolder:GetChildren()) do
	if t:IsA("TextButton") and t.LayoutOrder == 1 then
		t.MouseButton1Click:Fire()
		break
	end
end

-- ============================================
-- ОТКРЫТИЕ / ЗАКРЫТИЕ
-- ============================================
local opened = false
openBtn.MouseButton1Click:Connect(function()
	opened = not opened
	main.Visible = opened
end)

-- Уведомление о загрузке
print("✅ CheatMenu v2 загружено!")
pcall(function()
	game:GetService("StarterGui"):SetCore("SendNotification", {
		Title = "CheatMenu v2",
		Text = "Меню загружено! Нажми ☰ слева",
		Duration = 5
	})
end)
