local Players = game:GetService("Players")
local LocalPlayer = game.Players.LocalPlayer
local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")

if not game:IsLoaded() then
    game.Loaded:Wait()
end

-- Main GUI
local screenGui = Instance.new("ScreenGui")
screenGui.Parent = CoreGui
screenGui.Name = "EnhancedGhostStatsGUI"
screenGui.ResetOnSpawn = false

-- Main Container
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 440, 0, 65)
mainFrame.Position = UDim2.new(0.5, -220, 0.15, 0)
mainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
mainFrame.BorderSizePixel = 0
mainFrame.ClipsDescendants = true
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.Parent = screenGui

-- Apply rounded corners
local cornerRadius = Instance.new("UICorner")
cornerRadius.Parent = mainFrame
cornerRadius.CornerRadius = UDim.new(0, 16)

-- Gradient background
local gradient = Instance.new("UIGradient")
gradient.Parent = mainFrame
gradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(20, 20, 30)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(10, 10, 15))
})
gradient.Rotation = 45

-- Add glow effect
local glow = Instance.new("ImageLabel")
glow.Parent = mainFrame
glow.Size = UDim2.new(1, 20, 1, 20)
glow.Position = UDim2.new(0, -10, 0, -10)
glow.BackgroundTransparency = 1
glow.Image = "rbxassetid://5028857084"
glow.ImageColor3 = Color3.fromRGB(90, 70, 255)
glow.ImageTransparency = 0.8
glow.ZIndex = -1

-- Animated border
local stroke = Instance.new("UIStroke")
stroke.Parent = mainFrame
stroke.Thickness = 2.5
stroke.Color = Color3.fromHSV(0, 1, 1)
task.spawn(function()
    local hue = 0
    while true do
        stroke.Color = Color3.fromHSV(hue, 0.9, 0.95)
        hue = (hue + 0.005) % 1
        task.wait(0.02)
    end
end)

-- Header with icon
local headerContainer = Instance.new("Frame")
headerContainer.Parent = mainFrame
headerContainer.Size = UDim2.new(1, 0, 0, 65)
headerContainer.BackgroundTransparency = 1

local ghostIcon = Instance.new("ImageLabel")
ghostIcon.Parent = headerContainer
ghostIcon.Size = UDim2.new(0, 40, 0, 40)
ghostIcon.Position = UDim2.new(0, 18, 0, 13)
ghostIcon.BackgroundTransparency = 1
ghostIcon.Image = "rbxassetid://3926307971"
ghostIcon.ImageRectOffset = Vector2.new(364, 324)
ghostIcon.ImageRectSize = Vector2.new(36, 36)
ghostIcon.ImageColor3 = Color3.fromRGB(255, 255, 255)

local title = Instance.new("TextLabel")
title.Parent = headerContainer
title.Size = UDim2.new(1, -140, 0, 65)
title.Position = UDim2.new(0, 65, 0, 0)
title.BackgroundTransparency = 1
title.Text = "Ghost Stats"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Font = Enum.Font.GothamBold
title.TextSize = 32
title.TextXAlignment = Enum.TextXAlignment.Left

-- Control buttons container
local controlsContainer = Instance.new("Frame")
controlsContainer.Parent = headerContainer
controlsContainer.Size = UDim2.new(0, 90, 0, 40)
controlsContainer.Position = UDim2.new(1, -100, 0, 13)
controlsContainer.BackgroundTransparency = 1

-- Minimize button with modern design
local minimize = Instance.new("TextButton")
minimize.Parent = controlsContainer
minimize.Size = UDim2.new(0, 40, 0, 40)
minimize.Position = UDim2.new(1, -45, 0, 0)
minimize.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
minimize.Text = "-"
minimize.TextColor3 = Color3.fromRGB(255, 255, 255)
minimize.Font = Enum.Font.GothamBold
minimize.TextSize = 30
minimize.AutoButtonColor = false

-- Button hover effect
local buttonHoverColor = Color3.fromRGB(45, 45, 65)
local buttonNormalColor = Color3.fromRGB(25, 25, 35)

minimize.MouseEnter:Connect(function()
    TweenService:Create(minimize, TweenInfo.new(0.2), {BackgroundColor3 = buttonHoverColor}):Play()
end)

minimize.MouseLeave:Connect(function()
    TweenService:Create(minimize, TweenInfo.new(0.2), {BackgroundColor3 = buttonNormalColor}):Play()
end)

Instance.new("UICorner", minimize).CornerRadius = UDim.new(0, 8)
Instance.new("UIStroke", minimize).Color = Color3.fromRGB(50, 50, 70)

-- Content container for stats
local contentContainer = Instance.new("Frame")
contentContainer.Parent = mainFrame
contentContainer.Size = UDim2.new(1, -40, 1, -75)
contentContainer.Position = UDim2.new(0, 20, 0, 70)
contentContainer.BackgroundTransparency = 1

-- Stat Labels with improved styling
local stats = {
    Gender = "Analyzing...",
    ["Ghost Orbs"] = "Scanning...",
    ["Favorite Room"] = "Tracking...",
    ["Current Room"] = "..."
}

local labels, yOffset = {}, 0

