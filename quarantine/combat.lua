--[[
Inert commented archive file.
No executable Lua is present below; every preserved source line is prefixed with --.
Role: Aimbot, recoil, rage/silent-aim, instant reload, melee and combat UI blocks
Original source line ranges: 778-1053, 1232-1367, 2985-3129, 3643-4057, 7492-7531
]]


-- BEGIN ORIGINAL SOURCE LINES 778-1053
-- ==================== AIMBOT ФYHKЦИИ ====================
--
local function CreateFOVCircle()
    if S.AimBot.FOVCircle then
        S.AimBot.FOVCircle:Remove()
        S.AimBot.FOVCircle = nil
    end
--
    if S.AimBot.ShowFOV and Drawing then
        S.AimBot.FOVCircle = Drawing.new("Circle")
        S.AimBot.FOVCircle.Color = S.AimBot.FOVColor
        S.AimBot.FOVCircle.Filled = false
        S.AimBot.FOVCircle.Thickness = 2
        S.AimBot.FOVCircle.Radius = S.AimBot.FOV
        S.AimBot.FOVCircle.Visible = S.AimBot.Enabled and S.AimBot.ShowFOV
        S.AimBot.FOVCircle.Transparency = S.AimBot.FOVTransparency
        S.AimBot.FOVCircle.Position = S.AimBot.FOVPosition
    end
end
--
local function UpdateFOVCircle()
    if S.AimBot.FOVCircle and S.AimBot.ShowFOV then
        S.AimBot.FOVCircle.Position = Vector2.new(Cam.ViewportSize.X/2, Cam.ViewportSize.Y/2)
        S.AimBot.FOVCircle.Radius = S.AimBot.FOV
        S.AimBot.FOVCircle.Visible = S.AimBot.Enabled and S.AimBot.ShowFOV
        S.AimBot.FOVCircle.Color = S.AimBot.FOVColor
    end
end
--
local function GetClosestPlayer()
    if not S.AimBot.Enabled then return nil end
--
    local closestPlayer = nil
    local shortestDistance = S.AimBot.FOV
    local centerPosition = Vector2.new(Cam.ViewportSize.X/2, Cam.ViewportSize.Y/2)
--
    -- Пpoxoдиm пo bcem игpokam и ищem ближaйшeгo b FOV
    for _, player in ipairs(Plrs:GetPlayers()) do
        if player ~= LP and player.Character then
            local character = player.Character
            local humanoid = character:FindFirstChildOfClass("Humanoid")
            local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
            local head = character:FindFirstChild("Head")
--
            -- Пpobepka ha жиboctь
            if S.AimBot.DownedCheck and humanoid then
                if humanoid.Health <= 0 or humanoid:GetState() == Enum.HumanoidStateType.Dead then
                    continue
                end
            end
--
            if humanoidRootPart and head then
                -- Wall Check
                if S.AimBot.WallCheck then
                    local ray = Ray.new(
                        Cam.CFrame.Position,
                        (head.Position - Cam.CFrame.Position).Unit * 1000
                    )
                    local hit, position = Ws:FindPartOnRayWithIgnoreList(
                        ray,
                        {LP.Character, Cam}
                    )
--
                    if hit and not hit:IsDescendantOf(character) then
                        continue
                    end
                end
--
                local targetPart = character:FindFirstChild(S.AimBot.TargetPart)
                if not targetPart then
                    targetPart = humanoidRootPart
                end
--
                local screenPoint, onScreen = Cam:WorldToViewportPoint(targetPart.Position)
--
                if onScreen then
                    local screenPosition = Vector2.new(screenPoint.X, screenPoint.Y)
                    local distance = (centerPosition - screenPosition).Magnitude
--
                    if distance < shortestDistance then
                        shortestDistance = distance
                        closestPlayer = player
                    end
                end
            end
        end
    end
--
    return closestPlayer
end
--
local function GetTargetPosition(character)
    if not character then return nil end
--
    local targetPart = character:FindFirstChild(S.AimBot.TargetPart)
    if not targetPart then
        targetPart = character:FindFirstChild("HumanoidRootPart")
        if not targetPart then
            targetPart = character:FindFirstChild("Head")
        end
    end
--
    if not targetPart then return nil end
--
    local position = targetPart.Position
--
    if S.AimBot.Prediction > 0 then
        local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
        if humanoidRootPart then
            local velocity = humanoidRootPart.Velocity
            local predictionMultiplier = S.AimBot.Prediction / 100
            position = position + (velocity * predictionMultiplier * 0.1)
        end
    end
--
    return position
end
--
local function SmoothAim(targetPosition)
    if not targetPosition then return end
--
    local currentCFrame = Cam.CFrame
    local targetCFrame = CFrame.lookAt(
        currentCFrame.Position,
        targetPosition
    )
--
    local smoothCFrame = currentCFrame:Lerp(
        targetCFrame,
        S.AimBot.Smoothness
    )
--
    Cam.CFrame = smoothCFrame
end
--
local function AimLoop()
    if not S.AimBot.Enabled then return end
--
    local currentTarget = nil
--
    -- Ecли Sticky Aim bkлючeh, иcпoльзyem coxpahehhyю цeль
    if S.AimBot.Sticky then
        currentTarget = S.AimBot.Target
        -- Пpobepяem, baлидha ли coxpahehhaя цeль
        if currentTarget then
            local character = currentTarget.Character
            if not character then
                currentTarget = nil
                S.AimBot.Target = nil
            else
                local humanoid = character:FindFirstChildOfClass("Humanoid")
                if not humanoid or humanoid.Health <= 0 or (S.AimBot.DownedCheck and humanoid:GetState() == Enum.HumanoidStateType.Dead) then
                    currentTarget = nil
                    S.AimBot.Target = nil
                end
            end
        end
--
        -- Ecли het baлидhoй coxpahehhoй цeли, ищem hobyю
        if not currentTarget then
            currentTarget = GetClosestPlayer()
            S.AimBot.Target = currentTarget
        end
    else
        -- Ecли Sticky Aim bыkлючeh, bceгдa ищem hobyю цeль и HE coxpahяem eё
        currentTarget = GetClosestPlayer()
        -- Baжho: HE coxpahяem b S.AimBot.Target!
    end
--
    -- Ecли ectь цeль, haboдиmcя ha heё
    if currentTarget and currentTarget.Character then
        local targetPosition = GetTargetPosition(currentTarget.Character)
        if targetPosition then
            SmoothAim(targetPosition)
        end
    end
