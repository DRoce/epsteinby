--[[
Inert commented archive file.
No executable Lua is present below; every preserved source line is prefixed with --.
Role: State tables, constants, binding helpers, persistence setup
Original source line ranges: 68-102, 2041-2358, 4058-4078
]]


-- BEGIN ORIGINAL SOURCE LINES 68-102
S = {
    Farm = {Enabled = false, Target = nil, TeleConn = nil, EConn = nil, DmgConn = nil, RespawnCD = false, MaxHP = 115, Respawning = false},
    ESP = {On = false, HlOn = false, ArmsOn = false, Conn = nil, VMConn = nil, CharConn = nil, HlCol = Color3.fromRGB(255, 204, 204), ArmsCol = Color3.fromRGB(255, 204, 204)},
    Collect = {On = false, Sig = nil, Task = nil},
    Fly = {On = false, Method = "Ragdoll", InpConn = nil},
    Rage = {On = false, Target = nil, Task = nil, UseList = false, List = {}},
    Noclip = {On = false, Conn = nil},
    StopNeck = {On = false, Conn = nil},
    Unbreak = {On = false, Conns = {}},
    FakeDown = {On = false, Conn = nil, OrigVal = nil, StatObj = nil},
    NoFall = {On = false, Conns = {}},
    NoSpike = {On = false, Conn = nil},
    InstReload = {On = false, Conns = {}},
    MeleeA = {On = false, Conn = nil},
    Shadow = {Active = false, Usable = true},
    AdminChk = {On = false, Conn = nil},
    AntiAFK = {On = false, IdleConn = nil, Coro = nil},
    FullBright = {On = false, Conn = nil, OrigVals = {ClockTime = Lt.ClockTime, Brightness = Lt.Brightness, Ambient = Lt.Ambient, OutdoorAmbient = Lt.OutdoorAmbient, ColorShift_Top = Lt.ColorShift_Top, FogStart = Lt.FogStart, FogEnd = Lt.FogEnd}},
    FOV = {On = false, Val = 80, OrigVal = Cam.FieldOfView, Conn = nil},
    Sky = {On = false, Custom = nil, Orig = nil, Selected = "Nebula"},
    Cam = {NoclipOn = false, MaxDistOn = false, OrigMaxDist = LP.CameraMaxZoomDistance},
    UI = {TxtFocused = false, TxtRefocused = false, FarmCharConn = nil},
    SafeESP = {On = false, Coroutine = nil, Highlights = {}, Billboards = {}, ResetTimers = {}, FrozenPositions = {}, LastUpdateTime = tick()},
    LockpickScale = {On = false, Connection = nil},
    InfStamina = {On = false, Connection = nil},
    AimBot = {Enabled = false, AimKey = Enum.UserInputType.MouseButton2, Smoothness = 0.1, FOV = 100, ShowFOV = true, FOVColor = Color3.fromRGB(255, 255, 255), FOVTransparency = 0.5, WallCheck = true, DownedCheck = true, Prediction = 100, TargetPart = "Head", Connection = nil, Target = nil, FOVCircle = nil, FOVUpdateConnection = nil, FOVPosition = Vector2.new(Cam.ViewportSize.X/2, Cam.ViewportSize.Y/2), Sticky = true},
    ChinaHat = {Enabled = false, Color = Color3.fromRGB(255, 105, 180), Hat = nil, Connection = nil},
    PlayerChams = {Enabled = false, VisibleColor = Color3.fromRGB(255, 0, 0), OccludedColor = Color3.fromRGB(255, 255, 255), WallColor = Color3.fromRGB(0, 255, 255), Adornments = {}, Connection = nil},
    ESPDistance = {Value = 100, Min = 50, Max = 1000},
    Blur = {Enabled = false, BlurEffect = nil, Connection = nil, LastLookVector = nil, CurrentLookVector = nil, RotationSpeed = 0},
    Freecam = {Enabled = false, Speed = 50, Connection = nil, KeysDown = {}, Rotating = false, OnMobile = not UIS.KeyboardEnabled},
    NoRecoil = {Enabled = false, Connections = {}, WeaponCache = {}, OriginalValues = {}, Settings = {GunMods = {NoRecoil = true, Spread = true, SpreadAmount = 0}}}
}
--
--
-- END ORIGINAL SOURCE LINES 68-102

