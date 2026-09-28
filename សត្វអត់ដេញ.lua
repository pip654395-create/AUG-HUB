--==================================================
-- -- AUG HUB SAE
-- -- FULL CLIENT SCRIPT (KEY SYSTEM WITH 2 BUTTONS)
--==================================================

local Players = game:GetService("Players")
local ProximityPromptService = game:GetService("ProximityPromptService")
local TweenService = game:GetService("TweenService")
local SetClipboard = setclipboard or toclipboard or function() end

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

--==================================================
-- SETTINGS
--==================================================

local LogoId = "rbxassetid://YOUR_IMAGE_ASSET_ID"
local targetParent = (gethui and gethui()) or PlayerGui
local CORRECT_KEY = "AUG-47731"
local GET_KEY_URL = "https://bstshrt.com/u/aug3gf"
local KEY_FILE = "AugHub_Key.txt"

--==================================================
-- REMOVE OLD GUI
--==================================================

local oldGui = targetParent:FindFirstChild("AugHubGui")
if oldGui then
    oldGui:Destroy()
end

--==================================================
-- STATE
--==================================================

local AntiHitEnabled = false
local IsTeleporting = false
local IsMinimized = false
local CurrentScale = 1
local CurrentBackground = "Aura Red"

--==================================================
-- SCREEN GUI
--==================================================

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "AugHubGui"
screenGui.ResetOnSpawn = false
screenGui.IgnoreGuiInset = true
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
screenGui.Parent = targetParent

--==================================================
-- KEY SYSTEM FRAME
--==================================================

local keyFrame = Instance.new("Frame")
keyFrame.Name = "KeyFrame"
keyFrame.Size = UDim2.fromOffset(260, 190)
keyFrame.Position = UDim2.new(0.5, -130, 0.5, -95)
keyFrame.BackgroundColor3 = Color3.fromRGB(15, 5, 8)
keyFrame.BorderSizePixel = 0
keyFrame.Active = true
keyFrame.Draggable = true
keyFrame.ZIndex = 20
keyFrame.Visible = true
keyFrame.Parent = screenGui

local keyCorner = Instance.new("UICorner")
keyCorner.CornerRadius = UDim.new(0, 10)
keyCorner.Parent = keyFrame

local keyStroke = Instance.new("UIStroke")
keyStroke.Color = Color3.fromRGB(125, 10, 25)
keyStroke.Thickness = 1.5
keyStroke.Parent = keyFrame

local keyTitle = Instance.new("TextLabel")
keyTitle.Size = UDim2.new(1, -40, 0, 40)
keyTitle.BackgroundTransparency = 1
keyTitle.Text = "AUG HUB - KEY SYSTEM"
keyTitle.TextColor3 = Color3.fromRGB(255, 220, 225)
keyTitle.Font = Enum.Font.GothamBold
keyTitle.TextSize = 13
keyTitle.ZIndex = 21
keyTitle.Parent = keyFrame

-- ប៊ូតុង X នៅ Key System
local keyCloseBtn = Instance.new("TextButton")
keyCloseBtn.Size = UDim2.fromOffset(26, 26)
keyCloseBtn.Position = UDim2.new(1, -32, 0, 7)
keyCloseBtn.BackgroundColor3 = Color3.fromRGB(100, 10, 20)
keyCloseBtn.Text = "×"
keyCloseBtn.TextColor3 = Color3.new(1, 1, 1)
keyCloseBtn.Font = Enum.Font.GothamBold
keyCloseBtn.TextSize = 18
keyCloseBtn.ZIndex = 22
keyCloseBtn.AutoButtonColor = true
keyCloseBtn.Parent = keyFrame

local keyCloseCorner = Instance.new("UICorner")
keyCloseCorner.CornerRadius = UDim.new(0, 7)
keyCloseCorner.Parent = keyCloseBtn