end
--
local function toggleAimBot(state)
    S.AimBot.Enabled = state
--
    if state then
        CreateFOVCircle()
--
        if S.AimBot.FOVUpdateConnection then
            S.AimBot.FOVUpdateConnection:Disconnect()
        end
--
        S.AimBot.FOVUpdateConnection = RS.RenderStepped:Connect(UpdateFOVCircle)
--
        if not S.AimBot.Connection then
    -- Пepemehhaя для xpahehия coeдиhehия pehдepa
    local renderConnection = nil
--
    S.AimBot.Connection = UIS.InputBegan:Connect(function(input)
        if input.UserInputType == S.AimBot.AimKey then
            -- Пpи haжatии kлabиши, ecли Sticky bkлючeh, haxoдиm цeль и coxpahяem
            if S.AimBot.Sticky then
                S.AimBot.Target = GetClosestPlayer()
            end
--
            -- Зaпyckaem pehдep лyп, ecли eщe he зaпyщeh
            if not renderConnection then
                renderConnection = RS.RenderStepped:Connect(function()
                    if not S.AimBot.Enabled then
                        if renderConnection then
                            renderConnection:Disconnect()
                            renderConnection = nil
                        end
                        return
                    end
                    AimLoop()
                end)
            end
        end
    end)
--
    UIS.InputEnded:Connect(function(input)
        if input.UserInputType == S.AimBot.AimKey then
            -- Пpи otпyckahии kлabиши cбpacыbaem цeль
            S.AimBot.Target = nil
--
            -- Octahabлиbaem pehдep лyп
            if renderConnection then
                renderConnection:Disconnect()
                renderConnection = nil
            end
        end
    end)
end
--
        Lib:Notify("Aimbot enabled", 2)
    else
        if S.AimBot.FOVCircle then
            S.AimBot.FOVCircle:Remove()
            S.AimBot.FOVCircle = nil
        end
--
        if S.AimBot.FOVUpdateConnection then
            S.AimBot.FOVUpdateConnection:Disconnect()
            S.AimBot.FOVUpdateConnection = nil
        end
--
        if S.AimBot.Connection then
            S.AimBot.Connection:Disconnect()
            S.AimBot.Connection = nil
        end
--
        S.AimBot.Target = nil
        Lib:Notify("Aimbot disabled", 2)
    end
end
--
local function cleanupAimBot()
    if S.AimBot.Enabled then
        toggleAimBot(false)
    end
--
    if S.AimBot.FOVCircle then
        S.AimBot.FOVCircle:Remove()
        S.AimBot.FOVCircle = nil
    end
--
    if S.AimBot.FOVUpdateConnection then
        S.AimBot.FOVUpdateConnection:Disconnect()
        S.AimBot.FOVUpdateConnection = nil
    end
--
    if S.AimBot.Connection then
        S.AimBot.Connection:Disconnect()
        S.AimBot.Connection = nil
    end
--
    S.AimBot.Target = nil
end
--
-- END ORIGINAL SOURCE LINES 778-1053

-- BEGIN ORIGINAL SOURCE LINES 1232-1367
-- ==================== NO RECOIL FUNCTIONS ====================
--
local function cacheWeapons_NR()
    S.NoRecoil.WeaponCache = {}
    for _, v in pairs(getgc(true)) do
        if type(v) == 'table' and rawget(v, 'EquipTime') then
            table.insert(S.NoRecoil.WeaponCache, v)
            if not S.NoRecoil.OriginalValues[v] then
                S.NoRecoil.OriginalValues[v] = {
                    Recoil = v.Recoil,
                    CameraRecoilingEnabled = v.CameraRecoilingEnabled,
                    AngleX_Min = v.AngleX_Min,
                    AngleX_Max = v.AngleX_Max,
                    AngleY_Min = v.AngleY_Min,
                    AngleY_Max = v.AngleY_Max,
                    AngleZ_Min = v.AngleZ_Min,
                    AngleZ_Max = v.AngleZ_Max,
                    Spread = v.Spread
                }
            end
        end
    end
end
--
local function applyGunMods_NR()
    for _, weapon in ipairs(S.NoRecoil.WeaponCache) do
        if S.NoRecoil.Settings.GunMods.NoRecoil then
            weapon.Recoil = 0
            weapon.CameraRecoilingEnabled = false
            weapon.AngleX_Min = 0
            weapon.AngleX_Max = 0
            weapon.AngleY_Min = 0
            weapon.AngleY_Max = 0
            weapon.AngleZ_Min = 0
            weapon.AngleZ_Max = 0
        end
        if S.NoRecoil.Settings.GunMods.Spread then
            weapon.Spread = S.NoRecoil.Settings.GunMods.SpreadAmount
        end
    end
end
--
local function resetGunMods_NR()
    for weapon, values in pairs(S.NoRecoil.OriginalValues) do
        if weapon then
            pcall(function()
                weapon.Recoil = values.Recoil
                weapon.CameraRecoilingEnabled = values.CameraRecoilingEnabled
                weapon.AngleX_Min = values.AngleX_Min
                weapon.AngleX_Max = values.AngleX_Max
                weapon.AngleY_Min = values.AngleY_Min
                weapon.AngleY_Max = values.AngleY_Max
                weapon.AngleZ_Min = values.AngleZ_Min
                weapon.AngleZ_Max = values.AngleZ_Max
                weapon.Spread = values.Spread
            end)
        end
    end
end
--
local function handleWeapon_NR(weapon)
    if S.NoRecoil.Enabled then
        task.wait(0.1)
        cacheWeapons_NR()
        applyGunMods_NR()
    end
end
--
local function onCharacterAdded_NR(character)
    for _, child in ipairs(character:GetChildren()) do
        if child:IsA("Tool") then
            handleWeapon_NR(child)
        end
    end
--
    local childConn = character.ChildAdded:Connect(function(child)
        if child:IsA("Tool") then
            handleWeapon_NR(child)
        end
    end)
    table.insert(S.NoRecoil.Connections, childConn)
--
    local humanoid = character:WaitForChild("Humanoid", 2)
    if humanoid then
        local diedConn = humanoid.Died:Connect(function()
            if S.NoRecoil.Enabled then
                task.wait(1.5)
                cacheWeapons_NR()
                applyGunMods_NR()
            end
        end)
        table.insert(S.NoRecoil.Connections, diedConn)
    end
end
--
local function enableNoRecoil()
    if S.NoRecoil.Enabled then return end
    S.NoRecoil.Enabled = true
    S.NoRecoil.WeaponCache = {}
    S.NoRecoil.OriginalValues = {}
