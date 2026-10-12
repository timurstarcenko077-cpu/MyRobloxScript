-- Меню для мобильного executor'а
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Удаляем старое меню, если есть
local old = playerGui:FindFirstChild("MobileMenu")
if old then old:Destroy() end

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "MobileMenu"
screenGui.ResetOnSpawn = false
screenGui.IgnoreGuiInset = true
screenGui.Parent = playerGui

-- Кнопка открытия/закрытия (кружок)
local toggleBtn = Instance.new("TextButton")
toggleBtn.Size = UDim2.new(0, 60, 0, 60)
toggleBtn.Position = UDim2.new(0, 20, 0.5, -30)
toggleBtn.BackgroundColor3 = Color3.fromRGB(80, 40, 160)
toggleBtn.Text = "☰"
toggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
toggleBtn.TextSize = 30
toggleBtn.Font = Enum.Font.GothamBold
toggleBtn.BorderSizePixel = 0
toggleBtn.Parent = screenGui

local toggleCorner = Instance.new("UICorner")
toggleCorner.CornerRadius = UDim.new(1, 0)
toggleCorner.Parent = toggleBtn

-- Главное меню
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 250, 0, 320)
mainFrame.Position = UDim2.new(0, 90, 0.5, -160)
mainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 40)
mainFrame.BorderSizePixel = 0
mainFrame.Visible = false
mainFrame.Parent = screenGui

local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 14)
mainCorner.Parent = mainFrame

local stroke = Instance.new("UIStroke")
stroke.Color = Color3.fromRGB(120, 80, 200)
stroke.Thickness = 2
stroke.Parent = mainFrame

-- Заголовок
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 45)
title.BackgroundColor3 = Color3.fromRGB(80, 40, 160)
title.BorderSizePixel = 0
title.Text = "МЕНЮ"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Font = Enum.Font.GothamBold
title.TextSize = 22
title.Parent = mainFrame

local titleCorner = Instance.new("UICorner")
titleCorner.CornerRadius = UDim.new(0, 14)
titleCorner.Parent = title

-- Контейнер кнопок
local buttonHolder = Instance.new("Frame")
buttonHolder.Size = UDim2.new(1, -20, 1, -60)
buttonHolder.Position = UDim2.new(0, 10, 0, 55)
buttonHolder.BackgroundTransparency = 1
buttonHolder.Parent = mainFrame

local uiList = Instance.new("UIListLayout")
uiList.Padding = UDim.new(0, 8)
uiList.SortOrder = Enum.SortOrder.LayoutOrder
uiList.Parent = buttonHolder

-- Функция создания кнопки
local function createButton(text, order, callback)
	local btn = Instance.new("TextButton")
	btn.Size = UDim2.new(1, 0, 0, 45)
	btn.BackgroundColor3 = Color3.fromRGB(45, 45, 70)
	btn.BorderSizePixel = 0
	btn.Text = text
	btn.TextColor3 = Color3.fromRGB(255, 255, 255)
	btn.Font = Enum.Font.GothamSemibold
	btn.TextSize = 16
	btn.LayoutOrder = order
	btn.AutoButtonColor = false
	btn.Parent = buttonHolder

	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0, 10)
	corner.Parent = btn

	btn.MouseButton1Click:Connect(function()
		TweenService:Create(btn, TweenInfo.new(0.15), {
			BackgroundColor3 = Color3.fromRGB(120, 80, 200)
		}):Play()
		task.wait(0.15)
		TweenService:Create(btn, TweenInfo.new(0.15), {
			BackgroundColor3 = Color3.fromRGB(45, 45, 70)
		}):Play()
		callback()
	end)

	return btn
end

-- Открытие/закрытие меню
toggleBtn.MouseButton1Click:Connect(function()
	mainFrame.Visible = not mainFrame.Visible
	if mainFrame.Visible then
		mainFrame.Size = UDim2.new(0, 0, 0, 0)
		TweenService:Create(mainFrame, TweenInfo.new(0.25, Enum.EasingStyle.Back), {
			Size = UDim2.new(0, 250, 0, 320)
		}):Play()
	end
end)

-- === ТВОИ КНОПКИ ===
createButton("⚡ Speed 50", 1, function()
	player.Character.Humanoid.WalkSpeed = 50
end)

createButton("🦘 Jump 100", 2, function()
	player.Character.Humanoid.JumpPower = 100
end)

createButton("🌀 Infinite Jump", 3, function()
	UserInputService.JumpRequest:Connect(function()
		if player.Character and player.Character:FindFirstChild("Humanoid") then
			player.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
		end
	end)
end)

createButton("🔄 Reset", 4, function()
	player.Character.Humanoid.WalkSpeed = 16
	player.Character.Humanoid.JumpPower = 50
end)

createButton("❌ Close", 5, function()
	mainFrame.Visible = false
end)