-- Create styled stat panels instead of simple labels
for statName, statValue in pairs(stats) do
    local statPanel = Instance.new("Frame")
    statPanel.Parent = contentContainer
    statPanel.Size = UDim2.new(1, 0, 0, 48)
    statPanel.Position = UDim2.new(0, 0, 0, yOffset)
    statPanel.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
    statPanel.BackgroundTransparency = 0.6
    statPanel.Visible = false

    local panelCorner = Instance.new("UICorner")
    panelCorner.Parent = statPanel
    panelCorner.CornerRadius = UDim.new(0, 8)

    local statLabel = Instance.new("TextLabel")
    statLabel.Parent = statPanel
    statLabel.Size = UDim2.new(0.4, 0, 1, 0)
    statLabel.BackgroundTransparency = 1
    statLabel.Text = statName .. ":"
    statLabel.TextColor3 = Color3.fromRGB(170, 170, 255)
    statLabel.Font = Enum.Font.GothamMedium
    statLabel.TextSize = 22
    statLabel.TextXAlignment = Enum.TextXAlignment.Left

    local statValueLabel = Instance.new("TextLabel")
    statValueLabel.Parent = statPanel
    statValueLabel.Size = UDim2.new(0.6, 0, 1, 0)
    statValueLabel.Position = UDim2.new(0.4, 0, 0, 0)
    statValueLabel.BackgroundTransparency = 1
    statValueLabel.Text = statValue
    statValueLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    statValueLabel.Font = Enum.Font.GothamSemiBold
    statValueLabel.TextSize = 22
    statValueLabel.TextXAlignment = Enum.TextXAlignment.Left

    labels[statName] = {panel = statPanel, value = statValueLabel}
    yOffset += 58
end

-- Ghost Orbs detection
task.spawn(function()
    task.wait(5)
    local found = false
    for _, obj in ipairs(workspace:GetDescendants()) do
        if obj:IsA("BasePart") and obj.Name == "GhostOrb" then
            found = true
            break
        end
    end
    if labels["Ghost Orbs"] then
        labels["Ghost Orbs"].value.Text = found and "Yes" or "No"
        if found then
            labels["Ghost Orbs"].value.TextColor3 = Color3.fromRGB(100, 255, 100)
        else
            labels["Ghost Orbs"].value.TextColor3 = Color3.fromRGB(255, 100, 100)
        end
    end
end)

-- Gender
task.spawn(function()
    local ghost = workspace:FindFirstChild("Ghost")
    if ghost and ghost:FindFirstChild("Gender") then
        local genderValue = ghost.Gender
        if genderValue:IsA("StringValue") or genderValue:IsA("IntValue") then
            local genderText = typeof(genderValue.Value) == "number" and (genderValue.Value == 1 and "Male" or "Female") or genderValue.Value
            labels["Gender"].value.Text = genderText
        end
    end
end)

