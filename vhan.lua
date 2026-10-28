-- Vhan Hub - Codium Style Edition
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local localPlayer = Players.LocalPlayer
local playerGui = localPlayer:WaitForChild("PlayerGui")

-- Hapus GUI lama jika ada
if playerGui:FindFirstChild("VhanCodiumHub") then
    playerGui.VhanCodiumHub:Destroy()
end

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "VhanCodiumHub"
screenGui.Parent = playerGui
screenGui.ResetOnSpawn = false

-- Frame Utama (Gaya Modern Dark ala Codium)
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Parent = screenGui
mainFrame.BackgroundColor3 = Color3.fromRGB(18, 18, 22)
mainFrame.Position = UDim2.new(0.5, -150, 0.3, 0)
mainFrame.Size = UDim2.new(0, 300, 0, 340)
mainFrame.Active = true
mainFrame.Draggable = true

-- Garis Atas / Aksen Warna
local accentBar = Instance.new("Frame")
accentBar.Parent = mainFrame
accentBar.BackgroundColor3 = Color3.fromRGB(120, 80, 255)
accentBar.Size = UDim2.new(1, 0, 0, 4)

-- Judul / Header Ala Codium
local titleLabel = Instance.new("TextLabel")
titleLabel.Parent = mainFrame
titleLabel.BackgroundColor3 = Color3.fromRGB(25, 25, 32)
titleLabel.Size = UDim2.new(1, 0, 0, 40)
titleLabel.Font = Enum.Font.GothamBold
titleLabel.Text = "  ⚡ Vhan.Hub | Steal an Egg"
titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
titleLabel.TextSize = 15
titleLabel.TextXAlignment = Enum.TextXAlignment.Left

-- Tombol Close (X) di Pojok Kanan Atas
local closeBtn = Instance.new("TextButton")
closeBtn.Parent = titleLabel
closeBtn.BackgroundColor3 = Color3.fromRGB(25, 25, 32)
closeBtn.Position = UDim2.new(1, -40, 0, 0)
closeBtn.Size = UDim2.new(0, 40, 0, 40)
closeBtn.Font = Enum.Font.GothamBold
closeBtn.Text = "X"
closeBtn.TextColor3 = Color3.fromRGB(180, 180, 180)
closeBtn.TextSize:eq and nil or (closeBtn.TextSize = 14)

closeBtn.MouseButton1Click:Connect(function()
    screenGui:Destroy()
end)

-- Container / Tempat Tombol Fitur
local container = Instance.new("ScrollingFrame")
container.Parent = mainFrame
container.BackgroundColor3 = Color3.fromRGB(18, 18, 22)
container.BorderSizePixel = 0
container.Position = UDim2.new(0, 0, 0, 50)
container.Size = UDim2.new(1, 0, 1, -50)
container.CanvasSize = UDim2.new(0, 0, 0, 380)
container.ScrollBarThickness = 4

local uiLayout = Instance.new("UIListLayout")
uiLayout.Parent = container
uiLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
uiLayout.SortOrder = Enum.SortOrder.LayoutOrder
uiLayout.Padding = UDim.new(0, 8)

-- Fungsi Pembuat Tombol Keren Ala Codium
local function addActionBtn(text, callback)
    local btn = Instance.new("TextButton")
    btn.Parent = container
    btn.BackgroundColor3 = Color3.fromRGB(32, 32, 42)
    btn.Size = UDim2.new(0, 270, 0, 38)
    btn.Font = Enum.Font.GothamSemibold
    btn.Text = "  " .. text
    btn.TextColor3 = Color3.fromRGB(220, 220, 220)
    btn.TextSize = 13
    btn.TextXAlignment = Enum.TextXAlignment.Left
    
    -- Efek sudut melengkung
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = btn
    
    btn.MouseButton1Click:Connect(callback)
    return btn
end

-- 1. Fitur Speed Boost
local isSpeedOn = false
addActionBtn("⚡ Speed Boost (Toggle)", function()
    isSpeedOn = not isSpeedOn
    local char = localPlayer.Character
    if char and char:FindFirstChild("Humanoid") then
        char.Humanoid.WalkSpeed = isSpeedOn and 50 or 16
    end
end)

-- 2. Fitur Super Jump
local isJumpOn = false
addActionBtn("🦘 Super Jump (Toggle)", function()
    isJumpOn = not isJumpOn
    local char = localPlayer.Character
    if char and char:FindFirstChild("Humanoid") then
        char.Humanoid.JumpPower = isJumpOn and 120 or 50
    end
end)

-- 3. Fitur Teleport Sarang
addActionBtn("📍 Teleport ke Sarang", function()
    local char = localPlayer.Character
    if char and char:FindFirstChild("HumanoidRootPart") then
        char.HumanoidRootPart.CFrame = CFrame.new(0, 30, 0)
    end
end)

-- 4. Fitur Infinite Jump
local isInfJumpOn = false
addActionBtn("🚀 Infinite Jump (Udara)", function()
    isInfJumpOn = not isInfJumpOn
end)

UserInputService.JumpRequest:Connect(function()
    if isInfJumpOn then
        local char = localPlayer.Character
        if char and char:FindFirstChildOfClass("Humanoid") then
            char:FindFirstChildOfClass("Humanoid"):ChangeState(Enum.HumanoidStateType.Jumping)
        end
    end
end)

-- 5. Fitur Noclip (Tembus Tembok)
local isNoclipOn = false
addActionBtn("👻 Noclip (Tembus Dinding)", function()
    isNoclipOn = not isNoclipOn
end)

RunService.Stepped:Connect(function()
    if isNoclipOn then
        local char = localPlayer.Character
        if char then
            for _, part in pairs(char:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = false
                end
            end
        end
    end
end)