-- BEGIN ORIGINAL SOURCE LINES 2041-2358
Kohфiгypaцii Safe ESP
local SafeNames = {
    "MediumSafe_HO_24","MediumSafe_HO_39","MediumSafe_HO_41","MediumSafe_SEW_2",
    "MediumSafe_SEW_8","MediumSafe_SU_32","MediumSafe_SW_9","MediumSafe_TS_20",
    "MediumSafe_T_45","MediumSafe_T_46","MediumSafe_VC_21","MediumSafe_VC_30",
    "MediumSafe_VC_38","SmallSafe_BD_12","SmallSafe_BD_18","SmallSafe_C_3",
    "SmallSafe_FA_34","SmallSafe_FA_35","SmallSafe_FA_36","SmallSafe_HO_37",
    "SmallSafe_M_17","SmallSafe_SU_15","SmallSafe_SU_22","SmallSafe_SW_11",
    "SmallSafe_SW_26","SmallSafe_TO_42","SmallSafe_TO_43","SmallSafe_TO_44",
    "SmallSafe_WH_28"
}
local RegisterNames = {
    "Register_BS_29","Register_B_10","Register_B_19","Register_B_33",
    "Register_B_40","Register_B_7","Register_C_1","Register_GS_16",
    "Register_HO_23","Register_M_25","Register_M_31","Register_M_5",
    "Register_M_6","Register_P_13","Register_P_14","Register_TS_27",
    "Register_TS_4","Register_VI_47"
}
local previousSafeBrokenStates = {}
local previousRegisterBrokenStates = {}
--
local RSett = {
    MaxDist = 200,
    MinHP = 15,
    FireDelay = 0.5 - ((50 - 1) / 99) * (0.5 - 0.01),
    On = false,
    Hitmarkers = true
}
--
local HitSounds = {
    ["Boink"] = "rbxassetid://5451260445",
    ["TF2"] = "rbxassetid://5650646664",
    ["Rust"] = "rbxassetid://5043539486",
    ["CSGO"] = "rbxassetid://8679627751",
    ["Hitmarker"] = "rbxassetid://160432334",
    ["Fortnite"] = "rbxassetid://296102734"
}
--
local HSett = {
    On = true,
    SoundId = HitSounds["Rust"],
    Vol = 1
}
--
local HSound = Instance.new("Sound")
HSound.Volume = HSett.Vol
HSound.SoundId = HSett.SoundId
HSound.Parent = workspace
--
local function UpdHSound()
    HSound.SoundId = HSett.SoundId
    HSound.Volume = HSett.Vol
end
--
local function PlayHSound()
    if not HSett.On then return end
    pcall(function() HSound:Play() end)
end
--
local BB = {
    On = false,
    Col = Color3.fromRGB(255, 0, 0),
    Thick = 0.1,
    Life = 2,
    Type = "Beam",
    Trans = 0.7,
    Active = {},
    Texs = {
        Classic = "rbxassetid://446111271",
        Lightning = "rbxassetid://4896581936",
        Rainbow = "rbxassetid://2490624870",
        Smoke = "rbxassetid://291213448",
        Energy = "rbxassetid://371296774",
        Glitch = "rbxassetid://2490624875"
    },
    CurTex = "Classic",
    CustomTex = "rbxassetid://446111271",
    Conns = {}
}
--
local TTexs = {
    ["Classic"] = {Tex = "rbxassetid://446111271", Len = 1, Spd = 1, Mode = "Wrap"},
    ["Lightning"] = {Tex = "rbxassetid://4896581936", Len = 2, Spd = 5, Mode = "Wrap"},
    ["Rainbow"] = {Tex = "rbxassetid://2490624870", Len = 3, Spd = 2, Mode = "Wrap"},
    ["Neon"] = {Tex = "rbxassetid://2969628765", Len = 2, Spd = 1, Mode = "Wrap"},
    ["Plasma"] = {Tex = "rbxassetid://3193472519", Len = 3, Spd = 2, Mode = "Wrap"},
    ["Fire"] = {Tex = "rbxassetid://511127721", Len = 4, Spd = 3, Mode = "Wrap"},
    ["Custom"] = {Tex = "rbxassetid://446111271", Len = 1, Spd = 1, Mode = "Wrap"}
}
--
local function findMzl(gun)
    if not gun or gun.Parent == nil then return nil end
    local names = {"Muzzle", "Flash", "FirePoint", "Handle", "WeaponHandle"}
    for _, n in pairs(names) do
        local p = gun:FindFirstChild(n)
        if p and p:IsA("BasePart") then return p end
    end
    return gun:FindFirstChildWhichIsA("BasePart") or gun