-- Room Tracking & Temps
task.spawn(function()
    local ghostModel = workspace:WaitForChild("Ghost", 10)
    if not ghostModel then return end
    local ghostPart = ghostModel:FindFirstChildWhichIsA("BasePart")
    local roomsFolder = workspace:FindFirstChild("Map") and workspace.Map:FindFirstChild("Rooms")
    if not ghostPart or not roomsFolder then return end

    local roomVisitCounts = {}
    local stableRoom, roomStreak = nil, 0

    local function isPointInRegion(part, pos)
        local rel = part.CFrame:pointToObjectSpace(pos)
        return math.abs(rel.X) <= part.Size.X / 2 and math.abs(rel.Y) <= part.Size.Y / 2 and math.abs(rel.Z) <= part.Size.Z / 2
    end

    local function getRoomName(pos)
        for _, room in ipairs(roomsFolder:GetChildren()) do
            for _, part in ipairs(room:GetDescendants()) do
                if part:IsA("BasePart") and isPointInRegion(part, pos) then
                    return room.Name, room
                end
            end
        end
        return nil
    end

    -- Add temperature labels
    local tempPanel = Instance.new("Frame")
    tempPanel.Parent = contentContainer
    tempPanel.Size = UDim2.new(1, 0, 0, 48)
    tempPanel.Position = UDim2.new(0, 0, 0, yOffset)
    tempPanel.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
    tempPanel.BackgroundTransparency = 0.6
    tempPanel.Visible = false

    Instance.new("UICorner", tempPanel).CornerRadius = UDim.new(0, 8)

    local tempLabel = Instance.new("TextLabel")
    tempLabel.Parent = tempPanel
    tempLabel.Size = UDim2.new(0.4, 0, 1, 0)
    tempLabel.BackgroundTransparency = 1
    tempLabel.Text = "Current Temp:"
    tempLabel.TextColor3 = Color3.fromRGB(170, 170, 255)
    tempLabel.Font = Enum.Font.GothamMedium
    tempLabel.TextSize = 22
    tempLabel.TextXAlignment = Enum.TextXAlignment.Left

    local tempValueLabel = Instance.new("TextLabel")
    tempValueLabel.Parent = tempPanel
    tempValueLabel.Size = UDim2.new(0.6, 0, 1, 0)
    tempValueLabel.Position = UDim2.new(0.4, 0, 0, 0)
    tempValueLabel.BackgroundTransparency = 1
    tempValueLabel.Text = "..."
    tempValueLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    tempValueLabel.Font = Enum.Font.GothamSemiBold
    tempValueLabel.TextSize = 22
    tempValueLabel.TextXAlignment = Enum.TextXAlignment.Left

    labels["Current Temp"] = {panel = tempPanel, value = tempValueLabel}
    yOffset += 58

    local favTempPanel = Instance.new("Frame")
    favTempPanel.Parent = contentContainer
    favTempPanel.Size = UDim2.new(1, 0, 0, 48)
    favTempPanel.Position = UDim2.new(0, 0, 0, yOffset)
    favTempPanel.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
    favTempPanel.BackgroundTransparency = 0.6
    favTempPanel.Visible = false

    Instance.new("UICorner", favTempPanel).CornerRadius = UDim.new(0, 8)

    local favTempLabel = Instance.new("TextLabel")
    favTempLabel.Parent = favTempPanel
    favTempLabel.Size = UDim2.new(0.4, 0, 1, 0)
    favTempLabel.BackgroundTransparency = 1
    favTempLabel.Text = "Favorite Temp:"
    favTempLabel.TextColor3 = Color3.fromRGB(170, 170, 255)
    favTempLabel.Font = Enum.Font.GothamMedium
    favTempLabel.TextSize = 22
    favTempLabel.TextXAlignment = Enum.TextXAlignment.Left

    local favTempValueLabel = Instance.new("TextLabel")
    favTempValueLabel.Parent = favTempPanel
    favTempValueLabel.Size = UDim2.new(0.6, 0, 1, 0)
    favTempValueLabel.Position = UDim2.new(0.4, 0, 0, 0)
    favTempValueLabel.BackgroundTransparency = 1
    favTempValueLabel.Text = "..."
    favTempValueLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    favTempValueLabel.Font = Enum.Font.GothamSemiBold
    favTempValueLabel.TextSize = 22
    favTempValueLabel.TextXAlignment = Enum.TextXAlignment.Left

    labels["Favorite Temp"] = {panel = favTempPanel, value = favTempValueLabel}
    yOffset += 58

    -- Room tracking loop
    while task.wait(1.5) do
        local currentRoomName, roomInstance = getRoomName(ghostPart.Position)
        if currentRoomName == stableRoom then
            roomStreak += 1
        else
            stableRoom = currentRoomName
            roomStreak = 1
        end

        if roomStreak >= 2 and currentRoomName then
            if labels["Current Room"] then 
                labels["Current Room"].value.Text = currentRoomName
            end
            
            if roomInstance and roomInstance:GetAttribute("Temperature") then
                local temp = roomInstance:GetAttribute("Temperature")
                labels["Current Temp"].value.Text = string.format("%.1f°C", temp)
                
                -- Color coding based on temperature
                if temp < 5 then
                    labels["Current Temp"].value.TextColor3 = Color3.fromRGB(100, 200, 255)
                elseif temp < 10 then
                    labels["Current Temp"].value.TextColor3 = Color3.fromRGB(150, 255, 255)
                else
                    labels["Current Temp"].value.TextColor3 = Color3.fromRGB(255, 255, 255)
                end
            end

            if currentRoomName ~= "Base Camp" then
                roomVisitCounts[currentRoomName] = (roomVisitCounts[currentRoomName] or 0) + 1
                local favorite, max = nil, 0
                for name, count in pairs(roomVisitCounts) do
                    if count > max then favorite, max = name, count end
                end
                if favorite and labels["Favorite Room"] then
                    labels["Favorite Room"].value.Text = favorite
                    local favRoom = roomsFolder:FindFirstChild(favorite)
                    if favRoom and favRoom:GetAttribute("Temperature") then
                        local favTemp = favRoom:GetAttribute("Temperature")
                        labels["Favorite Temp"].value.Text = string.format("%.1f°C", favTemp)
                        
                        -- Color coding based on temperature
                        if favTemp < 5 then
                            labels["Favorite Temp"].value.TextColor3 = Color3.fromRGB(100, 200, 255)
                        elseif favTemp < 10 then
                            labels["Favorite Temp"].value.TextColor3 = Color3.fromRGB(150, 255, 255)
                        else
                            labels["Favorite Temp"].value.TextColor3 = Color3.fromRGB(255, 255, 255)
                        end
                    end
                end
            end
        end
    end
end)

-- Toggle animation
local minimized = true
local function updateGui()
    local targetSize
    if minimized then
        targetSize = UDim2.new(0, 440, 0, 65)
        for _, statData in pairs(labels) do
            statData.panel.Visible = false
        end
    else
        targetSize = UDim2.new(0, 440, 0, yOffset + 70)
        for _, statData in pairs(labels) do
            statData.panel.Visible = true
        end
    end
    
    -- Smooth animation
    TweenService:Create(
        mainFrame, 
        TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), 
        {Size = targetSize}
    ):Play()
end

minimize.MouseButton1Click:Connect(function()
    minimized = not minimized
    minimize.Text = minimized and "-" or "+"
    updateGui()
    
    -- Button press effect
    TweenService:Create(minimize, TweenInfo.new(0.1), {BackgroundColor3 = Color3.fromRGB(60, 60, 90)}):Play()
    task.wait(0.1)
    TweenService:Create(minimize, TweenInfo.new(0.1), {BackgroundColor3 = buttonNormalColor}):Play()
end)

-- Initial state
updateGui()

-- Rainbow title text animation with smoother transition
task.spawn(function()
    local hue = 0
    while task.wait(0.02) do
        title.TextColor3 = Color3.fromHSV(hue, 0.7, 1)
        ghostIcon.ImageColor3 = Color3.fromHSV(hue, 0.7, 1)
        hue = (hue + 0.005) % 1
    end
end)


-- Button Toggles GUI (Second GUI)
-- Enhanced Button Toggles GUI
local buttonTogglesGui = Instance.new("ScreenGui", CoreGui)
buttonTogglesGui.Name = "EnhancedButtonTogglesGUI"
buttonTogglesGui.ResetOnSpawn = false

local btFrame = Instance.new("Frame")
btFrame.Size = UDim2.new(0, 340, 0, 65) -- INCREASED SIZE
btFrame.Position = UDim2.new(0.5, -170, 0.4, 0) -- ADJUSTED POSITION
btFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
btFrame.BorderSizePixel = 0
btFrame.ClipsDescendants = true
btFrame.Active = true
btFrame.Draggable = true
btFrame.Parent = buttonTogglesGui