local keyBox = Instance.new("TextBox")
keyBox.Size = UDim2.new(1, -24, 0, 34)
keyBox.Position = UDim2.fromOffset(12, 45)
keyBox.BackgroundColor3 = Color3.fromRGB(30, 7, 12)
keyBox.PlaceholderText = "Enter Key Here..."
keyBox.Text = ""
keyBox.TextColor3 = Color3.fromRGB(255, 255, 255)
keyBox.PlaceholderColor3 = Color3.fromRGB(150, 120, 125)
keyBox.Font = Enum.Font.Gotham
keyBox.TextSize = 12
keyBox.ZIndex = 21
keyBox.Parent = keyFrame

local boxCorner = Instance.new("UICorner")
boxCorner.CornerRadius = UDim.new(0, 7)
boxCorner.Parent = keyBox

local submitBtn = Instance.new("TextButton")
submitBtn.Size = UDim2.new(1, -24, 0, 30)
submitBtn.Position = UDim2.fromOffset(12, 85)
submitBtn.BackgroundColor3 = Color3.fromRGB(105, 10, 25)
submitBtn.Text = "SUBMIT"
submitBtn.TextColor3 = Color3.new(1, 1, 1)
submitBtn.Font = Enum.Font.GothamBold
submitBtn.TextSize = 11
submitBtn.ZIndex = 21
submitBtn.AutoButtonColor = true
submitBtn.Parent = keyFrame

local submitCorner = Instance.new("UICorner")
submitCorner.CornerRadius = UDim.new(0, 7)
submitCorner.Parent = submitBtn

local getKeyBtn = Instance.new("TextButton")
getKeyBtn.Size = UDim2.new(1, -24, 0, 30)
getKeyBtn.Position = UDim2.fromOffset(12, 122)
getKeyBtn.BackgroundColor3 = Color3.fromRGB(45, 10, 15)
getKeyBtn.Text = "GET KEY"
getKeyBtn.TextColor3 = Color3.fromRGB(255, 220, 225)
getKeyBtn.Font = Enum.Font.GothamBold
getKeyBtn.TextSize = 10
getKeyBtn.ZIndex = 21
getKeyBtn.AutoButtonColor = true
getKeyBtn.Parent = keyFrame

local getKeyCorner = Instance.new("UICorner")
getKeyCorner.CornerRadius = UDim.new(0, 7)
getKeyCorner.Parent = getKeyBtn

--==================================================
-- MAIN FRAME (Hidden until key is correct)
--==================================================

local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.fromOffset(240, 190)
mainFrame.Position = UDim2.new(0.5, -120, 0.5, -95)
mainFrame.BackgroundColor3 = Color3.fromRGB(15, 5, 8)
mainFrame.BorderSizePixel = 0
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.ZIndex = 10
mainFrame.Visible = false
mainFrame.Parent = screenGui

local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 10)
mainCorner.Parent = mainFrame

local mainStroke = Instance.new("UIStroke")
mainStroke.Color = Color3.fromRGB(125, 10, 25)
mainStroke.Thickness = 1.5
mainStroke.Parent = mainFrame

--==================================================
-- HEADER
--==================================================

local header = Instance.new("Frame")
header.Size = UDim2.new(1, 0, 0, 38)
header.BackgroundColor3 = Color3.fromRGB(30, 7, 12)
header.BorderSizePixel = 0
header.ZIndex = 11
header.Parent = mainFrame

local headerCorner = Instance.new("UICorner")
headerCorner.CornerRadius = UDim.new(0, 10)
headerCorner.Parent = header

local logo = Instance.new("ImageLabel")
logo.Size = UDim2.fromOffset(28, 28)
logo.Position = UDim2.fromOffset(7, 5)
logo.BackgroundTransparency = 1
logo.Image = LogoId
logo.ZIndex = 12
logo.Parent = header

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -95, 1, 0)
title.Position = UDim2.fromOffset(42, 0)
title.BackgroundTransparency = 1
title.Text = "AUG HUB"
title.TextColor3 = Color3.fromRGB(255, 220, 225)
title.Font = Enum.Font.GothamBold
title.TextSize = 14
title.TextXAlignment = Enum.TextXAlignment.Left
title.ZIndex = 12
title.Parent = header

