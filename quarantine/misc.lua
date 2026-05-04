--[[
Inert commented archive file.
No executable Lua is present below; every preserved source line is prefixed with --.
Role: Admin/AFK checks, miscellaneous view/world-effect controls
Original source line ranges: 3453-3549, 7887-8021
]]


-- BEGIN ORIGINAL SOURCE LINES 3453-3549
local function AFKAction()
    pcall(function() VU:CaptureController(); VU:SetKeyDown('0x20'); task.wait(0.1); VU:SetKeyUp('0x20') end)
    pcall(function()
        local cam = workspace.CurrentCamera
        cam.CFrame = cam.CFrame * CFrame.Angles(math.rad(0.5),0,0)
        task.wait(0.1); cam.CFrame = cam.CFrame * CFrame.Angles(math.rad(-0.5),0,0)
    end)
end
--
local function toggleAFK(state)
    S.AntiAFK.On = state; _G.AFKPersist = state
    if S.AntiAFK.On then
        S.AntiAFK.IdleConn = LP.Idled:Connect(function() if S.AntiAFK.On then AFKAction() end end)
        S.AntiAFK.Coro = coroutine.create(function() while S.AntiAFK.On do AFKAction(); task.wait(30) end end)
        coroutine.resume(S.AntiAFK.Coro); Lib:Notify("AntiAFK on", 2)
    else
        if S.AntiAFK.IdleConn then S.AntiAFK.IdleConn:Disconnect(); S.AntiAFK.IdleConn = nil end
        S.AntiAFK.Coro = nil; Lib:Notify("AntiAFK off", 2)
    end
end
--
local staff = {
    groups = {
        [4165692] = {["Tester"]=true,["Contributor"]=true,["Tester+"]=true,["Developer"]=true,["Developer+"]=true,["Community Manager"]=true,["Manager"]=true,["Owner"]=true},
        [32406137] = {["Junior"]=true,["Moderator"]=true,["Senior"]=true,["Administrator"]=true,["Manager"]=true,["Holder"]=true},
        [14927228] = {["♞"]=true}
    },
    users = {3294804378,93676120,54087314,81275825,140837601,1229486091,46567801,418086275,29706395,3717066084,1424338327,5046662686,5046661126,5046659439,418199326,1024216621,1810535041,63238912,111250044,63315426,730176906,141193516,194512073,193945439,412741116,195538733,102045519,955294,957835150,25689921,366613818,281593651,455275714,208929505,96783330,156152502,93281166,959606619,142821118,632886139,175931803,122209625,278097946,142989311,1517131734,446849296,87189764,67180844,9212846,47352513,48058122,155413858,10497435,513615792,55893752,55476024,151691292,136584758,16983447,3111449,94693025,271400893,5005262660,295331237,64489098,244844600,114332275,25048901,69262878,50801509,92504899,42066711,50585425,31365111,166406495,2457253857,29761878,21831137,948293345,439942262,38578487,1163048,7713309208,3659305297,15598614,34616594,626833004,198610386,153835477,3923114296,3937697838,102146039,119861460,371665775,1206543842,93428604,1863173316,90814576,374665997,423005063,140172831,42662179,9066859,438805620,14855669,727189337,1871290386,608073286}
}
--
local function hasTrack(p)
    if not p or not p:IsA("Player") then return false, nil end
    for _, ch in pairs(p:GetChildren()) do
        if typeof(ch.Name) == "string" and string.sub(ch.Name, -8) == "Tracker$" then
            local tn = string.sub(ch.Name, 1, -9)
            if Plrs:FindFirstChild(tn) then return true, tn end
        end
    end
    return false, nil
end
--
local function isStaff(p)
    if not p or not p:IsA("Player") then return false end
    for gid, roles in pairs(staff.groups) do
        local suc, rank = pcall(function() return p:GetRankInGroup(gid) end)
        if suc and rank and rank > 0 then
            local suc2, role = pcall(function() return p:GetRoleInGroup(gid) end)
            if suc2 and role and roles[role] then return true, role, gid end
        end
    end
    for _, uid in ipairs(staff.users) do if p.UserId == uid then return true, "UserID", p.UserId end end
    return false
end
--
local function kickFmt(sInfo)
    if not sInfo or not sInfo.Staff then return "Staff found." end
    local msg = "Staff:\n"
    for i, s in ipairs(sInfo.Staff) do
        local idType = "Role"; local idVal = s.Role or "?"
        if s.Role == "UserID" then idType = "UserID"; idVal = s.GroupId or "?"
        elseif s.Role == "Tracker User" then idType = "Tracker"; idVal = "Active" end
        msg = msg .. string.format("- %s (%s: %s)%s", s.Name or "?", idType, idVal, s.TrackedP and " - Tracking: "..s.TrackedP or "")
        if i < #sInfo.Staff then msg = msg .. "\n" end
    end
    return msg
