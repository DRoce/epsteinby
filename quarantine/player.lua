--[[
Inert commented archive file.
No executable Lua is present below; every preserved source line is prefixed with --.
Role: Freecam, movement/player toggles, noclip/fly and player UI blocks
Original source line ranges: 1054-1231, 3130-3301, 3389-3452, 7532-7542
]]


-- BEGIN ORIGINAL SOURCE LINES 1054-1231
-- ==================== BLUR ФYHKЦИИ ====================
--
local function setupBlur()
    if not S.Blur.BlurEffect then
        S.Blur.BlurEffect = Instance.new("BlurEffect", Lt)
        S.Blur.BlurEffect.Size = 0
    end
--
    if S.Blur.Connection then
        S.Blur.Connection:Disconnect()
        S.Blur.Connection = nil
    end
--
    S.Blur.Connection = RS.RenderStepped:Connect(function()
        if not S.Blur.Enabled or not S.Blur.BlurEffect then return end
--
        S.Blur.CurrentLookVector = Cam.CFrame.LookVector
        S.Blur.RotationSpeed = (S.Blur.CurrentLookVector - (S.Blur.LastLookVector or S.Blur.CurrentLookVector)).Magnitude * 130
        S.Blur.BlurEffect.Size = math.clamp(S.Blur.RotationSpeed, 0, 20)
        S.Blur.LastLookVector = S.Blur.CurrentLookVector
    end)
end
--
local function disableBlur()
    if S.Blur.Connection then
        S.Blur.Connection:Disconnect()
        S.Blur.Connection = nil
    end
--
    if S.Blur.BlurEffect then
        S.Blur.BlurEffect.Size = 0
        S.Blur.BlurEffect:Destroy()
        S.Blur.BlurEffect = nil
    end
end
--
local function toggleBlur(state)
    S.Blur.Enabled = state
--
    if state then
        setupBlur()
        Lib:Notify("Blur enabled", 2)
    else
        disableBlur()
        Lib:Notify("Blur disabled", 2)
    end
end
--
-- ==================== FREECAM ФYHKЦИИ ====================
--
local function setupFreecam()
    local function handleInput(input, gameProcessed)
        if gameProcessed then return end
--
        if S.Freecam.Enabled then
            if input.UserInputType == Enum.UserInputType.Keyboard then
                if input.UserInputState == Enum.UserInputState.Begin then
                    S.Freecam.KeysDown[input.KeyCode] = true
                elseif input.UserInputState == Enum.UserInputState.End then
                    S.Freecam.KeysDown[input.KeyCode] = nil
                end
            elseif input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton2 then
                if input.UserInputState == Enum.UserInputState.Begin then
                    S.Freecam.Rotating = true
                elseif input.UserInputState == Enum.UserInputState.End then
                    S.Freecam.Rotating = false
                end
            end
        end
    end
--
    UIS.InputBegan:Connect(handleInput)
    UIS.InputEnded:Connect(handleInput)
--
    if S.Freecam.OnMobile then
        UIS.TouchMoved:Connect(function(touchPos, gameProcessed)
            if gameProcessed or not S.Freecam.Enabled or not S.Freecam.Rotating then return end
            local delta = touchPos.Delta
            Cam.CFrame = Cam.CFrame * CFrame.Angles(0, -delta.X * 0.005, 0) * CFrame.Angles(-delta.Y * 0.005, 0, 0)
        end)
    else
        UIS.InputChanged:Connect(function(input, gameProcessed)
            if gameProcessed or not S.Freecam.Enabled or not S.Freecam.Rotating then return end
            if input.UserInputType == Enum.UserInputType.MouseMovement then
                local delta = input.Delta
                Cam.CFrame = Cam.CFrame * CFrame.Angles(0, -delta.X * 0.005, 0) * CFrame.Angles(-delta.Y * 0.005, 0, 0)
            end
        end)
    end