local minimizeButton = Instance.new("TextButton")
minimizeButton.Size = UDim2.fromOffset(26, 26)
minimizeButton.Position = UDim2.new(1, -61, 0, 6)
minimizeButton.BackgroundColor3 = Color3.fromRGB(70, 10, 18)
minimizeButton.Text = "-"
minimizeButton.TextColor3 = Color3.new(1, 1, 1)
minimizeButton.Font = Enum.Font.GothamBold
minimizeButton.TextSize = 16
minimizeButton.ZIndex = 13
minimizeButton.Parent = header

local minimizeCorner = Instance.new("UICorner")
minimizeCorner.CornerRadius = UDim.new(0, 7)
minimizeCorner.Parent = minimizeButton

local closeButton = Instance.new("TextButton")
closeButton.Size = UDim2.fromOffset(26, 26)
closeButton.Position = UDim2.new(1, -32, 0, 6)
closeButton.BackgroundColor3 = Color3.fromRGB(100, 10, 20)
closeButton.Text = "×"
closeButton.TextColor3 = Color3.new(1, 1, 1)
closeButton.Font = Enum.Font.GothamBold
closeButton.TextSize = 18
closeButton.ZIndex = 13
closeButton.Parent = header

local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(0, 7)
closeCorner.Parent = closeButton

--==================================================
-- TABS
--==================================================

local mainTab = Instance.new("TextButton")
mainTab.Size = UDim2.fromOffset(112, 23)
mainTab.Position = UDim2.fromOffset(6, 43)
mainTab.BackgroundColor3 = Color3.fromRGB(105, 10, 25)
mainTab.Text = "MAIN"
mainTab.TextColor3 = Color3.new(1, 1, 1)
mainTab.Font = Enum.Font.GothamBold
mainTab.TextSize = 10
mainTab.ZIndex = 12
mainTab.Parent = mainFrame

local mainTabCorner = Instance.new("UICorner")
mainTabCorner.CornerRadius = UDim.new(0, 6)
mainTabCorner.Parent = mainTab

local miscTab = Instance.new("TextButton")
miscTab.Size = UDim2.fromOffset(112, 23)
miscTab.Position = UDim2.fromOffset(122, 43)
miscTab.BackgroundColor3 = Color3.fromRGB(45, 10, 15)
miscTab.Text = "MISC"
miscTab.TextColor3 = Color3.fromRGB(220, 180, 185)
miscTab.Font = Enum.Font.GothamBold
miscTab.TextSize = 10
miscTab.ZIndex = 12
miscTab.Parent = mainFrame

local miscTabCorner = Instance.new("UICorner")
miscTabCorner.CornerRadius = UDim.new(0, 6)
miscTabCorner.Parent = miscTab

--==================================================
-- CONTENT
--==================================================

local mainContent = Instance.new("Frame")
mainContent.Size = UDim2.new(1, -12, 1, -72)
mainContent.Position = UDim2.fromOffset(6, 70)
mainContent.BackgroundTransparency = 1
mainContent.ZIndex = 11
mainContent.Parent = mainFrame

local miscContent = Instance.new("Frame")
miscContent.Size = UDim2.new(1, -12, 1, -72)
miscContent.Position = UDim2.fromOffset(6, 70)
miscContent.BackgroundTransparency = 1
miscContent.Visible = false
miscContent.ZIndex = 11
miscContent.Parent = mainFrame

--==================================================
-- ANTI-HIT (MAIN FEATURE)
--==================================================

local antiHitBtn = Instance.new("TextButton")
antiHitBtn.Size = UDim2.new(1, 0, 0, 38)
antiHitBtn.Position = UDim2.fromOffset(0, 0)
antiHitBtn.BackgroundColor3 = Color3.fromRGB(55, 8, 15)
antiHitBtn.Text = "🛡 Anti-Hit : OFF"
antiHitBtn.TextColor3 = Color3.fromRGB(255, 220, 225)
antiHitBtn.Font = Enum.Font.GothamBold
antiHitBtn.TextSize = 11
antiHitBtn.ZIndex = 12
antiHitBtn.Parent = mainContent

local antiCorner = Instance.new("UICorner")
antiCorner.CornerRadius = UDim.new(0, 7)
antiCorner.Parent = antiHitBtn

--==================================================
-- MISC SETTINGS
--==================================================

