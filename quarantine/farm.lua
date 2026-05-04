--[[
Inert commented archive file.
No executable Lua is present below; every preserved source line is prefixed with --.
Role: Farm, collection, safe/register ESP, lockpick scale, stamina and farm UI blocks
Original source line ranges: 2359-2754, 3302-3388, 7455-7491
]]


-- BEGIN ORIGINAL SOURCE LINES 2359-2754
-- ==================== HOBЫE ФYHKЦИИ: SAFE ESP ====================
--
local function createHighlight(obj, objName, isRegister)
    local highlights = isRegister and S.SafeESP.RegisterHighlights or S.SafeESP.Highlights
    local billboards = isRegister and S.SafeESP.RegisterBillboards or S.SafeESP.Billboards
--
    if highlights[objName] then highlights[objName]:Destroy() end
    if billboards[objName] then billboards[objName]:Destroy() end
--
    local highlight = Instance.new("Highlight")
    highlight.Parent = game:GetService("CoreGui")
    highlight.Adornee = obj
    highlight.FillTransparency = 0.7
    highlight.OutlineTransparency = 1
    highlights[objName] = highlight
--
    local billboard = Instance.new("BillboardGui")
    billboard.Name = isRegister and "RegisterInfo" or "SafeInfo"
    billboard.Adornee = obj
    billboard.Size = UDim2.new(0, 200, 0, 60)
    billboard.StudsOffset = Vector3.new(0, 6, 0)
    billboard.AlwaysOnTop = true
    billboard.Parent = game:GetService("CoreGui")
--
    local textLabel = Instance.new("TextLabel")
    textLabel.Size = UDim2.new(1, 0, 1, 0)
    textLabel.BackgroundTransparency = 1
    textLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    textLabel.TextStrokeTransparency = 0
    textLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
    textLabel.TextSize = 10
    textLabel.TextScaled = false
    textLabel.Font = Enum.Font.GothamBold
    textLabel.Parent = billboard
--
    billboards[objName] = billboard
--
    obj.AncestryChanged:Connect(function()
        if not obj:IsDescendantOf(workspace) then
            if highlights[objName] then highlights[objName].Enabled = false end
            if billboards[objName] then billboards[objName].Enabled = false end
        end
    end)
end
--
local function setupSafeESP()
    if S.SafeESP.Coroutine then return end
