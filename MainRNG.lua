-- ==========================================
-- RNG HUB ULTIMATE LIBRARY (M4teoScripts)
-- ==========================================

local Library = {}
local CoreGui = game:GetService("CoreGui")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

function Library:Notify(data)
    local screenGui = CoreGui:FindFirstChild("DeltaAdvancedLib")
    if not screenGui then return end

    local notif = Instance.new("Frame")
    notif.Size = UDim2.new(0, 220, 0, 55)
    notif.Position = UDim2.new(1, 10, 1, -70)
    notif.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    notif.BorderSizePixel = 0
    notif.Parent = screenGui

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = notif

    local stroke = Instance.new("UIStroke")
    stroke.Thickness = 1.5
    stroke.Color = Color3.fromRGB(0, 170, 255)
    stroke.Parent = notif

    local titleLbl = Instance.new("TextLabel")
    titleLbl.Size = UDim2.new(1, -10, 0, 20)
    titleLbl.Position = UDim2.new(0, 8, 0, 4)
    titleLbl.BackgroundTransparency = 1
    titleLbl.Text = data.Title or "Notificación"
    titleLbl.TextColor3 = Color3.fromRGB(255, 255, 255)
    titleLbl.TextSize = 12
    titleLbl.Font = Enum.Font.SourceSansBold
    titleLbl.TextXAlignment = Enum.TextXAlignment.Left
    titleLbl.Parent = notif

    local descLbl = Instance.new("TextLabel")
    descLbl.Size = UDim2.new(1, -10, 0, 25)
    descLbl.Position = UDim2.new(0, 8, 0, 22)
    descLbl.BackgroundTransparency = 1
    descLbl.Text = data.Content or ""
    descLbl.TextColor3 = Color3.fromRGB(180, 180, 180)
    descLbl.TextSize = 11
    descLbl.Font = Enum.Font.SourceSans
    descLbl.TextXAlignment = Enum.TextXAlignment.Left
    descLbl.Parent = notif

    notif:TweenPosition(UDim2.new(1, -230, 1, -70), "Out", "Quad", 0.3, true)
    
    task.delay(data.Duration or 3, function()
        notif:TweenPosition(UDim2.new(1, 10, 1, -70), "In", "Quad", 0.3, true, function()
            notif:Destroy()
        end)
    end)
end

