--[[
Inert commented archive file.
No executable Lua is present below; every preserved source line is prefixed with --.
Role: Theme/save manager, menu unload/reset, startup/cleanup hooks
Original source line ranges: 8022-8157
]]


-- BEGIN ORIGINAL SOURCE LINES 8022-8157
TM:SetLibrary(Lib); SM:SetLibrary(Lib)
SM:SetIgnoreIndexes({'MenuKeybind'}); SM:IgnoreThemeSettings(); SM:SetFolder('Starlight/configs')
SetR = Tabs.Settings:AddRightGroupbox("Theme")
TM:ApplyToTab(Tabs.Settings); SM:BuildConfigSection(Tabs.Settings)
--
SetL:AddDivider(); SetL:AddLabel("Script Management")
SetL:AddButton({Text="Unload Script", Func=function()
    for _, t in pairs(Toggles) do if t and t.Keypicker then pcall(function() t.Keypicker:Destroy() end) end end
    if S.Rage.On then Rage_off() end; if S.Farm.Enabled then Toggles.AutoFarm:SetValue(false) end
    if S.Collect.On then CollectOff() end; if S.Fly.On then toggleFly(false) end
    if S.Noclip.On then toggleNoclip(false) end; if S.StopNeck.On then toggleStopNeck(false) end
    if S.Unbreak.On then toggleUnbreak(false) end; if S.FakeDown.On then toggleFakeD(false) end
    if S.NoFall.On then toggleNoFall(false) end; if S.NoSpike.On then toggleNoSpike(false) end
    if S.InstReload.On then toggleInstReload(false) end; if S.MeleeA.On then toggleMeleeA(false) end
    if S.Shadow.Active then _G.DeactivateShadow() end; if S.AdminChk.On then toggleAdminChk(false) end
    if S.AntiAFK.On then toggleAFK(false) end; if S.FullBright.On then disFB() end
    if S.FOV.On then FOV_off() end; if S.ESP.On then toggleSys(false) end
    if S.Sky.On then disSky() end; if BB.On then toggleBB(false) end
    if SA.On then cleanupSA() end
    if S.SafeESP.On then disableSafeESP() end
    if S.LockpickScale.On then disableLockpickScale() end
    if S.InfStamina.On then disableInfStamina() end
    if S.ChinaHat.Enabled then toggleChinaHat(false) end
    if S.PlayerChams.Enabled then togglePlayerChams(false) end
    if S.AimBot.Enabled then cleanupAimBot() end
    if S.Blur.Enabled then disableBlur() end
    if S.Freecam.Enabled then disableFreecam() end
    if S.NoRecoil.Enabled then disableNoRecoil() end -- ДOБABЛEHO: otkлючaem No Recoil
    if MapLighting.Enabled then MapLighting:Disable() end
    if MapBlur.Active then MapBlur:Toggle() end
    if WorldEffects.Enabled then WorldEffects:Disable() end
    if Toggles.KeyStrokesToggle and Toggles.KeyStrokesToggle.Value then
        Toggles.KeyStrokesToggle:SetValue(false)
    end
--
    _G.InvPersist = false; _G.FlyPersist = false; _G.MeleePersist = false; _G.NoclipPersist = false
    _G.AFKPersist = false; _G.FBPersist = false; _G.FOVPersist = false; _G.BBPersist = false
    if S.Cam.NoclipOn then LP.DevCameraOcclusionMode = Enum.DevCameraOcclusionMode.Zoom end
    if S.Cam.MaxDistOn then LP.CameraMaxZoomDistance = S.Cam.OrigMaxDist end
    _G.CleanupCL()
    if HSound then HSound:Stop(); HSound:Destroy() end
    clrTracers()
    S = {
        Farm = {Enabled=false, Target=nil},
        ESP = {On=false, HlOn=false},
        Collect = {On=false},
        Fly = {On=false},
        Rage = {On=false, List={}},
        Noclip = {On=false},
        StopNeck = {On=false},
        Unbreak = {On=false, Conns={}},
        FakeDown = {On=false},
        NoFall = {On=false, Conns={}},
        NoSpike = {On=false},
        InstReload = {On=false, Conns={}},
        MeleeA = {On=false},
        Shadow = {Active=false, Usable=true},
        AdminChk = {On=false},
        AntiAFK = {On=false},
        FullBright = {On=false},
        FOV = {On=false},
        Sky = {On=false},
        SafeESP = {On=false, Highlights={}, Billboards={}, ResetTimers={}, FrozenPositions={}},
        LockpickScale = {On=false, Connection=nil},
        InfStamina = {On=false, Connection=nil},
        ChinaHat = {Enabled=false, Color=Color3.fromRGB(255,105,180), Hat=nil, Connection=nil},
        PlayerChams = {Enabled=false, VisibleColor=Color3.fromRGB(255,0,0), OccludedColor=Color3.fromRGB(255,255,255), WallColor=Color3.fromRGB(0,255,255), Adornments={}, Connection=nil},
        ESPDistance = {Value=100, Min=50, Max=1000},
        AimBot = {Enabled=false, Connection=nil, Target=nil, FOVCircle=nil, FOVUpdateConnection=nil, FOVPosition=Vector2.new(Cam.ViewportSize.X/2, Cam.ViewportSize.Y/2)},
        Blur = {Enabled=false, BlurEffect=nil, Connection=nil, LastLookVector=nil, CurrentLookVector=nil, RotationSpeed=0},
        Freecam = {Enabled=false, Speed=50, Connection=nil, KeysDown={}, Rotating=false, OnMobile=not UIS.KeyboardEnabled},
        NoRecoil = {Enabled=false, Connections={}, WeaponCache={}, OriginalValues={}, Settings={GunMods={NoRecoil=true, Spread=true, SpreadAmount=0}}}
    }
    Lib:Notify("Script fully unloaded!", 3); task.wait(1)
    if Lib.Unload then Lib:Unload() end
end, DoubleClick=false})
--
S.Cam.OrigMaxDist = LP.CameraMaxZoomDistance; updCamSet()
Lib:Notify("Starlight.cc loaded!", 3)
--
task.spawn(function()
    task.wait(2)
    if _G.FlyPersist then toggleFly(true) end
    if _G.InvPersist then toggleInv(true) end
    if _G.MeleePersist then toggleMeleeA(true) end
    if _G.NoclipPersist then toggleNoclip(true) end
    if _G.AFKPersist then toggleAFK(true) end
    if _G.FBPersist then toggleFB(true) end
    if _G.FOVPersist then toggleFOV(true) end
    if _G.BBPersist then task.wait(4); toggleBB(true) end
end)
--
LP.CharacterAdded:Connect(function(c)
    task.wait(1)
    if S.ESP.ArmsOn and S.ESP.On then updArms() end
    onCharAdd(c)
end)
--
task.spawn(function()
    while task.wait(1) do
        local ct = tick(); local toRem = {}
        for id, t in pairs(BB.Active) do if ct - t.Created > BB.Life + 2 then table.insert(toRem, id) end end
        for _, id in ipairs(toRem) do
            if BB.Active[id] then pcall(function()
                if BB.Active[id].Beam then BB.Active[id].Beam:Destroy()
                elseif BB.Active[id].Line then BB.Active[id].Line:Remove() end
                if BB.Active[id].Atts then for _, a in ipairs(BB.Active[id].Atts) do if a and a.Parent then a:Destroy() end end end
            end) BB.Active[id] = nil end
        end
    end
end)
--
game:GetService("ScriptContext").Error:Connect(function(m, t, s) if m:find("Silent") or m:find("Aim") then warn("[SA] Error, clearing..."); pcall(cleanupSA) end end)
game:BindToClose(function() cleanupSA(); cleanupAimBot() end)
--
_G.CleanupAll = function()
    cleanupSA()
    cleanupAimBot()
    if BB.On then toggleBB(false) end
    if S.Rage.On then Rage_off() end
    toggleSys(false)
    Lib:Notify("All cleared", 3)
end
--
_G.SAAPI = {
    Toggle = toggleSA,
    Settings = SA,
    GetTarget = getValidT,
    Cleanup = cleanupSA,
    IsEnabled = function() return SA.On end
}
--
Lib:Notify("SA Ready!", 3)
end
--
--
-- END ORIGINAL SOURCE LINES 8022-8157