--
    S.SafeESP.LastUpdateTime = tick()
    S.SafeESP.Coroutine = coroutine.create(function()
        while S.SafeESP.On do
            local delta = tick() - S.SafeESP.LastUpdateTime
            S.SafeESP.LastUpdateTime = tick()
--
            for _, safeName in ipairs(SafeNames) do
                local success, safe = pcall(function()
                    return workspace.Map.BredMakurz:FindFirstChild(safeName)
                end)
--
                if not success or not safe then
                    if S.SafeESP.Highlights[safeName] then S.SafeESP.Highlights[safeName].Enabled = false end
                    if S.SafeESP.Billboards[safeName] then S.SafeESP.Billboards[safeName].Enabled = false end
                    continue
                end
--
                local adornee = safe
                local skip = false
--
                if safeName == "SmallSafe_M_17" then
                    local canHit = safe:FindFirstChild("CanHit")
                    local isOpen = canHit and canHit.Value == true
                    if isOpen then
                        if S.SafeESP.Highlights[safeName] then S.SafeESP.Highlights[safeName].Enabled = false end
                        if S.SafeESP.Billboards[safeName] then S.SafeESP.Billboards[safeName].Enabled = false end
                        skip = true
                    else
                        local mainPart = safe:FindFirstChild("MainPart") or safe
                        adornee = mainPart
                        if not S.SafeESP.Highlights[safeName] or not S.SafeESP.Highlights[safeName].Parent then
                            createHighlight(mainPart, safeName, false)
                        end
                        if S.SafeESP.Highlights[safeName] then
                            S.SafeESP.Highlights[safeName].Adornee = mainPart
                            S.SafeESP.Highlights[safeName].Enabled = true
                        end
                    end
                else
                    if not S.SafeESP.Highlights[safeName] or not S.SafeESP.Highlights[safeName].Parent then
                        createHighlight(adornee, safeName, false)
                    end
                    if S.SafeESP.Highlights[safeName] then
                        S.SafeESP.Highlights[safeName].Adornee = adornee
                        S.SafeESP.Highlights[safeName].Enabled = true
                    end
                end
--
                local billboard = S.SafeESP.Billboards[safeName]
                if billboard and billboard.Parent then
                    billboard.Adornee = adornee
                    if not S.SafeESP.FrozenPositions[safeName] then
                        billboard.StudsOffset = Vector3.new(0, 6, 0)
                    end
                    billboard.Enabled = true
                end
--
                if skip then continue end
--
                local isBroken = false
                local resetTime = 0
--
                pcall(function()
                    local values = safe:FindFirstChild("Values")
                    if values then
                        local broken = values:FindFirstChild("Broken")
                        if broken then isBroken = broken.Value end
                    end
--
                    if not isBroken then
                        local interact = safe:FindFirstChild("Interact")
                        if interact then isBroken = interact:GetAttribute("Broken") or false end
                    end
--
                    local wasBroken = previousSafeBrokenStates[safeName] or false
                    if isBroken and not wasBroken then
                        S.SafeESP.ResetTimers[safeName] = 720
                        if S.SafeESP.Billboards[safeName] and S.SafeESP.Billboards[safeName].Parent then
                            S.SafeESP.FrozenPositions[safeName] = S.SafeESP.Billboards[safeName].StudsOffset
                        end
                    end
--
                    previousSafeBrokenStates[safeName] = isBroken
--
                    if isBroken and S.SafeESP.ResetTimers[safeName] then
                        S.SafeESP.ResetTimers[safeName] = math.max(S.SafeESP.ResetTimers[safeName] - delta, 0)
                        resetTime = S.SafeESP.ResetTimers[safeName]
                    else
                        S.SafeESP.ResetTimers[safeName] = nil
                        S.SafeESP.FrozenPositions[safeName] = nil
                    end
                end)
--
                local highlight = S.SafeESP.Highlights[safeName]
                local billboard = S.SafeESP.Billboards[safeName]
--
                if highlight and billboard and billboard.Parent and billboard:FindFirstChild("TextLabel") then
                    highlight.FillColor = isBroken and Color3.fromRGB(255, 80, 80) or Color3.fromRGB(80, 255, 80)
                    highlight.Enabled = true
--
                    local minutes = math.floor(resetTime / 60)
                    local seconds = math.floor(resetTime % 60)
                    local timeText = isBroken and string.format("%d:%02d", minutes, seconds) or ""
                    billboard:FindFirstChild("TextLabel").Text = timeText
                    billboard.Enabled = isBroken and resetTime > 0
                end
            end
--
            for _, registerName in ipairs(RegisterNames) do
                local success, register = pcall(function()
                    return workspace.Map.BredMakurz:FindFirstChild(registerName)
                end)
--
                if not success or not register then
                    if S.SafeESP.RegisterHighlights[registerName] then S.SafeESP.RegisterHighlights[registerName].Enabled = false end
                    if S.SafeESP.RegisterBillboards[registerName] then S.SafeESP.RegisterBillboards[registerName].Enabled = false end
                    continue
                end
--
                if not S.SafeESP.RegisterHighlights[registerName] or not S.SafeESP.RegisterHighlights[registerName].Parent then
                    createHighlight(register, registerName, true)
                end
--
                if S.SafeESP.RegisterHighlights[registerName] then
                    S.SafeESP.RegisterHighlights[registerName].Adornee = register
                    S.SafeESP.RegisterHighlights[registerName].Enabled = true
                end
--
                local billboard = S.SafeESP.RegisterBillboards[registerName]
                if billboard and billboard.Parent then
                    billboard.Adornee = register
                    if not S.SafeESP.FrozenPositions[registerName] then
                        billboard.StudsOffset = Vector3.new(0, 6, 0)
                    end
                    billboard.Enabled = true
                end
--
                local isBroken = false
                local resetTime = 0
--
                pcall(function()
                    local values = register:FindFirstChild("Values")
                    if values then
                        local broken = values:FindFirstChild("Broken")
                        if broken then isBroken = broken.Value end
                    end
--
                    if not isBroken then
                        local interact = register:FindFirstChild("Interact")
                        if interact then isBroken = interact:GetAttribute("Broken") or false end
                    end
--
                    local wasBroken = previousRegisterBrokenStates[registerName] or false
                    if isBroken and not wasBroken then
                        S.SafeESP.ResetTimers[registerName] = 600
                        if billboard and billboard.Parent then
                            S.SafeESP.FrozenPositions[registerName] = billboard.StudsOffset
                        end
                    end
--
                    previousRegisterBrokenStates[registerName] = isBroken
--
                    if isBroken and S.SafeESP.ResetTimers[registerName] then
                        S.SafeESP.ResetTimers[registerName] = math.max(S.SafeESP.ResetTimers[registerName] - delta, 0)
                        resetTime = S.SafeESP.ResetTimers[registerName]
                    else
                        S.SafeESP.ResetTimers[registerName] = nil
                        S.SafeESP.FrozenPositions[registerName] = nil
                    end
                end)
--
                local highlight = S.SafeESP.RegisterHighlights[registerName]
                if highlight and billboard and billboard.Parent and billboard:FindFirstChild("TextLabel") then
                    highlight.FillColor = isBroken and Color3.fromRGB(255, 80, 80) or Color3.fromRGB(80, 255, 80)
                    highlight.Enabled = true
--
                    local minutes = math.floor(resetTime / 60)
                    local seconds = math.floor(resetTime % 60)
                    local timeText = isBroken and string.format("%d:%02d", minutes, seconds) or ""
                    billboard:FindFirstChild("TextLabel").Text = timeText
                    billboard.Enabled = isBroken and resetTime > 0
                end
            end
--
            task.wait(1)
        end
    end)