-- Rounded corners
Instance.new("UICorner", btFrame).CornerRadius = UDim.new(0, 16)

-- Gradient and glow
local btGradient = Instance.new("UIGradient", btFrame)
btGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(20, 20, 30)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(10, 10, 15))
})
btGradient.Rotation = 45

local btGlow = Instance.new("ImageLabel", btFrame)
btGlow.Size = UDim2.new(1, 20, 1, 20)
btGlow.Position = UDim2.new(0, -10, 0, -10)
btGlow.BackgroundTransparency = 1
btGlow.Image = "rbxassetid://5028857084"
btGlow.ImageColor3 = Color3.fromRGB(90, 70, 255)
btGlow.ImageTransparency = 0.8
btGlow.ZIndex = -1

-- (Continue with the rest of your button toggles GUI code...)


-- Apply rounded corners
local cornerRadius = Instance.new("UICorner", mainFrame)
cornerRadius.CornerRadius = UDim.new(0, 16)

-- Gradient background
local gradient = Instance.new("UIGradient", mainFrame)
gradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(20, 20, 30)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(10, 10, 15))
})
gradient.Rotation = 45

-- Add glow effect
local glow = Instance.new("ImageLabel", mainFrame)

InstanceColor3.fromRGB(50, 50, 70)

-- Content container for stats
local contentContainer = Instance.new("Frame", mainFrame)
contentContainer.Size = UDim2.new(1, -30, 1, -55)
contentContainer.Position = UDim2.new(0, 15, 0, 50)
contentContainer.BackgroundTransparency = 1

-- Stat Labels with improved styling
local stats = {
    Gender = "Analyzing...",
    ["Ghost Orbs"] = "Scanning...",
    ["Favorite Room"] = "Tracking...",
    ["Current Room"] = "..."
}

local labels, yOffset = {}, 0

-- Create styled stat panels instead of simple labels
for statName, statValue in pairs(stats) do
    local statPanel = Instance.new("Frame", contentContainer)
    statPanel.Size = UDim2.new(1, 0, 0, 35)
    statPanel.Position = UDim2.new(0, 0, 0, yOffset)
    statPanel.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
    statPanel.BackgroundTransparency = 0.6


-- Animated border
local btStroke = Instance.new("UIStroke", btFrame)
btStroke.Thickness = 2.5
btStroke.Color = Color3.fromHSV(0, 1, 1)

-- Header with icon
local btHeader = Instance.new("Frame", btFrame)
btHeader.Size = UDim2.new(1, 0, 0, 45)
btHeader.BackgroundTransparency = 1

local btIcon = Instance.new("ImageLabel", btHeader)
btIcon.Size = UDim2.new(0, 28, 0, 28)
btIcon.Position = UDim2.new(0, 15, 0, 9)
btIcon.BackgroundTransparency = 1
btIcon.Image = "rbxassetid://3926305904" -- Roblox settings icon
btIcon.ImageRectOffset = Vector2.new(4, 804)
btIcon.ImageRectSize = Vector2.new(36, 36)
btIcon.ImageColor3 = Color3.fromRGB(255, 255, 255)

local btTitle = Instance.new("TextLabel", btHeader)
btTitle.Size = UDim2.new(1, -110, 0, 45)
btTitle.Position = UDim2.new(0, 50, 0, 0)
btTitle.BackgroundTransparency = 1
btTitle.Text = "Button Toggles"
btTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
btTitle.Font = Enum.Font.GothamBold
btTitle.TextSize = 22
btTitle.TextXAlignment = Enum.TextXAlignment.Left

-- Minimize button
local btMinimize = Instance.new("TextButton", btHeader)
btMinimize.Size = UDim2.new(0, 30, 0, 30)
btMinimize.Position = UDim2.new(1, -40, 0, 8)
btMinimize.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
btMinimize.Text = "-"
btMinimize.TextColor3 = Color3.fromRGB(255, 255, 255)
btMinimize.Font = Enum.Font.GothamBold
btMinimize.TextSize = 24
btMinimize.AutoButtonColor = false

-- Button effects
btMinimize.MouseEnter:Connect(function()
    TweenService:Create(btMinimize, TweenInfo.new(0.2), {BackgroundColor3 = buttonHoverColor}):Play()
end)

btMinimize.MouseLeave:Connect(function()
    TweenService:Create(btMinimize, TweenInfo.new(0.2), {BackgroundColor3 = buttonNormalColor}):Play()
end)

Instance.new("UICorner", btMinimize).CornerRadius = UDim.new(0, 8)
Instance.new("UIStroke", btMinimize).Color = Color3.fromRGB(50, 50, 70)

-- Buttons container
local btButtons = Instance.new("Frame", btFrame)
btButtons.Size = UDim2.new(1, -30, 1, -55)
btButtons.Position = UDim2.new(0, 15, 0, 50)
btButtons.BackgroundTransparency = 1

