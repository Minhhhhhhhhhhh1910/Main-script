
-- MasteryHub UI LIB (Tab gọn trong UI + hoạt động đầy đủ)

local MasteryHub = {}

function MasteryHub:CreateWindow(config)
    local title = config.Title or "MASTERY HUB"
    local logoAsset = config.Logo or "rbxassetid://75617874946759"
    local gui = Instance.new("ScreenGui", game:GetService("CoreGui"))
    gui.Name = "MasteryHubUI"

    local main = Instance.new("Frame", gui)
    main.Size = UDim2.new(0, 530, 0, 400)
    main.Position = UDim2.new(0.5, -265, 0.5, -200)
    main.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    main.Active = true
    main.Draggable = true
    Instance.new("UICorner", main).CornerRadius = UDim.new(0, 10)

    local header = Instance.new("TextLabel", main)
    header.Size = UDim2.new(1, 0, 0, 40)
    header.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    header.Text = title
    header.Font = Enum.Font.GothamBold
    header.TextSize = 20
    header.TextColor3 = Color3.new(1, 1, 1)
    Instance.new("UICorner", header).CornerRadius = UDim.new(0, 10)

    local tabBar = Instance.new("Frame", main)
    tabBar.Size = UDim2.new(1, 0, 0, 30)
    tabBar.Position = UDim2.new(0, 0, 0, 40)
    tabBar.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    local tabLayout = Instance.new("UIListLayout", tabBar)
    tabLayout.FillDirection = Enum.FillDirection.Horizontal
    tabLayout.SortOrder = Enum.SortOrder.LayoutOrder
    tabLayout.Padding = UDim.new(0, 4)

    local content = Instance.new("Frame", main)
    content.Size = UDim2.new(1, 0, 1, -70)
    content.Position = UDim2.new(0, 0, 0, 70)
    content.BackgroundTransparency = 1

    -- Logo toggle
    local toggle = Instance.new("ImageButton", gui)
    toggle.Size = UDim2.new(0, 42, 0, 42)
    toggle.Position = UDim2.new(0, 10, 0, 10)
    toggle.Image = logoAsset
    toggle.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    Instance.new("UICorner", toggle).CornerRadius = UDim.new(1, 0)

    toggle.MouseButton1Click:Connect(function()
        main.Visible = not main.Visible
    end)

    local function Notify(title, msg)
        local popup = Instance.new("TextLabel", gui)
        popup.Size = UDim2.new(0, 300, 0, 60)
        popup.Position = UDim2.new(0.5, -150, 0, -70)
        popup.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
        popup.TextColor3 = Color3.new(1, 1, 1)
        popup.Font = Enum.Font.GothamBold
        popup.TextSize = 16
        popup.Text = title .. "\n" .. msg
        popup.TextWrapped = true
        popup.ZIndex = 999
        Instance.new("UICorner", popup).CornerRadius = UDim.new(0, 8)
        popup:TweenPosition(UDim2.new(0.5, -150, 0, 30), "Out", "Quad", 0.3, true)
        task.delay(2.5, function()
            popup:TweenPosition(UDim2.new(0.5, -150, 0, -70), "In", "Quad", 0.3, true)
            task.delay(0.3, function() popup:Destroy() end)
        end)
    end

    local API = {}

    function API:Notify(title, msg)
        Notify(title, msg)
    end

    function API:AddTab(info)
        local tabBtn = Instance.new("TextButton", tabBar)
        tabBtn.Size = UDim2.new(0, 100, 1, 0)
        tabBtn.Text = info.Title or "Tab"
        tabBtn.Font = Enum.Font.GothamBold
        tabBtn.TextSize = 14
        tabBtn.TextColor3 = Color3.new(1, 1, 1)
        tabBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
        Instance.new("UICorner", tabBtn).CornerRadius = UDim.new(0, 6)

        local page = Instance.new("ScrollingFrame", content)
        page.Size = UDim2.new(1, 0, 1, 0)
        page.AutomaticCanvasSize = Enum.AutomaticSize.Y
        page.ScrollBarThickness = 6
        page.Visible = false
        page.BackgroundTransparency = 1
        local layout = Instance.new("UIListLayout", page)
        layout.Padding = UDim.new(0, 6)

        tabBtn.MouseButton1Click:Connect(function()
            for _, c in pairs(content:GetChildren()) do
                if c:IsA("ScrollingFrame") then
                    c.Visible = false
                end
            end
            page.Visible = true
        end)

        local Tab = {}

        function Tab:AddLabel(text)
            local lbl = Instance.new("TextLabel", page)
            lbl.Size = UDim2.new(1, -10, 0, 25)
            lbl.Text = text
            lbl.Font = Enum.Font.Gotham
            lbl.TextSize = 14
            lbl.TextColor3 = Color3.new(1, 1, 1)
            lbl.BackgroundTransparency = 1
        end

        function Tab:AddButton(text, callback)
            local btn = Instance.new("TextButton", page)
            btn.Size = UDim2.new(1, -10, 0, 30)
            btn.Text = text
            btn.Font = Enum.Font.GothamBold
            btn.TextSize = 14
            btn.TextColor3 = Color3.new(1, 1, 1)
            btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
            Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
            btn.MouseButton1Click:Connect(callback)
        end

        return Tab
    end

    return API
end

return MasteryHub