--
    coroutine.resume(S.SafeESP.Coroutine)
    Lib:Notify("Safe ESP enabled", 2)
end
--
local function disableSafeESP()
    S.SafeESP.On = false
--
    for _, h in pairs(S.SafeESP.Highlights) do if h then h:Destroy() end end
    for _, b in pairs(S.SafeESP.Billboards) do if b then b:Destroy() end end
    for _, h in pairs(S.SafeESP.RegisterHighlights) do if h then h:Destroy() end end
    for _, b in pairs(S.SafeESP.RegisterBillboards) do if b then b:Destroy() end end
--
    S.SafeESP.Highlights = {}
    S.SafeESP.Billboards = {}
    S.SafeESP.ResetTimers = {}
    S.SafeESP.FrozenPositions = {}
    S.SafeESP.RegisterHighlights = {}
    S.SafeESP.RegisterBillboards = {}
    previousSafeBrokenStates = {}
    previousRegisterBrokenStates = {}
--
    S.SafeESP.Coroutine = nil
    Lib:Notify("Safe ESP disabled", 2)
end
--
local function toggleSafeESP(state)
    if state then
        S.SafeESP.On = true
        S.SafeESP.Highlights = {}
        S.SafeESP.Billboards = {}
        S.SafeESP.ResetTimers = {}
        S.SafeESP.FrozenPositions = {}
        S.SafeESP.RegisterHighlights = {}
        S.SafeESP.RegisterBillboards = {}
        setupSafeESP()
    else
        disableSafeESP()
    end
end
--
-- ==================== HOBЫE ФYHKЦИИ: LOCKPICK SCALE ====================
--
local function setupLockpickScale()
    if S.LockpickScale.Connection then return end
