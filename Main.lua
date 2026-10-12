-- goodSkillW | Dark Purple UI
-- Roblox Studio - LocalScript

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local old = playerGui:FindFirstChild("goodSkillW")
if old then old:Destroy() end

local C = {
    bg = Color3.fromRGB(17, 17, 23),
    panel = Color3.fromRGB(25, 25, 34),
    item = Color3.fromRGB(34, 34, 46),
    purple = Color3.fromRGB(158, 91, 255),
    white = Color3.fromRGB(240, 240, 248),
    muted = Color3.fromRGB(155, 155, 175),
    green = Color3.fromRGB(100, 220, 155)
}

local gui = Instance.new("ScreenGui")
gui.Name = "goodSkillW"
gui.ResetOnSpawn = false
gui.DisplayOrder = 20
gui.Parent = playerGui

local function create(class, props, parent)
    local obj = Instance.new(class)
    for key, value in pairs(props) do
        obj[key] = value
    end
    obj.Parent = parent
    return obj
end

local function corner(obj, radius)
    create("UICorner", {
        CornerRadius = UDim.new(0, radius)
    }, obj)
end

local function tween(obj, properties, duration)
    local t = TweenService:Create(
        obj,
        TweenInfo.new(duration or 0.2, Enum.EasingStyle.Quint,
            Enum.EasingDirection.Out),
        properties
    )
    t:Play()
    return t
end

local main = create("Frame", {
    Name = "Window",
    Size = UDim2.fromOffset(350, 270),
    Position = UDim2.new(0.5, -175, 0.5, -135),
    BackgroundColor3 = C.bg,
    BorderSizePixel = 0,
    ClipsDescendants = true
}, gui)
corner(main, 12)

create("UIStroke", {
    Color = C.purple,
    Transparency = 0.35,
    Thickness = 1.3
}, main)

-- Header
local header = create("Frame", {
    Size = UDim2.new(1, 0, 0, 43),
    BackgroundColor3 = C.panel,
    BorderSizePixel = 0
}, main)

local title = create("TextLabel", {
    Position = UDim2.fromOffset(12, 0),
    Size = UDim2.new(1, -100, 1, 0),
    BackgroundTransparency = 1,
    Text = "goodSkillW",
    TextColor3 = C.purple,
    Font = Enum.Font.GothamBold,
    TextSize = 17,
    TextXAlignment = Enum.TextXAlignment.Left
}, header)

create("TextLabel", {
    Position = UDim2.new(0, 100, 0, 1),
    Size = UDim2.new(1, -145, 1, 0),
    BackgroundTransparency = 1,
    Text = "● READY",
    TextColor3 = C.green,
    Font = Enum.Font.Gotham,
    TextSize = 9,
    TextXAlignment = Enum.TextXAlignment.Right
}, header)

local minimize = create("TextButton", {
    Position = UDim2.new(1, -35, 0, 7),
    Size = UDim2.fromOffset(25, 28),
    BackgroundColor3 = C.item,
    Text = "—",
    TextColor3 = C.white,
    Font = Enum.Font.GothamBold,
    TextSize = 16,
    AutoButtonColor = false
}, header)
corner(minimize, 6)

-- Sidebar
local sidebar = create("Frame", {
    Position = UDim2.fromOffset(8, 51),
    Size = UDim2.new(0, 94, 1, -59),
    BackgroundTransparency = 1
}, main)

create("UIListLayout", {
    Padding = UDim.new(0, 6),
    SortOrder = Enum.SortOrder.LayoutOrder
}, sidebar)

local pages = create("Frame", {
    Position = UDim2.fromOffset(110, 51),
    Size = UDim2.new(1, -118, 1, -59),
    BackgroundTransparency = 1
}, main)

local currentPage = nil
local tabButtons = {}
local states = {}

local function clearPage()
    for _, child in ipairs(pages:GetChildren()) do
        child:Destroy()
    end
end

local function pageHeading(text)
    create("TextLabel", {
        Size = UDim2.new(1, 0, 0, 27),
        BackgroundTransparency = 1,
        Text = text,
        TextColor3 = C.white,
        Font = Enum.Font.GothamBold,
        TextSize = 14,
        TextXAlignment = Enum.TextXAlignment.Left
    }, pages)
end

local function makeToggle(label, description, initial, callback)
    local row = create("Frame", {
        Size = UDim2.new(1, -2, 0, 51),
        BackgroundColor3 = C.panel,
        BorderSizePixel = 0
    }, pages)
    corner(row, 8)

    create("TextLabel", {
        Position = UDim2.fromOffset(9, 5),
        Size = UDim2.new(1, -55, 0, 20),
        BackgroundTransparency = 1,
        Text = label,
        TextColor3 = C.white,
        Font = Enum.Font.GothamMedium,
        TextSize = 11,
        TextXAlignment = Enum.TextXAlignment.Left
    }, row)

    create("TextLabel", {
        Position = UDim2.fromOffset(9, 25),
        Size = UDim2.new(1, -55, 0, 16),
        BackgroundTransparency = 1,
        Text = description,
        TextColor3 = C.muted,
        Font = Enum.Font.Gotham,
        TextSize = 9,
        TextXAlignment = Enum.TextXAlignment.Left
    }, row)

    local track = create("TextButton", {
        Position = UDim2.new(1, -43, 0.5, -10),
        Size = UDim2.fromOffset(34, 20),
        BackgroundColor3 = initial and C.purple or C.item,
        Text = "",
        AutoButtonColor = false
    }, row)
    corner(track, 10)

    local dot = create("Frame", {
        Size = UDim2.fromOffset(14, 14),
        Position = initial and UDim2.new(1, -17, 0.5, -7)
            or UDim2.fromOffset(3, 3),
        BackgroundColor3 = C.white,
        BorderSizePixel = 0
    }, track)
    corner(dot, 8)

    states[label] = initial

    track.Activated:Connect(function()
        states[label] = not states[label]
        local on = states[label]

        tween(track, {
            BackgroundColor3 = on and C.purple or C.item
        })

        tween(dot, {
            Position = on and UDim2.new(1, -17, 0.5, -7)
                or UDim2.fromOffset(3, 3)
        })

        if callback then
            callback(on)
        end
    end)

    return row
end

local function makeAction(label, callback)
    local b = create("TextButton", {
        Size = UDim2.new(1, -2, 0, 35),
        BackgroundColor3 = C.item,
        Text = label,
        TextColor3 = C.white,
        Font = Enum.Font.GothamMedium,
        TextSize = 11,
        AutoButtonColor = false
    }, pages)
    corner(b, 7)

    b.Activated:Connect(callback)
    b.MouseEnter:Connect(function()
        tween(b, {BackgroundColor3 = C.purple})
    end)
    b.MouseLeave:Connect(function()
        tween(b, {BackgroundColor3 = C.item})
    end)
end

local function showPage(name)
    currentPage = name
    clearPage()

    for tabName, b in pairs(tabButtons) do
        tween(b, {
            BackgroundColor3 = tabName == name and C.purple or C.panel
        })
    end

    if name == "Main" then
        pageHeading("Welcome back")
        makeAction("Show player name", function()
            print("Player: " .. player.Name)
        end)
        makeToggle("UI animations", "Button hover effects", true, function(on)
            print("UI animations:", on)
        end)
        makeToggle("Notifications", "Demo notification setting", true, function(on)
            print("Notifications:", on)
        end)

    elseif name == "Visuals" then
        pageHeading("Visual settings")
        makeToggle("Purple theme", "Change interface accent", true, function(on)
            C.purple = on and Color3.f