end
--
local function kickWithInfo(sInfo) local msg = kickFmt(sInfo); if LP then LP:Kick("Staff\n\n"..msg) end end
--
local function chkCurStaff()
    local found = {}; local cur = Plrs:GetPlayers()
    for i=1,#cur do local op = cur[i]; if op ~= LP then
        local isSt, role, gid = isStaff(op); local hasT, trackP = hasTrack(op)
        if isSt or hasT then table.insert(found, {Name=op.Name, Role=hasT and "Tracker User" or role, GroupId=gid, TrackedP=trackP}) end
    end end
    if #found > 0 then kickWithInfo({Staff=found}); return true end; return false
end
--
local function onPlayerJoin(op)
    if not S.AdminChk.On then return end
    local isSt, role, gid = isStaff(op); local hasT, trackP = hasTrack(op)
    if isSt or hasT then kickWithInfo({Staff={{Name=op.Name, Role=hasT and "Tracker User" or role, GroupId=gid, TrackedP=trackP}}}) end
end
--
local function toggleAdminChk(state)
    S.AdminChk.On = state
    if S.AdminChk.On then
        if S.AdminChk.Conn then S.AdminChk.Conn:Disconnect() end
        S.AdminChk.Conn = Plrs.PlayerAdded:Connect(onPlayerJoin)
        task.spawn(function() local found = chkCurStaff(); if found then S.AdminChk.On = false; if S.AdminChk.Conn then S.AdminChk.Conn:Disconnect(); S.AdminChk.Conn = nil end end end)
        Lib:Notify("AdminChk on", 2)
    else
        if S.AdminChk.Conn then S.AdminChk.Conn:Disconnect(); S.AdminChk.Conn = nil end
        Lib:Notify("AdminChk off", 2)
    end
end
--
-- END ORIGINAL SOURCE LINES 3453-3549