--
    S.LockpickScale.Connection = RS.Heartbeat:Connect(function()
        if not S.LockpickScale.On then return end
--
        local gui = LP.PlayerGui:FindFirstChild("LockpickGUI")
        if not gui then return end
--
        local mf = gui:FindFirstChild("MF")
        if not mf then return end
--
        local lpFrame = mf:FindFirstChild("LP_Frame")
        if not lpFrame then return end
--
        local frames = lpFrame:FindFirstChild("Frames")
        if not frames then return end
--
        for _, barName in ipairs({"B1", "B2", "B3"}) do
            local b = frames:FindFirstChild(barName)
            if b then
                local bar = b:FindFirstChild("Bar")
                if bar then
                    local uiScale = bar:FindFirstChild("UIScale")
                    if uiScale then uiScale.Scale = 10 end
                end
            end
        end
    end)
--
    Lib:Notify("Lockpick Scale enabled", 2)
end
--
local function disableLockpickScale()
    if S.LockpickScale.Connection then 
        S.LockpickScale.Connection:Disconnect() 
        S.LockpickScale.Connection = nil 
    end
--
    local gui = LP.PlayerGui:FindFirstChild("LockpickGUI")
    if gui then
        local mf = gui:FindFirstChild("MF")
        if mf then
            local lpFrame = mf:FindFirstChild("LP_Frame")
            if lpFrame then
                local frames = lpFrame:FindFirstChild("Frames")
                if frames then
                    for _, barName in ipairs({"B1", "B2", "B3"}) do
                        local b = frames:FindFirstChild(barName)
                        if b then
                            local bar = b:FindFirstChild("Bar")
                            if bar then
                                local uiScale = bar:FindFirstChild("UIScale")
                                if uiScale then uiScale.Scale = 1 end
                            end
                        end
                    end
                end
            end
        end
    end
--
    Lib:Notify("Lockpick Scale disabled", 2)
end
--
local function toggleLockpickScale(state)
    S.LockpickScale.On = state
    if state then
        setupLockpickScale()
    else
        disableLockpickScale()
    end
end
--
-- ==================== HOBЫE ФYHKЦИИ: INFINITE STAMINA ====================
--
local function setupInfStamina()
    if S.InfStamina.Connection then return end
--
    S.InfStamina.Connection = RS.RenderStepped:Connect(function()
        if not S.InfStamina.On then return end
--
        local char = LP.Character
        if not char then return end
--
        local hum = char:FindFirstChildOfClass("Humanoid")
        if hum and not hum:GetAttribute("ZSPRN_M") then
            hum:SetAttribute("ZSPRN_M", true)
        end
    end)
--
    Lib:Notify("Infinite Stamina enabled", 2)
end
--
local function disableInfStamina()
    if S.InfStamina.Connection then 
        S.InfStamina.Connection:Disconnect() 
        S.InfStamina.Connection = nil 
    end
--
    local char = LP.Character
    if char then
        local hum = char:FindFirstChildOfClass("Humanoid")
        if hum then hum:SetAttribute("ZSPRN_M", nil) end
    end
--
    Lib:Notify("Infinite Stamina disabled", 2)
end
--
local function toggleInfStamina(state)
    S.InfStamina.On = state
    if state then
        setupInfStamina()
    else
        disableInfStamina()
    end
end
--
-- END ORIGINAL SOURCE LINES 2359-2754

-- BEGIN ORIGINAL SOURCE LINES 3302-3388
local function startESpam()
    if S.Farm.EConn then S.Farm.EConn:Disconnect() end
    S.Farm.EConn = RS.Heartbeat:Connect(function()
        if Lib.Unloaded then if S.Farm.EConn then S.Farm.EConn:Disconnect(); S.Farm.EConn = nil end return end
        if not S.Farm.Enabled or S.Farm.Respawning then return end
        local c = LP.Character; if c then
            local vi = game:GetService("VirtualInputManager")
            vi:SendKeyEvent(true, Enum.KeyCode.E, false, game); task.wait(0.05); vi:SendKeyEvent(false, Enum.KeyCode.E, false, game)
        end
    end)
