-- LocalScript: РїРѕР»РѕР¶РёС‚Рµ РІ StarterPlayer > StarterPlayerScripts
-- RightShift РѕС‚РєСЂС‹РІР°РµС‚ Рё Р·Р°РєСЂС‹РІР°РµС‚ РјРµРЅСЋ, РЅР° С‚РµР»РµС„РѕРЅРµ РµСЃС‚СЊ РєРЅРѕРїРєР°-РёРєРѕРЅРєР° СЃР»РµРІР° СЃРІРµСЂС…Сѓ

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer

local COLORS = {
	bg = Color3.fromRGB(20, 20, 30),
	panel = Color3.fromRGB(30, 30, 45),
	accent = Color3.fromRGB(120, 90, 255),
	text = Color3.fromRGB(240, 240, 255),
	muted = Color3.fromRGB(150, 150, 175),
	off = Color3.fromRGB(55, 55, 80),
}

local FULL_SIZE = UDim2.fromOffset(420, 280)
local TOP_HEIGHT = 44

-- РџРѕРјРѕС‰РЅРёРєРё

local function round(obj, radius)
	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0, radius)
	corner.Parent = obj
end

local function tween(obj, props, duration)
	TweenService:Create(
		obj,
		TweenInfo.new(duration or 0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
		props
	):Play()
end

local function makeLabel(parent, text, size, color, font)
	local l = Instance.new("TextLabel")
	l.BackgroundTransparency = 1
	l.Text = text
	l.TextSize = size
	l.TextColor3 = color or COLORS.text
	l.Font = font or Enum.Font.Gotham
	l.TextXAlignment = Enum.TextXAlignment.Left
	l.Parent = parent
	return l
end

local function isPress(input)
	return input.UserInputType == Enum.UserInputType.MouseButton1
		or input.UserInputType == Enum.UserInputType.Touch
end

local function isMove(input)
	return input.UserInputType == Enum.UserInputType.MouseMovement
		or input.UserInputType == Enum.UserInputType.Touch
end

-- РћРєРЅРѕ

local gui = Instance.new("ScreenGui")
gui.Name = "MyMenu"
gui.ResetOnSpawn = false

local main = Instance.new("Frame")
main.Size = UDim2.fromOffset(420, 0)
main.Position = UDim2.new(0.5, -210, 0.5, -140)
main.BackgroundColor3 = COLORS.bg
main.ClipsDescendants = true
main.Parent = gui
round(main, 14)

local stroke = Instance.new("UIStroke")
stroke.Color = COLORS.accent
stroke.Thickness = 1.5
stroke.Transparency = 0.4
stroke.Parent = main

-- Р’РµСЂС…РЅСЏСЏ РїР°РЅРµР»СЊ

local top = Instance.new("Frame")
top.Size = UDim2.new(1, 0, 0, TOP_HEIGHT)
top.BackgroundColor3 = COLORS.panel
top.BorderSizePixel = 0
top.Parent = main

local title = makeLabel(top, "MY MENU", 16, COLORS.text, Enum.Font.GothamBold)
title.Position = UDim2.fromOffset(16, 0)
title.Size = UDim2.new(1, -90, 1, 0)

local function topButton(text, xOffset, color)
	local b = Instance.new("TextButton")
	b.Size = UDim2.fromOffset(28, 28)
	b.Position = UDim2.new(1, xOffset, 0.5, -14)
	b.BackgroundColor3 = color
	b.Text = text
	b.TextColor3 = Color3.new(1, 1, 1)
	b.Font = Enum.Font.GothamBold
	b.TextSize = 14
	b.Parent = top
	round(b, 8)
	return b
end

local closeBtn = topButton("X", -38, Color3.fromRGB(220, 70, 90))
local minBtn = topButton("-", -72, Color3.fromRGB(70, 70, 105))

-- РџРµСЂРµС‚Р°СЃРєРёРІР°РЅРёРµ Р·Р° РІРµСЂС…РЅСЋСЋ РїР°РЅРµР»СЊ

local dragging, dragStart, startPos

top.InputBegan:Connect(function(input)
	if isPress(input) then
		dragging = true
		dragStart = input.Position
		startPos = main.Position
		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				dragging = false
			end
		end)
	end
end)

UserInputService.InputChanged:Connect(function(input)
	if dragging and isMove(input) then
		local delta = input.Position - dragStart
		main.Position = UDim2.new(
			startPos.X.Scale, startPos.X.Offset + delta.X,
			startPos.Y.Scale, startPos.Y.Offset + delta.Y
		)
	end
end)