--
    cacheWeapons_NR()
    applyGunMods_NR()
--
    local charConn = LP.CharacterAdded:Connect(onCharacterAdded_NR)
    table.insert(S.NoRecoil.Connections, charConn)
--
    if LP.Character then
        onCharacterAdded_NR(LP.Character)
    end
--
    Lib:Notify("No Recoil enabled", 2)
end
--
local function disableNoRecoil()
    if not S.NoRecoil.Enabled then return end
    S.NoRecoil.Enabled = false
--
    resetGunMods_NR()
--
    for _, conn in ipairs(S.NoRecoil.Connections) do
        conn:Disconnect()
    end
    S.NoRecoil.Connections = {}
--
    Lib:Notify("No Recoil disabled", 2)
end
--
local function toggleNoRecoil(state)
    if state then
        enableNoRecoil()
    else
        disableNoRecoil()
    end
end
--
-- END ORIGINAL SOURCE LINES 1232-1367

-- BEGIN ORIGINAL SOURCE LINES 2985-3129
-- ==================== AIMBOT UI ====================
--
local AimBotGroup = Tabs.Combat:AddLeftGroupbox("Aimbot")
--
AimBotGroup:AddToggle("AimBotToggle", {
    Text = "Enable Aimbot",
    Default = false,
    Callback = function(state)
        toggleAimBot(state)
    end
})
--
AimBotGroup:AddDropdown("AimBotTargetPart", {
    Values = {"Head", "Torso", "HumanoidRootPart", "LeftArm", "RightArm", "LeftLeg", "RightLeg"},
    Default = "Head",
    Multi = false,
    Text = "Target Part",
    Callback = function(value)
        S.AimBot.TargetPart = value
        Lib:Notify("Target Part: " .. value, 2)
    end
})
--
AimBotGroup:AddSlider("AimBotSmoothness", {
    Text = "Smoothness",
    Default = 0.1,
    Min = 0.01,
    Max = 1,
    Rounding = 2,
    Compact = false,
    Callback = function(value)
        S.AimBot.Smoothness = value
        Lib:Notify("Smoothness: " .. string.format("%.2f", value), 2)
    end
})
--
AimBotGroup:AddSlider("AimBotPrediction", {
    Text = "Prediction",
    Default = 100,
    Min = 1,
    Max = 500,
    Rounding = 0,
    Compact = false,
    Callback = function(value)
        S.AimBot.Prediction = value
        Lib:Notify("Prediction: " .. value, 2)
    end
})
--
AimBotGroup:AddSlider("AimBotFOV", {
    Text = "FOV Circle",
    Default = 100,
    Min = 10,
    Max = 500,
    Rounding = 0,
    Compact = false,
    Callback = function(value)
        S.AimBot.FOV = value
        Lib:Notify("FOV: " .. value, 2)
    end
})
--
AimBotGroup:AddToggle("AimBotShowFOV", {
    Text = "Show FOV Circle",
    Default = true,
    Callback = function(state)
        S.AimBot.ShowFOV = state
        if state then
            CreateFOVCircle()
            Lib:Notify("FOV Circle shown", 2)
        else
            if S.AimBot.FOVCircle then
                S.AimBot.FOVCircle:Remove()
                S.AimBot.FOVCircle = nil
            end
            Lib:Notify("FOV Circle hidden", 2)
        end
    end
})
--
AimBotGroup:AddLabel("FOV Color:"):AddColorPicker("AimBotFOVColor", {
    Default = S.AimBot.FOVColor,
    Title = "FOV Circle Color",
    Callback = function(color)
        S.AimBot.FOVColor = color
        if S.AimBot.FOVCircle then
            S.AimBot.FOVCircle.Color = color
        end
        Lib:Notify("FOV Color changed", 2)
    end
})
--
AimBotGroup:AddSlider("AimBotFOVTransparency", {
    Text = "FOV Transparency",
    Default = 0.5,
    Min = 0,
    Max = 1,
    Rounding = 2,
    Compact = false,
    Callback = function(value)
        S.AimBot.FOVTransparency = value
        if S.AimBot.FOVCircle then
            S.AimBot.FOVCircle.Transparency = value
        end
        Lib:Notify("FOV Transparency: " .. string.format("%.2f", value), 2)
    end
})
--
AimBotGroup:AddToggle("AimBotWallCheck", {
    Text = "Wall Check",
    Default = true,
    Callback = function(state)
        S.AimBot.WallCheck = state
        Lib:Notify("Wall Check: " .. tostring(state), 2)
    end
})
--
AimBotGroup:AddToggle("AimBotSticky", {
    Text = "Sticky Aim",
    Default = true,
    Tooltip = "Sticky aim here",
    Callback = function(state)
        S.AimBot.Sticky = state
        if not state then
            -- Ecли Sticky bыkлючили, cбpacыbaem tekyщyю цeль, чtoбы aиmбot moг cboбoдho пepekлючatьcя.
            S.AimBot.Target = nil
        end
        Lib:Notify("Sticky Aim: " .. tostring(state), 2)
    end
})
--
AimBotGroup:AddToggle("AimBotDownedCheck", {
    Text = "Downed Check",
    Default = true,
    Callback = function(state)
        S.AimBot.DownedCheck = state
        Lib:Notify("Downed Check: " .. tostring(state), 2)
    end
})
--
AimBotGroup:AddDivider()
AimBotGroup:AddLabel("FOV is fixed at screen center")
--
-- ==================== OCHOBHOЙ KOД ПPOДOЛЖAETCЯ ====================
--
-- END ORIGINAL SOURCE LINES 2985-3129

-- BEGIN ORIGINAL SOURCE LINES 3643-4057
local function getClosest()
    local closest = nil; local minD = RSett.MaxDist; local myC = LP.Character; local myR = getHRP(myC); if not myR then return nil end
    if S.Rage.UseList then
        local cnt = 0; for _ in pairs(S.Rage.List) do cnt=cnt+1 end; if cnt==0 then return nil end
        for _, p in ipairs(Plrs:GetPlayers()) do
            if p ~= LP then
                local should = false
                for tn, _ in pairs(S.Rage.List) do if p.Name == tn then should = true; break end end
                if should then
                    local eC = p.Character; local eR = eC and eC:FindFirstChild("HumanoidRootPart"); local eH = eC and eC:FindFirstChildOfClass("Humanoid")
                    if eR and eH and eH.Health > RSett.MinHP and not eC:FindFirstChildOfClass("ForceField") then
                        local d = (myR.Position - eR.Position).Magnitude
                        if d < minD then minD = d; closest = p end
                    end
                end
            end
        end
    else
        for _, p in ipairs(Plrs:GetPlayers()) do
            if p ~= LP then
                local eC = p.Character; local eR = eC and eC:FindFirstChild("HumanoidRootPart"); local eH = eC and eC:FindFirstChildOfClass("Humanoid")
                if eR and eH and eH.Health > RSett.MinHP and not eC:FindFirstChildOfClass("ForceField") then
                    local d = (myR.Position - eR.Position).Magnitude
                    if d < minD then minD = d; closest = p end
                end
            end
        end
    end
    return closest
