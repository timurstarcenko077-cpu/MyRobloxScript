-- ============================================
-- 🔥 КНОПКА (перетаскиваемая + 3 способа открытия)
-- ============================================
local openBtn = Instance.new("TextButton")
openBtn.Name = "OpenBtn"
openBtn.Size = UDim2.new(0, 60, 0, 60)
openBtn.Position = UDim2.new(0, 20, 0.5, -30)     -- слева по центру
openBtn.BackgroundColor3 = ACCENT
openBtn.Text = "☰"
openBtn.TextColor3 = Color3.new(1, 1, 1)
openBtn.TextSize = 28
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

-- ============================================
-- 🔥 ПЕРЕТАСКИВАНИЕ КНОПКИ (чтобы убрать с проблемного места)
-- ============================================
local btnDragging = false
local btnDragStart, btnStartPos
local btnMoved = false

openBtn.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 
	or input.UserInputType == Enum.UserInputType.Touch then
		btnDragging = true
		btnMoved = false
		btnDragStart = input.Position
		btnStartPos = openBtn.Position
	end
end)

UserInputService.InputChanged:Connect(function(input)
	if btnDragging and (input.UserInputType == Enum.UserInputType.MouseMovement 
	or input.UserInputType == Enum.UserInputType.Touch) then
		local delta = input.Position - btnDragStart
		if math.abs(delta.X) > 5 or math.abs(delta.Y) > 5 then
			btnMoved = true
		end
		openBtn.Position = UDim2.new(
			btnStartPos.X.Scale, btnStartPos.X.Offset + delta.X,
			btnStartPos.Y.Scale, btnStartPos.Y.Offset + delta.Y
		)
	end
end)

UserInputService.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 
	or input.UserInputType == Enum.UserInputType.Touch then
		btnDragging = false
	end
end)

-- ============================================
-- 🔥 ОТКРЫТИЕ МЕНЮ (3 способа + защита от перетаскивания)
-- ============================================
local main

local function toggleMenu()
	if main then
		main.Visible = not main.Visible
	end
end

-- Способ 1: обычный клик
openBtn.MouseButton1Click:Connect(function()
	if not btnMoved then
		toggleMenu()
	end
end)

-- Способ 2: Activated (для мобилы)
openBtn.Activated:Connect(function()
	if not btnMoved then
		toggleMenu()
	end
end)

-- Способ 3: InputEnded (если не двигали — считаем кликом)
openBtn.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 
	or input.UserInputType == Enum.UserInputType.Touch then
		if not btnMoved then
			toggleMenu()
		end
	end
end)

-- ============================================
-- 🔥 FALLBACK: двойной тап по экрану (если кнопка не работает)
-- ============================================
local lastTap = 0
UserInputService.InputBegan:Connect(function(input, gp)
	if gp then return end
	if input.UserInputType == Enum.UserInputType.Touch 
	or input.UserInputType == Enum.UserInputType.MouseButton1 then
		local now = tick()
		if now - lastTap < 0.4 then
			toggleMenu()
		end
		lastTap = now
	end
end)

-- ============================================
-- 🔥 FALLBACK для ПК: клавиша RightControl
-- ============================================
UserInputService.InputBegan:Connect(function(input, gp)
	if gp then return end
	if input.KeyCode == Enum.KeyCode.RightControl 
	or input.KeyCode == Enum.KeyCode.RightShift then
		toggleMenu()
	end
end)9
	label.Parent = frame

	local barBg = Instance.new("Frame")
	barBg.Size = UDim2.new(1, -20, 0, 8)
	barBg.Position = UDim2.new(0, 10, 1, -14)
	barBg.BackgroundColor3 = Color3.fromRGB(50, 50, 62)
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

	local draggingSlider = false
	local function update(input)
		local pos = math.clamp((input.Position.X - barBg.AbsolutePosition.X) / barBg.AbsoluteSize.X, 0, 1)
		local value = math.floor(min + (max - min) * pos)
		fill.Size = UDim2.new(pos, 0, 1, 0)
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
	label.Size = UDim2.new(1, -8, 0, 22)
	label.BackgroundTransparency = 1
	label.Text = text
	label.TextColor3 = SUBTEXT
	label.Font = Enum.Font.GothamBold
	label.TextSize = 11
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
	tab.Size = UDim2.new(1, 0, 0, 32)
	tab.BackgroundColor3 = Color3.fromRGB(32, 32, 40)
	tab.Text = "  " .. name
	tab.TextColor3 = SUBTEXT
	tab.Font = Enum.Font.GothamMedium
	tab.TextSize = 13
	tab.TextXAlignment = Enum.TextXAlignment.Left
	tab.BorderSizePixel = 0
	tab.LayoutOrder = order
	tab.AutoButtonColor = false
	tab.ZIndex = 9999
	tab.Parent = tabHolder
	Instance.new("UICorner", tab).CornerRadius = UDim.new(0, 7)

	local function switchTo()
		for _, t in pairs(tabHolder:GetChildren()) do
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
	if plr == player then return end
	if not plr.Character then return end
	local char = plr.Character
	local hrp = char:FindFirstChild("HumanoidRootPart")
	if not hrp then return end

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
-- ФУНКЦИИ
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
end)

-- Открыть первую вкладку
task.wait(0.1)
for _, t in pairs(tabHolder:GetChildren()) do
	if t:IsA("TextButton") and t.LayoutOrder == 1 then
		t.MouseButton1Click:Fire()
		break
	end
end

print("✅ CheatMenu v4 загружено! Кнопка МЕНЮ внизу по центру.")