--
    S.Freecam.Connection = RS.RenderStepped:Connect(function()
        if not S.Freecam.Enabled or not LP.Character or not LP.Character:FindFirstChild("Humanoid") or LP.Character.Humanoid.Health <= 0 then 
            if S.Freecam.Enabled then
                S.Freecam.Enabled = false
                if Toggles and Toggles.FreecamToggle then
                    Toggles.FreecamToggle:SetValue(false)
                end
                Cam.CameraType = Enum.CameraType.Custom
                if LP.Character then
                    local hrp = LP.Character:FindFirstChild("HumanoidRootPart")
                    if hrp then
                        hrp.Anchored = false
                    end
                end
            end
            return
        end
--
        local moveVector = Vector3.new(0, 0, 0)
--
        if S.Freecam.KeysDown[Enum.KeyCode.W] then
            moveVector = moveVector + Cam.CFrame.LookVector
        end
        if S.Freecam.KeysDown[Enum.KeyCode.S] then
            moveVector = moveVector - Cam.CFrame.LookVector
        end
        if S.Freecam.KeysDown[Enum.KeyCode.A] then
            moveVector = moveVector - Cam.CFrame.RightVector
        end
        if S.Freecam.KeysDown[Enum.KeyCode.D] then
            moveVector = moveVector + Cam.CFrame.RightVector
        end
        if S.Freecam.KeysDown[Enum.KeyCode.E] or S.Freecam.KeysDown[Enum.KeyCode.Space] then
            moveVector = moveVector + Vector3.new(0, 1, 0)
        end
        if S.Freecam.KeysDown[Enum.KeyCode.Q] or S.Freecam.KeysDown[Enum.KeyCode.LeftShift] then
            moveVector = moveVector + Vector3.new(0, -1, 0)
        end
--
        if moveVector.Magnitude > 0 then
            moveVector = moveVector.Unit * S.Freecam.Speed
            Cam.CFrame = Cam.CFrame + moveVector * RS.RenderStepped:Wait()
        end
    end)
end
--
local function disableFreecam()
    if S.Freecam.Connection then
        S.Freecam.Connection:Disconnect()
        S.Freecam.Connection = nil
    end
--
    Cam.CameraType = Enum.CameraType.Custom
    if LP.Character then
        local hrp = LP.Character:FindFirstChild("HumanoidRootPart")
        if hrp then
            hrp.Anchored = false
        end
    end
--
    S.Freecam.KeysDown = {}
    S.Freecam.Rotating = false
end
--
local function toggleFreecam(state)
    S.Freecam.Enabled = state
--
    if state then
        setupFreecam()
        Cam.CameraType = Enum.CameraType.Scriptable
        if LP.Character then
            local hrp = LP.Character:FindFirstChild("HumanoidRootPart")
            if hrp then
                hrp.Anchored = true
            end
        end
        Lib:Notify("Freecam enabled", 2)
    else
        disableFreecam()
        Lib:Notify("Freecam disabled", 2)
    end
end
--
local function setFreecamSpeed(speed)
    S.Freecam.Speed = speed
    Lib:Notify("Freecam Speed: " .. speed, 2)
end
--
-- END ORIGINAL SOURCE LINES 1054-1231

-- BEGIN ORIGINAL SOURCE LINES 3130-3301
local function noclipLoop()
    while S.Noclip.On do
        if LP.Character then for _, p in pairs(LP.Character:GetDescendants()) do if p:IsA("BasePart") and p.CanCollide then p.CanCollide = false end end end
        RS.RenderStepped:Wait()
    end
end
--
local function toggleNoclip(state)
    S.Noclip.On = state; _G.NoclipPersist = state
    if S.Noclip.On then
        Lib:Notify("Noclip on", 2); noclipLoop()
        local function onChar(c) task.wait(0.5); if S.Noclip.On then noclipLoop() end end
        if LP.Character then onChar(LP.Character) end
        LP.CharacterAdded:Connect(onChar)
    else
        if S.Noclip.Conn then S.Noclip.Conn:Disconnect(); S.Noclip.Conn = nil end
        Lib:Notify("Noclip off", 2)
    end
end
--
local function stopNeck()
    if LP.Character then LP.Character:SetAttribute("NoNeckMove", true) end
end
--
local function restNeck()
    if LP.Character then LP.Character:SetAttribute("NoNeckMove", false) end