end
--
local function crBeam(sPos, ePos, col)
    if not BB.On or not sPos or not ePos then return nil end
    local bm, a0, a1
    local suc, err = pcall(function()
        bm = Instance.new("Beam")
        a0 = Instance.new("Attachment")
        a1 = Instance.new("Attachment")
        local par = workspace:FindFirstChild("Terrain") or workspace
        a0.Position = sPos; a0.Parent = par
        a1.Position = ePos; a1.Parent = par
        bm.Attachment0 = a0; bm.Attachment1 = a1
        bm.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, col), ColorSequenceKeypoint.new(1, col)})
        bm.Width0 = BB.Thick; bm.Width1 = BB.Thick * 0.5
        local tData = TTexs[BB.CurTex] or TTexs["Classic"]
        if BB.CurTex == "Custom" then bm.Texture = BB.CustomTex else bm.Texture = tData.Tex end
        bm.TextureLength = tData.Len; bm.TextureSpeed = tData.Spd; bm.TextureMode = tData.Mode
        bm.Transparency = NumberSequence.new({
            NumberSequenceKeypoint.new(0, BB.Trans * 0.5),
            NumberSequenceKeypoint.new(0.5, BB.Trans),
            NumberSequenceKeypoint.new(1, 1)
        })
        bm.FaceCamera = true; bm.LightEmission = 0.5; bm.LightInfluence = 0.1; bm.Parent = par
    end)
    if not suc then
        if bm then bm:Destroy() end
        if a0 then a0:Destroy() end
        if a1 then a1:Destroy() end
        return nil
    end
    local id = #BB.Active + 1
    BB.Active[id] = {Beam = bm, Atts = {a0, a1}, Created = tick(), Type = "Beam"}
    task.delay(BB.Life, function()
        if BB.Active[id] then
            pcall(function()
                if bm and bm.Parent then bm:Destroy() end
                for _, a in ipairs(BB.Active[id].Atts) do
                    if a and a.Parent then a:Destroy() end
                end
            end)
            BB.Active[id] = nil
        end
    end)
    return id
end
--
local function crLine(sPos, ePos, col)
    if not BB.On or not sPos or not ePos then return nil end
    local line
    local suc, err = pcall(function()
        if not Drawing then error("Drawing lib not available") end
        line = Drawing.new("Line")
        line.Visible = true
        line.From = Vector2.new(sPos.X, sPos.Y)
        line.To = Vector2.new(ePos.X, ePos.Y)
        line.Color = col
        line.Thickness = math.floor(BB.Thick * 10)
        line.Transparency = BB.Trans
        line.ZIndex = 999
    end)
    if not suc then warn("Line tracer fail:", err); return nil end
    local id = #BB.Active + 1
    BB.Active[id] = {Line = line, Created = tick(), Type = "Line"}
    local st = tick()
    task.spawn(function()
        while tick() - st < BB.Life do
            if BB.Active[id] and BB.Active[id].Line then
                local el = tick() - st
                local a = 1 - (el / BB.Life)
                pcall(function() BB.Active[id].Line.Transparency = 1 - (a * (1 - BB.Trans)) end)
            end
            task.wait(0.01)
        end
        if BB.Active[id] and BB.Active[id].Line then
            pcall(function() BB.Active[id].Line:Remove() end)
            BB.Active[id] = nil
        end
    end)
    return id