local bgTitle = Instance.new("TextLabel")
bgTitle.Size = UDim2.new(1, 0, 0, 24)
bgTitle.BackgroundTransparency = 1
bgTitle.Text = "Background Style"
bgTitle.TextColor3 = Color3.fromRGB(255, 220, 225)
bgTitle.Font = Enum.Font.GothamBold
bgTitle.TextSize = 10
bgTitle.TextXAlignment = Enum.TextXAlignment.Left
bgTitle.ZIndex = 12
bgTitle.Parent = miscContent

local bgButton = Instance.new("TextButton")
bgButton.Size = UDim2.new(1, 0, 0, 32)
bgButton.Position = UDim2.fromOffset(0, 25)
bgButton.BackgroundColor3 = Color3.fromRGB(55, 8, 15)
bgButton.Text = "Aura Red"
bgButton.TextColor3 = Color3.fromRGB(255, 220, 225)
bgButton.Font = Enum.Font.GothamBold
bgButton.TextSize = 10
bgButton.ZIndex = 12
bgButton.Parent = miscContent

local bgCorner = Instance.new("UICorner")
bgCorner.CornerRadius = UDim.new(0, 7)
bgCorner.Parent = bgButton

local scaleTitle = Instance.new("TextLabel")
scaleTitle.Size = UDim2.new(1, 0, 0, 24)
scaleTitle.Position = UDim2.fromOffset(0, 64)
scaleTitle.BackgroundTransparency = 1
scaleTitle.Text = "GUI Scale"
scaleTitle.TextColor3 = Color3.fromRGB(255, 220, 225)
scaleTitle.Font = Enum.Font.GothamBold
scaleTitle.TextSize = 10
scaleTitle.TextXAlignment = Enum.TextXAlignment.Left
scaleTitle.ZIndex = 12
scaleTitle.Parent = miscContent

local scaleButton = Instance.new("TextButton")
scaleButton.Size = UDim2.new(1, 0, 0, 32)
scaleButton.Position = UDim2.fromOffset(0, 89)
scaleButton.BackgroundColor3 = Color3.fromRGB(55, 8, 15)
scaleButton.Text = "Scale: 100%"
scaleButton.TextColor3 = Color3.fromRGB(255, 220, 225)
scaleButton.Font = Enum.Font.GothamBold
scaleButton.TextSize = 10
scaleButton.ZIndex = 12
scaleButton.Parent = miscContent

local scaleCorner = Instance.new("UICorner")
scaleCorner.CornerRadius = UDim.new(0, 7)
scaleCorner.Parent = scaleButton

local scaleObject = Instance.new("UIScale")
scaleObject.Scale = 1
scaleObject.Parent = mainFrame

local function setScale(value)
    CurrentScale = value
    scaleObject.Scale = value
    scaleButton.Text = "Scale: " .. math.floor(value * 100) .. "%"
end

scaleButton.Activated:Connect(function()
    if CurrentScale == 1 then
        setScale(0.85)
    elseif CurrentScale == 0.85 then
        setScale(0.75)
    elseif CurrentScale == 0.75 then
        setScale(1.15)
    else
        setScale(1)
    end
end)

bgButton.Activated:Connect(function()
    if CurrentBackground == "Aura Red" then
        CurrentBackground = "Dark"
        mainFrame.BackgroundColor3 = Color3.fromRGB(8, 8, 10)
        bgButton.Text = "Dark"
    else
        CurrentBackground = "Aura Red"
        mainFrame.BackgroundColor3 = Color3.fromRGB(15, 5, 8)
        bgButton.Text = "Aura Red"
    end
end)

--==================================================
-- TABS MANAGEMENT
--==================================================

local function showMain()
    mainContent.Visible = true
    miscContent.Visible = false
    mainTab.BackgroundColor3 = Color3.fromRGB(105, 10, 25)
    miscTab.BackgroundColor3 = Color3.fromRGB(45, 10, 15)
end

local function showMisc()
    mainContent.Visible = false
    miscContent.Visible = true
    mainTab.BackgroundColor3 = Color3.fromRGB(45, 10, 15)
    miscTab.BackgroundColor3 = Color3.fromRGB(105, 10, 25)
