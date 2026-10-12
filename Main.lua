-- goodSkillW | Neon Purple Menu
-- UI script for Roblox

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local player = Players.LocalPlayer

local gui = Instance.new("ScreenGui")
gui.Name = "goodSkillW"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

local purple = Color3.fromRGB(155, 70, 255)
local bg = Color3.fromRGB(17, 15, 25)
local panel = Color3.fromRGB(29, 25, 40)
local white = Color3.fromRGB(245, 240, 255)

local window = Instance.new("Frame")
window.Size = UDim2.fromOffset(340, 350)
window.Position = UDim2.new(0.5, -170, 0.5, -175)
window.BackgroundColor3 = bg
window.BorderSizePixel = 0
window.Parent = gui

Instance.new("UICorner", window).CornerRadius = UDim.new(0, 12)

local outline = Instance.new("UIStroke", window)
outline.Color = purple
outline.Thickness = 2

local header = Instance.new("TextLabel")
header.Size = UDim2.new(1, -70, 0, 45)
header.Position = UDim2.fromOffset(12, 0)
header.BackgroundTransparency = 1
header.Text = "goodSkillW"
header.TextColor3 = white
header.TextSize = 20
header.Font = Enum.Font.GothamBold
header.TextXAlignment = Enum.TextXAlignment.Left
header.Parent = window

local minimize = Instance.new("TextButton")
minimize.Size = UDim2.fromOffset(35, 30)
minimize.Position = UDim2.new(1, -45, 0, 8)
minimize.Text = "—"
minimize.TextColor3 = white
minimize.BackgroundColor3 = panel
minimize.Parent = window
Instance.new("UICorner", minimize).CornerRadius = UDim.new(0, 7)

local sidebar = Instance.new("Frame")
sidebar.Position = UDim2.fromOffset(8, 50)
sidebar.Size = UDim2.new(0, 95, 1, -60)
sidebar.BackgroundColor3 = panel
sidebar.BorderSizePixel = 0
sidebar.Parent = window
Instance.new("UICorner", sidebar).CornerRadius = UDim.new(0, 8)

local content = Instance.new("Frame")
content.Position = UDim2.fromOffset(110, 50)
content.Size = UDim2.new(1, -118, 1, -60)
content.BackgroundTransparency = 1
content.Parent = window

local search = Instance.new("TextBox")
search.Size = UDim2.new(1, -4, 0, 32)
search.BackgroundColor3 = panel
search.PlaceholderText = "Search..."
search.Text = ""
search.TextColor3 = white
search.PlaceholderColor3 = Color3.fromRGB(160, 150, 175)
search.TextSize = 12
search.Font = Enum.Font.Gotham
search.ClearTextOnFocus = false
search.Parent = content
Instance.new("UICorner", search).CornerRadius = UDim.new(0, 7)

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
list.CanvasSize = UDim2.new()
list.Parent = content

local layout = Instance.new("UIListLayout")
layout.Padding = UDim.new(0, 7)
layout.Parent = list

local pages = {
    Main = {"Notifications", "Animations"},
    Visuals = {"Purple glow", "Show labels"},
    Settings = {"Compact mode", "Sound effects"}
}

local states = {}
local rows = {}
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
        Instance.new("UICorner", row).CornerRadius = UDim.new(0, 7)

        local label = Instance.new("TextLabel")
        label.Size = UDim2.new(1, -65, 1, 0)
        label.Position = UDim2.fromOffset(8, 0)
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
        Instance.new("UICorner", toggle).CornerRadius = UDim.new(0, 6)

        toggle.Activated:Connect(function()
            states[name] = not states[name]
            toggle.Text = states[name] and "ON" or "OFF"

            TweenService:Create(toggle, TweenInfo.new(0.2), {
                BackgroundColor3 = states[name] and purple
                    or Color3.fromRGB(65, 60, 75)
            }):Play()
        end)

        table.insert(rows, {
            frame = row,
            label = string.lower(name)
        })
    end

    for _, item in ipairs(rows) do
        item.frame.Visible = search.Text == ""
            or string.find(item.label, string.lower(search.Text), 1, true) ~= nil
    end
end

for i, page in ipairs({"Main", "Visuals", "Settings"}) do
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(1, -10, 0, 35)
    button.Position = UDim2.fromOffset(5, 8 + (i - 1) * 43)
    button.BackgroundColor3 = bg
    button.Text = page
    button.TextColor3 = white
    button.TextSize = 11
    button.Font = Enum.Font.GothamBold
    button.Parent = sidebar
    Instance.new("UICorner", button).CornerRadius = UDim.new(0, 7)

    button.Activated:Connect(function()
        render(page)
    end)
end

search:GetPropertyChangedSignal("Text"):Connect(function()
    local query = string.lower(search.Text)
    for _, item in ipairs(rows) do
        item.frame.Visible = query == ""
            or string.find(item.label, query, 1, true) ~= nil
    end
end)

local minimized = false

minimize.Activated:Connect(function()
    minimized = not minimized

    if minimized then
        local info = TweenInfo.new(0.2, Enum.EasingStyle.Quad)
        TweenService:Create(window, info, {
            Size = UDim2.fromOffset(340, 45)
        }):Play()
    else
        TweenService:Create(window, TweenInfo.new(0.2), {
            Size = UDim2.fromOffset(340, 350)
        }):Play()
    end
end)

render("Main")
print("goodSkillW loaded")
