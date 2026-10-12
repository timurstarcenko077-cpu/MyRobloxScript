-- goodSkillW | NEON PURPLE MOBILE
-- Roblox Studio - LocalScript

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local old = playerGui:FindFirstChild("goodSkillW")
if old then old:Destroy() end

local C = {
    bg = Color3.fromRGB(13, 11, 22),
    panel = Color3.fromRGB(25, 20, 40),
    item = Color3.fromRGB(39, 30, 59),
    purple = Color3.fromRGB(174, 90, 255),
    glow = Color3.fromRGB(115, 45, 220),
    white = Color3.fromRGB(245, 240, 255),
    muted = Color3.fromRGB(165, 150, 190),
    green = Color3.fromRGB(100, 255, 180)
}

local gui = Instance.new("ScreenGui")
gui.Name = "goodSkillW"
gui.ResetOnSpawn = false
gui.DisplayOrder = 100
gui.Parent = playerGui

local function create(class, props, parent)
    local obj = Instance.new(class)
    for k, v in pairs(props) do
        obj[k] = v
    end
    obj.Parent = parent
    return obj
end

local function round(obj, radius)
    create("UICorner", {
        CornerRadius = UDim.new(0, radius)
    }, obj)
end

local function animate(obj, props, duration)
    local t = TweenService:Create(
        obj,
        TweenInfo.new(duration or 0.2, Enum.EasingStyle.Quint,
            Enum.EasingDirection.Out),
        props
    )
    t:Play()
    return t
end

-- Main window
local window = create("Frame", {
    Name = "Window",
    Size = UDim2.fromOffset(320, 330),
    Position = UDim2.new(0.5, -160, 0.5, -165),
    BackgroundColor3 = C.bg,
    BorderSizePixel = 0,
    ClipsDescendants = true
}, gui)
round(window, 14)

create("UIStroke", {
    Color = C.purple,
    Thickness = 1.5,
    Transparency = 0.1
}, window)

-- Header
local header = create("Frame", {
    Size = UDim2.new(1, 0, 0, 48),
    BackgroundColor3 = C.panel,
    BorderSizePixel = 0
}, window)

local title = create("TextLabel", {
    Position = UDim2.fromOffset(13, 0),
    Size = UDim2.new(1, -100, 1, 0),
    BackgroundTransparency = 1,
    Text = "✦ goodSkillW",
    TextColor3 = C.purple,
    Font = Enum.Font.GothamBold,
    TextSize = 18,
    TextXAlignment = Enum.TextXAlignment.Left
}, header)

local status = create("TextLabel", {
    Position = UDim2.new(1, -88, 0, 0),
    Size = UDim2.fromOffset(43, 48),
    BackgroundTransparency = 1,
    Text = "● ON",
    TextColor3 = C.green,
    Font = Enum.Font.GothamBold,
    TextSize = 10
}, header)

local minimize = create("TextButton", {
    Position = UDim2.new(1, -39, 0, 9),
    Size = UDim2.fromOffset(29, 29),
    BackgroundColor3 = C.item,
    Text = "—",
    TextColor3 = C.white,
    Font = Enum.Font.GothamBold,
    TextSize = 16,
    AutoButtonColor = false
}, header)
round(minimize, 8)

-- Tab bar
local tabBar = create("Frame", {
    Position = UDim2.fromOffset(9, 57),
    Size = UDim2.new(1, -18, 0, 38),
    BackgroundTransparency = 1
}, window)

create("UIListLayout", {
    FillDirection = Enum.FillDirection.Horizontal,
    Padding = UDim.new(0, 5),
    SortOrder = Enum.SortOrder.LayoutOrder
}, tabBar)

local content = create("ScrollingFrame", {
    Position = UDim2.fromOffset(9, 103),
    Size = UDim2.new(1, -18, 1, -112),
    BackgroundTransparency = 1,
    BorderSizePixel = 0,
    ScrollBarThickness = 3,
    ScrollBarImageColor3 = C.purple,
    CanvasSize = UDim2.new(0, 0, 0, 0),
    AutomaticCanvasSize = Enum.AutomaticSize.Y
}, window)