end

mainTab.Activated:Connect(showMain)
miscTab.Activated:Connect(showMisc)

--==================================================
-- ANTI-HIT ROUTE
--==================================================

local TeleportPoints = {
    Vector3.new(500.62, 241.28, -366.64),
    Vector3.new(504.45, 155.80, -366.35),
    Vector3.new(508.30, 70.28, -366.03),
    Vector3.new(513.86, 70.28, -366.25),
    Vector3.new(519.43, 70.28, -366.47),
    Vector3.new(524.32, 70.28, -366.59),
    Vector3.new(529.22, 70.28, -366.71),
    Vector3.new(538.01, 70.28, -365.55),
    Vector3.new(546.80, 70.28, -364.40)
}

local ANTI_HIT_SPEED = 0.005

local loadingFrame = Instance.new("Frame")
loadingFrame.Size = UDim2.fromOffset(220, 75)
loadingFrame.Position = UDim2.new(0.5, -110, 0.5, -38)
loadingFrame.BackgroundColor3 = Color3.fromRGB(12, 5, 8)
loadingFrame.BorderSizePixel = 0
loadingFrame.Visible = false
loadingFrame.ZIndex = 100
loadingFrame.Parent = screenGui

local loadingCorner = Instance.new("UICorner")
loadingCorner.CornerRadius = UDim.new(0, 10)
loadingCorner.Parent = loadingFrame

local loadingStroke = Instance.new("UIStroke")
loadingStroke.Color = Color3.fromRGB(125, 10, 25)
loadingStroke.Thickness = 1.5
loadingStroke.Parent = loadingFrame

local loadingText = Instance.new("TextLabel")
loadingText.Size = UDim2.new(1, 0, 0, 30)
loadingText.Position = UDim2.fromOffset(0, 7)
loadingText.BackgroundTransparency = 1
loadingText.Text = "AUG TELEPORTING..."
loadingText.TextColor3 = Color3.fromRGB(255, 220, 225)
loadingText.Font = Enum.Font.GothamBold
loadingText.TextSize = 11
loadingText.ZIndex = 101
loadingText.Parent = loadingFrame

local loadingBarBack = Instance.new("Frame")
loadingBarBack.Size = UDim2.new(1, -24, 0, 8)
loadingBarBack.Position = UDim2.fromOffset(12, 48)
loadingBarBack.BackgroundColor3 = Color3.fromRGB(45, 10, 15)
loadingBarBack.BorderSizePixel = 0
loadingBarBack.ZIndex = 101
loadingBarBack.Parent = loadingFrame

local loadingBarCorner = Instance.new("UICorner")
loadingBarCorner.CornerRadius = UDim.new(1, 0)
loadingBarCorner.Parent = loadingBarBack

local loadingBar = Instance.new("Frame")
loadingBar.Size = UDim2.new(0, 0, 1, 0)
loadingBar.BackgroundColor3 = Color3.fromRGB(150, 10, 30)
loadingBar.BorderSizePixel = 0
loadingBar.ZIndex = 102
loadingBar.Parent = loadingBarBack

local loadingBarFillCorner = Instance.new("UICorner")
loadingBarFillCorner.CornerRadius = UDim.new(1, 0)
loadingBarFillCorner.Parent = loadingBar

local function StopTeleportLoading()
    IsTeleporting = false
    loadingBar.Size = UDim2.new(1, 0, 1, 0)
    loadingFrame.Visible = false
end

local function TeleportRoute(character)
    if not character then return end
    local root = character:FindFirstChild("HumanoidRootPart")
    if not root then return end

    IsTeleporting = true
    loadingFrame.Visible = true
    loadingBar.Size = UDim2.new(0, 0, 1, 0)

    for i, position in ipairs(TeleportPoints) do
        if not AntiHitEnabled then
            StopTeleportLoading()
            return
        end
        if not root.Parent then
            StopTeleportLoading()
            return
        end

        root.CFrame = CFrame.new(position)
        local progress = i / #TeleportPoints

        TweenService:Create(
            loadingBar,
            TweenInfo.new(ANTI_HIT_SPEED, Enum.EasingStyle.Linear),
            { Size = UDim2.new(progress, 0, 1, 0) }
        ):Play()

        task.wait(ANTI_HIT_SPEED)
    end

    StopTeleportLoading()