-- BEGIN ORIGINAL SOURCE LINES 7887-8021
-- ==================== VIEW GROUP IN MISC ====================
--
local ViewGroup = Tabs.Misc:AddRightGroupbox("View")
--
ViewGroup:AddToggle("BlurToggle", {
    Text = "Blur",
    Default = false,
    Callback = function(value)
        toggleBlur(value)
    end
})
--
local FreecamToggle = ViewGroup:AddToggle("FreecamToggle", {
    Text = "Freecam",
    Default = false,
    Callback = function(value)
        toggleFreecam(value)
    end
})
--
FreecamToggle:AddKeyPicker("FreecamKey", {
    Default = "None", 
    SyncToggleState = true,
    Mode = "Toggle",
    Text = "Freecam Key",
    Callback = function() end,
})
--
ViewGroup:AddSlider("FreecamSpeed", {
    Text = "Freecam Speed",
    Default = 50,
    Min = 50,
    Max = 500,
    Rounding = 1,
    Callback = function(value)
        setFreecamSpeed(value)
    end
})
--
SkyG = Tabs.Visuals:AddLeftGroupbox("Skybox")
SkyG:AddToggle("SkyToggle", {Text="Enable Skybox", Default=false, Callback=function(v) if v then local cs = Options.SkyDropdown.Value or "Nebula"; enSky(cs) else disSky() end end})
SkyG:AddDropdown("SkyDropdown", {Values={"Nebula","Red Nebula","Nebula Pink","White Galaxy","Purple Nebula"}, Default="Nebula", Multi=false, Text="Skybox Type", Callback=function(v) S.Sky.Selected = v; if Toggles.SkyToggle.Value then enSky(v) end end})
--
VisL2 = Tabs.Visuals:AddLeftGroupbox("Camera")
VisL2:AddToggle("CamNoclip", {Text="Camera noclip", Default=false, Callback=function(v)
    S.Cam.NoclipOn = v; if v then LP.DevCameraOcclusionMode = Enum.DevCameraOcclusionMode.Invisicam; Lib:Notify("Cam noclip on", 2)
    else LP.DevCameraOcclusionMode = Enum.DevCameraOcclusionMode.Zoom; Lib:Notify("Cam noclip off", 2) end
end})
VisL2:AddToggle("CamMaxDist", {Text="Camera max distance", Default=false, Callback=function(v)
    S.Cam.MaxDistOn = v; if not v then LP.CameraMaxZoomDistance = S.Cam.OrigMaxDist; Lib:Notify("Cam max off", 2)
    else Lib:Notify("Cam max on", 2) end
end})
VisL2:AddSlider("CamMaxDistVal", {Text="Distance", Default=100, Min=10, Max=250, Rounding=0, Compact=false, Callback=function(v) if S.Cam.MaxDistOn then LP.CameraMaxZoomDistance = v end end})
--
VisVis = Tabs.Visuals:AddRightGroupbox("Visible")
VisVis:AddToggle("InvToggle", {Text="Invisible", Default=false, Callback=function(v) toggleInv(v) end}):AddKeyPicker("InvKey", {Default="None", SyncToggleState=false, Mode="Toggle", Text="Inv key", NoUI=false, Callback=function(k) if not canBind() then return end; Toggles.InvToggle:SetValue(not Toggles.InvToggle.Value) end})
--
MiscL = Tabs.Misc:AddLeftGroupbox("Character")
MiscL:AddToggle("NoclipToggle", {Text="Noclip", Default=false, Callback=function(v) toggleNoclip(v) end}):AddKeyPicker("NoclipKey", {Default="None", SyncToggleState=false, Mode="Toggle", Text="Noclip key", NoUI=false, Callback=function(k) if not canBind() then return end; Toggles.NoclipToggle:SetValue(not Toggles.NoclipToggle.Value) end})
MiscL:AddToggle("StopNeckToggle", {Text="Stop Neck Move", Default=false, Callback=function(v) toggleStopNeck(v) end})
MiscL:AddToggle("UnbreakToggle", {Text="Unbreak Limbs", Default=false, Callback=function(v) toggleUnbreak(v) end})
MiscL:AddToggle("FakeDownToggle", {Text="Fake Downed", Default=false, Callback=function(v) toggleFakeD(v) end})
MiscL:AddToggle("NoFallToggle", {Text="No Fall Damage", Default=false, Callback=function(v) toggleNoFall(v) end})
MiscL:AddToggle("NoSpikeToggle", {Text="No Spike", Default=false, Callback=function(v) toggleNoSpike(v) end})
--
MiscL:AddToggle("InfStaminaToggle", {Text="Infinite Stamina", Default=false, Callback=function(v)
    toggleInfStamina(v)
end})
--
MiscL:AddToggle("NoRecoilToggle", {
    Text = "No Recoil",
    Default = false,
    Callback = function(state)
        toggleNoRecoil(state)
    end
})
--
MiscR = Tabs.Misc:AddRightGroupbox("Security")
MiscR:AddToggle("AFKToggle", {Text="Anti AFK", Default=false, Callback=function(v) toggleAFK(v) end})
MiscR:AddToggle("AdminChkToggle", {Text="Admin Check", Default=false, Risky=true, Callback=function(v) toggleAdminChk(v) end})
--
-- ==================== WORLD EFFECTS UI ====================
--
local WorldEffectsGroup = Tabs.Misc:AddLeftGroupbox("World Effects")
--
local effectNames = {
    "None",
    "Sunset Paradise",
    "Neon City",
    "Arctic Frost",
    "Toxic Wasteland",
    "Blood Moon",
    "Deep Ocean",
    "Golden Hour",
    "Cyberpunk",
    "Volcanic Ash",
    "Mystic Forest",
    "Desert Storm",
    "Aurora Night",
    "Retro Wave",
    "Apocalypse",
    "Crystal Cave"
}
--
WorldEffectsGroup:AddDropdown("WorldEffectSelect", {
    Values = effectNames,
    Default = "None",
    Multi = false,
    Text = "Select Effect",
    Callback = function(value)
        if value == "None" then
            WorldEffects:Disable()
            Lib:Notify("World Effect disabled", 2)
        else
            WorldEffects:Enable(value)
            Lib:Notify("Applied: " .. value, 2)
        end
    end
})
--
WorldEffectsGroup:AddButton({
    Text = "Clear Effect",
    Func = function()
        WorldEffects:Disable()
        if Options.WorldEffectSelect then
            Options.WorldEffectSelect:SetValue("None")
        end
        Lib:Notify("World Effect cleared", 2)
    end,
    DoubleClick = false
})
--
-- ==================== END WORLD EFFECTS UI ====================
--
SetL = Tabs.Settings:AddLeftGroupbox("Configuration")
-- END ORIGINAL SOURCE LINES 7887-8021