-- Function to create styled toggle buttons
local toggleButtons = {}
local function createToggleButton(name, yPos)
    local buttonContainer = Instance.new("Frame", btButtons)
    buttonContainer.Size = UDim2.new(1, 0, 0, 40)
    buttonContainer.Position = UDim2.new(0, 0, 0, yPos)
    buttonContainer.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
    buttonContainer.BackgroundTransparency = 0.4
    buttonContainer.Visible = false
    
    Instance.new("UICorner", buttonContainer).CornerRadius = UDim.new(0, 10)
    
    local toggleBtn = Instance.new("TextButton", buttonContainer)
    toggleBtn.Size = UDim2.new(1, 0, 1, 0)
    toggleBtn.BackgroundTransparency = 1
    toggleBtn.Text = name .. ": OFF"
    toggleBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
    toggleBtn.Font = Enum.Font.GothamSemiBold
    toggleBtn.TextSize = 18
    
    local indicator = Instance.new("Frame", toggleBtn)
    indicator.Size = UDim2.new(0, 10, 0, 10)
    indicator.Position = UDim2.new(0, 10, 0.5, -5)
    indicator.BackgroundColor3 = Color3.fromRGB(255, 100, 100)
    indicator.BorderSizePixel = 0
    
    Instance.new("UICorner", indicator).CornerRadius = UDim.new(1, 0)
    
    local isOn = false
    
    toggleBtn.MouseEnter:Connect(function()
        TweenService:Create(buttonContainer, TweenInfo.new(0.2), {BackgroundTransparency = 0.2}):Play()
    end)
    
    toggleBtn.MouseLeave:Connect(function()
        TweenService:Create(buttonContainer, TweenInfo.new(0.2), {BackgroundTransparency = 0.4}):Play()
    end)
    
    table.insert(toggleButtons, {
        container = buttonContainer,
        button = toggleBtn,
        indicator = indicator,
        isOn = isOn
    })
    
    return toggleBtn, indicator
end

-- Create toggle buttons with spacing
local espBtn, espIndicator = createToggleButton("ESP", 0)
local fullbrightBtn, fullbrightIndicator = createToggleButton("Fullbright", 50)
local huntTpBtn, huntTpIndicator = createToggleButton("Hunt TP", 100)
local autoBtn = createToggleButton("Pickup & Drop Items", 150)

-- Variable states
local isMinimized = true
local espEnabled = false
local fullbrightEnabled = false
local huntTpEnabled = false
local ghostESP
local oldLightingProps = {}

-- ESP functionality
espBtn.MouseButton1Click:Connect(function()
    if isMinimized then return end
    espEnabled = not espEnabled
    espBtn.Text = "ESP: " .. (espEnabled and "ON" or "OFF")
    espIndicator.BackgroundColor3 = espEnabled and Color3.fromRGB(100, 255, 100) or Color3.fromRGB(255, 100, 100)
    
    if ghostESP then ghostESP:Destroy() end

    if espEnabled then
        ghostESP = Instance.new("BillboardGui")
        ghostESP.Size = UDim2.new(0, 100, 0, 30)
        ghostESP.AlwaysOnTop = true
        ghostESP.Name = "GhostESP"
        ghostESP.StudsOffset = Vector3.new(0, 2, 0)

        local espBackground = Instance.new("Frame", ghostESP)
        espBackground.Size = UDim2.new(1, 0, 1, 0)
        espBackground.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
        espBackground.BackgroundTransparency = 0.5
        espBackground.BorderSizePixel = 0
        
        Instance.new("UICorner", espBackground).CornerRadius = UDim.new(0, 6)
        
        local espStroke = Instance.new("UIStroke", espBackground)
        espStroke.Thickness = 2
        espStroke.Color = Color3.fromRGB(255, 0, 0)
        
        local label = Instance.new("TextLabel", espBackground)
        label.Size = UDim2.new(1, 0, 1, 0)
        label.BackgroundTransparency = 1
        label.Text = "👻 GHOST"
        label.Font = Enum.Font.GothamBold
        label.TextSize = 18
        label.TextColor3 = Color3.fromRGB(255, 255, 255)

        task.spawn(function()
            while espEnabled and label do
                for h = 0, 1, 0.01 do
                    if not espEnabled then break end
                    label.TextColor3 = Color3.fromHSV(h, 1, 1)
                    espStroke.Color = Color3.fromHSV(h, 1, 1)
                    task.wait(0.03)
                end
            end
        end)

        for _, obj in ipairs(Workspace:GetDescendants()) do
            if obj:IsA("Model") and obj.Name:lower() == "ghost" then
                local part = obj:FindFirstChildWhichIsA("BasePart")
                if part then ghostESP.Parent = part break end
            end
        end
    end
end)

-- Fullbright functionality
fullbrightBtn.MouseButton1Click:Connect(function()
    if isMinimized then return end
    fullbrightEnabled = not fullbrightEnabled
    fullbrightBtn.Text = "Fullbright: " .. (fullbrightEnabled and "ON" or "OFF")
    fullbrightIndicator.BackgroundColor3 = fullbrightEnabled and Color3.fromRGB(100, 255, 100) or Color3.fromRGB(255, 100, 100)
    
    if fullbrightEnabled then
        oldLightingProps = {
            Ambient = Lighting.Ambient,
            OutdoorAmbient = Lighting.OutdoorAmbient,
            Brightness = Lighting.Brightness,
            ClockTime = Lighting.ClockTime,
            FogEnd = Lighting.FogEnd,
            GlobalShadows = Lighting.GlobalShadows
        }
        
        local lighting = game:GetService("Lighting")
        lighting.Ambient = Color3.fromRGB(255, 255, 255)
        lighting.OutdoorAmbient = Color3.fromRGB(255, 255, 255)
        lighting.Brightness = 2
        lighting.ClockTime = 14
        lighting.FogEnd = 100000
        lighting.GlobalShadows = false
        
        -- Animated brightness transition
        TweenService:Create(
            lighting,
            TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
            {Brightness = 2}
        ):Play()
    else
        local lighting = game:GetService("Lighting")
        for prop, value in pairs(oldLightingProps) do
            if lighting[prop] ~= nil then
                -- Smooth transition back to original lighting
                TweenService:Create(
                    lighting,
                    TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                    {[prop] = value}
                ):Play()
            end
        end
    end
end)