end
--
local function toggleStopNeck(state)
    S.StopNeck.On = state
    if S.StopNeck.On then
        stopNeck(); Lib:Notify("StopNeck on", 2)
        local c = LP.CharacterAdded:Connect(function(c) task.wait(0.5); if S.StopNeck.On then stopNeck() end end)
        if S.StopNeck.Conn then S.StopNeck.Conn:Disconnect() end
        S.StopNeck.Conn = c
    else
        restNeck()
        if S.StopNeck.Conn then S.StopNeck.Conn:Disconnect(); S.StopNeck.Conn = nil end
        Lib:Notify("StopNeck off", 2)
    end
end
--
local function setupUnbreak()
    local cs = RepSt.CharStats; if not cs then return end
    local ms = cs:FindFirstChild(LP.Name); if not ms then return end
    local lf = ms:FindFirstChild("HealthValues"); if not lf then return end
    local function unbreakAll()
        for _, l in pairs(lf:GetChildren()) do
            local bv = l:FindFirstChild("Broken"); if bv then
                bv.Value = false
                local c = bv:GetPropertyChangedSignal("Value"):Connect(function() bv.Value = false end)
                table.insert(S.Unbreak.Conns, c)
            end
        end
    end
    unbreakAll()
    local c = lf.ChildAdded:Connect(function() task.wait(0.1); if S.Unbreak.On then unbreakAll() end end)
    table.insert(S.Unbreak.Conns, c)
end
--
local function toggleUnbreak(state)
    S.Unbreak.On = state
    if S.Unbreak.On then
        setupUnbreak(); Lib:Notify("Unbreak on", 2)
        LP.CharacterAdded:Connect(function() task.wait(1); if S.Unbreak.On then setupUnbreak() end end)
    else
        for _, c in pairs(S.Unbreak.Conns) do if c then c:Disconnect() end end
        S.Unbreak.Conns = {}; Lib:Notify("Unbreak off", 2)
    end
end
--
local function setupFakeD()
    if not LP.Character then return end
    local cs = RepSt.CharStats; if not cs then return end
    local ms = cs:FindFirstChild(LP.Name); if not ms then return end
    local dv = ms:FindFirstChild("Downed"); if not dv then return end
    S.FakeDown.StatObj = dv; S.FakeDown.OrigVal = dv.Value
    if dv.Value ~= true then dv.Value = true end
    S.FakeDown.Conn = dv:GetPropertyChangedSignal("Value"):Connect(function() if dv.Value ~= true then dv.Value = true end end)
end
--
local function restFakeD()
    if S.FakeDown.StatObj and S.FakeDown.OrigVal ~= nil then
        if S.FakeDown.Conn then S.FakeDown.Conn:Disconnect(); S.FakeDown.Conn = nil end
        S.FakeDown.StatObj.Value = S.FakeDown.OrigVal
        S.FakeDown.StatObj = nil; S.FakeDown.OrigVal = nil
    end
end
--
local function toggleFakeD(state)
    S.FakeDown.On = state
    if S.FakeDown.On then
        setupFakeD(); Lib:Notify("FakeDown on", 2)
        LP.CharacterAdded:Connect(function() task.wait(1); if S.FakeDown.On then setupFakeD() end end)
    else
        restFakeD(); Lib:Notify("FakeDown off", 2)
    end
end
--
local function addFF(char)
    if char then
        for _, o in pairs(char:GetChildren()) do if o:IsA("ForceField") and o.Visible == false then o:Destroy() end end
        local ff = Instance.new("ForceField"); ff.Parent = char; ff.Visible = false
        local c = char.ChildAdded:Connect(function(ch) if ch:IsA("ForceField") and ch.Visible == false then task.wait(0.1); if S.NoFall.On then ch.Visible = false end end end)
        table.insert(S.NoFall.Conns, c)
    end
end
--
local function toggleNoFall(state)
    S.NoFall.On = state
    if S.NoFall.On then
        if LP.Character then addFF(LP.Character) end
        Lib:Notify("NoFall on", 2)
        local c = LP.CharacterAdded:Connect(function(c) task.wait(0.5); if S.NoFall.On then addFF(c) end end)
        table.insert(S.NoFall.Conns, c)
    else
        for _, c in pairs(S.NoFall.Conns) do if c then c:Disconnect() end end
        S.NoFall.Conns = {}
        if LP.Character then for _, o in pairs(LP.Character:GetChildren()) do if o:IsA("ForceField") and o.Visible == false then o:Destroy() end end end
        Lib:Notify("NoFall off", 2)
    end