end
--
local function crTracer(sPos, ePos, col)
    if not BB.On then return nil end
    if not sPos or not ePos then return nil end
    if BB.Type == "Beam" then return crBeam(sPos, ePos, col)
    elseif BB.Type == "Line" and Drawing then return crLine(sPos, ePos, col) end
    return nil
end
--
local function clrTracers()
    for id, t in pairs(BB.Active) do
        pcall(function()
            if t.Beam then t.Beam:Destroy()
            elseif t.Line then t.Line:Remove() end
            if t.Atts then for _, a in ipairs(t.Atts) do if a and a.Parent then a:Destroy() end end end
        end)
        BB.Active[id] = nil
    end
    BB.Active = {}
end
--
local function setupBB()
    local ev2 = RepSt:FindFirstChild("Events2")
    if ev2 then
        local viz = ev2:FindFirstChild("Visualize")
        if viz then
            local c = viz.Event:Connect(function(_, sc, _, gun, _, sPos, bps)
                if not BB.On or not bps then return end
                local char = LP.Character; if not char then return end
                local myTool = char:FindFirstChildOfClass("Tool"); if myTool ~= gun then return end
                local mzl = findMzl(gun); local mzlPos = mzl and mzl.Position or sPos
                for _, bDir in pairs(bps) do
                    local ray = Ray.new(mzlPos, bDir * 1000)
                    local hit, hitPos = workspace:FindPartOnRayWithIgnoreList(ray, {Cam, char, gun})
                    local ePos = hit and hitPos or mzlPos + (bDir * 500)
                    crTracer(mzlPos, ePos, BB.Col)
                end
            end)
            table.insert(BB.Conns, c)
        end
    end
    local ev = RepSt:FindFirstChild("Events")
    if ev then
        local fire = ev:FindFirstChild("GNX_S")
        if fire then
            local c = fire.OnClientEvent:Connect(function(st, sc, gun, ft, sPos, dirs, silenced)
                if not BB.On or not dirs then return end
                local char = LP.Character; if not char then return end
                local tool = char:FindFirstChildOfClass("Tool"); if tool ~= gun then return end
                local mzl = findMzl(gun); local mzlPos = mzl and mzl.Position or sPos
                for _, dir in pairs(dirs) do
                    local ray = Ray.new(mzlPos, dir * 1000)
                    local hit, hitPos = workspace:FindPartOnRayWithIgnoreList(ray, {Cam, char, gun})
                    local ePos = hit and hitPos or mzlPos + (dir * 500)
                    crTracer(mzlPos, ePos, BB.Col)
                end
            end)
            table.insert(BB.Conns, c)
        end
    end
end
--
local function toggleBB(state)
    BB.On = state
    if BB.On then
        clrTracers()
        for _, c in pairs(BB.Conns) do if c then c:Disconnect() end end
        BB.Conns = {}
        local suc, err = pcall(setupBB)
        if not suc then warn("BB setup fail:", err) end
        local charC = LP.CharacterAdded:Connect(function()
            if not BB.On then return end
            clrTracers()
            task.wait(1); pcall(setupBB)
        end)
        table.insert(BB.Conns, charC)
        local remC = LP.CharacterRemoving:Connect(function() if BB.On then clrTracers() end end)
        table.insert(BB.Conns, remC)
        Lib:Notify("BulletBeam on", 2)
    else
        clrTracers()
        for _, c in pairs(BB.Conns) do if c then c:Disconnect() end end
        BB.Conns = {}
        Lib:Notify("BulletBeam off", 2)
    end
