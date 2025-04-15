local MasteryHub = {}

function MasteryHub:CreateWindow(settings)
    local ScreenGui = Instance.new("ScreenGui", game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui"))
    local MainFrame = Instance.new("Frame", ScreenGui)
    MainFrame.Size = UDim2.new(0, 600, 0, 400)
    MainFrame.Position = UDim2.new(0.5, -300, 0.5, -200)
    MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    MainFrame.Name = "MASTERY_HUB_UI"
    Instance.new("UICorner", MainFrame)

    local TitleBar = Instance.new("TextLabel", MainFrame)
    TitleBar.Text = settings.Title or "MASTERY HUB"
    TitleBar.Size = UDim2.new(1, 0, 0, 40)
    TitleBar.BackgroundColor3 = Color3.fromRGB(170, 0, 0)
    TitleBar.TextColor3 = Color3.new(1, 1, 1)
    TitleBar.Font = Enum.Font.GothamBold
    TitleBar.TextSize = 20
    Instance.new("UICorner", TitleBar)

    if settings.Logo then
        local Logo = Instance.new("ImageLabel", TitleBar)
        Logo.Size = UDim2.new(0, 30, 0, 30)
        Logo.Position = UDim2.new(0, 5, 0.5, -15)
        Logo.Image = settings.Logo
        Logo.BackgroundTransparency = 1
    end

    local TabBar = Instance.new("Frame", MainFrame)
    TabBar.Size = UDim2.new(0, 150, 1, -40)
    TabBar.Position = UDim2.new(0, 0, 0, 40)
    TabBar.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    Instance.new("UICorner", TabBar)

    local ContentFrame = Instance.new("Frame", MainFrame)
    ContentFrame.Size = UDim2.new(1, -160, 1, -50)
    ContentFrame.Position = UDim2.new(0, 160, 0, 45)
    ContentFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    Instance.new("UICorner", ContentFrame)

    local tabs = {}

    function MainFrame:AddTab(name)
        local tabBtn = Instance.new("TextButton", TabBar)
        tabBtn.Size = UDim2.new(1, -10, 0, 35)
        tabBtn.Position = UDim2.new(0, 5, 0, #tabs * 40 + 5)
        tabBtn.Text = name
        tabBtn.BackgroundColor3 = Color3.fromRGB(50, 0, 0)
        tabBtn.TextColor3 = Color3.new(1, 1, 1)
        tabBtn.Font = Enum.Font.GothamBold
        tabBtn.TextSize = 14
        Instance.new("UICorner", tabBtn)

        local tabContent = Instance.new("Frame", ContentFrame)
        tabContent.Size = UDim2.new(1, -10, 1, -10)
        tabContent.Position = UDim2.new(0, 5, 0, 5)
        tabContent.BackgroundTransparency = 1
        tabContent.Visible = false

        local layout = Instance.new("UIListLayout", tabContent)
        layout.Padding = UDim.new(0, 6)
        layout.SortOrder = Enum.SortOrder.LayoutOrder

        local tab = {}

        function tab:AddLabel(text)
            local lbl = Instance.new("TextLabel", tabContent)
            lbl.Size = UDim2.new(1, -10, 0, 25)
            lbl.Text = text
            lbl.TextColor3 = Color3.new(1, 1, 1)
            lbl.Font = Enum.Font.Gotham
            lbl.TextSize = 14
            lbl.BackgroundTransparency = 1
        end

        function tab:AddButton(text, callback)
            local btn = Instance.new("TextButton", tabContent)
            btn.Size = UDim2.new(1, -10, 0, 30)
            btn.Text = text
            btn.BackgroundColor3 = Color3.fromRGB(170, 0, 0)
            btn.TextColor3 = Color3.new(1, 1, 1)
            btn.Font = Enum.Font.GothamBold
            btn.TextSize = 14
            Instance.new("UICorner", btn)
            btn.MouseButton1Click:Connect(callback)
        end

        function tab:AddToggle(text, callback)
            local toggle = Instance.new("TextButton", tabContent)
            toggle.Size = UDim2.new(1, -10, 0, 30)
            toggle.Text = text .. ": OFF"
            toggle.BackgroundColor3 = Color3.fromRGB(100, 0, 0)
            toggle.TextColor3 = Color3.new(1, 1, 1)
            toggle.Font = Enum.Font.Gotham
            toggle.TextSize = 14
            Instance.new("UICorner", toggle)
            local state = false
            toggle.MouseButton1Click:Connect(function()
                state = not state
                toggle.Text = text .. ": " .. (state and "ON" or "OFF")
                callback(state)
            end)
        end

        tabBtn.MouseButton1Click:Connect(function()
            for _, t in pairs(tabs) do
                t.content.Visible = false
            end
            tabContent.Visible = true
        end)

        tab.content = tabContent
        table.insert(tabs, tab)
        if #tabs == 1 then
            tabContent.Visible = true
        end

        return tab
    end

    return MainFrame
end

return MasteryHub