end
--
local function disBarriers()
    local ff = Ws:FindFirstChild("Filter"); if not ff then return end
    local pf = ff:FindFirstChild("Parts"); if not pf then return end
    local fp = pf:FindFirstChild("F_Parts"); if not fp then return end
    for _, d in pairs(fp:GetDescendants()) do if d:IsA("Part") or d:IsA("MeshPart") then d.CanTouch = false end end
    S.NoSpike.Conn = fp.DescendantAdded:Connect(function(d) if d:IsA("Part") or d:IsA("MeshPart") then d.CanTouch = false end end)
end
--
local function toggleNoSpike(state)
    S.NoSpike.On = state
    if S.NoSpike.On then
        if Ws:FindFirstChild("Filter") then disBarriers()
        else local c = Ws.ChildAdded:Connect(function(ch) if ch.Name == "Filter" then task.wait(0.5); if S.NoSpike.On then disBarriers() end; c:Disconnect() end end) end
        Lib:Notify("NoSpike on", 2)
    else
        if S.NoSpike.Conn then S.NoSpike.Conn:Disconnect(); S.NoSpike.Conn = nil end
        local ff = Ws:FindFirstChild("Filter"); if ff then
            local pf = ff:FindFirstChild("Parts"); if pf then
                local fp = pf:FindFirstChild("F_Parts"); if fp then
                    for _, d in pairs(fp:GetDescendants()) do if d:IsA("Part") or d:IsA("MeshPart") then d.CanTouch = true end end
                end
            end
        end
        Lib:Notify("NoSpike off", 2)
    end
end
--
local function updCamSet()
    if S.Cam.NoclipOn then LP.DevCameraOcclusionMode = Enum.DevCameraOcclusionMode.Invisicam
    else LP.DevCameraOcclusionMode = Enum.DevCameraOcclusionMode.Zoom end
end
--
local function findTP(name)
    for _, p in pairs(Plrs:GetPlayers()) do
        if string.lower(p.Name) == string.lower(name) or string.lower(p.DisplayName) == string.lower(name) then return p end
    end
    return nil
end
--
local function getHRP(c) return c and c:FindFirstChild("HumanoidRootPart") end
--
local function toggleFists()
    local c = LP.Character; if not c then return end
    local bp = LP:FindFirstChild("Backpack"); if not bp then return end
    for _, t in pairs(bp:GetChildren()) do if t:IsA("Tool") then t.Parent = bp; task.wait(0.2); t.Parent = c; break end end
end
--
local function enNoClip(c) if not c then return end; for _, p in pairs(c:GetDescendants()) do if p:IsA("BasePart") then p.CanCollide = false end end end
--
-- END ORIGINAL SOURCE LINES 3130-3301

-- BEGIN ORIGINAL SOURCE LINES 3389-3452
local function stopRagLoop() if RUNS.Rag then RUNS.Rag:Disconnect(); RUNS.Rag = nil end end
local function stopOldFly() if RUNS.Old then RUNS.Old:Disconnect(); RUNS.Old = nil end end
local function stopAllFly() stopRagLoop(); stopOldFly(); if hrp then hrp.Velocity = Vector3.new(0,0,0) end end
--
local function startRagLoop()
    if not ragEv or not hrp then return end
    stopRagLoop()
    RUNS.Rag = RS.RenderStepped:Connect(function()
        if not hrp or not S.Fly.On or S.Fly.Method ~= "Ragdoll" then stopAllFly(); return end
        ragEv:FireServer("__---r", Vector3.new(0,0,0), hrp.CFrame, false)
    end)
