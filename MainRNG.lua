-- ==========================================
-- DELTA CUSTOM UI LIBRARY (M4teoScripts)
-- ==========================================

local Library = {}
local CoreGui = game:GetService("CoreGui")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

function Library:CreateWindow(titleText)
    -- Evitar duplicados
    if CoreGui:FindFirstChild("DeltaCustomLib") then
        CoreGui.DeltaCustomLib:Destroy()
    end

    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "DeltaCustomLib"
    ScreenGui.Parent = CoreGui

    local MainFrame = Instance.new("Frame")
    MainFrame.Size = UDim2.new(0, 260, 0, 320)
    MainFrame.Position = UDim2.new(0.5, -130, 0.5, -160)
    MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    MainFrame.BorderSizePixel = 0
    MainFrame.Active = true
    MainFrame.Draggable = true
    MainFrame.Parent = ScreenGui

    -- Borde RGB Animado
    local UIStroke = Instance.new("UIStroke")
    UIStroke.Thickness = 2
    UIStroke.Parent = MainFrame

    task.spawn(function()
        while MainFrame.Parent do
            local hue = tick() % 5 / 5
            UIStroke.Color = Color3.fromHSV(hue, 1, 1)
            task.wait()
        end
    end)

    -- Barra Superior
    local Title = Instance.new("TextLabel")
    Title.Size = UDim2.new(1, 0, 0, 25)
    Title.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    Title.BorderSizePixel = 0
    Title.Text = "  " .. (titleText or "Delta Library")
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.TextSize = 12
    Title.Font = Enum.Font.SourceSansBold
    Title.TextXAlignment = Enum.TextXAlignment.Left
    Title.Parent = MainFrame

    -- Botones Minimizar y Cerrar
    local MinButton = Instance.new("TextButton")
    MinButton.Size = UDim2.new(0, 20, 0, 20)
    MinButton.Position = UDim2.new(1, -45, 0, 2.5)
    MinButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    MinButton.Text = "-"
    MinButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    MinButton.Parent = MainFrame

    local CloseButton = Instance.new("TextButton")
    CloseButton.Size = UDim2.new(0, 20, 0, 20)
    CloseButton.Position = UDim2.new(1, -22, 0, 2.5)
    CloseButton.BackgroundColor3 = Color3.fromRGB(180, 40, 40)
    CloseButton.Text = "X"
    CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    CloseButton.Parent = MainFrame

    -- Contenedor de Elementos con Scroll y Auto-Layout
    local ScrollFrame = Instance.new("ScrollingFrame")
    ScrollFrame.Size = UDim2.new(1, -10, 1, -35)
    ScrollFrame.Position = UDim2.new(0, 5, 0, 30)
    ScrollFrame.BackgroundTransparency = 1
    ScrollFrame.BorderSizePixel = 0
    ScrollFrame.ScrollBarThickness = 4
    ScrollFrame.Parent = MainFrame

    local UIListLayout = Instance.new("UIListLayout")
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    UIListLayout.Padding = UDim.new(0, 6)
    UIListLayout.Parent = ScrollFrame

    UIListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        ScrollFrame.CanvasSize = UDim2.new(0, 0, 0, UIListLayout.AbsoluteContentSize.Y + 10)
    end)

    -- Minimizar / Cerrar Lógica
    local minimized = false
    MinButton.MouseButton1Click:Connect(function()
        minimized = not minimized
        if minimized then
            MainFrame:TweenSize(UDim2.new(0, 260, 0, 25), "Out", "Quad", 0.2, true)
            ScrollFrame.Visible = false
            MinButton.Text = "+"
        else
            MainFrame:TweenSize(UDim2.new(0, 260, 0, 320), "Out", "Quad", 0.2, true)
            task.wait(0.1)
            ScrollFrame.Visible = true
            MinButton.Text = "-"
        end
    end)

    CloseButton.MouseButton1Click:Connect(function()
        ScreenGui:Destroy()
    end)

    -- TABLA DE OBJETOS DE LA VENTANA (API DE LA LIBRERÍA)
    local Window = {}

    -- 1. Agregar Sección / Título
    function Window:AddHeader(text)
        local Header = Instance.new("TextLabel")
        Header.Size = UDim2.new(1, 0, 0, 20)
        Header.BackgroundTransparency = 1
        Header.Text = "  " .. text:upper()
        Header.TextColor3 = Color3.fromRGB(150, 150, 150)
        Header.TextSize = 10
        Header.Font = Enum.Font.SourceSansBold
        Header.TextXAlignment = Enum.TextXAlignment.Left
        Header.Parent = ScrollFrame
    end

    -- 2. Agregar Botón
    function Window:AddButton(text, callback)
        local Btn = Instance.new("TextButton")
        Btn.Size = UDim2.new(1, 0, 0, 32)
        Btn.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
        Btn.Text = "  " .. text
        Btn.TextColor3 = Color3.fromRGB(255, 255, 255)
        Btn.TextSize = 12
        Btn.Font = Enum.Font.SourceSans
        Btn.TextXAlignment = Enum.TextXAlignment.Left
        Btn.Parent = ScrollFrame

        Btn.MouseButton1Click:Connect(function()
            pcall(callback)
        end)
    end

    -- 3. Agregar Interruptor (Toggle)
    function Window:AddToggle(text, defaultState, callback)
        local toggled = defaultState or false
        local ToggleBtn = Instance.new("TextButton")
        ToggleBtn.Size = UDim2.new(1, 0, 0, 32)
        ToggleBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
        ToggleBtn.Text = "  " .. text .. " [ " .. (toggled and "ON" or "OFF") .. " ]"
        ToggleBtn.TextColor3 = toggled and Color3.fromRGB(100, 255, 100) or Color3.fromRGB(255, 100, 100)
        ToggleBtn.TextSize = 12
        ToggleBtn.Font = Enum.Font.SourceSansBold
        ToggleBtn.TextXAlignment = Enum.TextXAlignment.Left
        ToggleBtn.Parent = ScrollFrame

        ToggleBtn.MouseButton1Click:Connect(function()
            toggled = not toggled
            ToggleBtn.Text = "  " .. text .. " [ " .. (toggled and "ON" or "OFF") .. " ]"
            ToggleBtn.TextColor3 = toggled and Color3.fromRGB(100, 255, 100) or Color3.fromRGB(255, 100, 100)
            pcall(function() callback(toggled) end)
        end)
    end

    -- 4. Agregar Slider Funcional
    function Window:AddSlider(text, min, max, default, callback)
        local currentVal = default or min
        local SliderBg = Instance.new("Frame")
        SliderBg.Size = UDim2.new(1, 0, 0, 45)
        SliderBg.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
        SliderBg.BorderSizePixel = 0
        SliderBg.Parent = ScrollFrame

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

    -- 5. Agregar Etiqueta de Texto (Estado)
    function Window:AddLabel(text)
        local lbl = Instance.new("TextLabel")
        lbl.Size = UDim2.new(1, 0, 0, 28)
        lbl.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
        lbl.Text = "  " .. text
        lbl.TextColor3 = Color3.fromRGB(200, 200, 200)
        lbl.TextSize = 11
        lbl.Font = Enum.Font.SourceSans
        lbl.TextXAlignment = Enum.TextXAlignment.Left
        lbl.Parent = ScrollFrame

        local LabelAPI = {}
        function LabelAPI:SetText(newText)
            lbl.Text = "  " .. newText
        end
        return LabelAPI
    end

    return Window
end

return Library