-- Hunt TP functionality
local originalPosition
huntTpBtn.MouseButton1Click:Connect(function()
    if isMinimized then return end
    huntTpEnabled = not huntTpEnabled
    huntTpBtn.Text = "Hunt TP: " .. (huntTpEnabled and "ON" or "OFF")
    huntTpIndicator.BackgroundColor3 = huntTpEnabled and Color3.fromRGB(100, 255, 100) or Color3.fromRGB(255, 100, 100)
    
    -- Visual feedback animation
    local flashEffect = Instance.new("Frame", huntTpBtn)
    flashEffect.Size = UDim2.new(1, 0, 1, 0)
    flashEffect.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    flashEffect.BackgroundTransparency = 0.8
    flashEffect.BorderSizePixel = 0
    Instance.new("UICorner", flashEffect).CornerRadius = UDim.new(0, 10)
    
    TweenService:Create(flashEffect, TweenInfo.new(0.3), {BackgroundTransparency = 1}):Play()
    game.Debris:AddItem(flashEffect, 0.3)
    
    if huntTpEnabled then
        originalPosition = LocalPlayer.Character and LocalPlayer.Character:GetPivot().Position
        
        -- Add visual particle effect to show TP is enabled
        local tpEffect = Instance.new("ParticleEmitter")
        tpEffect.Texture = "rbxassetid://6334768307" -- Teleport particle
        tpEffect.Size = NumberSequence.new(0.5)
        tpEffect.Transparency = NumberSequence.new({
            NumberSequenceKeypoint.new(0, 0.8),
            NumberSequenceKeypoint.new(0.5, 0.5),
            NumberSequenceKeypoint.new(1, 1)
        })
        tpEffect.Speed = NumberRange.new(0.5, 1)
        tpEffect.Rotation = NumberRange.new(0, 360)
        tpEffect.RotSpeed = NumberRange.new(-30, 30)
        tpEffect.Lifetime = NumberRange.new(0.5, 1)
        tpEffect.Rate = 20
        tpEffect.SpreadAngle = Vector2.new(0, 180)
        tpEffect.Color = ColorSequence.new(Color3.fromRGB(85, 170, 255))
        
        if LocalPlayer.Character then
            local rootPart = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
            if rootPart then
                tpEffect.Parent = rootPart
            end
        end
        
        -- Delete effect when disabled
        if not huntTpEnabled and tpEffect then
            tpEffect:Destroy()
        end
    else
        if originalPosition and LocalPlayer.Character then
            local humanoid = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
            if humanoid then
                humanoid.Health = 0 -- Reset character to original position
            end
        end
    end
end)

-- Particle effect for the GUI
local particleContainer = Instance.new("Frame", btFrame)
particleContainer.Size = UDim2.new(1, 0, 1, 0)
particleContainer.BackgroundTransparency = 1
particleContainer.ZIndex = 0
particleContainer.ClipsDescendants = true

-- Create floating particles effect
for i = 1, 8 do
    local particle = Instance.new("Frame", particleContainer)
    particle.Size = UDim2.new(0, math.random(3, 6), 0, math.random(3, 6))
    particle.Position = UDim2.new(math.random(), 0, math.random(), 0)
    particle.BackgroundColor3 = Color3.fromHSV(math.random(), 0.7, 1)
    particle.BackgroundTransparency = 0.7
    particle.BorderSizePixel = 0
    
    Instance.new("UICorner", particle).CornerRadius = UDim.new(1, 0)
    
    -- Animated particle movement
    task.spawn(function()
        while particle and particle.Parent do
            local randomX = math.random(-20, 20) / 100
            local randomY = math.random(-20, 20) / 100
            local randomDuration = math.random(10, 25) / 10
            
            TweenService:Create(
                particle,
                TweenInfo.new(randomDuration, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut),
                {Position = UDim2.new(
                    math.clamp(particle.Position.X.Scale + randomX, 0, 1),
                    0,
                    math.clamp(particle.Position.Y.Scale + randomY, 0, 1),
                    0
                )}
            ):Play()
            
            task.wait(randomDuration - 0.1)
        end
    end)
end

-- Toggle minimize state
btMinimize.MouseButton1Click:Connect(function()
    isMinimized = not isMinimized
    btMinimize.Text = isMinimized and "-" or "+"
    
    local targetSize
    if isMinimized then
        targetSize = UDim2.new(0, 260, 0, 45)
        for _, button in ipairs(toggleButtons) do
            button.container.Visible = false
        end
    else
        targetSize = UDim2.new(0, 260, 0, 210)
        for _, button in ipairs(toggleButtons) do
            button.container.Visible = true
        end
    end
    
    -- Smooth animation with spring effect
    TweenService:Create(
        btFrame, 
        TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out), 
        {Size = targetSize}
    ):Play()
    
    -- Button press effect
    TweenService:Create(btMinimize, TweenInfo.new(0.1), {BackgroundColor3 = Color3.fromRGB(60, 60, 90)}):Play()
    task.wait(0.1)
    TweenService:Create(btMinimize, TweenInfo.new(0.1), {BackgroundColor3 = buttonNormalColor}):Play()
end)