end
--
local function Shoot(t)
    if Lib.Unloaded or not S.Rage.On then return end
    if not t or not t.Character then return end
    local tp = t.Character:FindFirstChild("Head") or t.Character:FindFirstChild("HumanoidRootPart")
    if not tp then return end
    local myC = LP.Character
    local tool = myC and myC:FindFirstChildOfClass("Tool")
    if not tool then return end
    local myR = myC:FindFirstChild("HumanoidRootPart")
    local eR = t.Character:FindFirstChild("HumanoidRootPart")
    if myR and eR then
        local d = (myR.Position - eR.Position).Magnitude
        if d > RSett.MaxDist then return end
    end
    local cam = workspace.CurrentCamera
    local hitPos = tp.Position
    local hitDir = (hitPos - cam.CFrame.Position).Unit
--
    -- Дoбabляem пpeдckaзahиe и cлyчaйhoe cmeщehиe kak b Silent Aim
    if S.AimBot.Prediction > 0 then
        local velocity = eR and eR.Velocity or Vector3.new(0,0,0)
        local predictionMultiplier = S.AimBot.Prediction / 100
        hitPos = hitPos + (velocity * predictionMultiplier * 0.1)
    end
--
    local rOff = Vector3.new((math.random()-0.5)*0.5, (math.random()-0.5)*0.5, (math.random()-0.5)*0.5)
    hitPos = hitPos + rOff
    hitDir = (hitPos - cam.CFrame.Position).Unit
--
    local rKey = randStr(30) .. "0"
    if not GNX or not ZFK then return end
--
    pcall(function() GNX:FireServer(tick(), rKey, tool, "FDS9I83", cam.CFrame.Position, {hitDir}, false) end)
    pcall(function() ZFK:FireServer("🧈", tool, rKey, 1, tp, hitPos, hitDir, nil, nil) end)
--
    -- Дoбabляem tpeйcep для BulletBeam пpи ctpeльбe c Ragebot
    if BB.On then
        local mzl = findMzl(tool)
        local mzlPos = mzl and mzl.Position or cam.CFrame.Position
        crTracer(mzlPos, hitPos, BB.Col)
    end
--
    if tp and tp.Name == "Head" then
        PlayHSound()
    end
end
--
local function RageLoop()
    while S.Rage.On do
        local myC = LP.Character; if myC and myC:FindFirstChildOfClass("Tool") then
            local t = getClosest(); S.Rage.Target = t; if t then Shoot(t) end
        else S.Rage.Target = nil end
        task.wait(RSett.FireDelay)
    end
    S.Rage.Target = nil
end
--
local function Rage_setDist(v) RSett.MaxDist = v end
local function Rage_setMinHP(v) RSett.MinHP = v end
local function Rage_setFR(v) local t = math.clamp(v,1,100); RSett.FireDelay = 0.5 - ((t-1)/99)*(0.5-0.01) end
local function Rage_setHM(v) RSett.Hitmarkers = v end
--
local function Rage_on()
    if S.Rage.On then return end; S.Rage.On = true
    if not S.Rage.Task then S.Rage.Task = task.spawn(RageLoop) end
    Lib:Notify("Rage on", 3)
end
--
local function Rage_off()
    S.Rage.On = false; if S.Rage.Task then task.cancel(S.Rage.Task); S.Rage.Task = nil end
    Lib:Notify("Rage off", 3)
end
--
local gunR = RepSt.Events:FindFirstChild("GNX_R")
--
local function setupInstReload(c)
    if not c or not S.InstReload.On then return end
    local function setupTool(t)
        if not t or not t:FindFirstChild("IsGun") then return end
        local vals = t:FindFirstChild("Values"); if not vals then return end
        local ammo = vals:FindFirstChild("SERVER_Ammo"); local stored = vals:FindFirstChild("SERVER_StoredAmmo")
        if not ammo or not stored then return end
        local c1 = stored:GetPropertyChangedSignal("Value"):Connect(function() if stored.Value ~= 0 then gunR:FireServer(tick(), "KLWE89U0", t) end end)
        local c2 = ammo:GetPropertyChangedSignal("Value"):Connect(function() if stored.Value ~= 0 then gunR:FireServer(tick(), "KLWE89U0", t) end end)
        table.insert(S.InstReload.Conns, c1); table.insert(S.InstReload.Conns, c2)
        if stored.Value ~= 0 then gunR:FireServer(tick(), "KLWE89U0", t) end
    end
    for _, t in pairs(c:GetChildren()) do if t:IsA("Tool") and t:FindFirstChild("IsGun") then setupTool(t) end end
    local c3 = c.ChildAdded:Connect(function(t) if t:IsA("Tool") and t:FindFirstChild("IsGun") then wait(0.1); setupTool(t) end end)
    table.insert(S.InstReload.Conns, c3)
end
--
local function toggleInstReload(state)
    S.InstReload.On = state
    if S.InstReload.On then
        for _, c in pairs(S.InstReload.Conns) do if c then c:Disconnect() end end
        S.InstReload.Conns = {}
        if LP.Character then setupInstReload(LP.Character) end
        local c = LP.CharacterAdded:Connect(function(c) wait(0.5); if S.InstReload.On then setupInstReload(c) end end)
        table.insert(S.InstReload.Conns, c)
        Lib:Notify("InstReload on", 2)
    else
        for _, c in pairs(S.InstReload.Conns) do if c then c:Disconnect() end end
        S.InstReload.Conns = {}; Lib:Notify("InstReload off", 2)
    end
