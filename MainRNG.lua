-- ==========================================
-- SCRIPT DE PRUEBA PARA RNG (Delta Executor)
-- Repositorio: m4teoscripts/RNG/MainRNG.lua
-- ==========================================

local CoreGui = game:GetService("CoreGui")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- Evitar duplicados si se ejecuta varias veces
if CoreGui:FindFirstChild("DeltaRNGTest") then
    CoreGui.DeltaRNGTest:Destroy()
end

-- Contenedor Principal
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "DeltaRNGTest"
ScreenGui.Parent = CoreGui

-- Ventana Principal (260x320)
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
Title.Text = "  RNG Test Menu - Delta"
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
ScrollFrame.CanvasSize = UDim2.new(0, 0, 0, 280)
ScrollFrame.ScrollBarThickness = 4
ScrollFrame.Parent = MainFrame

-- Función de ayuda para secciones
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

createHeader("Automatización RNG", 5)

-- 1. TOGGLE: Auto-Roll
local AutoRollBtn = Instance.new("TextButton")
AutoRollBtn.Size = UDim2.new(1, 0, 0, 35)
AutoRollBtn.Position = UDim2.new(0, 0, 0, 25)
AutoRollBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
AutoRollBtn.Text = "  Auto-Roll [ OFF ]"
AutoRollBtn.TextColor3 = Color3.fromRGB(255, 100, 100)
AutoRollBtn.TextSize = 12
AutoRollBtn.Font = Enum.Font.SourceSansBold
AutoRollBtn.TextXAlignment = Enum.TextXAlignment.Left
AutoRollBtn.Parent = ScrollFrame

-- 2. STATUS LABEL (Muestra el resultado de las tiradas simuladas)
local StatusLabel = Instance.new("TextLabel")
StatusLabel.Size = UDim2.new(1, 0, 0, 35)
StatusLabel.Position = UDim2.new(0, 0, 0, 65)
StatusLabel.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
StatusLabel.Text = "  Estado: Esperando inicio..."
StatusLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
StatusLabel.TextSize = 11
StatusLabel.Font = Enum.Font.SourceSans
StatusLabel.TextXAlignment = Enum.TextXAlignment.Left
StatusLabel.Parent = ScrollFrame

createHeader("Configuración de Ajustes", 105)

-- 3. SLIDER: Retardo de Tirada (Segundos)
local SliderBg = Instance.new("Frame")
SliderBg.Size = UDim2.new(1, 0, 0, 45)
SliderBg.Position = UDim2.new(0, 0, 0, 125)
SliderBg.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
SliderBg.BorderSizePixel = 0
SliderBg.Parent = ScrollFrame

local SliderText = Instance.new("TextLabel")
SliderText.Size = UDim2.new(1, 0, 0, 20)
SliderText.BackgroundTransparency = 1
SliderText.Text = "  Retardo (seg): 1.0"
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
SliderFill.Size = UDim2.new(0.5, 0, 1, 0)
SliderFill.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
SliderFill.BorderSizePixel = 0
SliderFill.Parent = SliderBar

-- Lógica del Slider
local rollDelay = 1.0
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
        rollDelay = math.floor((percentage * 2.0) * 10) / 10
        if rollDelay < 0.1 then rollDelay = 0.1 end
        SliderText.Text = "  Retardo (seg): " .. tostring(rollDelay)
    end
end)

-- 4. TEXTBOX: Filtro de Rareza opcional
local TextBox = Instance.new("TextBox")
TextBox.Size = UDim2.new(1, 0, 0, 35)
TextBox.Position = UDim2.new(0, 0, 0, 175)
TextBox.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
TextBox.PlaceholderText = " Filtrar rareza (Ej: Epic)..."
TextBox.Text = ""
TextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
TextBox.TextSize = 12
TextBox.Font = Enum.Font.SourceSans
TextBox.ClearTextOnFocus = false
TextBox.Parent = ScrollFrame

-- LÓGICA DE PRUEBA DEL RNG (Auto-Roll Loop)
local autoRollActive = false
local rollsCount = 0

AutoRollBtn.MouseButton1Click:Connect(function()
    autoRollActive = not autoRollActive
    if autoRollActive then
        AutoRollBtn.Text = "  Auto-Roll [ ON ]"
        AutoRollBtn.TextColor3 = Color3.fromRGB(100, 255, 100)
        
        task.spawn(function()
            local rarities = {"Common", "Uncommon", "Rare", "Epic", "Legendary", "Mythic"}
            while autoRollActive do
                rollsCount = rollsCount + 1
                local randomRoll = rarities[math.random(1, #rarities)]
                StatusLabel.Text = "  Tirada #" .. rollsCount .. ": [" .. randomRoll .. "]"
                task.wait(rollDelay)
            end
        end)
    else
        AutoRollBtn.Text = "  Auto-Roll [ OFF ]"
        AutoRollBtn.TextColor3 = Color3.fromRGB(255, 100, 100)
        StatusLabel.Text = "  Estado: Pausado."
    end
end)

-- Lógica Minimizar
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

-- Lógica Cerrar
CloseButton.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

print("¡Script de prueba RNG cargado con éxito en Delta!")
