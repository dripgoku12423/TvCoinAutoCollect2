local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")
local LocalPlayer = Players.LocalPlayer
local collectedCoins = {}
local isGuiVisible = true

-- Create GUI
local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local UICorner = Instance.new("UICorner")
local Title = Instance.new("TextLabel")
local Button = Instance.new("TextButton")
local ButtonCorner = Instance.new("UICorner")
local Notification = Instance.new("TextLabel")
local CloseButton = Instance.new("TextButton")
local CloseButtonCorner = Instance.new("UICorner")
local ShortcutLabel = Instance.new("TextLabel")
local CreditLabel = Instance.new("TextLabel")

-- Set up GUI hierarchy
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
Frame.Parent = ScreenGui
UICorner.Parent = Frame
Title.Parent = Frame
Button.Parent = Frame
ButtonCorner.Parent = Button
Notification.Parent = Frame
CloseButton.Parent = Frame
CloseButtonCorner.Parent = CloseButton
ShortcutLabel.Parent = Frame
CreditLabel.Parent = Frame

-- GUI Styling
ScreenGui.ResetOnSpawn = false

Frame.Size = UDim2.new(0, 350, 0, 200)
Frame.Position = UDim2.new(0.5, -175, 0.5, -100)
Frame.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
Frame.BorderSizePixel = 0
Frame.Active = true
Frame.Draggable = true -- Allow the GUI to be moved

UICorner.CornerRadius = UDim.new(0, 10) -- Rounded corners

Title.Size = UDim2.new(1, -20, 0.2, 0)
Title.Position = UDim2.new(0, 10, 0, 10)
Title.Text = "TvCoin AutoCollect"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextScaled = true
Title.BackgroundTransparency = 1
Title.Font = Enum.Font.GothamBold

Button.Size = UDim2.new(0.8, 0, 0.25, 0)
Button.Position = UDim2.new(0.1, 0, 0.35, 0)
Button.Text = "Collect All TvCoin"
Button.TextColor3 = Color3.fromRGB(255, 255, 255)
Button.TextScaled = true
Button.BackgroundColor3 = Color3.fromRGB(30, 136, 229)
Button.Font = Enum.Font.GothamBold
ButtonCorner.CornerRadius = UDim.new(0, 8)

Notification.Size = UDim2.new(0.8, 0, 0.2, 0)
Notification.Position = UDim2.new(0.1, 0, 0.7, 0)
Notification.Text = ""
Notification.TextColor3 = Color3.fromRGB(255, 255, 255)
Notification.TextScaled = true
Notification.BackgroundTransparency = 1
Notification.Font = Enum.Font.Gotham

CloseButton.Size = UDim2.new(0.15, 0, 0.15, 0)
CloseButton.Position = UDim2.new(0.85, -10, 0, 10)
CloseButton.Text = "X"
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.TextScaled = true
CloseButton.BackgroundColor3 = Color3.fromRGB(211, 47, 47)
CloseButton.Font = Enum.Font.GothamBold
CloseButtonCorner.CornerRadius = UDim.new(0, 8)

ShortcutLabel.Size = UDim2.new(0.4, 0, 0.1, 0)
ShortcutLabel.Position = UDim2.new(0.05, 0, 0.9, 0)
ShortcutLabel.Text = "Press K to Open GUI"
ShortcutLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
ShortcutLabel.TextScaled = true
ShortcutLabel.BackgroundTransparency = 1
ShortcutLabel.Font = Enum.Font.Gotham

CreditLabel.Size = UDim2.new(0.4, 0, 0.1, 0)
CreditLabel.Position = UDim2.new(0.55, 0, 0.9, 0)
CreditLabel.Text = "Credit: AveoVeva"
CreditLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
CreditLabel.TextScaled = true
CreditLabel.BackgroundTransparency = 1
CreditLabel.Font = Enum.Font.Gotham

-- TvCoin Collection Logic
local function collectCoins()
    local success = false
    local errorMessage = ""
    local map = Workspace:FindFirstChild("Map")
    if not map then
        errorMessage = "Map not found!"
        return success, errorMessage
    end

    for _, part in ipairs(map:GetDescendants()) do
        if part:IsA("BasePart") and part:FindFirstChild("TouchInterest") and not collectedCoins[part] then
            firetouchinterest(LocalPlayer.Character.HumanoidRootPart, part, 0)
            firetouchinterest(LocalPlayer.Character.HumanoidRootPart, part, 1)
            collectedCoins[part] = true
            success = true
        end
    end

    if not success then
        errorMessage = "No TvCoin found!"
    end

    return success, errorMessage
end

-- Button Functionality
Button.MouseButton1Click:Connect(function()
    local success, errorMessage = collectCoins()
    if success then
        Notification.Text = "All TvCoin collected successfully!"
        Notification.TextColor3 = Color3.fromRGB(76, 175, 80)
    else
        Notification.Text = errorMessage
        Notification.TextColor3 = Color3.fromRGB(211, 47, 47)
    end

    task.delay(3, function()
        Notification.Text = ""
    end)
end)

-- Close Button Functionality
CloseButton.MouseButton1Click:Connect(function()
    Frame.Visible = false
    isGuiVisible = false
end)

-- Reopen GUI with Key
UserInputService.InputBegan:Connect(function(input, isProcessed)
    if isProcessed then return end
    if input.KeyCode == Enum.KeyCode.K then
        isGuiVisible = not isGuiVisible
        Frame.Visible = isGuiVisible
    end
end)