function Library:CreateWindow(config)
    local titleText = config.Title or "RNG Hub"
    local subtitleText = config.Subtitle or ""
    local useKey = config.KeySystem or false
    local correctKey = config.Key or "1234"
    local keyLink = config.Link or "https://discord.gg/tuenlace"
    local keyNote = config.Note or ""

    if CoreGui:FindFirstChild("DeltaAdvancedLib") then
        CoreGui.DeltaAdvancedLib:Destroy()
    end

    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "DeltaAdvancedLib"
    ScreenGui.Parent = CoreGui

    local MainFrame = Instance.new("Frame")
    MainFrame.Size = UDim2.new(0, 280, 0, 340)
    MainFrame.Position = UDim2.new(0.5, -140, 0.5, -170)
    MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    MainFrame.BorderSizePixel = 0
    MainFrame.Active = true
    MainFrame.Draggable = true
    MainFrame.ClipsDescendants = true
    MainFrame.Visible = not useKey
    MainFrame.Parent = ScreenGui

    local CornerMain = Instance.new("UICorner")
    CornerMain.CornerRadius = UDim.new(0, 6)
    CornerMain.Parent = MainFrame

    local UIStroke = Instance.new("UIStroke")
    UIStroke.Thickness = 2
    UIStroke.Parent = MainFrame

    local ToggleUiBtn = Instance.new("TextButton")
    ToggleUiBtn.Size = UDim2.new(0, 45, 0, 45)
    ToggleUiBtn.Position = UDim2.new(0, 10, 0.5, -22)
    ToggleUiBtn.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
    ToggleUiBtn.BorderSizePixel = 0
    ToggleUiBtn.Text = "UI"
    ToggleUiBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    ToggleUiBtn.TextSize = 14
    ToggleUiBtn.Font = Enum.Font.SourceSansBold
    ToggleUiBtn.Active = true
    ToggleUiBtn.Draggable = false
    ToggleUiBtn.Visible = not useKey
    ToggleUiBtn.Parent = ScreenGui

    local CornerBtn = Instance.new("UICorner")
    CornerBtn.CornerRadius = UDim.new(0, 8)
    CornerBtn.Parent = ToggleUiBtn

    local ToggleStroke = Instance.new("UIStroke")
    ToggleStroke.Thickness = 2
    ToggleStroke.Parent = ToggleUiBtn

    task.spawn(function()
        while ScreenGui.Parent do
            local hue = tick() % 5 / 5
            local rgbColor = Color3.fromHSV(hue, 1, 1)
            UIStroke.Color = rgbColor
            ToggleStroke.Color = rgbColor
            task.wait()
        end
    end)

    if useKey then
        local KeyGui = Instance.new("Frame")
        KeyGui.Size = UDim2.new(0, 280, 0, keyNote ~= "" and 230 or 200)
        KeyGui.Position = UDim2.new(0.5, -140, 0.5, keyNote ~= "" and -115 or -100)
        KeyGui.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
        KeyGui.BorderSizePixel = 0
        KeyGui.Active = true
        KeyGui.Draggable = true
        KeyGui.Parent = ScreenGui

        local KeyStroke = Instance.new("UIStroke")
        KeyStroke.Thickness = 2
        KeyStroke.Parent = KeyGui
        task.spawn(function()
            while KeyGui.Parent do
                KeyStroke.Color = UIStroke.Color
                task.wait()
            end
        end)

        local KeyTitle = Instance.new("TextLabel")
        KeyTitle.Size = UDim2.new(1, 0, 0, 35)
        KeyTitle.BackgroundTransparency = 1
        KeyTitle.Text = "Sistema de Verificación"
        KeyTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
        KeyTitle.TextSize = 13
        KeyTitle.Font = Enum.Font.SourceSansBold
        KeyTitle.Parent = KeyGui

        local KeyDesc = Instance.new("TextLabel")
        KeyDesc.Size = UDim2.new(1, -20, 0, 35)
        KeyDesc.Position = UDim2.new(0, 10, 0, 32)
        KeyDesc.BackgroundTransparency = 1
        KeyDesc.Text = "Introduce tu clave de acceso para continuar."
        KeyDesc.TextColor3 = Color3.fromRGB(160, 160, 160)
        KeyDesc.TextSize = 11
        KeyDesc.Font = Enum.Font.SourceSans
        KeyDesc.TextWrapped = true
        KeyDesc.Parent = KeyGui

        local yOffset = 70
        if keyNote ~= "" then
            local KeyNoteLbl = Instance.new("TextLabel")
            KeyNoteLbl.Size = UDim2.new(1, -20, 0, 25)
            KeyNoteLbl.Position = UDim2.new(0, 10, 0, 68)
            KeyNoteLbl.BackgroundTransparency = 1
            KeyNoteLbl.Text = "💡 " .. keyNote
            KeyNoteLbl.TextColor3 = Color3.fromRGB(255, 200, 100)
            KeyNoteLbl.TextSize = 11
            KeyNoteLbl.Font = Enum.Font.SourceSansBold
            KeyNoteLbl.TextWrapped = true
            KeyNoteLbl.Parent = KeyGui
            yOffset = 95
        end

        local KeyBox = Instance.new("TextBox")
        KeyBox.Size = UDim2.new(1, -20, 0, 32)
        KeyBox.Position = UDim2.new(0, 10, 0, yOffset)
        KeyBox.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
        KeyBox.PlaceholderText = "Escribe tu clave aquí..."
        KeyBox.Text = ""
        KeyBox.TextColor3 = Color3.fromRGB(255, 255, 255)
        KeyBox.TextSize = 12
        KeyBox.Font = Enum.Font.SourceSans
        KeyBox.Parent = KeyGui

        local BoxCorner = Instance.new("UICorner")
        BoxCorner.CornerRadius = UDim.new(0, 4)
        BoxCorner.Parent = KeyBox

        local SubmitBtn = Instance.new("TextButton")
        SubmitBtn.Size = UDim2.new(0, 125, 0, 32)
        SubmitBtn.Position = UDim2.new(0, 10, 0, yOffset + 40)
        SubmitBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
        SubmitBtn.Text = "Verificar Clave"
        SubmitBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        SubmitBtn.TextSize = 12
        SubmitBtn.Font = Enum.Font.SourceSansBold
        SubmitBtn.Parent = KeyGui

        local SubCorner = Instance.new("UICorner")
        SubCorner.CornerRadius = UDim.new(0, 4)
        SubCorner.Parent = SubmitBtn

        local CopyBtn = Instance.new("TextButton")
        CopyBtn.Size = UDim2.new(0, 125, 0, 32)
        CopyBtn.Position = UDim2.new(0, 145, 0, yOffset + 40)
        CopyBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
        CopyBtn.Text = "Copiar Enlace"
        CopyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        CopyBtn.TextSize = 12
        CopyBtn.Font = Enum.Font.SourceSansBold
        CopyBtn.Parent = KeyGui

        local CopyCorner = Instance.new("UICorner")
        CopyCorner.CornerRadius = UDim.new(0, 4)
        CopyCorner.Parent = CopyBtn

        SubmitBtn.MouseButton1Click:Connect(function()
            if KeyBox.Text == correctKey then
                Library:Notify({Title = "¡Éxito!", Content = "Clave correcta. Bienvenido.", Duration = 3})
                KeyGui:Destroy()
                MainFrame.Visible = true
                ToggleUiBtn.Visible = true
            else
                Library:Notify({Title = "Error", Content = "Clave incorrecta.", Duration = 3})
            end
        end)

        CopyBtn.MouseButton1Click:Connect(function()
            if setclipboard then
                setclipboard(keyLink)
                Library:Notify({Title = "Copiado", Content = "Enlace copiado al portapapeles.", Duration = 3})
            else
                Library:Notify({Title = "Aviso", Content = "Tu ejecutor no soporta setclipboard.", Duration = 3})
            end
        end)
    end

    local Title = Instance.new("TextLabel")
    Title.Size = UDim2.new(1, -40, 0, subtitleText ~= "" and 18 or 24)
    Title.Position = UDim2.new(0, 10, 0, 4)
    Title.BackgroundTransparency = 1
    Title.Text = titleText
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.TextSize = 13
    Title.Font = Enum.Font.SourceSansBold
    Title.TextXAlignment = Enum.TextXAlignment.Left
    Title.Parent = MainFrame

    if subtitleText ~= "" then
        local SubtitleLbl = Instance.new("TextLabel")
        SubtitleLbl.Size = UDim2.new(1, -40, 0, 14)
        SubtitleLbl.Position = UDim2.new(0, 10, 0, 20)
        SubtitleLbl.BackgroundTransparency = 1
        SubtitleLbl.Text = subtitleText
        SubtitleLbl.TextColor3 = Color3.fromRGB(160, 160, 160)
        SubtitleLbl.TextSize = 10
        SubtitleLbl.Font = Enum.Font.SourceSans
        SubtitleLbl.TextXAlignment = Enum.TextXAlignment.Left
        SubtitleLbl.Parent = MainFrame
    end

    local CloseButton = Instance.new("TextButton")
    CloseButton.Size = UDim2.new(0, 22, 0, 22)
    CloseButton.Position = UDim2.new(1, -26, 0, 4)
    CloseButton.BackgroundColor3 = Color3.fromRGB(180, 40, 40)
    CloseButton.Text = "X"
    CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    CloseButton.TextSize = 12
    CloseButton.Parent = MainFrame

    local CornerClose = Instance.new("UICorner")
    CornerClose.CornerRadius = UDim.new(0, 4)
    CornerClose.Parent = CloseButton

    local tabbarY = subtitleText ~= "" and 38 or 30
    local TabBar = Instance.new("ScrollingFrame")
    TabBar.Size = UDim2.new(1, -16, 0, 30)
    TabBar.Position = UDim2.new(0, 8, 0, tabbarY)
    TabBar.BackgroundTransparency = 1
    TabBar.BorderSizePixel = 0
    TabBar.CanvasSize = UDim2.new(0, 0, 0, 0)
    TabBar.ScrollBarThickness = 3
    TabBar.Parent = MainFrame

    local TabListLayout = Instance.new("UIListLayout")
    TabListLayout.FillDirection = Enum.FillDirection.Horizontal
    TabListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    TabListLayout.Padding = UDim.new(0, 5)
    TabListLayout.Parent = TabBar

    TabListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        TabBar.CanvasSize = UDim2.new(0, TabListLayout.AbsoluteContentSize.X + 10, 0, 0)
    end)

    local pagesY = tabbarY + 35
    local PagesContainer = Instance.new("Frame")
    PagesContainer.Size = UDim2.new(1, -16, 1, -(pagesY + 6))
    PagesContainer.Position = UDim2.new(0, 8, 0, pagesY)
    PagesContainer.BackgroundTransparency = 1
    PagesContainer.Parent = MainFrame

    local isOpen = true
    ToggleUiBtn.MouseButton1Click:Connect(function()
        isOpen = not isOpen
        if isOpen then
            MainFrame.Visible = true
            MainFrame:TweenSizeAndPosition(UDim2.new(0, 280, 0, 340), UDim2.new(0.5, -140, 0.5, -170), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.25, true)
        else
            MainFrame:TweenSizeAndPosition(UDim2.new(0, 0, 0, 0), UDim2.new(0.5, 0, 0.5, 0), Enum.EasingDirection.In, Enum.EasingStyle.Quad, 0.2, true, function()
                MainFrame.Visible = false
            end)
        end
    end)

    CloseButton.MouseButton1Click:Connect(function()
        ScreenGui:Destroy()
    end)

    local Window = {}
    local firstTab = true

    function Window:AddTab(tabName)
        local TabButton = Instance.new("TextButton")
        TabButton.Size = UDim2.new(0, 85, 1, 0)
        TabButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
        TabButton.Text = tabName
        TabButton.TextColor3 = Color3.fromRGB(150, 150, 150)
        TabButton.TextSize = 11
        TabButton.Font = Enum.Font.SourceSansBold
        TabButton.Parent = TabBar

        local CornerTab = Instance.new("UICorner")
        CornerTab.CornerRadius = UDim.new(0, 4)
        CornerTab.Parent = TabButton

        local TabContent = Instance.new("ScrollingFrame")
        TabContent.Size = UDim2.new(1, 0, 1, 0)
        TabContent.BackgroundTransparency = 1
        TabContent.BorderSizePixel = 0
        TabContent.CanvasSize = UDim2.new(0, 0, 0, 0)
        TabContent.ScrollBarThickness = 4
        TabContent.Visible = false
        TabContent.Parent = PagesContainer

        local ContentLayout = Instance.new("UIListLayout")
        ContentLayout.SortOrder = Enum.SortOrder.LayoutOrder
        ContentLayout.Padding = UDim.new(0, 6)
        ContentLayout.Parent = TabContent

        ContentLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
            TabContent.CanvasSize = UDim2.new(0, 0, 0, ContentLayout.AbsoluteContentSize.Y + 10)
        end)

        if firstTab then
            firstTab = false
            TabContent.Visible = true
            TabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
            TabButton.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
        end

        TabButton.MouseButton1Click:Connect(function()
            for _, child in pairs(PagesContainer:GetChildren()) do
                if child:IsA("ScrollingFrame") then child.Visible = false end
            end
            for _, btn in pairs(TabBar:GetChildren()) do
                if btn:IsA("TextButton") then
                    TweenService:Create(btn, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(30, 30, 30), TextColor3 = Color3.fromRGB(150, 150, 150)}):Play()
                end
            end
            TabContent.Visible = true
            TweenService:Create(TabButton, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(45, 45, 45), TextColor3 = Color3.fromRGB(255, 255, 255)}):Play()
        end)

        local TabAPI = {}

        function TabAPI:AddHeader(text)
            local lbl = Instance.new("TextLabel")
            lbl.Size = UDim2.new(1, 0, 0, 20)
            lbl.BackgroundTransparency = 1
            lbl.Text = "  " .. text:upper()
            lbl.TextColor3 = Color3.fromRGB(150, 150, 150)
            lbl.TextSize = 10
            lbl.Font = Enum.Font.SourceSansBold
            lbl.TextXAlignment = Enum.TextXAlignment.Left
            lbl.Parent = TabContent
        end

        function TabAPI:AddLabel(text)
            local lbl = Instance.new("TextLabel")
            lbl.Size = UDim2.new(1, 0, 0, 25)
            lbl.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
            lbl.Text = "  " .. text
            lbl.TextColor3 = Color3.fromRGB(200, 200, 200)
            lbl.TextSize = 11
            lbl.Font = Enum.Font.SourceSans
            lbl.TextXAlignment = Enum.TextXAlignment.Left
            lbl.Parent = TabContent

            local Corner = Instance.new("UICorner")
            Corner.CornerRadius = UDim.new(0, 4)
            Corner.Parent = lbl

            local LabelAPI = {}
            function LabelAPI:SetText(newText)
                lbl.Text = "  " .. newText
            end
            return LabelAPI
        end

        function TabAPI:AddParagraph(title, content)
            local pFrame = Instance.new("Frame")
            pFrame.Size = UDim2.new(1, 0, 0, 55)
            pFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
            pFrame.BorderSizePixel = 0
            pFrame.Parent = TabContent

            local Corner = Instance.new("UICorner")
            Corner.CornerRadius = UDim.new(0, 4)
            Corner.Parent = pFrame

            local titleLbl = Instance.new("TextLabel")
            titleLbl.Size = UDim2.new(1, -10, 0, 20)
            titleLbl.Position = UDim2.new(0, 8, 0, 4)
            titleLbl.BackgroundTransparency = 1
            titleLbl.Text = title
            titleLbl.TextColor3 = Color3.fromRGB(255, 255, 255)
            titleLbl.TextSize = 12
            titleLbl.Font = Enum.Font.SourceSansBold
            titleLbl.TextXAlignment = Enum.TextXAlignment.Left
            titleLbl.Parent = pFrame

            local descLbl = Instance.new("TextLabel")
            descLbl.Size = UDim2.new(1, -10, 0, 25)
            descLbl.Position = UDim2.new(0, 8, 0, 24)
            descLbl.BackgroundTransparency = 1
            descLbl.Text = content
            descLbl.TextColor3 = Color3.fromRGB(180, 180, 180)
            descLbl.TextSize = 11
            descLbl.Font = Enum.Font.SourceSans
            descLbl.TextXAlignment = Enum.TextXAlignment.Left
            descLbl.TextWrapped = true
            descLbl.Parent = pFrame
        end

        function TabAPI:AddButton(text, callback)
            local Btn = Instance.new("TextButton")
            Btn.Size = UDim2.new(1, 0, 0, 32)
            Btn.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
            Btn.Text = "  " .. text
            Btn.TextColor3 = Color3.fromRGB(255, 255, 255)
            Btn.TextSize = 12
            Btn.Font = Enum.Font.SourceSans
            Btn.TextXAlignment = Enum.TextXAlignment.Left
            Btn.Parent = TabContent

            local Corner = Instance.new("UICorner")
            Corner.CornerRadius = UDim.new(0, 4)
            Corner.Parent = Btn

            Btn.MouseButton1Click:Connect(function() pcall(callback) end)
        end

        function TabAPI:AddToggle(text, defaultState, callback)
            local toggled = defaultState or false
            local ToggleBtn = Instance.new("TextButton")
            ToggleBtn.Size = UDim2.new(1, 0, 0, 32)
            ToggleBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
            ToggleBtn.Text = "  " .. text .. " [ " .. (toggled and "ON" or "OFF") .. " ]"
            ToggleBtn.TextColor3 = toggled and Color3.fromRGB(100, 255, 100) or Color3.fromRGB(255, 100, 100)
            ToggleBtn.TextSize = 12
            ToggleBtn.Font = Enum.Font.SourceSansBold
            ToggleBtn.TextXAlignment = Enum.TextXAlignment.Left
            ToggleBtn.Parent = TabContent

            local Corner = Instance.new("UICorner")
            Corner.CornerRadius = UDim.new(0, 4)
            Corner.Parent = ToggleBtn

            ToggleBtn.MouseButton1Click:Connect(function()
                toggled = not toggled
                ToggleBtn.Text = "  " .. text .. " [ " .. (toggled and "ON" or "OFF") .. " ]"
                ToggleBtn.TextColor3 = toggled and Color3.fromRGB(100, 255, 100) or Color3.fromRGB(255, 100, 100)
                pcall(function() callback(toggled) end)
            end)
        end

        function TabAPI:AddSlider(text, min, max, default, callback)
            local currentVal = default or min
            local SliderBg = Instance.new("Frame")
            SliderBg.Size = UDim2.new(1, 0, 0, 45)
            SliderBg.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
            SliderBg.BorderSizePixel = 0
            SliderBg.Parent = TabContent

            local Corner = Instance.new("UICorner")
            Corner.CornerRadius = UDim.new(0, 4)
            Corner.Parent = SliderBg

            local SliderText = Instance.new("TextLabel")
            SliderText.Size = UDim2.new(1, 0, 0, 20)
            SliderText.BackgroundTransparency = 1
            SliderText.Text = "  " .. text .. ": " .. tostring(currentVal)
            SliderText.TextColor3 = Color3.fromRGB(255, 255, 255)
            SliderText.TextSize = 12
            SliderText.Font = Enum.Font.SourceSans
            SliderText.TextXAlignment = Enum.TextXAlignment.Left
            SliderText.Parent = SliderBg

            local SliderBar = Instance.new("Frame")
            SliderBar.Size = UDim2.new(1, -20, 0, 6)
            SliderBar.Position = UDim2.new(0, 10, 0, 28)
            SliderBar.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
            SliderBar.BorderSizePixel = 0
            SliderBar.Parent = SliderBg

            local initialPercent = math.clamp((currentVal - min) / (max - min), 0, 1)
            local SliderFill = Instance.new("Frame")
            SliderFill.Size = UDim2.new(initialPercent, 0, 1, 0)
            SliderFill.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
            SliderFill.BorderSizePixel = 0
            SliderFill.Parent = SliderBar

            local dragging = false
            SliderBar.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                    dragging = true
                end
            end)

            UserInputService.InputEnded:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                    dragging = false
                end
            end)

            UserInputService.InputChanged:Connect(function(input)
                if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
                    local mousePos = input.Position.X
                    local barPos = SliderBar.AbsolutePosition.X
                    local barSize = SliderBar.AbsoluteSize.X
                    local percentage = math.clamp((mousePos - barPos) / barSize, 0, 1)
                    
                    SliderFill.Size = UDim2.new(percentage, 0, 1, 0)
                    currentVal = math.floor((min + (max - min) * percentage) * 10) / 10
                    SliderText.Text = "  " .. text .. ": " .. tostring(currentVal)
                    pcall(function() callback(currentVal) end)
                end
            end)
        end

        function TabAPI:AddTextbox(placeholder, callback)
            local TextBox = Instance.new("TextBox")
            TextBox.Size = UDim2.new(1, 0, 0, 32)
            TextBox.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
            TextBox.PlaceholderText = "  " .. placeholder
            TextBox.Text = ""
            TextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
            TextBox.TextSize = 12
            TextBox.Font = Enum.Font.SourceSans
            TextBox.ClearTextOnFocus = false
            TextBox.Parent = TabContent

            local Corner = Instance.new("UICorner")
            Corner.CornerRadius = UDim.new(0, 4)
            Corner.Parent = TextBox

            TextBox.FocusLost:Connect(function(enterPressed)
                if enterPressed then
                    pcall(function() callback(TextBox.Text) end)
                end
            end)
        end

        function TabAPI:AddDropdown(text, options, defaultOption, callback)
            local currentOption = defaultOption or options[1] or ""
            local isOpenDD = false

            local dropdownFrame = Instance.new("Frame")
            dropdownFrame.Size = UDim2.new(1, 0, 0, 32)
            dropdownFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
            dropdownFrame.BorderSizePixel = 0
            dropdownFrame.ClipsDescendants = true
            dropdownFrame.Parent = TabContent

            local Corner = Instance.new("UICorner")
            Corner.CornerRadius = UDim.new(0, 4)
            Corner.Parent = dropdownFrame

            local dropBtn = Instance.new("TextButton")
            dropBtn.Size = UDim2.new(1, 0, 0, 32)
            dropBtn.BackgroundTransparency = 1
            dropBtn.Text = "  " .. text .. ": " .. tostring(currentOption)
            dropBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
            dropBtn.TextSize = 12
            dropBtn.Font = Enum.Font.SourceSans
            dropBtn.TextXAlignment = Enum.TextXAlignment.Left
            dropBtn.Parent = dropdownFrame

            local optionsScroll = Instance.new("ScrollingFrame")
            optionsScroll.Size = UDim2.new(1, -10, 0, 0)
            optionsScroll.Position = UDim2.new(0, 5, 0, 35)
            optionsScroll.BackgroundTransparency = 1
            optionsScroll.BorderSizePixel = 0
            optionsScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
            optionsScroll.ScrollBarThickness = 3
            optionsScroll.Parent = dropdownFrame

            local optLayout = Instance.new("UIListLayout")
            optLayout.SortOrder = Enum.SortOrder.LayoutOrder
            optLayout.Padding = UDim.new(0, 4)
            optLayout.Parent = optionsScroll

            optLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
                optionsScroll.CanvasSize = UDim2.new(0, 0, 0, optLayout.AbsoluteContentSize.Y + 5)
            end)

            for _, opt in ipairs(options) do
                local optBtn = Instance.new("TextButton")
                optBtn.Size = UDim2.new(1, 0, 0, 26)
                optBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
                optBtn.Text = "  " .. tostring(opt)
                optBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
                optBtn.TextSize = 11
                optBtn.Font = Enum.Font.SourceSans
                optBtn.TextXAlignment = Enum.TextXAlignment.Left
                optBtn.Parent = optionsScroll

                local optCorner = Instance.new("UICorner")
                optCorner.CornerRadius = UDim.new(0, 3)
                optCorner.Parent = optBtn

                optBtn.MouseButton1Click:Connect(function()
                    currentOption = opt
                    dropBtn.Text = "  " .. text .. ": " .. tostring(currentOption)
                    isOpenDD = false
                    TweenService:Create(dropdownFrame, TweenInfo.new(0.2), {Size = UDim2.new(1, 0, 0, 32)}):Play()
                    pcall(function() callback(currentOption) end)
                end)
            end

            dropBtn.MouseButton1Click:Connect(function()
                isOpenDD = not isOpenDD
                local targetHeight = isOpenDD and math.clamp(optLayout.AbsoluteContentSize.Y + 45, 40, 130) or 32
                TweenService:Create(dropdownFrame, TweenInfo.new(0.2), {Size = UDim2.new(1, 0, 0, targetHeight)}):Play()
                optionsScroll.Size = UDim2.new(1, -10, 0, targetHeight - 38)
            end)
        end

        function TabAPI:AddKeybind(text, defaultKey, callback)
            local currentKey = defaultKey or Enum.KeyCode.E
            local binding = false

            local kbBtn = Instance.new("TextButton")
            kbBtn.Size = UDim2.new(1, 0, 0, 32)
            kbBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
            kbBtn.Text = "  " .. text
            kbBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
            kbBtn.TextSize = 12
            kbBtn.Font = Enum.Font.SourceSans
            kbBtn.TextXAlignment = Enum.TextXAlignment.Left
            kbBtn.Parent = TabContent

            local Corner = Instance.new("UICorner")
            Corner.CornerRadius = UDim.new(0, 4)
            Corner.Parent = kbBtn

            local valLbl = Instance.new("TextLabel")
            valLbl.Size = UDim2.new(0, 100, 1, 0)
            valLbl.Position = UDim2.new(1, -105, 0, 0)
            valLbl.BackgroundTransparency = 1
            valLbl.Text = "[" .. currentKey.Name .. "]"
            valLbl.TextColor3 = Color3.fromRGB(0, 170, 255)
            valLbl.TextSize = 12
            valLbl.Font = Enum.Font.SourceSansBold
            valLbl.TextXAlignment = Enum.TextXAlignment.Right
            valLbl.Parent = kbBtn

            kbBtn.MouseButton1Click:Connect(function()
                binding = true
                valLbl.Text = "[...]"
            end)

            UserInputService.InputBegan:Connect(function(input, gp)
                if binding then
                    if input.UserInputType == Enum.UserInputType.Keyboard then
                        currentKey = input.KeyCode
                        valLbl.Text = "[" .. currentKey.Name .. "]"
                        binding = false
                        pcall(function() callback(currentKey) end)
                    end
                else
                    if not gp and input.KeyCode == currentKey then
                        pcall(function() callback(currentKey) end)
                    end
                end
            end)
        end

        function TabAPI:AddColorPicker(text, defaultColor, callback)
            local color = defaultColor or Color3.fromRGB(255, 255, 255)
            local cpBtn = Instance.new("TextButton")
            cpBtn.Size = UDim2.new(1, 0, 0, 32)
            cpBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
            cpBtn.Text = "  " .. text
            cpBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
            cpBtn.TextSize = 12
            cpBtn.Font = Enum.Font.SourceSans
            cpBtn.TextXAlignment = Enum.TextXAlignment.Left
            cpBtn.Parent = TabContent

            local Corner = Instance.new("UICorner")
            Corner.CornerRadius = UDim.new(0, 4)
            Corner.Parent = cpBtn

            local preview = Instance.new("Frame")
            preview.Size = UDim2.new(0, 24, 0, 18)
            preview.Position = UDim2.new(1, -32, 0.5, -9)
            preview.BackgroundColor3 = color
            preview.Parent = cpBtn

            local prevCorner = Instance.new("UICorner")
            prevCorner.CornerRadius = UDim.new(0, 3)
            prevCorner.Parent = preview

            cpBtn.MouseButton1Click:Connect(function()
                local pickerGui = Instance.new("Frame")
                pickerGui.Size = UDim2.new(0, 280, 0, 155)
                pickerGui.Position = UDim2.new(0.5, -140, 0.5, -77)
                pickerGui.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
                pickerGui.BorderSizePixel = 0
                pickerGui.Active = true
                pickerGui.Parent = ScreenGui

                local pickerCorner = Instance.new("UICorner")
                pickerCorner.CornerRadius = UDim.new(0, 6)
                pickerCorner.Parent = pickerGui

                local pickerStroke = Instance.new("UIStroke")
                pickerStroke.Thickness = 1.5
                pickerStroke.Color = Color3.fromRGB(0, 170, 255)
                pickerStroke.Parent = pickerGui

                local titleL = Instance.new("TextLabel")
                titleL.Size = UDim2.new(1, -15, 0, 24)
                titleL.Position = UDim2.new(0, 10, 0, 6)
                titleL.BackgroundTransparency = 1
                titleL.Text = "Selector de Color (Arcoíris)"
                titleL.TextColor3 = Color3.fromRGB(255, 255, 255)
                titleL.TextSize = 12
                titleL.Font = Enum.Font.SourceSansBold
                titleL.TextXAlignment = Enum.TextXAlignment.Left
                titleL.Parent = pickerGui

                local previewPicker = Instance.new("Frame")
                previewPicker.Size = UDim2.new(0, 45, 0, 45)
                previewPicker.Position = UDim2.new(1, -55, 0, 38)
                previewPicker.BackgroundColor3 = color
                previewPicker.BorderSizePixel = 0
                previewPicker.Parent = pickerGui

                local ppCorner = Instance.new("UICorner")
                ppCorner.CornerRadius = UDim.new(0, 4)
                ppCorner.Parent = previewPicker

                -- Barra de espectro de colores
                local colorBar = Instance.new("Frame")
                colorBar.Size = UDim2.new(0, 200, 0, 45)
                colorBar.Position = UDim2.new(0, 10, 0, 38)
                colorBar.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                colorBar.BorderSizePixel = 0
                colorBar.Parent = pickerGui

                local cbCorner = Instance.new("UICorner")
                cbCorner.CornerRadius = UDim.new(0, 4)
                cbCorner.Parent = colorBar

                local colorsList = {
                    Color3.fromRGB(255, 0, 0),     -- Rojo
                    Color3.fromRGB(255, 255, 0),   -- Amarillo
                    Color3.fromRGB(0, 255, 0),     -- Verde
                    Color3.fromRGB(0, 255, 255),   -- Cian
                    Color3.fromRGB(0, 0, 255),     -- Azul
                    Color3.fromRGB(255, 0, 255),   -- Magenta
                    Color3.fromRGB(255, 0, 0)      -- Rojo final
                }

                local gradLayout = Instance.new("UIListLayout")
                gradLayout.FillDirection = Enum.FillDirection.Horizontal
                gradLayout.SortOrder = Enum.SortOrder.LayoutOrder
                gradLayout.Parent = colorBar

                for _, colVal in ipairs(colorsList) do
                    local strip = Instance.new("Frame")
                    strip.Size = UDim2.new(1/#colorsList, 0, 1, 0)
                    strip.BackgroundColor3 = colVal
                    strip.BorderSizePixel = 0
                    strip.Parent = colorBar
                end

                -- Obtener el valor de tono (Hue) inicial del color actual
                local initHue, _, _ = color:ToHSV()

                -- Indicador visual (círculo/cursor) sobre la barra de colores
                local pickerIndicator = Instance.new("Frame")
                pickerIndicator.Size = UDim2.new(0, 8, 1, 6)
                pickerIndicator.Position = UDim2.new(initHue, -4, 0, -3)
                pickerIndicator.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                pickerIndicator.BorderSizePixel = 0
                pickerIndicator.Parent = colorBar

                local piCorner = Instance.new("UICorner")
                piCorner.CornerRadius = UDim.new(1, 0)
                piCorner.Parent = pickerIndicator

                local piStroke = Instance.new("UIStroke")
                piStroke.Thickness = 2
                piStroke.Color = Color3.fromRGB(0, 0, 0)
                piStroke.Parent = pickerIndicator

                local tempColor = color
                local selecting = false

                local function updateColor(inputPos)
                    local absPos = colorBar.AbsolutePosition
                    local absSize = colorBar.AbsoluteSize
                    local relX = math.clamp((inputPos.X - absPos.X) / absSize.X, 0, 1)
                    
                    pickerIndicator.Position = UDim2.new(relX, -4, 0, -3)
                    tempColor = Color3.fromHSV(relX, 1, 1)
                    previewPicker.BackgroundColor3 = tempColor
                end

                colorBar.InputBegan:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                        selecting = true
                        updateColor(input.Position)
                    end
                end)

                UserInputService.InputEnded:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                        selecting = false
                    end
                end)

                UserInputService.InputChanged:Connect(function(input)
                    if selecting and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
                        updateColor(input.Position)
                    end
                end)

                local acceptBtn = Instance.new("TextButton")
                acceptBtn.Size = UDim2.new(0.5, -15, 0, 28)
                acceptBtn.Position = UDim2.new(0, 10, 1, -36)
                acceptBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
                acceptBtn.Text = "Aceptar"
                acceptBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
                acceptBtn.TextSize = 11
                acceptBtn.Font = Enum.Font.SourceSansBold
                acceptBtn.Parent = pickerGui

                local acCorner = Instance.new("UICorner")
                acCorner.CornerRadius = UDim.new(0, 4)
                acCorner.Parent = acceptBtn

                local cancelBtn = Instance.new("TextButton")
                cancelBtn.Size = UDim2.new(0.5, -15, 0, 28)
                cancelBtn.Position = UDim2.new(0.5, 5, 1, -36)
                cancelBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
                cancelBtn.Text = "Cancelar"
                cancelBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
                cancelBtn.TextSize = 11
                cancelBtn.Font = Enum.Font.SourceSansBold
                cancelBtn.Parent = pickerGui

                local ccCorner = Instance.new("UICorner")
                ccCorner.CornerRadius = UDim.new(0, 4)
                ccCorner.Parent = cancelBtn

                acceptBtn.MouseButton1Click:Connect(function()
                    color = tempColor
                    preview.BackgroundColor3 = color
                    pcall(function() callback(color) end)
                    pickerGui:Destroy()
                end)

                cancelBtn.MouseButton1Click:Connect(function()
                    pickerGui:Destroy()
                end)
            end)
        end

        return TabAPI
    end

    return Window
end

return Library
