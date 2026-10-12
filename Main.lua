local Players = game:GetService("Players")
local player = Players.LocalPlayer

if not player then
    warn("goodSkillW: LocalPlayer не найден")
    return
end

local playerGui = player:WaitForChild("PlayerGui")

local old = playerGui:FindFirstChild("goodSkillW")
if old then
    old:Destroy()
end

local gui = Instance.new("ScreenGui")
gui.Name = "goodSkillW"
gui.ResetOnSpawn = false
gui.DisplayOrder = 100
gui.Parent = playerGui

local frame = Instance.new("Frame")
frame.Size = UDim2.fromOffset(300, 180)
frame.Position = UDim2.new(0.5, -150, 0.5, -90)
frame.BackgroundColor3 = Color3.fromRGB(20, 20, 28)
frame.BorderSizePixel = 0
frame.Parent = gui

Instance.new("UICorner", frame).CornerRadius =
    UDim.new(0, 12)

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -50, 0, 45)
title.Position = UDim2.fromOffset(12, 0)
title.BackgroundTransparency = 1
title.Text = "goodSkillW"
title.TextColor3 = Color3.fromRGB(170, 100, 255)
title.TextSize = 20
title.Font = Enum.Font.GothamBold
title.Parent = frame

local button = Instance.new("TextButton")
button.Size = UDim2.new(1, -24, 0, 45)
button.Position = UDim2.fromOffset(12, 65)
button.BackgroundColor3 = Color3.fromRGB(120, 65, 210)
button.Text = "MENU WORKS"
button.TextColor3 = Color3.new(1, 1, 1)
button.TextSize = 15
button.Font = Enum.Font.GothamBold
button.Parent = frame

Instance.new("UICorner", button).CornerRadius =
    UDim.new(0, 8)

local close = Instance.new("TextButton")
close.Size = UDim2.fromOffset(30, 30)
close.Position = UDim2.new(1, -36, 0, 7)
close.Text = "X"
close.TextColor3 = Color3.new(1, 1, 1)
close.BackgroundColor3 = Color3.fromRGB(60, 45, 80)
close.Parent = frame

close.Activated:Connect(function()
    gui:Destroy()
end)

button.Activated:Connect(function()
    button.Text = "IT WORKS!"
end)

print("goodSkillW: interface created")