-- Р‘РѕРєРѕРІР°СЏ РїР°РЅРµР»СЊ Рё СЃС‚СЂР°РЅРёС†С‹

local side = Instance.new("Frame")
side.Position = UDim2.fromOffset(0, TOP_HEIGHT)
side.Size = UDim2.new(0, 110, 1, -TOP_HEIGHT)
side.BackgroundColor3 = COLORS.panel
side.BorderSizePixel = 0
side.Parent = main

local sideLayout = Instance.new("UIListLayout")
sideLayout.Padding = UDim.new(0, 6)
sideLayout.SortOrder = Enum.SortOrder.LayoutOrder
sideLayout.Parent = side

local sidePadding = Instance.new("UIPadding")
sidePadding.PaddingTop = UDim.new(0, 10)
sidePadding.PaddingLeft = UDim.new(0, 8)
sidePadding.PaddingRight = UDim.new(0, 8)
sidePadding.Parent = side

local content = Instance.new("Frame")
content.Position = UDim2.fromOffset(110, TOP_HEIGHT)
content.Size = UDim2.new(1, -110, 1, -TOP_HEIGHT)
content.BackgroundTransparency = 1
content.Parent = main

local pages = {}
local tabButtons = {}
local tabCount = 0

local function selectTab(name)
	for pageName, page in pairs(pages) do
		page.Visible = (pageName == name)
	end
	for btnName, btn in pairs(tabButtons) do
		tween(btn, { BackgroundColor3 = (btnName == name) and COLORS.accent or COLORS.bg })
	end
end

local function createTab(name)
	tabCount += 1

	local btn = Instance.new("TextButton")
	btn.Size = UDim2.new(1, 0, 0, 34)
	btn.BackgroundColor3 = COLORS.bg
	btn.Text = name
	btn.TextColor3 = COLORS.text
	btn.Font = Enum.Font.GothamMedium
	btn.TextSize = 14
	btn.AutoButtonColor = false
	btn.LayoutOrder = tabCount
	btn.Parent = side
	round(btn, 8)
	btn.MouseButton1Click:Connect(function()
		selectTab(name)
	end)
	tabButtons[name] = btn

	local page = Instance.new("Frame")
	page.Size = UDim2.fromScale(1, 1)
	page.BackgroundTransparency = 1
	page.Visible = false
	page.Parent = content

	local padding = Instance.new("UIPadding")
	padding.PaddingTop = UDim.new(0, 14)
	padding.PaddingLeft = UDim.new(0, 14)
	padding.PaddingRight = UDim.new(0, 14)
	padding.Parent = page

	local layout = Instance.new("UIListLayout")
	layout.Padding = UDim.new(0, 10)
	layout.SortOrder = Enum.SortOrder.LayoutOrder
	layout.Parent = page

	pages[name] = page
	return page
end

-- Р­Р»РµРјРµРЅС‚С‹ РёРЅС‚РµСЂС„РµР№СЃР°

local function addButton(page, text, callback)
	local b = Instance.new("TextButton")
	b.Size = UDim2.new(1, 0, 0, 38)
	b.BackgroundColor3 = COLORS.accent
	b.Text = text
	b.TextColor3 = Color3.new(1, 1, 1)
	b.Font = Enum.Font.GothamMedium
	b.TextSize = 14
	b.Parent = page
	round(b, 10)
	b.MouseButton1Click:Connect(function()
		callback(b)
	end)
	return b
end

local function addToggle(page, text, default, callback)
	local row = Instance.new("Frame")
	row.Size = UDim2.new(1, 0, 0, 38)
	row.BackgroundColor3 = COLORS.panel
	row.Parent = page
	round(row, 10)

	local l = makeLabel(row, text, 14)
	l.Position = UDim2.fromOffset(12, 0)
	l.Size = UDim2.new(1, -70, 1, 0)

	local track = Instance.new("TextButton")
	track.Text = ""
	track.AutoButtonColor = false
	track.Size = UDim2.fromOffset(42, 22)
	track.Position = UDim2.new(1, -54, 0.5, -11)
	track.Parent = row
	round(track, 11)

	local knob = Instance.new("Frame")
	knob.Size = UDim2.fromOffset(16, 16)
	knob.BackgroundColor3 = Color3.new(1, 1, 1)
	knob.Parent = track
	round(knob, 8)

	local state = default

	local function render(animated)
		local trackColor = state and COLORS.accent or COLORS.off
		local knobPos = state and UDim2.fromOffset(23, 3) or UDim2.fromOffset(3, 3)
		if animated then
			tween(t
