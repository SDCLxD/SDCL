local Library = {}
    
warn("Preparing UI...")

repeat wait() until game:IsLoaded()
repeat wait() until game.Players.LocalPlayer
repeat wait() until game.Players.LocalPlayer.Character
repeat wait() until game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")

warn("UI Loaded.")

local Tween = game:GetService("TweenService")
local Tweeninfo = TweenInfo.new
local Input = game:GetService("UserInputService")
local Run = game:GetService("RunService")
local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local CoreGui = game:GetService("CoreGui")
local HttpService = game:GetService("HttpService")
local ms = Player:GetMouse()

local Utility = {}
local Objects = {}
local Animate = {}

function Utility:TweenObject(obj, properties, duration, ...)
    Tween:Create(obj, Tweeninfo(duration, ...), properties):Play()
end

function Utility:Pop(object, shrink)
    local clone = object:Clone()

    clone.AnchorPoint = Vector2.new(0.5, 0.5)
    clone.Size = clone.Size - UDim2.new(0, shrink, 0, shrink)
    clone.Position = UDim2.new(0.5, 0, 0.5, 0)

    clone.Parent = object

    object.BackgroundTransparency = 1
    Utility:TweenObject(clone, {Size = object.Size}, 0.2)

    spawn(function()
        wait(0.2)

        object.BackgroundTransparency = 0
        clone:Destroy()
    end)

    return clone
end

function Utility:TweenColor(obj, value, t)
Tween:Create(obj, TweenInfo.new(.25), {BackgroundColor3 = value}):Play()
end

function Utility:TweenTransparency(obj, style, value)
    if string.lower(style) == 'bg' then
        Tween:Create(obj, TweenInfo.new(.25), {BackgroundTransparency = value}):Play()
    elseif string.lower(style) == 'img' then 
        Tween:Create(obj, TweenInfo.new(.25), {ImageTransparency = value}):Play()
    elseif string.lower(style) == 'text' then 
        Tween:Create(obj, TweenInfo.new(.25), {TextTransparency = value}):Play()
    end
end

function Utility:TweenRotation(obj, value)
Tween:Create(obj, TweenInfo.new(.25), {Rotation = value}):Play()
end

function Animate:CreateGradient(object)
    local UIGradient = Instance.new("UIGradient")
    
    UIGradient.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(209, 209, 209))}
    UIGradient.Rotation = 25
    UIGradient.Parent = object
end

function Library:DraggingEnabled(frame, parent)
    parent = parent or frame

    local dragging = false
    local dragInput, mousePos, framePos

    frame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            mousePos = input.Position
            framePos = parent.Position

            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    frame.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then
            dragInput = input
        end
    end)

    Input.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - mousePos
            Utility:TweenObject(parent, {Position = UDim2.new(framePos.X.Scale, framePos.X.Offset + delta.X, framePos.Y.Scale, framePos.Y.Offset + delta.Y)}, 0.25)
        end
    end)
end

