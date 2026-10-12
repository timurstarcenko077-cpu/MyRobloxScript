local Players = game:GetService("Players")
local player = Players.LocalPlayer

local gui = Instance.new("ScreenGui")
gui.Name = "MyMenu"

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 260, 0, 150)
frame.Position = UDim2.new(0.5, -130, 0.5, -75)
frame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
frame.Parent = gui

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 45)
title.Text = "MY MENU"
title.TextColor3 = Color3.new(1, 1, 1)
title.BackgroundTransparency = 1
title.Parent = frame

local button = Instance.new("TextButton")
button.Size = UDim2.new(0, 200, 0, 45)
button.Position = UDim2.new(0.5, -100, 0, 70)
button.Text = "Привет скиипт в разработке!"
button.Parent = frame

button.MouseButton1Click:Connect(function()
    button.Text = "Привет скрипт в разработке, " .. player.Name
end)

gui.Parent = player:WaitForChild("PlayerGui")
