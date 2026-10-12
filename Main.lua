-- goodSkillW | Neon Purple
-- UI menu

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local old = playerGui:FindFirstChild("goodSkillW")
if old then
    old:Destroy()
end

local purple = Color3.fromRGB(155, 70, 255)
local bg = Color3.fromRGB(17, 15, 25)
local panel = Color3.fromRGB(29, 25, 40)
local white = Color3.fromRGB(245, 240, 255)
local muted = Color3.fromRGB(155, 148, 174)

local gui = Instance.new("ScreenGui")
gui.Name = "goodSkillW"
gui.ResetOnSpawn = false
gui.Parent = playerGui

local function round(obj, radius)
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, radius)
    c.Parent = obj
end

local function animate(obj, duration, properties)
    TweenService:Create(
        obj,
        TweenInfo.new(duration, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
        properties
    ):Play()
end

-- Main window
local window = Instance.new("Frame")
window.Name = "Window"
window.Size = UDim2.fromOffset(340, 350)
window.Position = UDim2.new(0.5, -170, 0.5, -175)
window.BackgroundColor3 = bg
window.BorderSizePixel = 0
window.ClipsDescendants = true
window.Parent = gui
round(window, 12)

local outline = Instance.new("UIStroke")
outline.Color = purple
outline.Thickness = 2
outline.Parent = window

-- Header
local header = Instance.new("Frame")
header.Size = UDim2.new(1, 0, 0, 45)
header.BackgroundColor3 = panel
header.BorderSizePixel = 0
header.Parent = window

local title = Instance.new("TextLabel")
title.Position = UDim2.fromOffset(12, 0)
title.Size = UDim2.new(1, -100, 1, 0)
title.BackgroundTransparency = 1
title.Text = "goodSkillW"
title.TextColor3 = white
title.TextSize = 18
title.Font = Enum.Font.GothamBold
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = header

local minimize = Instance.new("TextButton")
minimize.Size = UDim2.fromOffset(30, 29)
minimize.Position = UDim2.new(1, -75, 0, 8)
minimize.BackgroundColor3 = bg
minimize.Text = "—"
minimize.TextColor3 = white
minimize.TextSize = 18
minimize.Font = Enum.Font.GothamBold
minimize.Parent = header
round(minimize, 7)

local close = Instance.new("TextButton")
close.Size = UDim2.fromOffset(30, 29)
close.Position = UDim2.new(1, -38, 0, 8)
close.BackgroundColor3 = Color3.fromRGB(95, 35, 115)
close.Text = "×"
close.TextColor3 = white
close.TextSize = 20
close.Font = Enum.Font.GothamBold
close.Parent = header
round(close, 7)

-- Sidebar
local sidebar = Instance.new("Frame")
sidebar.Position = UDim2.fromOffset(8, 53)
sidebar.Size = UDim2.new(0, 95, 1, -61)
sidebar.BackgroundColor3 = panel
sidebar.BorderSizePixel = 0
sidebar.Parent = window
round(sidebar, 8)

-- Content
local content = Instance.new("Frame")
content.Position = UDim2.fromOffset(110, 53)
content.Size = UDim2.new(1, -118, 1, -61)
content.BackgroundTransparency = 1
content.Parent = window

local search = Instance.new("TextBox")
search.Size = UDim2.new(1, -4, 0, 32)
search.BackgroundColor3 = panel
search.PlaceholderText = "Search functions..."
search.Text = ""
search.TextColor3 = white
search.PlaceholderColor3 = muted
search.TextSize = 11
search.Font = Enum.Font.Gotham
search.ClearTextOnFocus = false
search.Parent = content
round(search, 7)

local pageTitle = Instance.new("TextLabel")
pageTitle.Position = UDim2.fromOffset(2, 38)
pageTitle.Size = UDim2.new(1, -4, 0, 28)
pageTitle.BackgroundTransparency = 1
pageTitle.Text = "Main"
pageTitle.TextColor3 = purple
pageTitle.TextSize = 16
pageTitle.Font = Enum.Font.GothamBold
pageTitle.TextXAlignment = Enum.TextXAlignment.Left
pageTitle.Parent = content

local list = Instance.new("ScrollingFrame")
list.Position = UDim2.fromOffset(0, 70)
list.Size = UDim2.new(1, -4, 1, -72)
list.BackgroundTransparency = 1
list.BorderSizePixel = 0
list.ScrollBarThickness = 3
list.ScrollBarImageColor3 = purple
list.AutomaticCanvasSize = Enum.AutomaticSize.Y
list.CanvasSize = UDim2.new(0, 0, 0, 0)
list.Parent = content

local listLayout = Instance.new("UIListLayout")
listLayout.Padding = UDim.new(0, 7)
listLayout.SortOrder = Enum.SortOrder.LayoutOrder
listLayout.Parent = list

-- Pages and toggle states
local pages = {
    Main = {
        "Notifications",
        "Animations"
    },

    Visuals = {
        "Purple glow",
        "Show labels"
    },

    Settings = {
        "Compact mode",
        "Sound effects"
    }
}

local states = {}
local rows = {}
local tabButtons = {}
local currentPage = "Main"

local function render(page)
    currentPage = page
    pageTitle.Text = page

    for _, child in ipairs(list:GetChildren()) do
        if child:IsA("Frame") then
            child:Destroy()
        end
    end

    rows = {}

    for _, name in ipairs(pages[page]) do
        if states[name] == nil then
            states[name] = false
        end

        local row = Instance.new("Frame")
        row.Size = UDim2.new(1, -3, 0, 42)
        row.BackgroundColor3 = panel
        row.BorderSizePixel = 0
        row.Parent = list
        round(row, 7)

        local label = Instance.new("TextLabel")
        label.Position = UDim2.fromOffset(8, 0)
        label.Size = UDim2.new(1, -65, 1, 0)
        label.BackgroundTransparency = 1
        label.Text = name
        label.TextColor3 = white
        label.TextSize = 11
        label.Font = Enum.Font.Gotham
        label.TextXAlignment = Enum.TextXAlignment.Left
        label.Parent = row

        local toggle = Instance.new("TextButton")
        toggle.Size = UDim2.fromOffset(48, 25)
        toggle.Position = UDim2.new(1, -55, 0.5, -12)
        toggle.BackgroundColor3 = states[name] and purple
            or Color3.fromRGB(65, 60, 75)
        toggle.Text = states[name] and "ON" or "OFF"
        toggle.TextColor3 = white
        toggle.TextSize = 10
        toggle.Font = Enum.Font.GothamBold
        toggle.Parent = row
        round(toggle, 6)

        toggle.Activated:Connect(function()
            states[name] = not states[name]

            toggle.Text = states[name] and "ON" or "OFF"

            animate(toggle, 0.18, {
                BackgroundColor3 = states[name] and purple
                    or Color3.fromRGB(65, 60, 75)
            })
        end)

        table.insert(rows, {
            frame = row,
            label = string.lower(name)
        })
    end

    for name, button in pairs(tabButtons) do
        button.BackgroundColor3 = name == page
            and Color3.fromRGB(75, 42, 115)
            or bg

        button.TextColor3 = name == page and white or muted
    end

    local query = string.lower(search.Text)

    for _, item in ipairs(rows) do
        item.frame.Visible = query == ""
            or string.find(item.label, query, 1, true) ~= nil
    end
end

-- Tabs
for i, page in ipairs({"Main", "Visuals", "Settings"}) do
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(1, -10, 0, 35)
    button.Position = UDim2.fromOffset(5, 8 + (i - 1) * 43)
    button.BackgroundC