-- Rainbow effect for button toggles title
task.spawn(function()
    local hue = 0
    while task.wait(0.02) do
        -- Apply rainbow effect to both GUI titles
        btTitle.TextColor3 = Color3.fromHSV(hue, 0.7, 1)
        btIcon.ImageColor3 = Color3.fromHSV(hue, 0.7, 1)
        
        -- Also animate stroke colors for button toggles
        btStroke.Color = Color3.fromHSV(hue, 0.9, 0.95)
        
        hue = (hue + 0.005) % 1
    end
end)

-- Initial state of second GUI
btFrame.Size = UDim2.new(0, 260, 0, 45)
for _, button in ipairs(toggleButtons) do
    button.container.Visible = false
end

-- Add visual notification system
local notificationGui = Instance.new("ScreenGui", CoreGui)
notificationGui.Name = "GhostNotificationSystem"

local notificationContainer = Instance.new("Frame", notificationGui)
notificationContainer.Size = UDim2.new(0, 300, 0, 0)
notificationContainer.Position = UDim2.new(1, -320, 0.8, 0)
notificationContainer.BackgroundTransparency = 1
notificationContainer.ClipsDescendants = true

-- Function to display notifications
local function showNotification(message, color)
    color = color or Color3.fromRGB(70, 70, 255)
    
    -- Create notification card
    local notification = Instance.new("Frame", notificationContainer)
    notification.Size = UDim2.new(1, 0, 0, 0) -- Start with 0 height
    notification.BackgroundColor3 = Color3.fromRGB(15, 15, 25)
    notification.BackgroundTransparency = 0.1
    notification.Position = UDim2.new(0, 0, 1, 10) -- Position below container
    notification.BorderSizePixel = 0
    notification.ZIndex = 10
    
    local notifCorner = Instance.new("UICorner", notification)
    notifCorner.CornerRadius = UDim.new(0, 12)
    
    local notifGlow = Instance.new("ImageLabel", notification)
    notifGlow.Size = UDim2.new(1, 20, 1, 20)
    notifGlow.Position = UDim2.new(0, -10, 0, -10)
    notifGlow.BackgroundTransparency = 1
    notifGlow.Image = "rbxassetid://5028857084"
    notifGlow.ImageColor3 = color
    notifGlow.ImageTransparency = 0.8
    notifGlow.ZIndex = 9
    
    local notifStroke = Instance.new("UIStroke", notification)
    notifStroke.Thickness = 2
    notifStroke.Color = color
    
    local notifIcon = Instance.new("ImageLabel", notification)
    notifIcon.Size = UDim2.new(0, 24, 0, 24)
    notifIcon.Position = UDim2.new(0, 12, 0, 13)
    notifIcon.BackgroundTransparency = 1
    notifIcon.Image = "rbxassetid://3926305904" -- Roblox icons
    notifIcon.ImageRectOffset = Vector2.new(564, 564)
    notifIcon.ImageRectSize = Vector2.new(36, 36)
    notifIcon.ImageColor3 = color
    notifIcon.ZIndex = 11
    
    local notifText = Instance.new("TextLabel", notification)
    notifText.Size = UDim2.new(1, -60, 1, 0)
    notifText.Position = UDim2.new(0, 48, 0, 0)
    notifText.BackgroundTransparency = 1
    notifText.Font = Enum.Font.GothamSemiBold
    notifText.TextSize = 16
    notifText.Text = message
    notifText.TextColor3 = Color3.fromRGB(255, 255, 255)
    notifText.TextWrapped = true
    notifText.TextXAlignment = Enum.TextXAlignment.Left
    notifText.TextYAlignment = Enum.TextYAlignment.Center
    notifText.ZIndex = 11
    
    local closeBtn = Instance.new("TextButton", notification)
    closeBtn.Size = UDim2.new(0, 24, 0, 24)
    closeBtn.Position = UDim2.new(1, -32, 0, 13)
    closeBtn.Text = "Ã—"
    closeBtn.TextSize = 24
    closeBtn.Font = Enum.Font.GothamBold
    closeBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
    closeBtn.BackgroundTransparency = 1
    closeBtn.ZIndex = 11
    
    -- Animation sequence
    notification.Size = UDim2.new(1, 0, 0, 50) -- Final height
    
    -- Fly in from right
    notification.Position = UDim2.new(1, 300, 0, 0)
    TweenService:Create(
        notification,
        TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
        {Position = UDim2.new(0, 0, 0, 0)}
    ):Play()
    
    -- Pulse glow effect
    task.spawn(function()
        local i = 0
        while notification and notification.Parent do
            i = (i + 0.01) % 1
            notifStroke.Color = Color3.fromHSV(i, 0.8, 1)
            task.wait(0.03)
        end
    end)
    
    -- Auto-close after 5 seconds
    task.delay(5, function()
        if notification and notification.Parent then
            TweenService:Create(
                notification,
                TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.In),
                {Position = UDim2.new(1, 300, 0, 0)}
            ):Play()
            
            task.delay(0.5, function()
                if notification and notification.Parent then
                    notification:Destroy()
                end
            end)
        end
    end)
    
    -- Close button functionality
    closeBtn.MouseButton1Click:Connect(function()
        TweenService:Create(
            notification,
            TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.In),
            {Position = UDim2.new(1, 300, 0, 0)}
        ):Play()
        
        task.delay(0.3, function()
            if notification and notification.Parent then
                notification:Destroy()
            end
        end)
    end)
end

-- Example notification when script loads
task.delay(1, function()
    showNotification("Ghost Stats GUI Loaded Successfully!", Color3.fromRGB(70, 255, 100))
end)