end
--
local function MeleeA_on()
    if S.MeleeA.On then return end
    local plrs = game:GetService("Players"); local me = plrs.LocalPlayer; local run = RS
    local rep = RepSt; local evf = rep:WaitForChild("Events")
    local rf = evf:WaitForChild("XMHH.2"); local re = evf:WaitForChild("XMHH2.2")
    local maxd = 5
    local function Attack(t)
        if not (t and t:FindFirstChild("Head")) then return end
        local c = me.Character; local tool = c and c:FindFirstChildOfClass("Tool"); local hrp = c and c:FindFirstChild("HumanoidRootPart")
        if not rf or not rf:IsA("RemoteFunction") then warn("MeleeA err: no RF"); return end
        if not re or not re:IsA("RemoteEvent") then warn("MeleeA err: no RE"); return end
        local a1 = {[1]="🍞",[2]=tick(),[3]=tool,[4]="43TRFWX",[5]="Normal",[6]=tick(),[7]=true}
        local suc, res = pcall(function() return rf:InvokeServer(unpack(a1)) end)
        if not suc then warn("MeleeA invoke fail:", res); return end
        task.wait(0.1)
        local h = tool and (tool:FindFirstChild("WeaponHandle") or tool:FindFirstChild("Handle")) or (c and c:FindFirstChild("Right Arm"))
        local head = t:FindFirstChild("Head")
        if h and head and hrp then
            local a2 = {[1]="🍞",[2]=tick(),[3]=tool,[4]="2389ZFX34",[5]=res,[6]=false,[7]=h,[8]=head,[9]=t,[10]=hrp.Position,[11]=head.Position}
            local suc2, err2 = pcall(function() re:FireServer(unpack(a2)) end)
            if not suc2 then warn("MeleeA fire fail:", err2) end
        end
    end
    S.MeleeA.On = true; _G.MeleePersist = true
    S.MeleeA.Conn = run.RenderStepped:Connect(function()
        if not S.MeleeA.On then return end
        local c = me.Character; local hrp = c and c:FindFirstChild("HumanoidRootPart")
        if hrp then for _, p in ipairs(plrs:GetPlayers()) do
            if p ~= me then
                local ec = p.Character; local ehrp = ec and ec:FindFirstChild("HumanoidRootPart"); local eh = ec and ec:FindFirstChildOfClass("Humanoid")
                if ehrp and eh then
                    local d = (hrp.Position - ehrp.Position).Magnitude
                    if d < maxd and eh.Health > 15 and not ec:FindFirstChildOfClass("ForceField") then Attack(ec) end
                end
            end
        end end
    end)
    Lib:Notify("MeleeA on", 2)
end
--
local function MeleeA_off()
    if not S.MeleeA.On then return end; S.MeleeA.On = false; _G.MeleePersist = false
    if S.MeleeA.Conn then S.MeleeA.Conn:Disconnect(); S.MeleeA.Conn = nil end
    Lib:Notify("MeleeA off", 2)
end
--
local function toggleMeleeA(state) if state then MeleeA_on() else MeleeA_off() end end
--
_G.ActivateShadow = function() if S.Shadow.Active or not S.Shadow.Usable then return end; S.Shadow.Active = true; _G.InvPersist = true; Lib:Notify("Inv on", 2) end
_G.DeactivateShadow = function() if not S.Shadow.Active then return end; S.Shadow.Active = false; _G.InvPersist = false; Lib:Notify("Inv off", 2) end
_G.IsShadowActive = function() return S.Shadow.Active end
local function toggleInv(state) if state then _G.ActivateShadow() else _G.DeactivateShadow() end end
--
task.spawn(function()
    repeat task.wait() until game:IsLoaded()
    local svc_ref = cloneref or function(...) return ... end
    local GS = setmetatable({}, {__index = function(_,k) return svc_ref(game:GetService(k)) end})
    local P = Plrs.LocalPlayer; local C = P.Character or P.CharacterAdded:Wait(); local H; local HRP
    local function refresh() C = P.Character; if C then HRP = C:FindFirstChild("HumanoidRootPart"); H = C:FindFirstChildOfClass("Humanoid") else HRP=nil; H=nil end end
    refresh()
    local animCache = nil; local camoAnim = Instance.new("Animation", nil); camoAnim.AnimationId = "rbxassetid://215384594"
    local RS2 = GS.RunService; local UpdF = RS2.Heartbeat; local WaitR = RS2.RenderStepped
    local CG = GS.CoreGui; local SG = GS.StarterGui
    local HUD = Instance.new("ScreenGui"); HUD.Name = "ShadowWarningHUD"; HUD.Parent = CG; HUD.ResetOnSpawn = false; HUD.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    local WarnTxt = Instance.new("TextLabel", HUD); WarnTxt.Text = "⚠️Visible⚠️"; WarnTxt.Visible = false
    WarnTxt.Size = UDim2.new(0,200,0,30); WarnTxt.Position = UDim2.new(0.5,-100,0.85,0); WarnTxt.BackgroundTransparency = 1
    WarnTxt.Font = Enum.Font.GothamSemibold; WarnTxt.TextSize = 24; WarnTxt.TextColor3 = Color3.fromRGB(255,255,0); WarnTxt.TextStrokeTransparency = 0.5; WarnTxt.ZIndex = 10
    if C and not C:FindFirstChild("Torso") then
        pcall(function() SG:SetCore("SendNotification", {Title="Shadow FAIL", Text="Need R6", Duration=5}) end)
        S.Shadow.Usable = false
    end
    local function chkGround() return H and H:IsDescendantOf(workspace) and H.FloorMaterial ~= Enum.Material.Air end
    local function cacheAnim()
        if animCache then pcall(function() animCache:Stop() end); animCache = nil end
        if H then local suc, res = pcall(function() return H:LoadAnimation(camoAnim) end); if suc then animCache = res; animCache.Priority = Enum.AnimationPriority.Action4 else animCache = nil end
        else animCache = nil end
    end
    local function applyShadow(dt)
        if not S.Shadow.Active or not S.Shadow.Usable then return end
        if not C or not H or not HRP or not H:IsDescendantOf(workspace) or H.Health <= 0 then WarnTxt.Visible = false; return end
        WarnTxt.Visible = not chkGround()
        local initCF = HRP.CFrame; local initCamOff = H.CameraOffset
        local _, yaw = workspace.CurrentCamera.CFrame:ToOrientation()
        HRP.CFrame = CFrame.new(HRP.CFrame.Position) * CFrame.fromOrientation(0,yaw,0)
        HRP.CFrame = HRP.CFrame * CFrame.Angles(math.rad(90),0,0); H.CameraOffset = Vector3.new(0,1.44,0)
        if animCache then local suc = pcall(function() if not animCache.IsPlaying then animCache:Play() end; animCache:AdjustSpeed(0); animCache.TimePosition = 0.3 end)
            if not suc then cacheAnim() end
        elseif H and H.Health > 0 then cacheAnim() end
        WaitR:Wait()
        if H and H:IsDescendantOf(workspace) then H.CameraOffset = initCamOff end
        if HRP and HRP:IsDescendantOf(workspace) then HRP.CFrame = initCF end
        if H and H:IsDescendantOf(workspace) and H.MoveDirection.Magnitude > 0 then
            local ws = 12; local vo = H.MoveDirection * ws * dt; HRP.CFrame = HRP.CFrame + vo
        end
        if animCache then pcall(function() animCache:Stop() end) end
        if HRP and HRP:IsDescendantOf(workspace) then
            local lv = workspace.CurrentCamera.CFrame.LookVector; local flat = Vector3.new(lv.X,0,lv.Z).Unit
            if flat.Magnitude > 0.1 then local fCF = CFrame.new(HRP.Position, HRP.Position+flat); HRP.CFrame = fCF end
        end
        if C then for _, v in pairs(C:GetDescendants()) do if v:IsA("BasePart") and v.Transparency ~= 1 then v.Transparency = 0.5 end end end
    end
    local shadowConn = UpdF:Connect(function(dt)
        if not S.Shadow.Active or not S.Shadow.Usable then
            if not S.Shadow.Active and C then for _, v in pairs(C:GetDescendants()) do if v:IsA("BasePart") and v.Transparency == 0.5 then v.Transparency = 0 end end end
            WarnTxt.Visible = false; return
        end
        applyShadow(dt)
    end)
    P.CharacterAdded:Connect(function(nc)
        if animCache then pcall(function() animCache:Stop() end); animCache = nil end
        task.wait(0.5); refresh()
        if not H then task.wait(0.5); refresh(); if not H then S.Shadow.Usable = false; if S.Shadow.Active then _G.DeactivateShadow() end
            pcall(function() SG:SetCore("SendNotification", {Title="Shadow Err", Text="No char type", Duration=5}) end) return end end
        if H.RigType ~= Enum.HumanoidRigType.R6 then
            S.Shadow.Usable = false; if S.Shadow.Active then _G.DeactivateShadow() end
            pcall(function() SG:SetCore("SendNotification", {Title="Shadow Warn", Text="Non-R6 ("..tostring(H.RigType)..")", Duration=5}) end)
            return
        else S.Shadow.Usable = true end
        if _G.InvPersist and S.Shadow.Usable then task.wait(1); _G.ActivateShadow(); Lib:Notify("Inv restored", 2) end
    end)
    P.CharacterRemoving:Connect(function(oc) if animCache then pcall(function() animCache:Stop() end); animCache = nil end; WarnTxt.Visible = false end)
    if _G.InvPersist and S.Shadow.Usable then task.wait(2); _G.ActivateShadow() end
end)
--
SA = {
    On = false, DrawCircle = true, DrawSize = 120, ChkDowned = true, ChkTeam = true, VisChk = false,
    MaxDist = 300, AutoWall = true, HitChance = 80, UseFOV = true, Debug = false,
    FOVCol = Color3.fromRGB(255,0,0), TMode = "Head",
    Parts = {["Head"]={"Head"}, ["Torso"]={"UpperTorso","LowerTorso","HumanoidRootPart"}, ["Random"]={"Head","UpperTorso","LowerTorso","HumanoidRootPart","LeftUpperArm","RightUpperArm","LeftUpperLeg","RightUpperLeg"}}
}
--
SACircle = nil
local function crFOVCircle()
    if SACircle then SACircle:Remove(); SACircle = nil end
    if SA.DrawCircle and Drawing then
        SACircle = Drawing.new("Circle"); SACircle.Color = SA.FOVCol; SACircle.Filled = false
        SACircle.Thickness = 2; SACircle.Radius = SA.DrawSize; SACircle.Visible = true; SACircle.Transparency = 1
    end