function Library:AddWindow(title, gameName)
    title = title or "Said Hub"
    gameName = gameName or "N/A"

    for _, v in pairs(CoreGui:GetChildren()) do
        if v:IsA("ScreenGui") and v.Name == "Gui" then
            v:Destroy()
        end
    end

    table.insert(Library, title)

    -- Container
    local Gui = Instance.new("ScreenGui")
    local Container = Instance.new("Frame")
    local ContainerCorner = Instance.new("UICorner")
    local UIScale = Instance.new("UIScale")
    local ElementContainer = Instance.new("Frame")
    local Elements = Instance.new("Frame")
    local ElementCorner = Instance.new("UICorner")

    -- Top Bar
    local Header = Instance.new("Frame")
    local HeaderCorner = Instance.new("UICorner")
    local coverup = Instance.new("Frame")
    local Title = Instance.new("TextLabel")
    local Logo = Instance.new("ImageLabel")
    local Divisor = Instance.new("Frame")
    local Close = Instance.new("ImageLabel")
    local Exit = Instance.new("ImageLabel")
    local ExitButton = Instance.new("TextButton")
    local CloseButton = Instance.new("TextButton")

    -- Tab Stuff
    local TabFrame = Instance.new("Frame")
    local TabCorner = Instance.new("UICorner")
    local TabScroll = Instance.new("ScrollingFrame")
    local TabGridLayout = Instance.new("UIGridLayout")

    -- Shadow
    local shadowHolder = Instance.new("Frame")
    local umbraShadow = Instance.new("ImageLabel")
    local penumbraShadow = Instance.new("ImageLabel")
    local ambientShadow = Instance.new("ImageLabel")

    Library:DraggingEnabled(Header, Container)

    Gui.Name = "Gui"
    Gui.Parent = CoreGui
    Gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    
    Container.Name = "Container"
    Container.Parent = Gui
    Container.AnchorPoint = Vector2.new(0.5, 0.5)
    Container.BackgroundColor3 = Color3.new(0.133333, 0.133333, 0.133333)
    Container.BorderColor3 = Color3.new(0, 0, 0)
    Container.BorderSizePixel = 0
    Container.Position = UDim2.new(0.5, 0, 0.5, 0)
    Container.Size = UDim2.new(0, 670, 0, 400)
    Container.ClipsDescendants = true
    
    UIScale.Parent = Container
    UIScale.Scale = 1

    ContainerCorner.CornerRadius = UDim.new(0, 4)
    ContainerCorner.Name = "ContainerCorner"
    ContainerCorner.Parent = Container

    ElementContainer.Name = "ElementContainer"
    ElementContainer.Parent = Container
    ElementContainer.AnchorPoint = Vector2.new(0, 0.5)
    ElementContainer.BackgroundColor3 = Color3.new(0.0862745, 0.0862745, 0.0862745)
    ElementContainer.BorderColor3 = Color3.new(0, 0, 0)
    ElementContainer.BorderSizePixel = 0
    ElementContainer.ClipsDescendants = true
    ElementContainer.Position = UDim2.new(0.278, 0, 0.505, 10)
    ElementContainer.Size = UDim2.new(0.694, 0, 0.02, 348)

    Elements.Name = "Elements"
    Elements.Parent = ElementContainer
    Elements.AnchorPoint = Vector2.new(0, 0)
    Elements.BackgroundColor3 = Color3.fromRGB(22, 22, 22)
    Elements.BackgroundTransparency = 1
    Elements.BorderColor3 = Color3.fromRGB(27, 42, 53)
    Elements.Position = UDim2.new(0, 0, 0, 0)
    Elements.ClipsDescendants = true
    Elements.Size = UDim2.new(1, 0, 1, 0)

    ElementCorner.CornerRadius = UDim.new(0, 4)
    ElementCorner.Name = "ElementCorner"
    ElementCorner.Parent = ElementContainer

    local Fader = Instance.new("Frame")
    local FaderGradient = Instance.new("UIGradient")
    local Fader_2 = Instance.new("Frame")
    local FaderGradient_2 = Instance.new("UIGradient")
    
    Fader.Name = "Fader"
    Fader.Parent = ElementContainer
    Fader.AnchorPoint = Vector2.new(0, 1)
    Fader.BackgroundColor3 = Color3.fromRGB(22, 22, 22)
    Fader.BorderSizePixel = 0
    Fader.Position = UDim2.new(0, 0, 1, 0)
    Fader.Size = UDim2.new(1, 0, -0.0388888903, 44)
    Fader.ZIndex = 3
    
    FaderGradient.Rotation = -90
    FaderGradient.Transparency = NumberSequence.new{NumberSequenceKeypoint.new(0.00, 0.00), NumberSequenceKeypoint.new(1.00, 1.00)}
    FaderGradient.Name = "FaderGradient"
    FaderGradient.Parent = Fader
    
    Fader_2.Name = "Fader"
    Fader_2.Parent = ElementContainer
    Fader_2.BackgroundColor3 = Color3.fromRGB(22, 22, 22)
    Fader_2.BorderSizePixel = 0
    Fader_2.Size = UDim2.new(1, 0,-0.073, 44)
    Fader_2.ZIndex = 3
    
    FaderGradient_2.Rotation = 90
    FaderGradient_2.Transparency = NumberSequence.new{NumberSequenceKeypoint.new(0.00, 0.00), NumberSequenceKeypoint.new(1.00, 1.00)}
    FaderGradient_2.Name = "FaderGradient"
    FaderGradient_2.Parent = Fader_2
    
    local UIPageLayout = Instance.new("UIPageLayout")
    
    UIPageLayout.Parent = Elements
    UIPageLayout.FillDirection = Enum.FillDirection.Vertical
    UIPageLayout.SortOrder = Enum.SortOrder.LayoutOrder
    UIPageLayout.EasingDirection = Enum.EasingDirection.InOut
    UIPageLayout.EasingStyle = Enum.EasingStyle.Quad
    UIPageLayout.Padding = UDim.new(0, 0)
    UIPageLayout.TweenTime = 0.500

    Header.Name = "Header"
    Header.Parent = Container
    Header.BackgroundColor3 = Color3.new(0.0862745, 0.0862745, 0.0862745)
    Header.BorderColor3 = Color3.new(0.168627, 0.168627, 0.168627)
    Header.BorderSizePixel = 0
    Header.Size = UDim2.new(0, 670, 0, 30)
    Header.ZIndex = 5
    Header.ClipsDescendants = true
    
    coverup.Name = "coverup"
    coverup.Parent = Header
    coverup.BackgroundColor3 = Color3.new(0.0862745, 0.0862745, 0.0862745)
    coverup.BorderColor3 = Color3.new(0, 0, 0)
    coverup.BorderSizePixel = 0
    coverup.Position = UDim2.new(0, 0, 0.758620679, 0)
    coverup.Size = UDim2.new(1, 0, 0, 7)
    
    Title.Name = "Title"
    Title.Parent = Header
    Title.BackgroundColor3 = Color3.new(1, 1, 1)
    Title.BackgroundTransparency = 1
    Title.BorderColor3 = Color3.new(0, 0, 0)
    Title.BorderSizePixel = 0
    Title.Position = UDim2.new(0.0579494797, 0, 0, 0)
    Title.Size = UDim2.new(0, 625, 0, 29)
    Title.ZIndex = 2
    Title.Font = Enum.Font.Ubuntu
    Title.Text = title .. " - " .. gameName
    Title.TextColor3 = Color3.new(1, 1, 1)
    Title.TextSize = 16
    Title.TextStrokeColor3 = Color3.new(1, 1, 1)
    Title.TextWrapped = true
    Title.TextXAlignment = Enum.TextXAlignment.Left
    
    Logo.Name = "Logo"
    Logo.Parent = Header
    Logo.AnchorPoint = Vector2.new(0.5, 0.5)
    Logo.BackgroundColor3 = Color3.new(0.0862745, 0.0862745, 0.0862745)
    Logo.BackgroundTransparency = 1
    Logo.BorderColor3 = Color3.new(0, 0, 0)
    Logo.BorderSizePixel = 0
    Logo.Position = UDim2.new(0.0299999993, 0, 0.5, 0)
    Logo.Size = UDim2.new(0, 26, 0, 26)
    Logo.ZIndex = 2
    Logo.Image = "rbxassetid://14795786510"

    Divisor.Name = "Divisor"
    Divisor.Parent = Header
    Divisor.AnchorPoint = Vector2.new(0, 1)
    Divisor.BackgroundColor3 = Color3.new(0.494118, 0.247059, 0.741176)
    Divisor.BorderColor3 = Color3.new(0, 0, 0)
    Divisor.BorderSizePixel = 0
    Divisor.Position = UDim2.new(1, -40, 1, -3)
    Divisor.Size = UDim2.new(0, 2, 0, 20)
    
    Close.Name = "Close"
    Close.Parent = Header
    Close.AnchorPoint = Vector2.new(0, 1)
    Close.BackgroundTransparency = 1
    Close.Position = UDim2.new(1, -35, 1, 0)
    Close.Size = UDim2.new(0, 26, 0, 26)
    Close.Image = "rbxassetid://2777727756"

    CloseButton.Parent = Close
    CloseButton.BackgroundColor3 = Color3.new(1, 1, 1)
    CloseButton.BackgroundTransparency = 1
    CloseButton.BorderColor3 = Color3.new(0, 0, 0)
    CloseButton.BorderSizePixel = 0
    CloseButton.Size = UDim2.new(1, 0, 1, 0)
    CloseButton.AutoButtonColor = false
    CloseButton.Font = Enum.Font.SourceSans
    CloseButton.Text = ""
    CloseButton.TextColor3 = Color3.new(0, 0, 0)
    CloseButton.TextSize = 14
    
    Exit.Name = "Exit"
    Exit.Parent = Header
    Exit.AnchorPoint = Vector2.new(0, 1)
    Exit.BackgroundTransparency = 1
    Exit.Position = UDim2.new(1, -70, 1, 0)
    Exit.Size = UDim2.new(0, 26, 0, 26)
    Exit.Image = "rbxassetid://2777726146"

    ExitButton.Parent = Exit
    ExitButton.BackgroundColor3 = Color3.new(1, 1, 1)
    ExitButton.BackgroundTransparency = 1
    ExitButton.BorderColor3 = Color3.new(0, 0, 0)
    ExitButton.BorderSizePixel = 0
    ExitButton.Size = UDim2.new(1, 0, 1, 0)
    ExitButton.AutoButtonColor = false
    ExitButton.Font = Enum.Font.SourceSans
    ExitButton.Text = ""
    ExitButton.TextColor3 = Color3.new(0, 0, 0)
    ExitButton.TextSize = 14

    CloseButton.MouseButton1Click:Connect(function()
        Gui:Destroy()
    end)

    TabFrame.Name = "TabFrame"
    TabFrame.Parent = Container
    TabFrame.AnchorPoint = Vector2.new(0, 0.5)
    TabFrame.BackgroundColor3 = Color3.fromRGB(22, 22, 22)
    TabFrame.BorderColor3 = Color3.fromRGB(27, 42, 53)
    TabFrame.Position = UDim2.new(0.00999999978, 0, 0.49751243, 15)
    TabFrame.Size = UDim2.new(0.249628529, 0, 0.0298507456, 348)

    TabCorner.CornerRadius = UDim.new(0, 4)
    TabCorner.Name = "TabCorner"
    TabCorner.Parent = TabFrame

    TabScroll.Name = "TabScroll"
    TabScroll.Parent = TabFrame
    TabScroll.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    TabScroll.BackgroundTransparency = 1.000
    TabScroll.BorderSizePixel = 0
    TabScroll.Position = UDim2.new(0, 0, 0, 0)
    TabScroll.Size = UDim2.new(1, 0, 1, 0)
    TabScroll.ZIndex = 2
    TabScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
    TabScroll.ScrollBarImageColor3 = Color3.fromRGB(255, 255, 255)
    TabScroll.ScrollBarThickness = 6

    TabGridLayout.Name = "TabGridLayout"
    TabGridLayout.Parent = TabScroll
    TabGridLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    TabGridLayout.SortOrder = Enum.SortOrder.LayoutOrder
    TabGridLayout.CellSize = UDim2.new(0, 150, 0, 35)

    shadowHolder.Name = "shadowHolder"
    shadowHolder.Parent = Container
    shadowHolder.AnchorPoint = Vector2.new(0.5, 0.5)
    shadowHolder.BackgroundTransparency = 1
    shadowHolder.Position = UDim2.new(0.5, 0, 0.5, 0)
    shadowHolder.Size = UDim2.new(0, 680, 0, 410)
    shadowHolder.ZIndex = 0
    
    umbraShadow.Name = "umbraShadow"
    umbraShadow.Parent = shadowHolder
    umbraShadow.AnchorPoint = Vector2.new(0.5, 0.5)
    umbraShadow.BackgroundTransparency = 1
    umbraShadow.Position = UDim2.new(0.5, 0, 0.5, 0)
    umbraShadow.Size = UDim2.new(1, 4, 1, 4)
    umbraShadow.ZIndex = 0
    umbraShadow.Image = "rbxassetid://1316045217"
    umbraShadow.ImageColor3 = Color3.new(0.0862745, 0.0862745, 0.0862745)
    umbraShadow.ImageTransparency = 0.8600000143051147
    umbraShadow.ScaleType = Enum.ScaleType.Slice
    umbraShadow.SliceCenter = Rect.new(10, 10, 118, 118)
    
    penumbraShadow.Name = "penumbraShadow"
    penumbraShadow.Parent = shadowHolder
    penumbraShadow.AnchorPoint = Vector2.new(0.5, 0.5)
    penumbraShadow.BackgroundTransparency = 1
    penumbraShadow.Position = UDim2.new(0.5, 0, 0.5, 0)
    penumbraShadow.Size = UDim2.new(1, 4, 1, 4)
    penumbraShadow.ZIndex = 0
    penumbraShadow.Image = "rbxassetid://1316045217"
    penumbraShadow.ImageColor3 = Color3.new(0.0862745, 0.0862745, 0.0862745)
    penumbraShadow.ImageTransparency = 0.8799999952316284
    penumbraShadow.ScaleType = Enum.ScaleType.Slice
    penumbraShadow.SliceCenter = Rect.new(10, 10, 118, 118)
    
    ambientShadow.Name = "ambientShadow"
    ambientShadow.Parent = shadowHolder
    ambientShadow.AnchorPoint = Vector2.new(0.5, 0.5)
    ambientShadow.BackgroundTransparency = 1
    ambientShadow.Position = UDim2.new(0.5, 0, 0.5, 0)
    ambientShadow.Size = UDim2.new(1, 4, 1, 4)
    ambientShadow.ZIndex = 0
    ambientShadow.Image = "rbxassetid://1316045217"
    ambientShadow.ImageColor3 = Color3.new(0.0862745, 0.0862745, 0.0862745)
    ambientShadow.ImageTransparency = 0.8799999952316284
    ambientShadow.ScaleType = Enum.ScaleType.Slice
    ambientShadow.SliceCenter = Rect.new(10, 10, 118, 118)

    TabGridLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        local absoluteSize = TabGridLayout.AbsoluteContentSize
        TabScroll.CanvasSize = UDim2.new(0, 0, 0, absoluteSize.Y+6)
    end)

    local Tabs = {}

    local first = true
    local LayoutOrder = - 1

    function Tabs:AddTab(tabTitle)

        LayoutOrder = LayoutOrder + 1

        tabTitle = tabTitle or "Tab"

        local TabButton = Instance.new("TextButton")
        local TabButtonCorner = Instance.new("UICorner")
        local slice = Instance.new("Frame")
        local sliceCorner = Instance.new("UICorner")

        local PageContainer = Instance.new("Frame")
        local SectionScroll = Instance.new("ScrollingFrame")
        local SectionScrollListLayout = Instance.new("UIListLayout")

        PageContainer.Name = tabTitle.."_Page"
        PageContainer.Parent = Elements
        PageContainer.BackgroundColor3 = Color3.fromRGB(22, 22, 22)
        PageContainer.BackgroundTransparency = 1.000
        PageContainer.BorderColor3 = Color3.fromRGB(27, 42, 53)
        PageContainer.Size = UDim2.new(1, 0, 1, 0)
        PageContainer.LayoutOrder = LayoutOrder
        PageContainer.Visible = true

        SectionScroll.Name = "SectionScroll"
        SectionScroll.Parent = PageContainer
        SectionScroll.AnchorPoint = Vector2.new(0, 0.5)
        SectionScroll.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        SectionScroll.BackgroundTransparency = 1.000
        SectionScroll.BorderSizePixel = 0
        SectionScroll.Position = UDim2.new(0, 0, 0.5, 0)
        SectionScroll.Size = UDim2.new(1, 0, 0.961111128, 0)
        SectionScroll.ZIndex = 2
        SectionScroll.CanvasPosition = Vector2.new(0, 0)
        SectionScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
        SectionScroll.ScrollBarImageColor3 = Color3.fromRGB(255, 255, 255)
        SectionScroll.ScrollBarThickness = 6
    
        SectionScrollListLayout.Name = "SectionScrollListLayout"
        SectionScrollListLayout.Parent = SectionScroll
        SectionScrollListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
        SectionScrollListLayout.SortOrder = Enum.SortOrder.LayoutOrder
        SectionScrollListLayout.Padding = UDim.new(0, 6)

        SectionScrollListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
            local absoluteSize = SectionScrollListLayout.AbsoluteContentSize
            SectionScroll.CanvasSize = UDim2.new(0, 0, 0, absoluteSize.Y)
        end)

        TabButton.Name = "TabButton"
        TabButton.Parent = TabScroll
        TabButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        TabButton.BackgroundTransparency = 1.000
        TabButton.Position = UDim2.new(0.0107816709, 0, 0.0441953987, 0)
        TabButton.Size = UDim2.new(0, 141, 0, 43)
        TabButton.ZIndex = 2
        TabButton.Font = Enum.Font.Ubuntu
        TabButton.Text = tabTitle
        TabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        TabButton.TextSize = 16.000
        TabButton.TextWrapped = true
    
        TabButtonCorner.CornerRadius = UDim.new(0, 4)
        TabButtonCorner.Name = "TabButtonCorner"
        TabButtonCorner.Parent = TabButton
    
        slice.Name = "slice"
        slice.Parent = TabButton
        slice.AnchorPoint = Vector2.new(0.5, 1)
        slice.BackgroundColor3 = Color3.fromRGB(126, 63, 189)
        slice.BackgroundTransparency = 1
        slice.Position = UDim2.new(0.5, 0, 1, 0)
        slice.Size = UDim2.new(0, 20, 0, 4)
    
        sliceCorner.CornerRadius = UDim.new(0, 4)
        sliceCorner.Name = "sliceCorner"
        sliceCorner.Parent = slice

        if first then
            first = false
            slice.Size = UDim2.new(0, 50, 0, 4)
            slice.BackgroundTransparency = 0
            TabButton.TextTransparency = 0
        else
            slice.Size = UDim2.new(0, 20, 0, 4)
            slice.BackgroundTransparency = 1
            TabButton.TextTransparency = 0.5
        end

        TabButton.MouseButton1Click:Connect(function()
            if PageContainer.Name == tabTitle.."_Page" then
                for i, v in next, Elements:GetChildren() do
                    if not v:IsA("UICorner") and not v:IsA("UIPageLayout") then
                        if v.Name == tabTitle.."_Page" then
                            UIPageLayout:JumpToIndex(PageContainer.LayoutOrder)
                        end
                    end
                end

                for i, v in next, TabScroll:GetChildren() do
                    if v:IsA("TextButton") then
                        Utility:TweenObject(v, {TextTransparency = .5}, 0.1)
                        Tween:Create(v.slice, Tweeninfo(0.2, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut), {
                            Size = UDim2.new(0, 15, 0, 4)
                        }):Play()
                        Tween:Create(v.slice, Tweeninfo(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut), {
                            BackgroundTransparency = 1
                        }):Play()
                    end
                end
    
                Utility:TweenObject(TabButton, {TextTransparency = 0}, 0.1)
                Tween:Create(slice, Tweeninfo(0.2, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut), {
                    Size = UDim2.new(0, 50, 0, 4)
                }):Play()
                Tween:Create(slice, Tweeninfo(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut), {
                    BackgroundTransparency = 0
                }):Play()
            end
        end)

        table.insert(Tabs, tabTitle)

        local Sections = {}

        function Sections:AddSection(secName)
            secName = secName or "Section"

            local SectionFrame = Instance.new("Frame")
            local SectionFrameCorner = Instance.new("UICorner")
            local SectionText = Instance.new("TextLabel")
            local slice_3 = Instance.new("Frame")
            local SectionFrameListLayout = Instance.new("UIListLayout")

            SectionFrame.Name = secName .. "_Section"
            SectionFrame.Parent = SectionScroll
            SectionFrame.BackgroundColor3 = Color3.fromRGB(34, 34, 34)
            SectionFrame.Position = UDim2.new(0.396265566, 0, 0, 0)
            SectionFrame.Size = UDim2.new(0, 470, 0, 492)
            SectionFrame.ClipsDescendants = true
        
            SectionFrameCorner.CornerRadius = UDim.new(0, 4)
            SectionFrameCorner.Name = "SectionFrameCorner"
            SectionFrameCorner.Parent = SectionFrame
        
            SectionText.Name = "SectionText"
            SectionText.Parent = SectionFrame
            SectionText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            SectionText.BackgroundTransparency = 1.000
            SectionText.Size = UDim2.new(1, 0, 0, 26)
            SectionText.ZIndex = 3
            SectionText.Font = Enum.Font.Ubuntu
            SectionText.Text = secName
            SectionText.TextColor3 = Color3.fromRGB(255, 255, 255)
            SectionText.TextSize = 21.000
        
            slice_3.Name = "slice"
            slice_3.Parent = SectionText
            slice_3.AnchorPoint = Vector2.new(0.5, 1)
            slice_3.BackgroundColor3 = Color3.fromRGB(126, 63, 189)
            slice_3.BorderSizePixel = 0
            slice_3.Position = UDim2.new(0.5, 0, 1, 0)
            slice_3.Size = UDim2.new(0, 420, 0, 3)
        
            SectionFrameListLayout.Name = "SectionFrameListLayout"
            SectionFrameListLayout.Parent = SectionFrame
            SectionFrameListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
            SectionFrameListLayout.SortOrder = Enum.SortOrder.LayoutOrder
            SectionFrameListLayout.Padding = UDim.new(0, 6)

            SectionFrameListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
                local absoluteSize = SectionFrameListLayout.AbsoluteContentSize
                SectionFrame.Size = UDim2.new(0, 470, 0, absoluteSize.Y+6)
            end)

            local Elements = {}

            function Elements:AddButton(btitle, callback)
                btitle = btitle or "Button"
                callback = callback or function() end

                local Button = Instance.new("TextButton")
                local ButtonCorner = Instance.new("UICorner")

                Button.Name = "Button"
                Button.Parent = SectionFrame
                Button.BackgroundColor3 = Color3.new(0.0862745, 0.0862745, 0.0862745)
                Button.BorderColor3 = Color3.new(0, 0, 0)
                Button.BorderSizePixel = 0
                Button.ClipsDescendants = true
                Button.Size = UDim2.new(0, 435, 0, 34)
                Button.ZIndex = 2
                Button.AutoButtonColor = false
                Button.Font = Enum.Font.Ubuntu
                Button.Text = " " .. btitle
                Button.TextColor3 = Color3.new(1, 1, 1)
                Button.TextSize = 16
                Button.TextXAlignment = Enum.TextXAlignment.Left

                ButtonCorner.CornerRadius = UDim.new(0, 4)
                ButtonCorner.Name = "ButtonCorner"
                ButtonCorner.Parent = Button

                Button.MouseButton1Click:Connect(function()
                    Utility:Pop(Button, 10)
                end)

                Button.MouseButton1Click:Connect(function()
                    pcall(callback)
                end)
            end

            function Elements:AddToggle(togtitle, setting, callback)
                togtitle = togtitle or "Toggle"
                callback = callback or function() end

                local description = setting.Description
                local tog = setting.Toggled or false

                local Toggle = Instance.new("Frame")
                local ToggleText = Instance.new("TextLabel")
                local Label = Instance.new("ImageLabel")
                local Circle = Instance.new("ImageLabel")
                local EnableButton = Instance.new("TextButton")
                local ToggleDesc = Instance.new("TextLabel")
                local LabelCorner = Instance.new("UICorner")

                if description == false then
                    ToggleDesc:Destroy()
                    ToggleText.Name = "ToggleText"
                    ToggleText.Parent = Toggle
                    ToggleText.BackgroundColor3 = Color3.new(1, 1, 1)
                    ToggleText.BackgroundTransparency = 1
                    ToggleText.BorderColor3 = Color3.new(0, 0, 0)
                    ToggleText.BorderSizePixel = 0
                    ToggleText.Position = UDim2.new(0, 0, 0, 8)
                    ToggleText.Size = UDim2.new(0, 325, 0, 15)
                    ToggleText.Font = Enum.Font.Ubuntu
                    ToggleText.Text = " " .. togtitle
                    ToggleText.TextColor3 = Color3.new(1, 1, 1)
                    ToggleText.TextSize = 16
                    ToggleText.TextXAlignment = Enum.TextXAlignment.Left
                else
                    ToggleText.Name = "ToggleText"
                    ToggleText.Parent = Toggle
                    ToggleText.BackgroundColor3 = Color3.new(1, 1, 1)
                    ToggleText.BackgroundTransparency = 1
                    ToggleText.BorderColor3 = Color3.new(0, 0, 0)
                    ToggleText.BorderSizePixel = 0
                    ToggleText.Position = UDim2.new(0, 0, 0, 1)
                    ToggleText.Size = UDim2.new(0, 325, 0, 15)
                    ToggleText.Font = Enum.Font.Ubuntu
                    ToggleText.Text = " " .. togtitle
                    ToggleText.TextColor3 = Color3.new(1, 1, 1)
                    ToggleText.TextSize = 16
                    ToggleText.TextXAlignment = Enum.TextXAlignment.Left
                    ToggleDesc.Name = "ToggleDesc"
                    ToggleDesc.Parent = Toggle
                    ToggleDesc.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    ToggleDesc.BackgroundTransparency = 1.000
                    ToggleDesc.Position = UDim2.new(0, 0, 0, 18)
                    ToggleDesc.Size = UDim2.new(0, 325, 0, 12)
                    ToggleDesc.Font = Enum.Font.Ubuntu
                    ToggleDesc.Text = " " .. description
                    ToggleDesc.TextColor3 = Color3.fromRGB(255, 255, 255)
                    ToggleDesc.TextSize = 12.000
                    ToggleDesc.TextXAlignment = Enum.TextXAlignment.Left
                end
                
                Toggle.Name = "Toggle"
                Toggle.Parent = SectionFrame
                Toggle.BackgroundColor3 = Color3.new(0.0862745, 0.0862745, 0.0862745)
                Toggle.BorderColor3 = Color3.new(0, 0, 0)
                Toggle.BorderSizePixel = 0
                Toggle.Size = UDim2.new(0, 435, 0, 34)

                Label.Name = "Label"
                Label.Parent = Toggle
                Label.BackgroundColor3 = Color3.new(1, 1, 1)
                Label.BackgroundTransparency = 1
                Label.Position = UDim2.new(0, 368, 0, 5)
                Label.Size = UDim2.new(0, 48, 0, 25)
                Label.Image = "rbxassetid://3570695787"
                Label.ImageColor3 = Color3.new(0, 0, 0)
                Label.ScaleType = Enum.ScaleType.Slice
                Label.SliceCenter = Rect.new(100, 100, 100, 100)

                LabelCorner.CornerRadius = UDim.new(0, 4)
                LabelCorner.Name = "LabelCorner"
                LabelCorner.Parent = Label

                Circle.Name = "Circle"
                Circle.Parent = Label
                Circle.BackgroundColor3 = Color3.new(1, 1, 1)
                Circle.BackgroundTransparency = 1
                Circle.Position = UDim2.new(0, 4, 0, 4)
                Circle.Size = UDim2.new(0, 18, 0, 18)
                Circle.Image = "rbxassetid://3570695787"
                Circle.ImageColor3 = Color3.fromRGB(200, 200, 200)
                Circle.ScaleType = Enum.ScaleType.Slice
                Circle.SliceCenter = Rect.new(100, 100, 100, 100)

                EnableButton.Name = "EnableButton"
                EnableButton.Parent = Circle
                EnableButton.BackgroundColor3 = Color3.new(1, 1, 1)
                EnableButton.BackgroundTransparency = 1
                EnableButton.BorderColor3 = Color3.new(0, 0, 0)
                EnableButton.BorderSizePixel = 0
                EnableButton.Size = UDim2.new(1, 0, 1, 0)
                EnableButton.Font = Enum.Font.SourceSans
                EnableButton.Text = ""
                EnableButton.TextColor3 = Color3.new(0, 0, 0)
                EnableButton.TextSize = 14

                local isToggle = false

                if tog == true then
                    isToggle = true
                    local tweenInfo = TweenInfo.new(
                        0.12,
                        Enum.EasingStyle.Linear,
                        Enum.EasingDirection.In
                    )
            
                    game.TweenService:Create(Circle, tweenInfo, {ImageColor3 = Color3.fromRGB(126, 63, 189)}):Play()
                    game.TweenService:Create(Circle, tweenInfo, {Position = UDim2.new(0, 25, 0, 4)}):Play()
                end
                pcall(callback, isToggle)
                local OnClick = function() 
                    if isToggle == false then
                        isToggle = true
                        local tweenInfo = TweenInfo.new(
                        0.12,
                        Enum.EasingStyle.Linear,
                        Enum.EasingDirection.In
                        )
            
                        game.TweenService:Create(Circle, tweenInfo, {ImageColor3 = Color3.fromRGB(126, 63, 189)}):Play()
                        game.TweenService:Create(Circle, tweenInfo, {Position = UDim2.new(0, 25, 0, 4)}):Play()
                    else
                        isToggle = false
                        local tweenInfo = TweenInfo.new(
                        0.12,
                        Enum.EasingStyle.Linear,
                        Enum.EasingDirection.In
                        )
            
                        game.TweenService:Create(Circle, tweenInfo, {ImageColor3 = Color3.fromRGB(200, 200, 200)}):Play()
                        game.TweenService:Create(Circle, tweenInfo, {Position = UDim2.new(0, 4, 0, 4)}):Play()
                    end
                    pcall(callback, isToggle)
                end
                EnableButton.MouseButton1Click:Connect(OnClick)
                return {
                    SetValue = function(val) 
                        if val~=isToggle then 
                            OnClick()
                        end
                    end
                }
                end -- Final

                function Elements:AddDropdown(droptitle, setting, callback)
                    local DropElements = {}
                    droptitle = droptitle or "Dropdown"
                    
                    local list = setting.List or {}
                    local search = setting.Search
                    local default = setting.Default
    
                    callback = callback or function() end
    
                    local opened = false
    
                    local TextLabel = Instance.new("TextLabel")
                    local DropButton = Instance.new("TextButton")
                    local DropSearch = Instance.new("TextBox")
                    local Dropdown = Instance.new("Frame")
                    local DropdownCorner = Instance.new("UICorner")
                    local DropdownListLayout = Instance.new("UIListLayout")
                    local TopFrame = Instance.new("Frame")
                    local ArrowIcon = Instance.new("ImageLabel")
                    local TopFrameCorner = Instance.new("UICorner")
                    local DropItemHolder = Instance.new("ScrollingFrame")
                    local DropItemListLayout = Instance.new("UIListLayout")
                    
                    Dropdown.Name = "Dropdown"
                    Dropdown.Parent = SectionFrame
                    Dropdown.BackgroundColor3 = Color3.fromRGB(22, 22, 22)
                    Dropdown.ClipsDescendants = true
                    Dropdown.Position = UDim2.new(0.0319148935, 0, 0.186978295, 0)
                    Dropdown.Size = UDim2.new(0, 435, 0, 34)
                    Dropdown.ZIndex = 2
                    
                    DropdownCorner.CornerRadius = UDim.new(0, 4)
                    DropdownCorner.Name = "DropdownCorner"
                    DropdownCorner.Parent = Dropdown
                    
                    DropdownListLayout.Name = "DropdownListLayout"
                    DropdownListLayout.Parent = Dropdown
                    DropdownListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
                    DropdownListLayout.SortOrder = Enum.SortOrder.LayoutOrder
                    DropdownListLayout.Padding = UDim.new(0, 5)
                    
                    TopFrame.Name = "TopFrame"
                    TopFrame.Parent = Dropdown
                    TopFrame.BackgroundColor3 = Color3.fromRGB(22, 22, 22)
                    TopFrame.Size = UDim2.new(0, 435, 0, 34)
                    TopFrame.ZIndex = 2
                    
                    ArrowIcon.Name = "ArrowIcon"
                    ArrowIcon.Parent = TopFrame
                    ArrowIcon.AnchorPoint = Vector2.new(0.5, 0.5)
                    ArrowIcon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    ArrowIcon.BackgroundTransparency = 1.000
                    ArrowIcon.Position = UDim2.new(0.949999988, 0, 0.5, 0)
                    ArrowIcon.Size = UDim2.new(0, 23, 0, 23)
                    ArrowIcon.ZIndex = 2
                    ArrowIcon.Image = "rbxassetid://7072706663"
                    ArrowIcon.ImageColor3 = Color3.fromRGB(255, 255, 255)
                    
                    TopFrameCorner.CornerRadius = UDim.new(0, 4)
                    TopFrameCorner.Name = "TopFrameCorner"
                    TopFrameCorner.Parent = TopFrame
                    
                    if search == true then
                        DropSearch.Name = "DropSearch"
                        DropSearch.Parent = TopFrame
                        DropSearch.AnchorPoint = Vector2.new(1, 0)
                        DropSearch.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                        DropSearch.BackgroundTransparency = 1.000
                        DropSearch.Position = UDim2.new(0.899999976, 0, 0, 0)
                        DropSearch.Size = UDim2.new(0, 389, 0, 34)
                        DropSearch.ZIndex = 2
                        DropSearch.Font = Enum.Font.Ubuntu
                        DropSearch.Text = droptitle .. ":"
                        DropSearch.TextColor3 = Color3.fromRGB(255, 255, 255)
                        DropSearch.TextSize = 16.000
                        DropSearch.TextXAlignment = Enum.TextXAlignment.Left
                    else
                        TextLabel.Parent = TopFrame
                        TextLabel.AnchorPoint = Vector2.new(1, 0)
                        TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                        TextLabel.BackgroundTransparency = 1.000
                        TextLabel.Position = UDim2.new(0.899999976, 0, 0, 0)
                        TextLabel.Size = UDim2.new(0, 389, 0, 34)
                        TextLabel.Font = Enum.Font.Ubuntu
                        TextLabel.Text = droptitle .. ":"
                        TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
                        TextLabel.TextSize = 16.000
                        TextLabel.TextXAlignment = Enum.TextXAlignment.Left
                        
                        DropButton.Name = "DropButton"
                        DropButton.Parent = TopFrame
                        DropButton.Active = false
                        DropButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                        DropButton.BackgroundTransparency = 1.000
                        DropButton.Size = UDim2.new(1, 0, 0, 34)
                        DropButton.ZIndex = 2
                        DropButton.AutoButtonColor = false
                        DropButton.Font = Enum.Font.Ubuntu
                        DropButton.Text = ""
                        DropButton.TextColor3 = Color3.fromRGB(255, 255, 255)
                        DropButton.TextSize = 16.000
                        DropButton.TextWrapped = true
                        DropButton.TextXAlignment = Enum.TextXAlignment.Left
                    end
    
                    DropItemHolder.Name = "DropItemHolder"
                    DropItemHolder.Parent = Dropdown
                    DropItemHolder.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    DropItemHolder.BackgroundTransparency = 1.000
                    DropItemHolder.BorderSizePixel = 0
                    DropItemHolder.Position = UDim2.new(0, 0, 0.254901975, 0)
                    DropItemHolder.Size = UDim2.new(1, 0, 0.0130718956, 100)
                    DropItemHolder.CanvasSize = UDim2.new(0, 0, 0, 0)
                    DropItemHolder.ScrollBarThickness = 6
                    DropItemHolder.ScrollBarImageColor3 = Color3.fromRGB(255, 255, 255)
                    
                    DropItemListLayout.Name = "DropItemListLayout"
                    DropItemListLayout.Parent = DropItemHolder
                    DropItemListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
                    DropItemListLayout.SortOrder = Enum.SortOrder.LayoutOrder
                    DropItemListLayout.Padding = UDim.new(0, 5)
    
                    if default then
                        callback(default)
                        TextLabel.Text = droptitle .. ": " .. default
                    elseif default and search then
                        callback(default)
                        DropSearch.Text = droptitle .. ": " .. default
                    end
                    
                    if not search then
                        DropButton.MouseButton1Click:Connect(function()
                            if opened then
                                Dropdown:TweenSize(UDim2.new(0, 440, 0, 34), "Out", "Quad", 0.5, true)
                                Tween:Create(ArrowIcon, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Rotation = 0}):Play();
                            else
                                Dropdown:TweenSize(UDim2.new(0, 440, 0, 146), "Out", "Quad", 0.5, true)
                                Tween:Create(ArrowIcon, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Rotation = 180}):Play();
                            end
                            opened = not opened
                        end) 
                    else
                        local function updateResult()
                            local search = string.lower(DropSearch.Text)
                            for i, v in pairs(DropItemHolder:GetChildren()) do
                                if v:IsA("GuiButton") then
                                    if search ~= "" then
                                        local item = string.lower(v.Text)
                                        if string.find(item, search) then
                                            v.Visible = true
                                        else
                                            v.Visible = false
                                        end
                                    else
                                        v.Visible = true
                                    end
                                end
                            end
                        end
    
                        local focused
    
                        DropSearch.Focused:Connect(function()
                            focused = true
                            Dropdown:TweenSize(UDim2.new(0, 440, 0, 146), "Out", "Quad", 0.5, true)
                            Tween:Create(ArrowIcon, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Rotation = 180}):Play();
                        end)
    
                        DropSearch.FocusLost:Connect(function()
                            focused = false
                            Dropdown:TweenSize(UDim2.new(0, 440, 0, 34), "Out", "Quad", 0.5, true)
                            Tween:Create(ArrowIcon, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Rotation = 0}):Play();
    
                            if not tostring(DropSearch.Text) or not tonumber(DropSearch.Text) then
                                DropSearch.Text = droptitle .. ":"
                                for i, v in pairs(DropItemHolder:GetChildren()) do
                                    if v:IsA("GuiButton") then
                                        v.Visible = true
                                    end
                                end
                            end
                        end)
    
                        DropSearch.Changed:Connect(function()
                            if focused then
                                updateResult()
                            end
                        end)  
                    end
    
                    DropItemListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
                        local absoluteSize = DropItemListLayout.AbsoluteContentSize
                        DropItemHolder.CanvasSize = UDim2.new(0, 0, 0, absoluteSize.Y)
                    end)
    
                    for i, v in next, list do
                        local DropItem = Instance.new("TextButton")
                        local DropItemCorner = Instance.new("UICorner")              
    
                        DropItem.Name = v .. "_DropItem"
                        DropItem.Parent = DropItemHolder
                        DropItem.BackgroundColor3 = Color3.fromRGB(22, 22, 22)
                        DropItem.Size = UDim2.new(0, 420, 0, 30)
                        DropItem.AutoButtonColor = false
                        DropItem.Font = Enum.Font.Ubuntu
                        DropItem.Text = " " .. v
                        DropItem.TextColor3 = Color3.fromRGB(255, 255, 255)
                        DropItem.TextSize = 16.000
                        DropItem.TextXAlignment = Enum.TextXAlignment.Left
                        DropItem.ZIndex = 2
                    
                        DropItemCorner.CornerRadius = UDim.new(0, 4)
                        DropItemCorner.Name = "ToggleCorner"
                        DropItemCorner.Parent = DropItem
    
                        DropItem.MouseButton1Click:Connect(function()
                            opened = false
                            Utility:Pop(DropItem, 8)
                            callback(v)
    
                            if not search then
                                TextLabel.Text = droptitle .. ": " .. v
                            else
                                DropSearch.Text = droptitle .. ": " .. v
    
                            end
    
                            Dropdown:TweenSize(UDim2.new(0, 440, 0, 34), "Out", "Quad", 0.5, true)
                            Tween:Create(ArrowIcon, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Rotation = 0}):Play();
                        end)
                    end
    
                    function DropElements:Add(newlist)
                        newlist = newlist or {}
    
                        for i, v in next, newlist do
                            local DropItem = Instance.new("TextButton")
                            local DropItemCorner = Instance.new("UICorner")              
        
                            DropItem.Name = v .. "_DropItem"
                            DropItem.Parent = DropItemHolder
                            DropItem.BackgroundColor3 = Color3.fromRGB(22, 22, 22)
                            DropItem.Size = UDim2.new(0, 420, 0, 30)
                            DropItem.AutoButtonColor = false
                            DropItem.Font = Enum.Font.Ubuntu
                            DropItem.Text = " " .. v
                            DropItem.TextColor3 = Color3.fromRGB(255, 255, 255)
                            DropItem.TextSize = 16.000
                            DropItem.TextXAlignment = Enum.TextXAlignment.Left
                            DropItem.ZIndex = 2
                        
                            DropItemCorner.CornerRadius = UDim.new(0, 4)
                            DropItemCorner.Name = "ToggleCorner"
                            DropItemCorner.Parent = DropItem

        
                            DropItem.MouseButton1Click:Connect(function()
                                opened = false
                                Utility:Pop(DropItem, 8)
                                callback(v)
    
                                if not search then
                                    TextLabel.Text = droptitle .. ": " .. v
                                else
                                    DropSearch.Text = droptitle .. ": " .. v
                                end
    
                                Dropdown:TweenSize(UDim2.new(0, 440, 0, 34), "Out", "Quad", 0.5, true)
                                Tween:Create(ArrowIcon, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Rotation = 0}):Play();
                            end)
                        end
                    end
    
                    function DropElements:Clear()
                        for i, v in pairs(DropItemHolder:GetChildren()) do
                            if v:IsA("TextButton") then
                                v:Destroy()
                            end
                        end
                    end
    
                    return DropElements
                end -- Final

                function Elements:AddSlider(slidertitle, setting, callback)
                    slidertitle = slidertitle or "Slider"
                    callback = callback or function() end
                    local Max_Value = setting.Max or 100
                    local Min_Value = setting.Min or 0
                    local DefaultValue = setting.DefaultValue or 0
    
                    local dragging = false
    
                    local Slider = Instance.new("Frame")
                    local SliderButton = Instance.new("Frame")
                    local SliderPercent = Instance.new("Frame")
                    local SliderPercentCorner = Instance.new("UICorner")
                    local SliderDrag = Instance.new("Frame")
                    local SliderDragCorner = Instance.new("UICorner")
                    local UICorner = Instance.new("UICorner")
                    local SliderIcon = Instance.new("ImageLabel")
                    local SilderText = Instance.new("TextLabel")
                    local SilderNumber = Instance.new("TextLabel")
                    local SliderCorner = Instance.new("UICorner")
    
                    Slider.Name = "Slider"
                    Slider.Parent = SectionFrame
                    Slider.BackgroundColor3 = Color3.fromRGB(22, 22, 22)
                    Slider.Size = UDim2.new(0, 435, 0, 49)
                
                    SliderButton.Name = "SliderBar"
                    SliderButton.Parent = Slider
                    SliderButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    SliderButton.BorderSizePixel = 0
                    SliderButton.Position = UDim2.new(0.023, 0, 0.694000006, 0)
                    SliderButton.Size = UDim2.new(0, 420, 0, 8)
                    SliderButton.ZIndex = 2
                
                    SliderPercent.Name = "SliderInBar"
                    SliderPercent.Parent = SliderButton
                    SliderPercent.BackgroundColor3 = Color3.fromRGB(126, 63, 189)
                    SliderPercent.Size = UDim2.new(0, 0, 1, 0)
                    SliderPercent.ZIndex = 2
                
                    SliderPercentCorner.CornerRadius = UDim.new(0, 4)
                    SliderPercentCorner.Name = "SliderPercentCorner"
                    SliderPercentCorner.Parent = SliderPercent
                
                    SliderDrag.Name = "SliderDrag"
                    SliderDrag.Parent = SliderPercent
                    SliderDrag.AnchorPoint = Vector2.new(0.5, 0.5)
                    SliderDrag.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
                    SliderDrag.Position = UDim2.new(1, 0, 0.5, 0)
                    SliderDrag.Size = UDim2.new(0, 12, 0, 17)
                
                    SliderDragCorner.CornerRadius = UDim.new(0, 4)
                    SliderDragCorner.Name = "SliderDragCorner"
                    SliderDragCorner.Parent = SliderDrag
                
                    UICorner.CornerRadius = UDim.new(0, 4)
                    UICorner.Parent = SliderButton
                
                    SliderIcon.Name = "SliderIcon"
                    SliderIcon.Parent = Slider
                    SliderIcon.AnchorPoint = Vector2.new(0.5, 0.899999976)
                    SliderIcon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    SliderIcon.BackgroundTransparency = 1.000
                    SliderIcon.Position = UDim2.new(0.949999988, 0, 0.5, 0)
                    SliderIcon.Size = UDim2.new(0, 23, 0, 23)
                    SliderIcon.ZIndex = 2
                    SliderIcon.Image = "rbxassetid://5650881226"
                    SliderIcon.ImageColor3 = Color3.fromRGB(255,255,255)
                
                    SilderText.Name = "SilderText"
                    SilderText.Parent = Slider
                    SilderText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    SilderText.BackgroundTransparency = 1.000
                    SilderText.Size = UDim2.new(0, 366, 0, 34)
                    SilderText.ZIndex = 2
                    SilderText.Font = Enum.Font.Ubuntu
                    SilderText.Text = " " .. slidertitle
                    SilderText.TextColor3 = Color3.fromRGB(255,255,255)
                    SilderText.TextSize = 16.000
                    SilderText.TextXAlignment = Enum.TextXAlignment.Left
                
                    SilderNumber.Name = "SilderNumber"
                    SilderNumber.Parent = Slider
                    SilderNumber.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    SilderNumber.BackgroundTransparency = 1.000
                    SilderNumber.Position = UDim2.new(0.831818163, 0, -0.0408163257, 0)
                    SilderNumber.Size = UDim2.new(0, 30, 0, 34)
                    SilderNumber.ZIndex = 2
                    SilderNumber.Font = Enum.Font.Ubuntu
                    SilderNumber.Text = Min_Value
                    SilderNumber.TextColor3 = Color3.fromRGB(255,255,255)
                    SilderNumber.TextSize = 16.000
                    SilderNumber.TextXAlignment = Enum.TextXAlignment.Right
                    SilderNumber.TextTransparency = 1
                
                    SliderCorner.CornerRadius = UDim.new(0, 4)
                    SliderCorner.Name = "SliderCorner"
                    SliderCorner.Parent = Slider
    
                    SliderPercent.Size = UDim2.new(((DefaultValue or 0) / Max_Value),0, 1, 0)
                    SilderNumber.Text = tostring(DefaultValue and math.floor((DefaultValue / Max_Value) * (Max_Value - Min_Value) + Min_Value) or 0)
                    pcall(callback, DefaultValue)
    
                    local function move(input)
                        local pos =
                            UDim2.new(
                                math.clamp((input.Position.X - SliderButton.AbsolutePosition.X) / SliderButton.AbsoluteSize.X, 0, 1),
                                0,
                                1,
                                0
                            )
                        Utility:TweenObject(SliderPercent, {Size = pos}, 0.25)
                        local value = math.floor(((pos.X.Scale * Max_Value) / Max_Value) * (Max_Value - Min_Value) + Min_Value)
                        SilderNumber.Text = tostring(value)
                        pcall(callback, value)
                    end
    
                    SliderDrag.InputBegan:Connect(function(input)
                        if input.UserInputType == Enum.UserInputType.MouseButton1 then
                            dragging = true
                            Utility:TweenObject(SilderNumber, {TextTransparency = 0}, 0.5)
                        end
                    end)
    
                    SliderDrag.InputEnded:Connect(function(input)
                        if input.UserInputType == Enum.UserInputType.MouseButton1 then
                            dragging = false
                            Utility:TweenObject(SilderNumber, {TextTransparency = 1}, 0.5)
                        end
                    end)
    
                    Input.InputChanged:Connect(function(input)
                        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
                            move(input)
                        end
                    end)
    
                    local SliderElements = {}
    
                    function SliderElements:Change(tochange)
                        SliderPercent.Size = UDim2.new(((tochange or 0) / Max_Value), 0, 1, 0)
                        SilderNumber.Text = tostring(tochange and math.floor((tochange / Max_Value) * (Max_Value - Min_Value) + Min_Value) or 0)
                        pcall(callback, tochange)
                    end
    
                end -- Final

                function Elements:AddTextbox(boxtitle, desc, callback,def)
                    boxtitle = boxtitle or "Textbox"
                    desc = desc or "Enter here!"
                    callback = callback or function() end
    
                    local TextBox = Instance.new("Frame")
                    local TextBoxText = Instance.new("TextLabel")
                    local TextBoxCorner = Instance.new("UICorner")
                    local Box = Instance.new("TextBox")
                    local UICorner_2 = Instance.new("UICorner")
                    local TextBoxIcon = Instance.new("ImageLabel")
    
                    TextBox.Name = "TextBox"
                    TextBox.Parent = SectionFrame
                    TextBox.BackgroundColor3 = Color3.fromRGB(22, 22, 22)
                    TextBox.Position = UDim2.new(0.0319148935, 0, 0.826464236, 0)
                    TextBox.Size = UDim2.new(0, 435, 0, 65)
                
                    TextBoxText.Name = "TextBoxText"
                    TextBoxText.Parent = TextBox
                    TextBoxText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    TextBoxText.BackgroundTransparency = 1.000
                    TextBoxText.Size = UDim2.new(0, 396, 0, 34)
                    TextBoxText.ZIndex = 2
                    TextBoxText.Font = Enum.Font.Ubuntu
                    TextBoxText.Text = " " .. boxtitle
                    TextBoxText.TextColor3 = Color3.fromRGB(255, 255, 255)
                    TextBoxText.TextSize = 16.000
                    TextBoxText.TextXAlignment = Enum.TextXAlignment.Left
                
                    TextBoxCorner.CornerRadius = UDim.new(0, 4)
                    TextBoxCorner.Name = "TextBoxCorner"
                    TextBoxCorner.Parent = TextBox
                
                    Box.Name = "Box"
                    Box.Parent = TextBox
                    Box.AnchorPoint = Vector2.new(0.5, 0.5)
                    Box.BackgroundColor3 = Color3.fromRGB(36, 36, 36)
                    Box.Position = UDim2.new(0.5, 0, 0.714999974, 0)
                    Box.Size = UDim2.new(0, 426, 0, 25)
                    Box.ZIndex = 2
                    Box.Font = Enum.Font.Ubuntu
                    Box.PlaceholderText = desc
                    Box.Text = ""
                    Box.TextColor3 = Color3.fromRGB(255, 255, 255)
                    Box.TextSize = 18.000
                    Box.TextTruncate = Enum.TextTruncate.AtEnd
                
                    UICorner_2.CornerRadius = UDim.new(0, 4)
                    UICorner_2.Parent = Box
                
                    TextBoxIcon.Name = "TextBoxIcon"
                    TextBoxIcon.Parent = TextBox
                    TextBoxIcon.AnchorPoint = Vector2.new(0.5, 0.899999976)
                    TextBoxIcon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    TextBoxIcon.BackgroundTransparency = 1.000
                    TextBoxIcon.Position = UDim2.new(0.949999988, 0, 0.392307699, 0)
                    TextBoxIcon.Size = UDim2.new(0, 23, 0, 23)
                    TextBoxIcon.ZIndex = 2
                    TextBoxIcon.Image = "rbxassetid://5650877793"
                    TextBoxIcon.ImageColor3 = Color3.fromRGB(255, 255, 255)
    
                    if def then Box.Text=def end
                    Box.FocusLost:Connect(function()
                        Utility:Pop(Box, 10)
                    end)
    
                    Box.FocusLost:Connect(function(enterPressed)
                        if not enterPressed then
                            return
                        else
                            callback(Box.Text)
                        end
                    end)
                end -- Final

            local minimized = false
    
            ExitButton.MouseButton1Click:Connect(function()
                if minimized == false then
                    local tweenInfo = TweenInfo.new(
                        1,
                        Enum.EasingStyle.Quint,
                        Enum.EasingDirection.Out
                    )
            
                    local tween = Tween:Create(Container, tweenInfo, {Size = UDim2.new(0, 670, 0, 30)}):Play()
                    minimized = true
                    task.wait(0.001)
                    Exit.Image = "rbxassetid://2777725930"
                else
                    local tweenInfo = TweenInfo.new(
                        1,
                        Enum.EasingStyle.Quint,
                        Enum.EasingDirection.Out
                    )
            
                    local tween = Tween:Create(Container, tweenInfo, {Size = UDim2.new(0, 670, 0, 400)}):Play()
                    minimized = false
                    task.wait(0.001)
                    Exit.Image = "rbxassetid://2777726146"
                end
            end)

            return Elements
        end
        return Sections
    end
    return Tabs
end

return Library