create("UIListLayout", {
    Padding = UDim.new(0, 8),
    SortOrder = Enum.SortOrder.LayoutOrder
}, content)

local tabs = {}
local states = {}

local function clearContent()
    for _, obj in ipairs(content:GetChildren()) do
        if not obj:IsA("UIListLayout") then
            obj:Destroy()
        end
    end
end

local function heading(text)
    return create("TextLabel", {
        Size = UDim2.new(1, -3, 0, 29),
        BackgroundTransparency = 1,
        Text = text,
        TextColor3 = C.white,
        Font = Enum.Font.GothamBold,
        TextSize = 15,
        TextXAlignment = Enum.TextXAlignment.Left
    }, content)
end

local function addToggle(name, desc, default, callback)
    states[name] = default

    local row = create("Frame", {
        Size = UDim2.new(1, -3, 0, 57),
        BackgroundColor3 = C.panel,
        BorderSizePixel = 0
    }, content)
    round(row, 9)

    create("UIStroke", {
        Color = C.glow,
        Transparency = 0.78,
        Thickness = 1
    }, row)

    create("TextLabel", {
        Position = UDim2.fromOffset(10, 7),
        Size = UDim2.new(1, -65, 0, 20),
        BackgroundTransparency = 1,
        Text = name,
        TextColor3 = C.white,
        Font = Enum.Font.GothamMedium,
        TextSize = 12,
        TextXAlignment = Enum.TextXAlignment.Left
    }, row)

    create("TextLabel", {
        Position = UDim2.fromOffset(10, 29),
        Size = UDim2.new(1, -65, 0, 17),
        BackgroundTransparency = 1,
        Text = desc,
        TextColor3 = C.muted,
        Font = Enum.Font.Gotham,
        TextSize = 9,
        TextXAlignment = Enum.TextXAlignment.Left
    }, row)

    local toggle = create("TextButton", {
        Position = UDim2.new(1, -52, 0.5, -12),
        Size = UDim2.fromOffset(42, 24),
        BackgroundColor3 = default and C.purple or C.item,
        Text = "",
        AutoButtonColor = false
    }, row)
    round(toggle, 12)

    local dot = create("Frame", {
        Position = default and UDim2.new(1, -21, 0.5, -8)
            or UDim2.fromOffset(4, 4),
        Size = UDim2.fromOffset(16, 16),
        BackgroundColor3 = C.white,
        BorderSizePixel = 0
    }, toggle)
    round(dot, 9)

    toggle.Activated:Connect(function()
        states[name] = not states[name]
        local enabled = states[name]

        animate(toggle, {
            BackgroundColor3 = enabled and C.purple or C.item
        })

        animate(dot, {
            Position = enabled and UDim2.new(1, -21, 0.5, -8)
                or UDim2.fromOffset(4, 4)
        })

        if callback then
            callback(enabled)
        end
    end)

    return row
end

local function addAction(text, callback)
    local b = create("TextButton", {
        Size = UDim2.new(1, -3, 0, 43),
        BackgroundColor3 = C.item,
        Text = text,
        TextColor3 = C.white,
        Font = Enum.Font.GothamMedium,
        TextSize = 12,
        AutoButtonColor = false
    }, content)
    round(b, 9)

    b.Activated:Connect(callback)

    b.MouseEnter:Connect(function()
        animate(b, {BackgroundColor3 = C.glow})
    end)
    b.MouseLeave:Connect(function()
        animate(b, {BackgroundColor3 = C.item})
    end)
end

local function showPage(name)
    clearContent()

    for tabName, button in pairs(tabs) do
        animate(button, {
            BackgroundColor3 = tabName == name and C.purple or C.panel
        })
    end

    if name == "Home" then
        heading("Welcome, " .. player.DisplayName)
        addAction("✦  goodSkillW is ready
