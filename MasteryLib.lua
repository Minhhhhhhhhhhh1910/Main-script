local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local UIS = game:GetService("UserInputService")
local player = game.Players.LocalPlayer

-- Tạo GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = player.PlayerGui
ScreenGui.Name = "CustomUI"

-- Tạo Container cho Window
local window = Instance.new("Frame")
window.Size = UDim2.new(0, 400, 0, 300)
window.Position = UDim2.new(0.5, -200, 0.5, -150)
window.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
window.BorderSizePixel = 0
window.Parent = ScreenGui
window.AnchorPoint = Vector2.new(0.5, 0.5)

-- Tạo Tab Header
local tabHeader = Instance.new("Frame")
tabHeader.Size = UDim2.new(1, 0, 0, 50)
tabHeader.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
tabHeader.BorderSizePixel = 0
tabHeader.Parent = window

-- Tạo Nút Tab
local tabButton = Instance.new("TextButton")
tabButton.Size = UDim2.new(1, 0, 1, 0)
tabButton.BackgroundTransparency = 1
tabButton.Text = "Status and Server"
tabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
tabButton.TextSize = 20
tabButton.Font = Enum.Font.GothamBold
tabButton.Parent = tabHeader

-- Tạo Nút Đóng/Mở Tab
local toggleButton = Instance.new("TextButton")
toggleButton.Size = UDim2.new(0, 30, 0, 30)
toggleButton.Position = UDim2.new(1, -40, 0, 10)
toggleButton.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
toggleButton.Text = "X"
toggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
toggleButton.TextSize = 20
toggleButton.Font = Enum.Font.GothamBold
toggleButton.Parent = tabHeader

-- Tạo Tab Content (Nội dung của Tab)
local tabContent = Instance.new("Frame")
tabContent.Size = UDim2.new(1, 0, 1, -50)
tabContent.Position = UDim2.new(0, 0, 0, 50)
tabContent.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
tabContent.BorderSizePixel = 0
tabContent.Visible = false
tabContent.Parent = window

-- Tạo Nội Dung Tab
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 30)
title.BackgroundTransparency = 1
title.Text = "Server Status and Info"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextSize = 20
title.Font = Enum.Font.GothamBold
title.Parent = tabContent

local statusLabel = Instance.new("TextLabel")
statusLabel.Size = UDim2.new(1, 0, 0, 30)
statusLabel.Position = UDim2.new(0, 0, 0, 40)
statusLabel.BackgroundTransparency = 1
statusLabel.Text = "Server Status: Online"
statusLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
statusLabel.TextSize = 18
statusLabel.Font = Enum.Font.Gotham
statusLabel.Parent = tabContent

local playersLabel = Instance.new("TextLabel")
playersLabel.Size = UDim2.new(1, 0, 0, 30)
playersLabel.Position = UDim2.new(0, 0, 0, 80)
playersLabel.BackgroundTransparency = 1
playersLabel.Text = "Players Online: 250"
playersLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
playersLabel.TextSize = 18
playersLabel.Font = Enum.Font.Gotham
playersLabel.Parent = tabContent

-- Di chuyển UI
local dragInput, mousePos, framePos
local dragging = false

tabHeader.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        mousePos = input.Position
        framePos = window.Position
    end
end)

UIS.InputChanged:Connect(function(input)
    if dragging then
        local delta = input.Position - mousePos
        window.Position = UDim2.new(framePos.X.Scale, framePos.X.Offset + delta.X, framePos.Y.Scale, framePos.Y.Offset + delta.Y)
    end
end)

UIS.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)

-- Hàm Toggle Tab Content
toggleButton.MouseButton1Click:Connect(function()
    if tabContent.Visible then
        -- Ẩn Tab
        TweenService:Create(tabContent, TweenInfo.new(0.3), {Size = UDim2.new(1, 0, 0, 0)}):Play()
        wait(0.3)
        tabContent.Visible = false
    else
        -- Hiển Thị Tab
        tabContent.Visible = true
        TweenService:Create(tabContent, TweenInfo.new(0.3), {Size = UDim2.new(1, 0, 1, -50)}):Play()
    end
end)

-- Hiển thị UI
window.Visible = true

-- Thiết lập cho tab button
tabButton.MouseButton1Click:Connect(function()
    -- Toggle hiển thị nội dung
    toggleButton.MouseButton1Click()
end)