end
--
local function getValidT()
    if not SA.On then return nil end
    local t = nil; local minD = math.huge; local centerPos = Vector2.new(Cam.ViewportSize.X/2, Cam.ViewportSize.Y/2)
    for _, p in pairs(Plrs:GetPlayers()) do
        if p == LP then continue end; if not p.Character then continue end
        if SA.ChkTeam and p.Team == LP.Team then continue end
        local c = p.Character; local h = c:FindFirstChildOfClass("Humanoid")
        if not h or h.Health <= 0 then continue end
        local validP = SA.Parts[SA.TMode]; if not validP then validP = {"Head"} end
        local avail = {}; for _, pn in ipairs(validP) do local pt = c:FindFirstChild(pn); if pt then table.insert(avail, {Part=pt, Name=pn}) end end
        if #avail == 0 then continue end
        local sel = nil
        if SA.TMode == "Head" then sel = avail[1]
        elseif SA.TMode == "Torso" then sel = avail[math.random(1,#avail)]
        elseif SA.TMode == "Random" then sel = avail[math.random(1,#avail)]
        else sel = avail[1] end
        if not sel then continue end
        local tp = sel.Part; local pPos = tp.Position
        local myC = LP.Character; local myR = myC and myC:FindFirstChild("HumanoidRootPart")
        if myR then local d = (myR.Position - pPos).Magnitude; if d > SA.MaxDist then continue end end
        local sPos, onSc = Cam:WorldToViewportPoint(pPos); if not onSc then continue end
        if SA.UseFOV then
            local sPt = Vector2.new(sPos.X, sPos.Y); local dToM = (centerPos - sPt).Magnitude
            if dToM > SA.DrawSize then continue end
            if dToM < minD then minD = dToM; t = {Player=p, Char=c, Part=tp, PName=sel.Name, Pos=pPos, Dist=dToM, ScPos=sPos, WDist=(myR and (myR.Position-pPos).Magnitude) or 0} end
        else
            if myR then local wd = (myR.Position - pPos).Magnitude; if wd < minD then minD = wd; t = {Player=p, Char=c, Part=tp, PName=sel.Name, Pos=pPos, Dist=0, ScPos=sPos, WDist=wd} end end
        end
    end
    if t then local ch = math.random(1,100); if ch > SA.HitChance then return nil end end
    return t
end
--
local function canFire(t) if not t then return false end; if SA.UseFOV and t.Dist > SA.DrawSize then return false end; return true end
--
SALoopConn = nil
local function updFOVCircle()
    if SACircle and SA.DrawCircle then
        SACircle.Position = Vector2.new(Cam.ViewportSize.X/2, Cam.ViewportSize.Y/2)
        SACircle.Radius = SA.DrawSize; SACircle.Visible = SA.On; SACircle.Color = SA.FOVCol
    end
end
--
local function startSALoop()
    if SALoopConn then SALoopConn:Disconnect() end
    SALoopConn = RS.Heartbeat:Connect(function() updFOVCircle(); _G.CurSATarget = getValidT() end)
end
--
SAConns = {}; local lastT = nil; local lastDmg = false
--
local function hookShoot()
    for _, c in pairs(SAConns) do if c then c:Disconnect() end end; SAConns = {}
    local ev2 = RepSt:FindFirstChild("Events2")
    if ev2 then
        local viz = ev2:FindFirstChild("Visualize")
        if viz then
            local c = viz.Event:Connect(function(_, sc, _, gun, _, sPos, bps)
                if not SA.On then return end
                local t = getValidT(); if not t or not canFire(t) then lastT = nil; lastDmg = false; return end
                lastT = t; local c = LP.Character; if not c then return end
                local myG = c:FindFirstChildOfClass("Tool"); if not myG or myG ~= gun then return end
                local h = t.Char:FindFirstChildOfClass("Humanoid"); if not h or h.Health <= 0 then return end
                local tp = t.Part; local pPos = tp.Position
                local rOff = Vector3.new((math.random()-0.5)*0.5,(math.random()-0.5)*0.5,(math.random()-0.5)*0.5)
                local hitPos = pPos + rOff
                local newB = {}; for i=1,#bps do
                    local dir = (hitPos - sPos).Unit; local spAmt = (100 - SA.HitChance)/500
                    local sp = Vector3.new((math.random()-0.5)*spAmt,(math.random()-0.5)*spAmt,(math.random()-0.5)*spAmt)
                    table.insert(newB, dir+sp)
                end
                lastDmg = true
                local function playHit() if not HSett.On then return end; PlayHSound() end
                task.spawn(function()
                    for i=1,#newB do task.wait(0.01); pcall(function() ZFK:FireServer("🧈", gun, sc, i, tp, hitPos, newB[i]) end) end
                    playHit(); Lib:Notify(string.format("Hit: %s (%s)", t.Player.Name, t.PName), 2)
                end)
                if BB.On and lastDmg then local mzl = findMzl(gun); local mzlPos = mzl and mzl.Position or sPos; for _, dir in pairs(newB) do crTracer(mzlPos, hitPos, Color3.fromRGB(0,255,0)) end end
                if gun:FindFirstChild("Hitmarker") and lastDmg then gun.Hitmarker:Fire(tp) end
                if lastDmg then return _, sc, _, gun, _, sPos, newB end
                return _, sc, _, gun, _, sPos, bps
            end)
            table.insert(SAConns, c)
        end
    end
    if GNX then
        local c = GNX.OnClientEvent:Connect(function(st, sc, gun, ft, sPos, dirs, silenced)
            if not SA.On then return end
            local t = getValidT(); if not t or not canFire(t) then lastT = nil; lastDmg = false; return end
            lastT = t; local c = LP.Character; if not c then return end
            local myG = c:FindFirstChildOfClass("Tool"); if not myG or myG ~= gun then return end
            local h = t.Char:FindFirstChildOfClass("Humanoid"); if not h or h.Health <= 0 then return end
            local tp = t.Part; local pPos = tp.Position
            local rOff = Vector3.new((math.random()-0.5)*0.5,(math.random()-0.5)*0.5,(math.random()-0.5)*0.5)
            local hitPos = pPos + rOff
            local newD = {}; for i=1,#dirs do
                local dir = (hitPos - sPos).Unit; local spAmt = (100 - SA.HitChance)/400
                local sp = Vector3.new((math.random()-0.5)*spAmt,(math.random()-0.5)*spAmt,(math.random()-0.5)*spAmt)
                table.insert(newD, dir+sp)
            end
            lastDmg = true
            local function playHit() if not HSett.On then return end; PlayHSound() end
            task.spawn(function()
                for i=1,#newD do task.wait(0.01); pcall(function() ZFK:FireServer("🧈", gun, sc, i, tp, hitPos, newD[i]) end) end
                playHit(); Lib:Notify(string.format("Hit: %s (%s)", t.Player.Name, t.PName), 2)
            end)
            if BB.On and lastDmg then local mzl = findMzl(gun); local mzlPos = mzl and mzl.Position or sPos; for _, dir in pairs(newD) do crTracer(mzlPos, hitPos, Color3.fromRGB(0,255,0)) end end
            if gun:FindFirstChild("Hitmarker") and lastDmg then gun.Hitmarker:Fire(tp) end
            if lastDmg then return st, sc, gun, ft, sPos, newD, silenced end
            return st, sc, gun, ft, sPos, dirs, silenced
        end)
        table.insert(SAConns, c)
    end
end
--
local function toggleSA(state)
    if state and SA.On then return end; if not state and not SA.On then return end
    SA.On = state
    if state then
        crFOVCircle(); startSALoop(); hookShoot(); Lib:Notify("SA on", 2)
    else
        if SALoopConn then SALoopConn:Disconnect(); SALoopConn = nil end
        if SACircle then SACircle:Remove(); SACircle = nil end
        for _, c in pairs(SAConns) do if c then c:Disconnect() end end; SAConns = {}
        _G.CurSATarget = nil; lastT = nil; lastDmg = false; Lib:Notify("SA off", 2)
    end
end
--
local function cleanupSA()
    if SA.On then toggleSA(false) end
    if SACircle then SACircle:Remove(); SACircle = nil end
    for _, c in pairs(SAConns) do if c then c:Disconnect() end end; SAConns = {}
    if SALoopConn then SALoopConn:Disconnect(); SALoopConn = nil end
    _G.CurSATarget = nil; lastT = nil; lastDmg = false
    SA = {On=false, DrawCircle=true, DrawSize=120, ChkDowned=true, ChkTeam=true, VisChk=false, MaxDist=300, AutoWall=true, HitChance=80, UseFOV=true, Debug=false, FOVCol=Color3.fromRGB(255,0,0), TMode="Head", Parts={["Head"]={"Head"},["Torso"]={"UpperTorso","LowerTorso","HumanoidRootPart"},["Random"]={"Head","UpperTorso","LowerTorso","HumanoidRootPart"}}}
    if Toggles and Toggles.SAToggle then Toggles.SAToggle:SetValue(false) end
end
--
-- END ORIGINAL SOURCE LINES 3643-4057

-- BEGIN ORIGINAL SOURCE LINES 7492-7531
RageL = Tabs.Combat:AddLeftGroupbox("Ragebot")
RageR = Tabs.Combat:AddRightGroupbox("Rage settings")
--
RageL:AddToggle("RagebotToggle", {Text="Enable Ragebot", Default=false, Callback=function(v) if v then Rage_on() else Rage_off() end end}):AddKeyPicker("RagebotKey", {Default="None", SyncToggleState=false, Mode="Toggle", Text="Ragebot key", NoUI=false, Callback=function(k) if not canBind() then return end; Toggles.RagebotToggle:SetValue(not Toggles.RagebotToggle.Value) end})
--
RageL:AddSlider("RageDistance", {Text="Max distance", Default=200, Min=0, Max=1000, Rounding=0, Compact=false, Callback=function(v) Rage_setDist(v) end})
RageL:AddSlider("RageMinHP", {Text="Min enemy HP", Default=15, Min=1, Max=115, Rounding=0, Compact=false, Callback=function(v) Rage_setMinHP(v) end})
RageL:AddSlider("RageFireRate", {Text="Fire rate (1-100)", Default=50, Min=1, Max=100, Rounding=0, Compact=false, Callback=function(v) Rage_setFR(v) end})
--
RageR:AddToggle("RageUseTargetListToggle", {Text="Target specific players", Default=false, Callback=function(v)
    S.Rage.UseList = v
    if v then if #S.Rage.List == 0 then Lib:Notify("List empty - no attack", 2) else Lib:Notify("List on - attack selected", 2) end
    else Lib:Notify("List off - attack all", 2) end
end})
--
RageR:AddDropdown("RageTargetDropdown", {SpecialType="Player", Multi=true, Text="Select targets", Callback=function(v) S.Rage.List = v; if #v > 0 then Lib:Notify(#v.." target(s)", 2) else Lib:Notify("List cleared", 2) end end})
--
RageR:AddDivider(); RageR:AddLabel("Hitsounds:")
RageR:AddToggle("RageSoundsToggle", {Text="Enable hitsounds", Default=true, Tooltip="Sound on headshot", Callback=function(v) HSett.On = v; Lib:Notify(v and "Hitsounds ON" or "Hitsounds OFF", 2) end})
RageR:AddDropdown("RageSoundType", {Values={"Boink","TF2","Rust","CSGO","Hitmarker","Fortnite"}, Default="Rust", Multi=false, Text="Sound type", Callback=function(v) HSett.SoundId = HitSounds[v] or HitSounds["Rust"]; UpdHSound(); Lib:Notify("Sound: "..v, 2) end})
RageR:AddSlider("RageSoundVolume", {Text="Volume", Default=1, Min=0, Max=10, Rounding=1, Compact=false, Callback=function(v) HSett.Vol = v; UpdHSound() end})
--
SAGroup = Tabs.Combat:AddRightGroupbox("Silent Aim")
SAGroup:AddToggle("SAToggle", {Text="Enable Silent Aim", Default=false, Callback=function(s) toggleSA(s) end})
SAGroup:AddDropdown("SATargetMode", {Values={"Head","Torso","Random"}, Default="Head", Multi=false, Text="Target Mode", Callback=function(v) SA.TMode = v; Lib:Notify("Mode: "..v, 2); if SA.On then _G.CurSATarget = getValidT() end end})
SAGroup:AddLabel("Mode: "..SA.TMode)
SAGroup:AddSlider("SAFOV", {Text="FOV Circle Size", Default=120, Min=10, Max=500, Rounding=0, Compact=false, Callback=function(v) SA.DrawSize = v; if SACircle then SACircle.Radius = v end end})
SAGroup:AddLabel("FOV Color:"):AddColorPicker("FOVColor", {Default=SA.FOVCol, Title="FOV Circle Color", Callback=function(v) SA.FOVCol = v; if SACircle then SACircle.Color = v end; Lib:Notify("FOV color changed", 2) end})
SAGroup:AddSlider("SAHitChance", {Text="Hit Chance %", Default=80, Min=10, Max=100, Rounding=0, Compact=false, Callback=function(v) SA.HitChance = v; Lib:Notify("HC: "..v.."%", 2) end})
SAGroup:AddToggle("SAShowFOV", {Text="Show FOV Circle", Default=true, Callback=function(s) SA.DrawCircle = s; if s and SA.On then crFOVCircle() elseif not s and SACircle then SACircle:Remove(); SACircle = nil end end})
SAGroup:AddSlider("SAMaxDist", {Text="Max Distance", Default=300, Min=50, Max=1000, Rounding=0, Compact=false, Callback=function(v) SA.MaxDist = v end})
SAGroup:AddToggle("SATeamCheck", {Text="Team Check", Default=true, Callback=function(s) SA.ChkTeam = s end})
SAGroup:AddToggle("SAAutoWall", {Text="Auto Wall", Default=true, Callback=function(s) SA.AutoWall = s end})
tInd = SAGroup:AddLabel("Target: None | Mode: "..SA.TMode.." | HC: "..SA.HitChance.."%")
task.spawn(function() while task.wait(0.3) do if SA.On then local t = _G.CurSATarget; if t then local can = canFire(t); if can then tInd:SetText(string.format("Target: %s (%s) | Mode: %s | HC: %d%%", t.Player.Name, t.PName, SA.TMode, SA.HitChance)); tInd.TextColor3 = Color3.fromRGB(0,255,0) else tInd:SetText(string.format("Target: %s (Out) | Mode: %s | HC: %d%%", t.Player.Name, t.PName, SA.TMode, SA.HitChance)); tInd.TextColor3 = Color3.fromRGB(255,50,50) end else tInd:SetText("Target: None | Mode: "..SA.TMode.." | HC: "..SA.HitChance.."%"); tInd.TextColor3 = Color3.fromRGB(255,255,255) end end end end)
--
FeatL = Tabs.Combat:AddLeftGroupbox("Features")
FeatL:AddToggle("InstReload", {Text="Instant Reload", Default=false, Callback=function(v) toggleInstReload(v) end})
FeatL:AddToggle("MeleeAura", {Text="Melee Aura", Default=false, Callback=function(v) toggleMeleeA(v) end}):AddKeyPicker("MeleeAuraKey", {Default="None", SyncToggleState=false, Mode="Toggle", Text="Melee Aura key", NoUI=false, Callback=function(k) if not canBind() then return end; Toggles.MeleeAura:SetValue(not Toggles.MeleeAura.Value) end})
--
-- END ORIGINAL SOURCE LINES 7492-7531
