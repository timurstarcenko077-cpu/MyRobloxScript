-- ============================================
--  ОБНОВЛЁННОЕ МЕНЮ v3 (фикс кликов)
-- ============================================
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Очистка
for _, name in pairs({"ModernCheatMenu", "MainMenu", "SimpleMenu", "MobileMenu", "CheatMenu_v2", "CheatMenu_v3"}) do
	local old = playerGui:FindFirstChild(name)
	if old then old:Destroy() end
end
for _, v in pairs(workspace:GetDescendants()) do
	if v.Name == "CHEAT_ESP" or v.Name == "CHEAT_HL" or v.Name == "CHEAT_BOX" then v:Destroy() end
end

local ACCENT = Color3.fromRGB(138, 43, 226)
local BG = Color3.fromRGB(18, 18, 22)
local SIDEBAR = Color3.fromRGB(24, 24, 30)
local ELEMENT = Color3.fromRGB(34, 34, 42)
local TEXT = Color3.fromRGB(240, 240, 245)
local SUBTEXT = Color3.fromRGB(150, 150, 160)

-- ============================================
-- GUI (фикс: высокий DisplayOrder + IgnoreGuiInset)
-- ============================================
local gui = Instance.new("ScreenGui")
gui.Name = "CheatMenu_v3"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
gui.DisplayOrder = 999999              -- 🔥 ПОВЕРХ ВСЕГО
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
gui.Enabled = true
gui.Parent = playerGui

-- ============================================
-- КНОПКА ОТКРЫТИЯ (большая, вверху справа)
-- ============================================
local openBtn = Instance.new("TextButton")
openBtn.Name = "OpenBtn"
openBtn.Size = UDim2.new(0, 60, 0, 60)
openBtn.Position = UDim2.new(1, -80, 0, 80)   -- справа сверху (не под топбаром)
openBtn.BackgroundColor3 = ACCENT
openBtn.Text = "☰"
openBtn.TextColor3 = Color3.new(1, 1, 1)
openBtn.TextSize = 28
openBtn.Font = Enum.Font.GothamBold
openBtn.BorderSizePixel = 0
openBtn.Active = true
openBtn.Selectable = true
openBtn.ZIndex = 100                    -- поверх всего в GUI
openBtn.AutoButtonColor = true
openBtn.Parent = gui

local corner = Instance.new("UICorner", openBtn)
corner.CornerRadius = UDim.new(1, 0)

local strokeBtn = Instance.new("UIStroke", openBtn)
strokeBtn.Color = Color3.fromRGB(200, 150, 255)
strokeBtn.Thickness = 2

-- 🔥 ФИКС: обработка нажатий через InputBegan (работает на мобиле)
local function onClick(callback)
	local touched = false
	openBtn.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 
		or input.UserInputType == Enum.UserInputType.Touch then
			touched = true
		end
	end)
	openBtn.InputEnded:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 
		or input.UserInputType == Enum.UserInputType.Touch then
			if touched then
				touched = false
				callback()
			end
		end
	end)
	-- Fallback
	openBtn.MouseButton1Click:Connect(function()
		callback()
	end)
endbel.Parent = scroll
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