end
--
local function setBBCol(r,g,b) BB.Col = Color3.new(r,g,b) end
--
hlCols = {
    Red = Color3.fromRGB(255,50,50), Orange = Color3.fromRGB(255,165,0),
    Yellow = Color3.fromRGB(255,255,0), Green = Color3.fromRGB(50,255,50),
    Blue = Color3.fromRGB(50,150,255), Indigo = Color3.fromRGB(75,0,130),
    Violet = Color3.fromRGB(238,130,238), White = Color3.fromRGB(255,255,255)
}
--
binds = {Ragebot = Enum.KeyCode.V, Invisible = Enum.KeyCode.T, Noclip = Enum.KeyCode.B, MeleeAura = Enum.KeyCode.Y, Fly = Enum.KeyCode.Z}
--
SAVE_CUBE = Vector3.new(-4185.1, 102.6, 283.6)
UNDER = Vector3.new(-5048.8, -258.8, -129.8)
SAVE_VIBE = Vector3.new(-4878.1, -165.5, -921.2)
--
_G.InvPersist = false; _G.FlyPersist = false; _G.MeleePersist = false; _G.NoclipPersist = false
_G.AFKPersist = false; _G.FBPersist = false; _G.FOVPersist = false; _G.BBPersist = false
--
Set = {IsDead = false}
CDs = {Pick = {MoneyCD = false}}
--
me = LP
hrp = nil
RUNS = {Rag = nil, Old = nil}
evFolderFly = RepSt:FindFirstChild("Events")
flyEv = evFolderFly and evFolderFly:FindFirstChild("RZDONL")
ragEv = evFolderFly and evFolderFly:FindFirstChild("__RZDONL")
flySpd = 60
--
UIS.TextBoxFocused:Connect(function() S.UI.TxtFocused = true; S.UI.TxtRefocused = true; task.wait(0.1); S.UI.TxtRefocused = false end)
UIS.TextBoxFocusReleased:Connect(function() S.UI.TxtFocused = false; S.UI.TxtRefocused = false end)
--
local function canBind()
    if S.UI.TxtFocused then return false end
    if S.UI.TxtRefocused then return false end
    local pg = LP:FindFirstChild("PlayerGui")
    if pg then for _, g in pairs(pg:GetChildren()) do
        if g:IsA("ScreenGui") and (g.Name:find("Chat") or g.Name:find("chat")) then
            for _, f in pairs(g:GetDescendants()) do
                if f:IsA("TextBox") and f.Visible and f.Active then return false end
            end
        end
    end end
    return true
end
--
local function randStr(len)
    local res = ""
    for i=1,len do res = res .. string.char(math.random(97,122)) end
    return res
end
--
-- END ORIGINAL SOURCE LINES 2041-2358

-- BEGIN ORIGINAL SOURCE LINES 4058-4078
local function setupPersist()
    LP.CharacterAdded:Connect(function(c)
        task.wait(1)
        if _G.FlyPersist then task.wait(0.5); toggleFly(true); Lib:Notify("Fly restored", 2) end
        if _G.InvPersist then task.wait(1); toggleInv(true) end
        if _G.MeleePersist then task.wait(1.5); toggleMeleeA(true); Lib:Notify("MeleeA restored", 2) end
        if _G.NoclipPersist then task.wait(2); toggleNoclip(true); Lib:Notify("Noclip restored", 2) end
        if _G.AFKPersist then task.wait(2.5); toggleAFK(true); Lib:Notify("AFK restored", 2) end
        if _G.FBPersist then task.wait(3); toggleFB(true); Lib:Notify("FB restored", 2) end
        if _G.FOVPersist then task.wait(3.5); toggleFOV(true); Lib:Notify("FOV restored", 2) end
        if _G.BBPersist then task.wait(4); toggleBB(true); Lib:Notify("BB restored", 2) end
    end)
end
--
setupPersist()
--
SkinState = {
    On = false, Auto = false, Class = "Pistols", Weapon = nil, Skin = nil, Equipped = {}, Conns = {}, Loaded = false,
    Classes = {"Armors","Melees","GrenadeLaunchers","Pistols","Snipers","SMGS","Rifles","Shotguns"}
}
--
-- END ORIGINAL SOURCE LINES 4058-4078
