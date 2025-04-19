
-- MasteryUILib: MAKE BY MASTERY TEAM + UI ONLY WORLD
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local HttpService = game:GetService("HttpService")

local MasteryUILib = {}
local savedTabKey = "MasteryUILib_LastTab"

local function randomColor()
    return Color3.fromHSV(math.random(), 0.6, 1)
end

function MasteryUILib:CreateWindow(config)
    local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
    ScreenGui.Name = "MasteryUILib_" .. HttpService:GenerateGUID(false)
    ScreenGui.ResetOnSpawn = false

    local MainFrame = Instance.new("Frame", ScreenGui)
    MainFrame.Size = UDim2.new(0, 600, 0, 400)
    MainFrame.Position = UDim2.new(0.5, -300, 0.5, -200)
    MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    MainFrame.BorderSizePixel = 0
    MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
    MainFrame.Name = "MainUI"

    local UICorner = Instance.new("UICorner", MainFrame)
    UICorner.CornerRadius = UDim.new(0, 8)

    local TopBar = Instance.new("Frame", MainFrame)
    TopBar.Size = UDim2.new(1, 0, 0, 40)
    TopBar.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    TopBar.Name = "TopBar"

    local Title = Instance.new("TextLabel", TopBar)
    Title.Size = UDim2.new(1, -80, 1, 0)
    Title.Position = UDim2.new(0, 10, 0, 0)
    Title.BackgroundTransparency = 1
    Title.Text = config.Title or "Mastery UI"
    Title.Font = Enum.Font.GothamBold
    Title.TextSize = 18
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.TextXAlignment = Enum.TextXAlignment.Left

    local CloseBtn = Instance.new("TextButton", TopBar)
    CloseBtn.Size = UDim2.new(0, 40, 0, 30)
    CloseBtn.Position = UDim2.new(1, -45, 0, 5)
    CloseBtn.Text = "X"
    CloseBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
    CloseBtn.TextColor3 = Color3.new(1, 1, 1)
    CloseBtn.AutoButtonColor = true

    local TabHolder = Instance.new("Frame", MainFrame)
    TabHolder.Position = UDim2.new(0, 0, 0, 40)
    TabHolder.Size = UDim2.new(1, 0, 0, 40)
    TabHolder.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    TabHolder.Name = "TabHolder"

    local TabList = Instance.new("UIListLayout", TabHolder)
    TabList.FillDirection = Enum.FillDirection.Horizontal
    TabList.SortOrder = Enum.SortOrder.LayoutOrder

    local PageContainer = Instance.new("Frame", MainFrame)
    PageContainer.Position = UDim2.new(0, 0, 0, 80)
    PageContainer.Size = UDim2.new(1, 0, 1, -80)
    PageContainer.BackgroundTransparency = 1
    PageContainer.Name = "PageContainer"

    local pages = {}
    local lastTab = nil

    local function switchTab(tabButton, page)
        if lastTab then
            lastTab.BackgroundTransparency = 0.4
            pages[lastTab.Name].Visible = false
        end
        tabButton.BackgroundTransparency = 0
        page.Visible = true
        lastTab = tabButton
    end

    function MasteryUILib:AddTab(info)
        local tabButton = Instance.new("TextButton", TabHolder)
        tabButton.Size = UDim2.new(0, 120, 1, 0)
        tabButton.Text = info.Title or "Tab"
        tabButton.Name = info.Title or "Tab"
        tabButton.BackgroundColor3 = randomColor()
        tabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        tabButton.BackgroundTransparency = 0.4

        local page = Instance.new("ScrollingFrame", PageContainer)
        page.Size = UDim2.new(1, 0, 1, 0)
        page.Visible = false
        page.BackgroundTransparency = 1
        page.ScrollBarThickness = 8
        page.Name = info.Title or "Tab"

        local layout = Instance.new("UIListLayout", page)
        layout.Padding = UDim.new(0, 10)
        layout.SortOrder = Enum.SortOrder.LayoutOrder

        tabButton.MouseButton1Click:Connect(function()
            switchTab(tabButton, page)
        end)

        pages[tabButton.Name] = page

        -- Load last tab
        if not lastTab or tabButton.Name == savedTabKey then
            switchTab(tabButton, page)
        end

        return {
            AddSection = function(_, title)
                local section = Instance.new("Frame", page)
                section.Size = UDim2.new(1, -20, 0, 80)
                section.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
                section.BorderSizePixel = 0

                local sectionLabel = Instance.new("TextLabel", section)
                sectionLabel.Size = UDim2.new(1, 0, 0, 20)
                sectionLabel.Text = title or "Section"
                sectionLabel.Font = Enum.Font.GothamBold
                sectionLabel.TextSize = 14
                sectionLabel.TextColor3 = Color3.new(1,1,1)
                sectionLabel.BackgroundTransparency = 1

                return {
                    AddButton = function(_, text, callback)
                        local btn = Instance.new("TextButton", section)
                        btn.Size = UDim2.new(1, -10, 0, 30)
                        btn.Position = UDim2.new(0, 5, 0, 25)
                        btn.Text = text
                        btn.Font = Enum.Font.Gotham
                        btn.TextSize = 14
                        btn.TextColor3 = Color3.new(1,1,1)
                        btn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
                        btn.MouseButton1Click:Connect(callback)
                    end
                }
            end
        }
    end

    -- Drag UI
    local dragging, offset
    TopBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            offset = input.Position - MainFrame.Position
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            MainFrame.Position = UDim2.new(0, input.Position.X - offset.X, 0, input.Position.Y - offset.Y)
        end
    end)
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)

    CloseBtn.MouseButton1Click:Connect(function()
        ScreenGui:Destroy()
    end)

    return MasteryUILib
end

return MasteryUILib