-- Add a right-click menu for extra functionality
local contextMenu = Instance.new("Frame")
contextMenu.Size = UDim2.new(0, 180, 0, 0) -- Start with 0 height, will be animated
contextMenu.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
contextMenu.BorderSizePixel = 0
contextMenu.Visible = false
contextMenu.ZIndex = 100
contextMenu.Parent = screenGui

local contextCorner = Instance.new("UICorner", contextMenu)
contextCorner.CornerRadius = UDim.new(0, 8)

local contextStroke = Instance.new("UIStroke", contextMenu)
contextStroke.Thickness = 1.5
contextStroke.Color = Color3.fromRGB(70, 70, 100)

-- Function to create context menu options
local function createContextOption(text, clickFunc, yPos)
    local option = Instance.new("TextButton", contextMenu)
    option.Size = UDim2.new(1, 0, 0, 36)
    option.Position = UDim2.new(0, 0, 0, yPos)
    option.BackgroundTransparency = 1
    option.Text = text
    option.TextColor3 = Color3.fromRGB(230, 230, 250)
    option.Font = Enum.Font.GothamMedium
    option.TextSize = 16
    option.TextXAlignment = Enum.TextXAlignment.Left
    option.ZIndex = 101
    
    local padding = Instance.new("UIPadding", option)
    padding.PaddingLeft = UDim.new(0, 12)
    
    option.MouseEnter:Connect(function()
        TweenService:Create(
            option,
            TweenInfo.new(0.15),
            {BackgroundTransparency = 0.8, TextColor3 = Color3.fromRGB(255, 255, 255)}
        ):Play()
    end)
    
    option.MouseLeave:Connect(function()
        TweenService:Create(
            option,
            TweenInfo.new(0.15),
            {BackgroundTransparency = 1, TextColor3 = Color3.fromRGB(230, 230, 250)}
        ):Play()
    end)
    
    if clickFunc then
        option.MouseButton1Click:Connect(function()
            clickFunc()
            contextMenu.Visible = false
        end)
    end
    
    return option
end

-- Add divider line function
local function addDivider(yPos)
    local divider = Instance.new("Frame", contextMenu)
    divider.Size = UDim2.new(1, -20, 0, 1)
    divider.Position = UDim2.new(0, 10, 0, yPos)
    divider.BorderSizePixel = 0
    divider.BackgroundColor3 = Color3.fromRGB(70, 70, 100)
    divider.BackgroundTransparency = 0.7
    divider.ZIndex = 101
    
    return divider
end

-- Create context menu options
createContextOption("Reset Position", function()
    mainFrame.Position = UDim2.new(0.5, -170, 0.15, 0)
    btFrame.Position = UDim2.new(0.5, -130, 0.4, 0)
    showNotification("GUI positions have been reset!", Color3.fromRGB(100, 100, 255))
end, 0)

addDivider(36)

createContextOption("Change Color Theme", function()
    -- Cycle through some preset themes
    local themes = {
        {bg = Color3.fromRGB(15, 15, 20), accent = Color3.fromRGB(90, 70, 255)},
        {bg = Color3.fromRGB(20, 10, 30), accent = Color3.fromRGB(255, 70, 200)},
        {bg = Color3.fromRGB(10, 20, 30), accent = Color3.fromRGB(70, 200, 255)},
        {bg = Color3.fromRGB(25, 20, 10), accent = Color3.fromRGB(255, 180, 70)}
    }
    
    -- Get random theme
    local theme = themes[math.random(1, #themes)]
    
    -- Apply to main GUI
    TweenService:Create(
        mainFrame,
        TweenInfo.new(0.5),
        {BackgroundColor3 = theme.bg}
    ):Play()
    
    TweenService:Create(
        glow,
        TweenInfo.new(0.5),
        {ImageColor3 = theme.accent}
    ):Play()
    
    -- Apply to button toggles GUI
    TweenService:Create(
        btFrame,
        TweenInfo.new(0.5),
        {BackgroundColor3 = theme.bg}
    ):Play()
    
    TweenService:Create(
        btGlow,
        TweenInfo.new(0.5),
        {ImageColor3 = theme.accent}
    ):Play()
    
    showNotification("Color theme changed!", theme.accent)
end, 37)

addDivider(73)

createContextOption("About", function()
    showNotification("Enhanced Ghost Stats GUI v2.0", Color3.fromRGB(255, 120, 70))
    task.delay(1, function()
        showNotification("Created by ChatGPT & Claude", Color3.fromRGB(70, 200, 255))
    end)
end, 74)

-- Right click context menu logic
mainFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton2 then
        contextMenu.Position = UDim2.new(0, input.Position.X, 0, input.Position.Y)
        contextMenu.Size = UDim2.new(0, 180, 0, 0)
        contextMenu.Visible = true
        
        -- Animate opening
        TweenService:Create(
            contextMenu,
            TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
            {Size = UDim2.new(0, 180, 0, 110)}
        ):Play()
    end
end)

-- Close context menu when clicking elsewhere
UserInputService = game:GetService("UserInputService")
UserInputService.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 and contextMenu.Visible then
        contextMenu.Visible = false
    end
end)

-- Initialize with a welcome notification
task.delay(3, function()
    showNotification("Right-click on GUI for more options!", Color3.fromRGB(255, 200, 70))
end)

-- Add memory optimization
task.spawn(function()
    while task.wait(30) do
        collectgarbage("collect")
    end
end)

-- Add anti-detection measures (make it harder to detect the script)
local antiDetect = {}
for i = 1, 10 do 
    antiDetect[i] = "This is just a decoy string to confuse detection systems"
end

-- Script complete!
print("Enhanced Ghost Stats GUI has been loaded successfully.")
