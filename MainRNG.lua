-- ==========================================
-- RNG HUB - DELTA EXECUTOR (M4teoScripts)
-- ==========================================

local Library = {}
local CoreGui = game:GetService("CoreGui")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

function Library:CreateWindow(titleText)
    if CoreGui:FindFirstChild("DeltaAdvancedLib") then
        CoreGui.DeltaAdvancedLib:Destroy()
    end

    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "DeltaAdvancedLib"
    ScreenGui.Parent = CoreGui

    -- Botón Flotante "UI" (Izquierda, Negro con RGB)
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
    ToggleUiBtn.Draggable = true
    ToggleUiBtn.Parent = ScreenGui

    local CornerBtn = Instance.new("UICorner")
    CornerBtn.CornerRadius = UDim.new(0, 8)
    CornerBtn.Parent = ToggleUiBtn

    local ToggleStroke = Instance.new("UIStroke")
    ToggleStroke.Thickness = 2
    ToggleStroke.Parent = ToggleUiBtn

    -- Ventana Principal (Inicia abierta para que la veas al instante)
    local MainFrame = Instance.new("Frame")
    MainFrame.Size = UDim2.new(0, 280, 0, 340)
    MainFrame.Position = UDim2.new(0.5, -140, 0.5, -170)
    MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    MainFrame.BorderSizePixel = 0
    MainFrame.Active = true
    MainFrame.Draggable = true
    MainFrame.ClipsDescendants = true
    MainFrame.Visible = true 
    MainFrame.Parent = ScreenGui

    local CornerMain = Instance.new("UICorner")
    CornerMain.CornerRadius = UDim.new(0, 6)
    CornerMain.Parent = MainFrame

    local UIStroke = Instance.new("UIStroke")
    UIStroke.Thickness = 2
    UIStroke.Parent = MainFrame

    -- Bucle RGB
    task.spawn(function()
        while ScreenGui.Parent do
            local hue = tick() % 5 / 5
            local rgbColor = Color3.fromHSV(hue, 1, 1)
            UIStroke.Color = rgbColor
            ToggleStroke.Color = rgbColor
            task.wait()
        end
    end)

    -- Barra Superior
    local Title = Instance.new("TextLabel")
    Title.Size = UDim2.new(1, -55, 0, 30)
    Title.Position = UDim2.new(0, 10, 0, 0)
    Title.BackgroundTransparency = 1
    Title.Text = titleText or "RNG Hub"
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.TextSize = 13
    Title.Font = Enum.Font.SourceSansBold
    Title.TextXAlignment = Enum.TextXAlignment.Left
    Title.Parent = MainFrame

    -- Botón Cerrar (X)
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

    -- Contenedor de Pestañas
    local TabBar = Instance.new("ScrollingFrame")
    TabBar.Size = UDim2.new(1, -16, 0, 30)
    TabBar.Position = UDim2.new(0, 8, 0, 35)
    TabBar.BackgroundTransparency = 1
    TabBar.BorderSizePixel = 0
    TabBar.CanvasSize = UDim2.new(0, 0, 0, 0)
    TabBar.ScrollBarThickness = 0
    TabBar.Parent = MainFrame

    local TabListLayout = Instance.new("UIListLayout")
    TabListLayout.FillDirection = Enum.FillDirection.Horizontal
    TabListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    TabListLayout.Padding = UDim.new(0, 5)
    TabListLayout.Parent = TabBar

    -- Contenedor de Páginas
    local PagesContainer = Instance.new("Frame")
    PagesContainer.Size = UDim2.new(1, -16, 1, -75)
    PagesContainer.Position = UDim2.new(0, 8, 0, 70)
    PagesContainer.BackgroundTransparency = 1
    PagesContainer.Parent = MainFrame

    -- Animación Botón UI
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

        return TabAPI
    end

    return Window
end

-- ==========================================
-- CREACIÓN DE LAS PESTAÑAS Y ELEMENTOS DENTRO DEL HUBS
-- ==========================================
local Window = Library:CreateWindow("RNG Hub Pro")

-- Pestaña 1
local MainTab = Window:AddTab("Principal")
MainTab:AddHeader("Automatización")
MainTab:AddToggle("Auto-Roll", false, function(state)
    print("Auto-Roll cambiado a:", state)
end)
MainTab:AddButton("Tirada Única", function()
    print("¡Tirada realizada con éxito!")
end)

-- Pestaña 2
local SettingsTab = Window:AddTab("Ajustes")
SettingsTab:AddHeader("Preferencias")
SettingsTab:AddToggle("Ocultar Animaciones", true, function(state)
    print("Animaciones ocultas:", state)
end)
