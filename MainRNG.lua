local CoreGui = game:GetService("CoreGui")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

if CoreGui:FindFirstChild("DeltaMegaGui") then
    CoreGui.DeltaMegaGui:Destroy()
end

-- Contenedor Principal
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "DeltaMegaGui"
ScreenGui.Parent = CoreGui

-- Ventana Principal (260x340)
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 260, 0, 340)
MainFrame.Position = UDim2.new(0.5, -130, 0.5, -170)
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
Title.Text = "  Delta Ultimate Menu"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 12
Title.Font = Enum.Font.SourceSansBold
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = MainFrame

-- Botones Superior (-) y (X)
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

-- Contenedor con Scroll
local ScrollFrame = Instance.new("ScrollingFrame")
ScrollFrame.Size = UDim2.new(1, -10, 1, -35)
ScrollFrame.Position = UDim2.new(0, 5, 0, 30)
ScrollFrame.BackgroundTransparency = 1
ScrollFrame.BorderSizePixel = 0
ScrollFrame.CanvasSize = UDim2.new(0, 0, 0, 380)
ScrollFrame.ScrollBarThickness = 4
ScrollFrame.Parent = MainFrame

-- FUNCIÓN AUXILIAR: SECCIÓN
local function createHeader(text, yPos)
    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(1, 0, 0, 20)
    lbl.Position = UDim2.new(0, 0, 0, yPos)
    lbl.BackgroundTransparency = 1
    lbl.Text = "  " .. text:upper()
    lbl.TextColor3 = Color3.fromRGB(150, 150, 150)
    lbl.TextSize = 10
    lbl.Font = Enum.Font.SourceSansBold
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.Parent = ScrollFrame
end

-- 1. SECCIÓN: JUGADOR
createHeader("Configuración de Jugador", 5)

-- Toggle 1 (ESP / Godmode)
local Toggle1 = Instance.new("TextButton")
Toggle1.Size = UDim2.new(1, 0, 0, 32)
Toggle1.Position = UDim2.new(0, 0, 0, 25)
Toggle1.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
Toggle1.Text = "  GodMode [ OFF ]"
Toggle1.TextColor3 = Color3.fromRGB(255, 100, 100)
Toggle1.TextSize = 12
Toggle1.Font = Enum.Font.SourceSansBold
Toggle1.TextXAlignment = Enum.TextXAlignment.Left
Toggle1.Parent = ScrollFrame

local t1State = false
Toggle1.MouseButton1Click:Connect(function()
    t1State = not t1State
    Toggle1.Text = t1State and "  GodMode [ ON ]" or "  GodMode [ OFF ]"
    Toggle1.TextColor3 = t1State and Color3.fromRGB(100, 255, 100) or Color3.fromRGB(255, 100, 100)
end)

-- Slider Funcional (Velocidad)
local SliderBg = Instance.new("Frame")
SliderBg.Size = UDim2.new(1, 0, 0, 45)
SliderBg.Position = UDim2.new(0, 0, 0, 62)
SliderBg.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
SliderBg.BorderSizePixel = 0
SliderBg.Parent = ScrollFrame

local SliderText = Instance.new("TextLabel")
SliderText.Size = UDim2.new(1, 0, 0, 20)
SliderText.BackgroundTransparency = 1
SliderText.Text = "  Velocidad: 16"
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

local SliderFill = Instance.new("Frame")
SliderFill.Size = UDim2.new(0.16, 0, 1, 0)
SliderFill.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
SliderFill.BorderSizePixel = 0
SliderFill.Parent = SliderBar

-- Lógica del Slider Arrastrable
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
        local value = math.floor(percentage * 100)
        SliderText.Text = "  Velocidad: " .. value
        
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
            LocalPlayer.Character.Humanoid.WalkSpeed = value
        end
    end
end)

-- 2. SECCIÓN: EXTRAS
createHeader("Extras y Utilidades", 115)

-- Toggle 2
local Toggle2 = Instance.new("TextButton")
Toggle2.Size = UDim2.new(1, 0, 0, 32)
Toggle2.Position = UDim2.new(0, 0, 0, 135)
Toggle2.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
Toggle2.Text = "  Auto-Farm [ OFF ]"
Toggle2.TextColor3 = Color3.fromRGB(255, 100, 100)
Toggle2.TextSize = 12
Toggle2.Font = Enum.Font.SourceSansBold
Toggle2.TextXAlignment = Enum.TextXAlignment.Left
Toggle2.Parent = ScrollFrame

local t2State = false
Toggle2.MouseButton1Click:Connect(function()
    t2State = not t2State
    Toggle2.Text = t2State and "  Auto-Farm [ ON ]" or "  Auto-Farm [ OFF ]"
    Toggle2.TextColor3 = t2State and Color3.fromRGB(100, 255, 100) or Color3.fromRGB(255, 100, 100)
end)

-- Dropdown
local DropdownBtn = Instance.new("TextButton")
DropdownBtn.Size = UDim2.new(1, 0, 0, 32)
DropdownBtn.Position = UDim2.new(0, 0, 0, 172)
DropdownBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
DropdownBtn.Text = "  Modo de Juego v [ Normal ]"
DropdownBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
DropdownBtn.TextSize = 12
DropdownBtn.Font = Enum.Font.SourceSans
DropdownBtn.TextXAlignment = Enum.TextXAlignment.Left
DropdownBtn.Parent = ScrollFrame

local dropOpen = false
DropdownBtn.MouseButton1Click:Connect(function()
    dropOpen = not dropOpen
    DropdownBtn.Text = dropOpen and "  Modo de Juego ^ [ Pro ]" or "  Modo de Juego v [ Normal ]"
end)

-- TextBox
local TextBox = Instance.new("TextBox")
TextBox.Size = UDim2.new(1, 0, 0, 32)
TextBox.Position = UDim2.new(0, 0, 0, 209)
TextBox.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
TextBox.PlaceholderText = " Escribe un mensaje global..."
TextBox.Text = ""
TextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
TextBox.TextSize = 12
TextBox.Font = Enum.Font.SourceSans
TextBox.ClearTextOnFocus = false
TextBox.Parent = ScrollFrame

-- Lógica Minimizar
local minimized = false
MinButton.MouseButton1Click:Connect(function()
    minimized = not minimized
    if minimized then
        MainFrame:TweenSize(UDim2.new(0, 260, 0, 25), "Out", "Quad", 0.2, true)
        ScrollFrame.Visible = false
        MinButton.Text = "+"
    else
        MainFrame:TweenSize(UDim2.new(0, 260, 0, 340), "Out", "Quad", 0.2, true)
        task.wait(0.1)
        ScrollFrame.Visible = true
        MinButton.Text = "-"
    end
end)

-- Lógica Cerrar
CloseButton.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)