end
--
local function enRagFly()
    local c = me.Character or me.CharacterAdded:Wait(); hrp = c:FindFirstChild("HumanoidRootPart"); if not hrp then return end
    stopAllFly(); startRagLoop()
    RUNS.Old = RS.RenderStepped:Connect(function()
        if not hrp or not S.Fly.On or S.Fly.Method ~= "Ragdoll" then stopAllFly(); return end
        local cam = workspace.CurrentCamera; local mv = Vector3.new(0,0,0)
        if UIS:IsKeyDown(Enum.KeyCode.W) then mv = mv + cam.CFrame.LookVector * flySpd end
        if UIS:IsKeyDown(Enum.KeyCode.S) then mv = mv - cam.CFrame.LookVector * flySpd end
        if UIS:IsKeyDown(Enum.KeyCode.A) then mv = mv - cam.CFrame.RightVector * flySpd end
        if UIS:IsKeyDown(Enum.KeyCode.D) then mv = mv + cam.CFrame.RightVector * flySpd end
        hrp.Velocity = mv
        if flyEv then flyEv:FireServer("---r", Vector3.new(0,0,0), hrp.CFrame, false) end
    end)
end
--
local function enOldFly()
    stopAllFly()
    RUNS.Old = RS.RenderStepped:Connect(function()
        if not S.Fly.On or S.Fly.Method ~= "Old" then stopAllFly(); return end
        local p = me; local c = p.Character or p.CharacterAdded:Wait(); local rp = c:FindFirstChild("HumanoidRootPart")
        if rp then
            local cam = workspace.CurrentCamera; local md = Vector3.zero
            if UIS:IsKeyDown(Enum.KeyCode.W) then md = md + cam.CFrame.LookVector end
            if UIS:IsKeyDown(Enum.KeyCode.S) then md = md - cam.CFrame.LookVector end
            if UIS:IsKeyDown(Enum.KeyCode.A) then md = md - cam.CFrame.RightVector end
            if UIS:IsKeyDown(Enum.KeyCode.D) then md = md + cam.CFrame.RightVector end
            if UIS:IsKeyDown(Enum.KeyCode.Space) then md = md + Vector3.new(0,1,0) end
            if UIS:IsKeyDown(Enum.KeyCode.LeftControl) then md = md - Vector3.new(0,1,0) end
            rp.CFrame = rp.CFrame + (md * 50 * RS.RenderStepped:Wait())
        end
    end)
end
--
local function applyFly()
    stopAllFly(); if not S.Fly.On then return end
    if S.Fly.Method == "Ragdoll" then enRagFly() else enOldFly() end
end
--
local function onCharAdd(c)
    if not S.Fly.On then return end; task.wait(0.5); c:WaitForChild("HumanoidRootPart"); task.wait(0.1)
    if S.Fly.On then applyFly() end
end
--
local function toggleFly(state)
    S.Fly.On = state; _G.FlyPersist = state
    if S.Fly.On then
        if LP.Character then applyFly() end
        Lib:Notify("Fly on ("..S.Fly.Method..")", 2)
    else stopAllFly(); Lib:Notify("Fly off", 2) end
end
--
-- END ORIGINAL SOURCE LINES 3389-3452

-- BEGIN ORIGINAL SOURCE LINES 7532-7542
PlayerL = Tabs.Player:AddLeftGroupbox("Movement")
PlayerL:AddDropdown("FlyMethod", {Values={"Ragdoll","Old"}, Default="Ragdoll", Multi=false, Text="Fly method", Callback=function(v) S.Fly.Method = v; if S.Fly.On then applyFly() end end})
PlayerL:AddToggle("FlyToggle", {Text="Fly", Default=false, Callback=function(v) toggleFly(v) end}):AddKeyPicker("FlyKey", {Default="None", SyncToggleState=false, Mode="Toggle", Text="Fly key", NoUI=false, Callback=function(k) if not canBind() then return end; Toggles.FlyToggle:SetValue(not Toggles.FlyToggle.Value) end})
--
--
--
PlayerR = Tabs.Player:AddRightGroupbox("Player Info")
PlayerR:AddLabel("Player Information:"); PlayerR:AddLabel("Username: "..LP.Name)
if LP.DisplayName then PlayerR:AddLabel("Display Name: "..LP.DisplayName) end
PlayerR:AddLabel("Account Age: "..LP.AccountAge.." days")
--
-- END ORIGINAL SOURCE LINES 7532-7542