end

antiHitBtn.Activated:Connect(function()
    AntiHitEnabled = not AntiHitEnabled

    if AntiHitEnabled then
        antiHitBtn.Text = "🛡 Anti-Hit : ON"
        antiHitBtn.BackgroundColor3 = Color3.fromRGB(105, 10, 25)
    else
        antiHitBtn.Text = "🛡 Anti-Hit : OFF"
        antiHitBtn.BackgroundColor3 = Color3.fromRGB(55, 8, 15)

        if IsTeleporting then
            StopTeleportLoading()
        end
    end
end)

ProximityPromptService.PromptTriggered:Connect(function(prompt, player)
    if player ~= LocalPlayer then return end
    if not AntiHitEnabled then return end
    if IsTeleporting then return end

    local character = LocalPlayer.Character
    if not character then return end

    task.spawn(function()
        TeleportRoute(character)
    end)
end)

--==================================================
-- MINIMIZE / MAXIMIZE SYSTEM (- / +)
--==================================================

minimizeButton.Activated:Connect(function()
    IsMinimized = not IsMinimized

    if IsMinimized then
        minimizeButton.Text = "+"
        mainTab.Visible = false
        miscTab.Visible = false
        mainContent.Visible = false
        miscContent.Visible = false
        mainFrame.Size = UDim2.fromOffset(240, 38)
    else
        minimizeButton.Text = "-"
        mainTab.Visible = true
        miscTab.Visible = true
        mainFrame.Size = UDim2.fromOffset(240, 190)
        if mainTab.BackgroundColor3 == Color3.fromRGB(105, 10, 25) then
            mainContent.Visible = true
        else
            miscContent.Visible = true
        end
    end
end)

--==================================================
-- CLOSE GUI
--==================================================

closeButton.Activated:Connect(function()
    screenGui.Enabled = false
end)

--==================================================
-- KEY SYSTEM LOGIC
--==================================================

local function saveKey()
    pcall(function()
        if writefile then
            writefile(KEY_FILE, CORRECT_KEY)
        end
    end)
end

local function hasValidSavedKey()
    local success, result = pcall(function()
        if type(isfile) == "function" and isfile(KEY_FILE) then
            return readfile(KEY_FILE)
        end
        return nil
    end)
    return success and result == CORRECT_KEY
end

-- ប៊ូតុង X នៅ Key System (បិទ GUI)
keyCloseBtn.MouseButton1Click:Connect(function()
    screenGui.Enabled = false
end)
keyCloseBtn.Activated:Connect(function()
    screenGui.Enabled = false
end)

-- ប៊ូតុង Submit
local function onSubmit()
    if keyBox.Text == CORRECT_KEY then
        saveKey()
        keyFrame.Visible = false
        keyFrame:Destroy()
        mainFrame.Visible = true
        showMain()
        print("[AUG] Hub loaded successfully with valid key.")
    else
        submitBtn.Text = "INVALID KEY!"
        submitBtn.BackgroundColor3 = Color3.fromRGB(150, 20, 20)
        task.wait(1.5)
        submitBtn.Text = "SUBMIT"
        submitBtn.BackgroundColor3 = Color3.fromRGB(105, 10, 25)
    end
end

submitBtn.MouseButton1Click:Connect(onSubmit)
submitBtn.Activated:Connect(onSubmit)

-- ប៊ូតុង Get Key
local function onGetKey()
    pcall(function()
        SetClipboard(GET_KEY_URL)
    end)
    getKeyBtn.Text = "LINK COPIED!"
    task.wait(1.5)
    getKeyBtn.Text = "GET KEY"
end

getKeyBtn.MouseButton1Click:Connect(onGetKey)
getKeyBtn.Activated:Connect(onGetKey)

-- ពិនិត្យ Key រក្សាទុក
if hasValidSavedKey() then
    keyFrame.Visible = false
    keyFrame:Destroy()
    mainFrame.Visible = true
    showMain()
    print("[AUG] Hub loaded with saved key.")
end