end
--
local function forceRespawn()
    if S.Farm.RespawnCD or S.Farm.Respawning then return end
    S.Farm.RespawnCD = true; S.Farm.Respawning = true
    local c = LP.Character; if c then local h = c:FindFirstChild("Humanoid"); if h then h.Health = 0 end end
    local vi = game:GetService("VirtualInputManager")
    vi:SendKeyEvent(true, Enum.KeyCode.E, false, game); task.wait(0.05); vi:SendKeyEvent(false, Enum.KeyCode.E, false, game)
    task.wait(0.3); vi:SendKeyEvent(true, Enum.KeyCode.E, false, game); task.wait(0.05); vi:SendKeyEvent(false, Enum.KeyCode.E, false, game)
    task.wait(0.2); vi:SendKeyEvent(true, Enum.KeyCode.E, false, game); task.wait(0.05); vi:SendKeyEvent(false, Enum.KeyCode.E, false, game)
    task.wait(0.5); S.Farm.RespawnCD = false; S.Farm.Respawning = false
end
--
local function startDmgDetect()
    if S.Farm.DmgConn then S.Farm.DmgConn:Disconnect() end
    S.Farm.DmgConn = RS.Heartbeat:Connect(function()
        if Lib.Unloaded then if S.Farm.DmgConn then S.Farm.DmgConn:Disconnect(); S.Farm.DmgConn = nil end return end
        if not S.Farm.Enabled or S.Farm.Respawning then return end
        local c = LP.Character; if not c then return end
        local h = c:FindFirstChild("Humanoid"); if not h then return end
        if h.MaxHealth > S.Farm.MaxHP then S.Farm.MaxHP = h.MaxHealth end
        if h.Health < S.Farm.MaxHP then forceRespawn() end
    end)
end
--
local function teleToTarget()
    if Lib.Unloaded then return end
    if not S.Farm.Enabled or S.Farm.Respawning then return end
    local myC = LP.Character; if not myC or not S.Farm.Target then return end
    local tC = S.Farm.Target.Character; if not tC then return end
    local myR = getHRP(myC); if not myR then return end
    enNoClip(myC)
    local tR = getHRP(tC); if not tR then return end
    local lv = tR.CFrame.LookVector
    local tPos = tR.Position + (lv * 2.5) + Vector3.new(0, 0.5, 0)
    local bCF = CFrame.new(tPos) * CFrame.Angles(0, math.pi, 0)
    myR.CFrame = bCF
end
--
local function teleToCube() if Lib.Unloaded then return end; local c = LP.Character; if not c then return end; local rp = getHRP(c); if not rp then return end; rp.CFrame = CFrame.new(SAVE_CUBE); Lib:Notify("To SaveCube", 2) end
local function teleToUnder() if Lib.Unloaded then return end; local c = LP.Character; if not c then return end; local rp = getHRP(c); if not rp then return end; rp.CFrame = CFrame.new(UNDER); Lib:Notify("To Underground", 2) end
local function teleToVibe() if Lib.Unloaded then return end; local c = LP.Character; if not c then return end; local rp = getHRP(c); if not rp then return end; rp.CFrame = CFrame.new(SAVE_VIBE); Lib:Notify("To SaveVibe", 2) end
--
local function CollectCore()
    local function runCollect()
        if not S.Collect.On or Set.IsDead then return end
        local bc = Ws.Filter:FindFirstChild("SpawnedBread"); if not bc then return end
        local pr = RepSt.Events:FindFirstChild("CZDPZUS"); if not pr then return end
        local c = LP.Character; local rp = c and c:FindFirstChild("HumanoidRootPart"); if not rp or CDs.Pick.MoneyCD then return end
        local cp = rp.Position
        for _, i in ipairs(bc:GetChildren()) do
            local dsq = (cp - i.Position).Magnitude^2
            if dsq < 25 and not CDs.Pick.MoneyCD then
                CDs.Pick.MoneyCD = true
                pcall(function() pr:FireServer(i) end)
                task.wait(1.1); CDs.Pick.MoneyCD = false; break
            end
        end
    end
    S.Collect.Sig = RS.RenderStepped:Connect(runCollect)
end
--
local function CollectOn()
    if S.Collect.On then return end; S.Collect.On = true
    if S.Collect.Sig then S.Collect.Sig:Disconnect(); S.Collect.Sig = nil end
    if S.Collect.Task then coroutine.close(S.Collect.Task); S.Collect.Task = nil end
    S.Collect.Task = coroutine.create(CollectCore); coroutine.resume(S.Collect.Task)
    Lib:Notify("AutoPick on!", 3)
end
--
local function CollectOff()
    if not S.Collect.On then return end; S.Collect.On = false
    if S.Collect.Sig then S.Collect.Sig:Disconnect(); S.Collect.Sig = nil end
    if CDs and CDs.Pick then CDs.Pick.MoneyCD = false end
    Lib:Notify("AutoPick off!", 3)
end
--
-- END ORIGINAL SOURCE LINES 3302-3388

-- BEGIN ORIGINAL SOURCE LINES 7455-7491
FarmL = Tabs.Farm:AddLeftGroupbox("Auto Farm")
FarmR = Tabs.Farm:AddRightGroupbox("Auto Pick Money")
--
targetIn = FarmL:AddInput("TargetName", {Text="Target Name", Placeholder="Enter username...", Default="", Callback=function(v) end})
--
FarmL:AddToggle("AutoFarm", {Text="Auto Farm", Default=false, Callback=function(s)
    S.Farm.Enabled = s
    if s then
        local tn = targetIn.Value; if tn == "" then Toggles.AutoFarm:SetValue(false); Lib:Notify("Enter name!", 3); return end
        S.Farm.Target = findTP(tn); if not S.Farm.Target then Toggles.AutoFarm:SetValue(false); Lib:Notify("Player not found!", 3); return end
        toggleFists()
        if not S.UI.FarmCharConn then S.UI.FarmCharConn = LP.CharacterAdded:Connect(function(c) task.wait(0.2); if S.Farm.Enabled then toggleFists(); Lib:Notify("Fists after death", 2) end end) end
        startESpam(); startDmgDetect(); S.Farm.TeleConn = RS.Heartbeat:Connect(teleToTarget); Lib:Notify("Farm started!", 3)
    else
        if S.Farm.TeleConn then S.Farm.TeleConn:Disconnect() end; if S.Farm.EConn then S.Farm.EConn:Disconnect() end; if S.Farm.DmgConn then S.Farm.DmgConn:Disconnect() end
        if S.UI.FarmCharConn then S.UI.FarmCharConn:Disconnect(); S.UI.FarmCharConn = nil end
        S.Farm.Target = nil; S.Farm.RespawnCD = false; S.Farm.Respawning = false; S.Farm.MaxHP = 115; Lib:Notify("Farm stopped!", 3)
    end
end})
--
FarmL:AddDivider(); FarmL:AddLabel("Teleports:")
FarmL:AddButton({Text="SaveCube", Func=teleToCube})
FarmL:AddButton({Text="Underground", Func=teleToUnder})
FarmL:AddButton({Text="SaveVibecheck", Func=teleToVibe})
--
FarmR:AddToggle("AutoPickMoney", {Text="Auto Pick Money", Default=false, Callback=function(v) if v then CollectOn() else CollectOff() end end})
--
local FarmToolsR = Tabs.Farm:AddRightGroupbox("Tools")
--
FarmToolsR:AddToggle("SafeESPToggle", {Text="Safe ESP", Default=false, Callback=function(v)
    toggleSafeESP(v)
end})
--
FarmToolsR:AddToggle("LockpickScaleToggle", {Text="Lockpick Scale", Default=false, Callback=function(v)
    toggleLockpickScale(v)
end})
--
-- END ORIGINAL SOURCE LINES 7455-7491
