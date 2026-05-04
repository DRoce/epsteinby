--[[
Inert commented archive file.
No executable Lua is present below; every preserved source line is prefixed with --.
Role: Map lighting/blur, chams, ESP/highlights, world effects, fullbright/FOV/sky, crosshair/view visuals UI
Original source line ranges: 103-777, 1368-2040, 2755-2892, 3550-3642, 7543-7886
]]


-- BEGIN ORIGINAL SOURCE LINES 103-777
-- ==================== MAP LIGHTING SYSTEM ====================
--
local MapLighting = {
    Enabled = false,
    OriginalLighting = {},
    ProtectionConnection = nil,
    LightingConnection = nil,
    CurrentColorIndex = 1,
    LightingColors = {
        {Name = "Purple", MainColor = Color3.fromRGB(180, 100, 255), AmbientColor = Color3.fromRGB(80, 40, 120)},
        {Name = "Blue", MainColor = Color3.fromRGB(100, 150, 255), AmbientColor = Color3.fromRGB(40, 60, 120)},
        {Name = "Red", MainColor = Color3.fromRGB(255, 80, 80), AmbientColor = Color3.fromRGB(120, 30, 30)},
        {Name = "Green", MainColor = Color3.fromRGB(80, 255, 80), AmbientColor = Color3.fromRGB(30, 120, 30)},
        {Name = "Pink", MainColor = Color3.fromRGB(255, 120, 180), AmbientColor = Color3.fromRGB(120, 50, 80)},
        {Name = "Orange", MainColor = Color3.fromRGB(255, 160, 50), AmbientColor = Color3.fromRGB(120, 70, 20)}
    }
}
--
function MapLighting:SaveOriginalLighting()
    self.OriginalLighting = {
        Brightness = Lt.Brightness,
        Ambient = Lt.Ambient,
        OutdoorAmbient = Lt.OutdoorAmbient,
        ColorShift_Top = Lt.ColorShift_Top,
        ColorShift_Bottom = Lt.ColorShift_Bottom,
        FogColor = Lt.FogColor,
        FogEnd = Lt.FogEnd,
        ClockTime = Lt.ClockTime,
        ExposureCompensation = Lt.ExposureCompensation,
        GlobalShadows = Lt.GlobalShadows,
        ShadowSoftness = Lt.ShadowSoftness,
        EnvironmentDiffuseScale = Lt.EnvironmentDiffuseScale,
        EnvironmentSpecularScale = Lt.EnvironmentSpecularScale
    }
end
--
function MapLighting:ApplyLighting()
    if not self.Enabled then return end
--
    local colorInfo = self.LightingColors[self.CurrentColorIndex]
--
    Lt.Ambient = colorInfo.AmbientColor
    Lt.OutdoorAmbient = colorInfo.MainColor
    Lt.ColorShift_Top = colorInfo.MainColor
    Lt.ColorShift_Bottom = colorInfo.AmbientColor
    Lt.FogColor = colorInfo.MainColor
    Lt.FogEnd = 10000
    Lt.ClockTime = 14
    Lt.Brightness = 2.5
    Lt.ExposureCompensation = 0
    Lt.GlobalShadows = true
    Lt.ShadowSoftness = 0.5
    Lt.EnvironmentDiffuseScale = 1
    Lt.EnvironmentSpecularScale = 1
end
--
function MapLighting:RestoreLighting()
    for property, value in pairs(self.OriginalLighting) do
        pcall(function()
            Lt[property] = value
        end)
    end
end
--
function MapLighting:CreateProtectionSystem()
    local propertiesToProtect = {
        "Ambient",
        "OutdoorAmbient", 
        "ColorShift_Top",
        "ColorShift_Bottom",
        "Brightness",
        "FogColor",
        "FogEnd",
        "ClockTime"
    }
--
    local lastCheck = tick()
    local targetValues = {}
--
    local colorInfo = self.LightingColors[self.CurrentColorIndex]
    targetValues = {
        Ambient = colorInfo.AmbientColor,
        OutdoorAmbient = colorInfo.MainColor,
        ColorShift_Top = colorInfo.MainColor,
        ColorShift_Bottom = colorInfo.AmbientColor,
        Brightness = 2.5,
        FogColor = colorInfo.MainColor,
        FogEnd = 10000,
        ClockTime = 14
    }
--
    self.ProtectionConnection = RS.Heartbeat:Connect(function()
        local now = tick()
        if now - lastCheck > 0.05 then
            lastCheck = now
--
            if self.Enabled then
                for _, property in ipairs(propertiesToProtect) do
                    if targetValues[property] then
                        local current = Lt[property]
                        local target = targetValues[property]
--
                        if current ~= target then
                            pcall(function()
                                if typeof(current) == "Color3" then
                                    Lt[property] = target
                                else
                                    Lt[property] = target
                                end
                            end)
                        end
                    end
                end
            end
        end
    end)
end
--
function MapLighting:Enable()
    if self.Enabled then return end
--
    self.Enabled = true
    self:SaveOriginalLighting()
    self:ApplyLighting()
--
    if self.LightingConnection then
        self.LightingConnection:Disconnect()
    end
--
    self.LightingConnection = RS.Heartbeat:Connect(function()
        if self.Enabled then
            self:ApplyLighting()
        end
    end)
--
    if self.ProtectionConnection then
        self.ProtectionConnection:Disconnect()
    end
--
    self:CreateProtectionSystem()
end
--
function MapLighting:Disable()
    if not self.Enabled then return end
--
    self.Enabled = false
--
    if self.LightingConnection then
        self.LightingConnection:Disconnect()
        self.LightingConnection = nil
    end
--
    if self.ProtectionConnection then
        self.ProtectionConnection:Disconnect()
        self.ProtectionConnection = nil
    end
--
    self:RestoreLighting()
end
--
function MapLighting:Toggle()
    if self.Enabled then
        self:Disable()
    else
        self:Enable()
    end
end
--
function MapLighting:SetColor(index)
    if index < 1 or index > #self.LightingColors then return end
    self.CurrentColorIndex = index
    if self.Enabled then
        self:ApplyLighting()
    end
end
--
Initialize
MapLighting:SaveOriginalLighting()
--
-- ==================== MAP BLUR SYSTEM ====================
--
local MapBlur = {
    Active = false,
    Components = {},
    Connections = {},
    VisualTime = 0,
    OriginalLightingSettings = {}
}
--
local VISION_CONFIG = {
    COLOR_MASTER = {
        NEUTRAL_NIGHT = Color3.fromRGB(20, 25, 35),
        CLEAR_BLUE = Color3.fromRGB(120, 140, 180),
        SOFT_WHITE = Color3.fromRGB(230, 225, 210),
        SHADOW_GRAY = Color3.fromRGB(35, 35, 40)
    },
--
    VISUAL_MAGIC = {
        ANIMATION_GRACE = 0.15,
        LIGHT_DANCE = 0.08
    },
--
    POSTPROCESS_ART = {
        BLOOM_GENTLE = {INTENSITY = 0.45, SIZE = 24, THRESHOLD = 0.85},
        COLOR_HARMONY = {BRIGHTNESS = 0.05, CONTRAST = 0.2, SATURATION = 0.65}
    }
}
--
function MapBlur:SaveOriginalSettings()
    self.OriginalLightingSettings = {
        Brightness = Lt.Brightness,
        ClockTime = Lt.ClockTime,
        TimeOfDay = Lt.TimeOfDay,
        ExposureCompensation = Lt.ExposureCompensation,
        ShadowSoftness = Lt.ShadowSoftness,
        ShadowColor = Lt.ShadowColor,
        Ambient = Lt.Ambient,
        OutdoorAmbient = Lt.OutdoorAmbient,
        ColorShift_Top = Lt.ColorShift_Top,
        ColorShift_Bottom = Lt.ColorShift_Bottom,
        FogStart = Lt.FogStart,
        FogEnd = Lt.FogEnd,
        FogColor = Lt.FogColor,
        GlobalShadows = Lt.GlobalShadows,
        EnvironmentDiffuseScale = Lt.EnvironmentDiffuseScale,
        EnvironmentSpecularScale = Lt.EnvironmentSpecularScale,
        GeographicLatitude = Lt.GeographicLatitude
    }
--
    self.OriginalLightingSettings.PostEffects = {}
    for _, effect in pairs(Lt:GetChildren()) do
        if effect:IsA("PostEffect") then
            self.OriginalLightingSettings.PostEffects[effect.Name] = {
                Object = effect:Clone(),
                Parent = effect.Parent
            }
        end
    end
end
--
function MapBlur:RestoreOriginalSettings()
    for setting, value in pairs(self.OriginalLightingSettings) do
        if setting ~= "PostEffects" and Lt[setting] ~= nil then
            pcall(function()
                Lt[setting] = value
            end)
        end
    end
--
    for _, effect in pairs(Lt:GetChildren()) do
        if effect:IsA("PostEffect") then
            pcall(function() effect:Destroy() end)
        end
    end
--
    if self.OriginalLightingSettings.PostEffects then
        for name, effectData in pairs(self.OriginalLightingSettings.PostEffects) do
            pcall(function()
                local effect = effectData.Object:Clone()
                effect.Name = name
                effect.Parent = Lt
            end)
        end
    end
end
--
function MapBlur:Toggle()
    self.Active = not self.Active
--
    if self.Active then
        self:InitializeVision()
    else
        self:StopVision()
    end
end
--
function MapBlur:InitializeVision()
    if self.Active then return end
--
    self:CleanVision()
    self:SetupCustomLighting()
    self:CreateVisualEnhancements()
    self:StartVisualSymphony()
--
    self.Active = true
    self.VisualTime = 0
end
--
function MapBlur:CleanVision()
    for _, conn in pairs(self.Connections) do
        if conn then pcall(function() conn:Disconnect() end) end
    end
--
    for _, comp in pairs(self.Components) do
        if comp and comp.Parent then
            pcall(function() comp:Destroy() end)
        end
    end
--
    self.Components = {}
    self.Connections = {}
end
--
function MapBlur:SetupCustomLighting()
    Lt.TimeOfDay = "02:00:00"
    Lt.ClockTime = 2.0
    Lt.GlobalShadows = true
    Lt.ShadowSoftness = 0.4
    Lt.ShadowColor = VISION_CONFIG.COLOR_MASTER.SHADOW_GRAY
    Lt.FogStart = 0
    Lt.FogEnd = 100000
    Lt.FogColor = Color3.fromRGB(255, 255, 255)
    Lt.Ambient = VISION_CONFIG.COLOR_MASTER.NEUTRAL_NIGHT
    Lt.OutdoorAmbient = VISION_CONFIG.COLOR_MASTER.CLEAR_BLUE
    Lt.ColorShift_Top = VISION_CONFIG.COLOR_MASTER.SOFT_WHITE
    Lt.ColorShift_Bottom = VISION_CONFIG.COLOR_MASTER.CLEAR_BLUE
    Lt.Brightness = 0.45
    Lt.ExposureCompensation = 0.15
    Lt.EnvironmentDiffuseScale = 0.8
    Lt.EnvironmentSpecularScale = 0.35
end
--
function MapBlur:CreateVisualEnhancements()
    local enhancements = {}
--
    local success, bloom = pcall(function()
        local gentleBloom = Instance.new("BloomEffect")
        gentleBloom.Name = "SWILL_GentleBloom"
        gentleBloom.Intensity = VISION_CONFIG.POSTPROCESS_ART.BLOOM_GENTLE.INTENSITY
        gentleBloom.Size = VISION_CONFIG.POSTPROCESS_ART.BLOOM_GENTLE.SIZE
        gentleBloom.Threshold = VISION_CONFIG.POSTPROCESS_ART.BLOOM_GENTLE.THRESHOLD
        gentleBloom.Parent = Lt
        return gentleBloom
    end)
--
    if success then
        enhancements.Bloom = bloom
    end
--
    local success2, color = pcall(function()
        local harmony = Instance.new("ColorCorrectionEffect")
        harmony.Name = "SWILL_ColorHarmony"
        harmony.Brightness = VISION_CONFIG.POSTPROCESS_ART.COLOR_HARMONY.BRIGHTNESS
        harmony.Contrast = VISION_CONFIG.POSTPROCESS_ART.COLOR_HARMONY.CONTRAST
        harmony.Saturation = VISION_CONFIG.POSTPROCESS_ART.COLOR_HARMONY.SATURATION
        harmony.TintColor = Color3.fromRGB(255, 250, 245)
        harmony.Parent = Lt
        return harmony
    end)
--
    if success2 then
        enhancements.ColorCorrection = color
    end
--
    local success3, dof = pcall(function()
        local depth = Instance.new("DepthOfFieldEffect")
        depth.Name = "SWILL_VisionDepth"
        depth.FarIntensity = 0.15
        depth.FocusDistance = 25
        depth.InFocusRadius = 30
        depth.NearIntensity = 0.3
        depth.Parent = Lt
        return depth
    end)
--
    if success3 and dof then
        enhancements.DepthOfField = dof
    end
--
    self.Components.Enhancements = enhancements
end
--
function MapBlur:StartVisualSymphony()
    self.Connections.VisualMaster = RS.RenderStepped:Connect(function(delta)
        self:UpdateVisualMasterpiece(delta)
    end)
end
--
function MapBlur:UpdateVisualMasterpiece(delta)
    if not self.Active then return end
--
    self.VisualTime = self.VisualTime + delta * VISION_CONFIG.VISUAL_MAGIC.ANIMATION_GRACE
--
    local time = self.VisualTime
    local waveA = math.sin(time * 0.2)
    local waveB = math.cos(time * 0.3)
    local waveC = math.sin(time * 0.5)
--
    local ambientBlend = (waveA + 1) / 2
    Lt.Ambient = Color3.fromRGB(
        20 + ambientBlend * 10,
        25 + ambientBlend * 8,
        35 + ambientBlend * 5
    )
--
    Lt.Brightness = 0.45 + waveB * 0.02
    Lt.ShadowSoftness = 0.4 + waveC * 0.08
--
    local enhancements = self.Components.Enhancements or {}
--
    if enhancements.Bloom then
        local bloomWave = (math.sin(time * 0.7) + 1) / 2
        enhancements.Bloom.Intensity = 0.4 + bloomWave * 0.1
        enhancements.Bloom.Size = 22 + waveB * 6
    end
--
    if enhancements.ColorCorrection then
        local tintWave = 0.98 + math.sin(time * 0.4) * 0.02
        enhancements.ColorCorrection.TintColor = Color3.fromRGB(
            255 * tintWave,
            250 * tintWave,
            245 * tintWave
        )
--
        enhancements.ColorCorrection.Saturation = 0.65 + waveA * 0.08
        enhancements.ColorCorrection.Contrast = 0.2 + waveC * 0.05
    end
--
    if enhancements.DepthOfField then
        enhancements.DepthOfField.FocusDistance = 24 + waveB * 8
        enhancements.DepthOfField.FarIntensity = 0.12 + waveA * 0.06
    end
end
--
function MapBlur:StopVision()
    if not self.Active then return end
--
    self.Active = false
--
    task.wait(0.5)
    self:CleanVision()
    self:RestoreOriginalSettings()
end
--
Initialize
MapBlur:SaveOriginalSettings()
getgenv().SWILL_Vision = MapBlur
--
-- ==================== CHINA HAT FYHKTsII (TOLKO HA CEБYa) ====================
--
local function CreateChinaHat(character)
    if S.ChinaHat.Hat then
        S.ChinaHat.Hat:Destroy()
        S.ChinaHat.Hat = nil
    end
--
    local head = character:FindFirstChild("Head")
    if not head then return end
--
    local cone = Instance.new("Part")
    cone.Size = Vector3.new(1, 1, 1)
    cone.BrickColor = BrickColor.new("White")
    cone.Transparency = 0.3
    cone.Anchored = false
    cone.CanCollide = false
--
    local mesh = Instance.new("SpecialMesh", cone)
    mesh.MeshType = Enum.MeshType.FileMesh
    mesh.MeshId = "rbxassetid://1033714"
    mesh.Scale = Vector3.new(1.7, 1.1, 1.7)
--
    local weld = Instance.new("Weld")
    weld.Part0 = head
    weld.Part1 = cone
    weld.C0 = CFrame.new(0, 0.9, 0)
--
    cone.Parent = character
    weld.Parent = cone
--
    local highlight = Instance.new("Highlight", cone)
    highlight.FillColor = S.ChinaHat.Color
    highlight.FillTransparency = 0.5
    highlight.OutlineColor = S.ChinaHat.Color
    highlight.OutlineTransparency = 0
--
    S.ChinaHat.Hat = cone
end
--
local function UpdateChinaHat()
    if not S.ChinaHat.Enabled then
        if S.ChinaHat.Hat then
            S.ChinaHat.Hat:Destroy()
            S.ChinaHat.Hat = nil
        end
        return
    end
--
    local character = LP.Character
    if character and character:FindFirstChild("Head") and character:FindFirstChild("Humanoid") then
        local humanoid = character.Humanoid
        if humanoid.Health > 0 then
            if not S.ChinaHat.Hat then
                CreateChinaHat(character)
            else
                local highlight = S.ChinaHat.Hat:FindFirstChildOfClass("Highlight")
                if highlight then
                    highlight.FillColor = S.ChinaHat.Color
                    highlight.OutlineColor = S.ChinaHat.Color
                end
            end
        elseif S.ChinaHat.Hat then
            S.ChinaHat.Hat:Destroy()
            S.ChinaHat.Hat = nil
        end
    elseif S.ChinaHat.Hat then
        S.ChinaHat.Hat:Destroy()
        S.ChinaHat.Hat = nil
    end
end
--
local function setupChinaHat()
    if S.ChinaHat.Connection then
        S.ChinaHat.Connection:Disconnect()
    end
--
    S.ChinaHat.Connection = RS.Heartbeat:Connect(function()
        UpdateChinaHat()
    end)
--
    if LP.Character then
        CreateChinaHat(LP.Character)
    end
end
--
local function toggleChinaHat(state)
    S.ChinaHat.Enabled = state
--
    if state then
        setupChinaHat()
        Lib:Notify("China Hat enabled", 2)
    else
        if S.ChinaHat.Connection then
            S.ChinaHat.Connection:Disconnect()
            S.ChinaHat.Connection = nil
        end
--
        if S.ChinaHat.Hat then
            S.ChinaHat.Hat:Destroy()
            S.ChinaHat.Hat = nil
        end
--
        Lib:Notify("China Hat disabled", 2)
    end
end
--
-- ==================== PLAYER CHAMS FYHKTsII ====================
--
local function CreateAdornments(part)
    local Adornments = {}
    for vis = 1, 2 do
        if part.Name == "Head" then
            Adornments[vis] = Instance.new("CylinderHandleAdornment")
            Adornments[vis].Height = 1.2
            Adornments[vis].Radius = 0.78
            Adornments[vis].CFrame = CFrame.new(Vector3.new(), Vector3.new(0, 1, 0))
            if vis == 1 then
                Adornments[vis].Radius = Adornments[vis].Radius - 0.15
                Adornments[vis].Height = Adornments[vis].Height - 0.15
            end
        else
            Adornments[vis] = Instance.new("BoxHandleAdornment")
            Adornments[vis].Size = part.Size + Vector3.new(0.2, 0.2, 0.2)
            if vis == 1 then
                Adornments[vis].Size = Adornments[vis].Size - Vector3.new(0.15, 0.15, 0.15)
            end
        end
        Adornments[vis].Parent = game:GetService("CoreGui")
        Adornments[vis].Adornee = part
        Adornments[vis].Name = vis == 1 and "Occluded" or "Visible"
        Adornments[vis].ZIndex = vis == 1 and 2 or 1
        Adornments[vis].AlwaysOnTop = vis == 1
    end
    return Adornments
end
--
local function UpdatePlayerChams()
    if not S.PlayerChams.Enabled then
        for _, playerData in pairs(S.PlayerChams.Adornments) do
            for _, adornmentsTable in pairs(playerData) do
                for _, adornment in pairs(adornmentsTable) do
                    adornment.Visible = false
                end
            end
        end
        return
    end
--
    local localRoot = LP.Character and LP.Character:FindFirstChild("HumanoidRootPart")
    if not localRoot then return end
--
    for _, player in pairs(Plrs:GetPlayers()) do
        if player == LP then continue end
--
        if not player.Character or not player.Character:FindFirstChild("HumanoidRootPart") then
            if S.PlayerChams.Adornments[player] then
                for _, adornmentsTable in pairs(S.PlayerChams.Adornments[player]) do
                    for _, adornment in pairs(adornmentsTable) do
                        adornment.Visible = false
                    end
                end
            end
            continue
        end
--
        local distance = (player.Character.HumanoidRootPart.Position - localRoot.Position).Magnitude
        if distance > S.ESPDistance.Value then
            if S.PlayerChams.Adornments[player] then
                for _, adornmentsTable in pairs(S.PlayerChams.Adornments[player]) do
                    for _, adornment in pairs(adornmentsTable) do
                        adornment.Visible = false
                    end
                end
            end
            continue
        end
--
        if not S.PlayerChams.Adornments[player] then
            S.PlayerChams.Adornments[player] = {}
        end
--
        for _, part in pairs(player.Character:GetChildren()) do
            if part:IsA("BasePart") and table.find({"Head", "Torso", "Left Arm", "Right Arm", "Left Leg", "Right Leg"}, part.Name) then
                if not S.PlayerChams.Adornments[player][part] then
                    S.PlayerChams.Adornments[player][part] = CreateAdornments(part)
                end
--
                S.PlayerChams.Adornments[player][part][1].Visible = true
                S.PlayerChams.Adornments[player][part][1].Color3 = S.PlayerChams.OccludedColor
                S.PlayerChams.Adornments[player][part][1].Transparency = 0
--
                S.PlayerChams.Adornments[player][part][2].Visible = true
                S.PlayerChams.Adornments[player][part][2].Color3 = S.PlayerChams.VisibleColor
                S.PlayerChams.Adornments[player][part][2].Transparency = 0.5
                S.PlayerChams.Adornments[player][part][2].AlwaysOnTop = false
                S.PlayerChams.Adornments[player][part][2].ZIndex = 1
            end
        end
    end
end
--
local function setupPlayerChams()
    if S.PlayerChams.Connection then
        S.PlayerChams.Connection:Disconnect()
    end
--
    S.PlayerChams.Connection = RS.Heartbeat:Connect(function()
        UpdatePlayerChams()
    end)
end
--
local function togglePlayerChams(state)
    S.PlayerChams.Enabled = state
--
    if state then
        setupPlayerChams()
        Lib:Notify("Player Chams enabled", 2)
    else
        if S.PlayerChams.Connection then
            S.PlayerChams.Connection:Disconnect()
            S.PlayerChams.Connection = nil
        end
--
        for _, playerData in pairs(S.PlayerChams.Adornments) do
            for _, adornmentsTable in pairs(playerData) do
                for _, adornment in pairs(adornmentsTable) do
                    adornment:Destroy()
                end
            end
        end
        S.PlayerChams.Adornments = {}
--
        Lib:Notify("Player Chams disabled", 2)
    end
end
--
-- END ORIGINAL SOURCE LINES 103-777

-- BEGIN ORIGINAL SOURCE LINES 1368-2040
-- ==================== WORLD EFFECTS SYSTEM ====================
--
local WorldEffects = {
    Enabled = false,
    CurrentEffect = "None",
    OriginalSettings = {},
    Connections = {},
    Effects = {}
}
--
function WorldEffects:SaveOriginal()
    if next(self.OriginalSettings) ~= nil then return end
--
    self.OriginalSettings = {
        Brightness = Lt.Brightness,
        ClockTime = Lt.ClockTime,
        Ambient = Lt.Ambient,
        OutdoorAmbient = Lt.OutdoorAmbient,
        ColorShift_Top = Lt.ColorShift_Top,
        ColorShift_Bottom = Lt.ColorShift_Bottom,
        FogColor = Lt.FogColor,
        FogStart = Lt.FogStart,
        FogEnd = Lt.FogEnd,
        ExposureCompensation = Lt.ExposureCompensation,
        GlobalShadows = Lt.GlobalShadows,
        ShadowSoftness = Lt.ShadowSoftness,
        EnvironmentDiffuseScale = Lt.EnvironmentDiffuseScale,
        EnvironmentSpecularScale = Lt.EnvironmentSpecularScale,
        PostEffects = {}
    }
--
    for _, effect in pairs(Lt:GetChildren()) do
        if effect:IsA("PostEffect") then
            self.OriginalSettings.PostEffects[effect.Name] = {
                Object = effect:Clone(),
                Parent = effect.Parent
            }
        end
    end
end
--
function WorldEffects:RestoreOriginal()
    for property, value in pairs(self.OriginalSettings) do
        if property ~= "PostEffects" and Lt[property] ~= nil then
            pcall(function()
                Lt[property] = value
            end)
        end
    end
--
    for _, effect in pairs(Lt:GetChildren()) do
        if effect:IsA("PostEffect") and not self.OriginalSettings.PostEffects[effect.Name] then
            pcall(function() effect:Destroy() end)
        end
    end
--
    if self.OriginalSettings.PostEffects then
        for name, effectData in pairs(self.OriginalSettings.PostEffects) do
            local existing = Lt:FindFirstChild(name)
            if not existing then
                pcall(function()
                    local effect = effectData.Object:Clone()
                    effect.Name = name
                    effect.Parent = Lt
                end)
            end
        end
    end
end
--
function WorldEffects:ClearEffects()
    for _, conn in pairs(self.Connections) do
        if conn then pcall(function() conn:Disconnect() end) end
    end
    self.Connections = {}
--
    for _, effect in pairs(Lt:GetChildren()) do
        if effect:IsA("PostEffect") and effect.Name:find("WE_") then
            pcall(function() effect:Destroy() end)
        end
    end
end
--
function WorldEffects:ApplyEffect(effectName)
    self:ClearEffects()
--
    if effectName == "None" then
        self:RestoreOriginal()
        return
    end
--
    local effect = self.Effects[effectName]
    if not effect then return end
--
    effect.Apply()
end
--
WorldEffects.Effects["Sunset Paradise"] = {
    Apply = function()
        Lt.ClockTime = 17.5
        Lt.Brightness = 2.8
        Lt.Ambient = Color3.fromRGB(255, 140, 100)
        Lt.OutdoorAmbient = Color3.fromRGB(255, 180, 120)
        Lt.ColorShift_Top = Color3.fromRGB(255, 200, 150)
        Lt.ColorShift_Bottom = Color3.fromRGB(255, 120, 80)
        Lt.FogColor = Color3.fromRGB(255, 160, 100)
        Lt.FogStart = 100
        Lt.FogEnd = 8000
        Lt.ExposureCompensation = 0.3
--
        local bloom = Instance.new("BloomEffect")
        bloom.Name = "WE_Bloom"
        bloom.Intensity = 0.8
        bloom.Size = 32
        bloom.Threshold = 0.6
        bloom.Parent = Lt
--
        local cc = Instance.new("ColorCorrectionEffect")
        cc.Name = "WE_ColorCorrection"
        cc.Brightness = 0.1
        cc.Contrast = 0.15
        cc.Saturation = 0.3
        cc.TintColor = Color3.fromRGB(255, 240, 220)
        cc.Parent = Lt
    end
}
--
WorldEffects.Effects["Neon City"] = {
    Apply = function()
        Lt.ClockTime = 0
        Lt.Brightness = 1.5
        Lt.Ambient = Color3.fromRGB(80, 40, 120)
        Lt.OutdoorAmbient = Color3.fromRGB(120, 60, 180)
        Lt.ColorShift_Top = Color3.fromRGB(180, 100, 255)
        Lt.ColorShift_Bottom = Color3.fromRGB(100, 50, 150)
        Lt.FogColor = Color3.fromRGB(140, 80, 200)
        Lt.FogStart = 50
        Lt.FogEnd = 5000
        Lt.ExposureCompensation = 0.2
--
        local bloom = Instance.new("BloomEffect")
        bloom.Name = "WE_Bloom"
        bloom.Intensity = 1.2
        bloom.Size = 40
        bloom.Threshold = 0.4
        bloom.Parent = Lt
--
        local cc = Instance.new("ColorCorrectionEffect")
        cc.Name = "WE_ColorCorrection"
        cc.Brightness = 0
        cc.Contrast = 0.3
        cc.Saturation = 0.5
        cc.TintColor = Color3.fromRGB(200, 180, 255)
        cc.Parent = Lt
--
        local time = 0
        table.insert(WorldEffects.Connections, RS.Heartbeat:Connect(function(dt)
            time = time + dt
            local wave = math.sin(time * 2) * 0.5 + 0.5
            Lt.ColorShift_Top = Color3.fromRGB(
                180 + wave * 75,
                100 + wave * 100,
                255
            )
        end))
    end
}
--
WorldEffects.Effects["Arctic Frost"] = {
    Apply = function()
        Lt.ClockTime = 12
        Lt.Brightness = 3.5
        Lt.Ambient = Color3.fromRGB(200, 220, 255)
        Lt.OutdoorAmbient = Color3.fromRGB(220, 240, 255)
        Lt.ColorShift_Top = Color3.fromRGB(240, 250, 255)
        Lt.ColorShift_Bottom = Color3.fromRGB(180, 200, 230)
        Lt.FogColor = Color3.fromRGB(220, 235, 255)
        Lt.FogStart = 0
        Lt.FogEnd = 6000
        Lt.ExposureCompensation = 0.4
--
        local bloom = Instance.new("BloomEffect")
        bloom.Name = "WE_Bloom"
        bloom.Intensity = 0.6
        bloom.Size = 28
        bloom.Threshold = 0.8
        bloom.Parent = Lt
--
        local cc = Instance.new("ColorCorrectionEffect")
        cc.Name = "WE_ColorCorrection"
        cc.Brightness = 0.15
        cc.Contrast = 0.1
        cc.Saturation = -0.1
        cc.TintColor = Color3.fromRGB(230, 240, 255)
        cc.Parent = Lt
    end
}
--
WorldEffects.Effects["Toxic Wasteland"] = {
    Apply = function()
        Lt.ClockTime = 14
        Lt.Brightness = 2
        Lt.Ambient = Color3.fromRGB(100, 120, 40)
        Lt.OutdoorAmbient = Color3.fromRGB(140, 180, 60)
        Lt.ColorShift_Top = Color3.fromRGB(180, 220, 80)
        Lt.ColorShift_Bottom = Color3.fromRGB(100, 140, 40)
        Lt.FogColor = Color3.fromRGB(150, 200, 70)
        Lt.FogStart = 20
        Lt.FogEnd = 4000
        Lt.ExposureCompensation = 0.1
--
        local bloom = Instance.new("BloomEffect")
        bloom.Name = "WE_Bloom"
        bloom.Intensity = 0.9
        bloom.Size = 35
        bloom.Threshold = 0.5
        bloom.Parent = Lt
--
        local cc = Instance.new("ColorCorrectionEffect")
        cc.Name = "WE_ColorCorrection"
        cc.Brightness = -0.05
        cc.Contrast = 0.25
        cc.Saturation = 0.4
        cc.TintColor = Color3.fromRGB(200, 255, 150)
        cc.Parent = Lt
    end
}
--
WorldEffects.Effects["Blood Moon"] = {
    Apply = function()
        Lt.ClockTime = 0
        Lt.Brightness = 1.2
        Lt.Ambient = Color3.fromRGB(120, 20, 20)
        Lt.OutdoorAmbient = Color3.fromRGB(180, 30, 30)
        Lt.ColorShift_Top = Color3.fromRGB(255, 50, 50)
        Lt.ColorShift_Bottom = Color3.fromRGB(150, 20, 20)
        Lt.FogColor = Color3.fromRGB(200, 40, 40)
        Lt.FogStart = 30
        Lt.FogEnd = 5000
        Lt.ExposureCompensation = 0
--
        local bloom = Instance.new("BloomEffect")
        bloom.Name = "WE_Bloom"
        bloom.Intensity = 1
        bloom.Size = 38
        bloom.Threshold = 0.45
        bloom.Parent = Lt
--
        local cc = Instance.new("ColorCorrectionEffect")
        cc.Name = "WE_ColorCorrection"
        cc.Brightness = -0.1
        cc.Contrast = 0.35
        cc.Saturation = 0.3
        cc.TintColor = Color3.fromRGB(255, 200, 200)
        cc.Parent = Lt
--
        local time = 0
        table.insert(WorldEffects.Connections, RS.Heartbeat:Connect(function(dt)
            time = time + dt
            local pulse = math.sin(time * 3) * 0.3 + 0.7
            bloom.Intensity = pulse * 1.2
        end))
    end
}
--
WorldEffects.Effects["Deep Ocean"] = {
    Apply = function()
        Lt.ClockTime = 6
        Lt.Brightness = 1
        Lt.Ambient = Color3.fromRGB(20, 60, 100)
        Lt.OutdoorAmbient = Color3.fromRGB(30, 90, 150)
        Lt.ColorShift_Top = Color3.fromRGB(50, 120, 200)
        Lt.ColorShift_Bottom = Color3.fromRGB(20, 70, 120)
        Lt.FogColor = Color3.fromRGB(40, 100, 160)
        Lt.FogStart = 10
        Lt.FogEnd = 3000
        Lt.ExposureCompensation = -0.2
--
        local bloom = Instance.new("BloomEffect")
        bloom.Name = "WE_Bloom"
        bloom.Intensity = 0.5
        bloom.Size = 25
        bloom.Threshold = 0.7
        bloom.Parent = Lt
--
        local cc = Instance.new("ColorCorrectionEffect")
        cc.Name = "WE_ColorCorrection"
        cc.Brightness = -0.15
        cc.Contrast = 0.2
        cc.Saturation = 0.2
        cc.TintColor = Color3.fromRGB(180, 200, 255)
        cc.Parent = Lt
--
        local blur = Instance.new("BlurEffect")
        blur.Name = "WE_Blur"
        blur.Size = 3
        blur.Parent = Lt
    end
}
--
WorldEffects.Effects["Golden Hour"] = {
    Apply = function()
        Lt.ClockTime = 16
        Lt.Brightness = 3
        Lt.Ambient = Color3.fromRGB(255, 200, 120)
        Lt.OutdoorAmbient = Color3.fromRGB(255, 220, 150)
        Lt.ColorShift_Top = Color3.fromRGB(255, 240, 180)
        Lt.ColorShift_Bottom = Color3.fromRGB(255, 180, 100)
        Lt.FogColor = Color3.fromRGB(255, 210, 140)
        Lt.FogStart = 150
        Lt.FogEnd = 9000
        Lt.ExposureCompensation = 0.35
--
        local bloom = Instance.new("BloomEffect")
        bloom.Name = "WE_Bloom"
        bloom.Intensity = 0.7
        bloom.Size = 30
        bloom.Threshold = 0.65
        bloom.Parent = Lt
--
        local cc = Instance.new("ColorCorrectionEffect")
        cc.Name = "WE_ColorCorrection"
        cc.Brightness = 0.12
        cc.Contrast = 0.12
        cc.Saturation = 0.25
        cc.TintColor = Color3.fromRGB(255, 245, 220)
        cc.Parent = Lt
--
        local sr = Instance.new("SunRaysEffect")
        sr.Name = "WE_SunRays"
        sr.Intensity = 0.15
        sr.Spread = 0.5
        sr.Parent = Lt
    end
}
--
WorldEffects.Effects["Cyberpunk"] = {
    Apply = function()
        Lt.ClockTime = 22
        Lt.Brightness = 1.8
        Lt.Ambient = Color3.fromRGB(100, 40, 120)
        Lt.OutdoorAmbient = Color3.fromRGB(150, 60, 180)
        Lt.ColorShift_Top = Color3.fromRGB(255, 0, 200)
        Lt.ColorShift_Bottom = Color3.fromRGB(0, 200, 255)
        Lt.FogColor = Color3.fromRGB(180, 50, 200)
        Lt.FogStart = 40
        Lt.FogEnd = 4500
        Lt.ExposureCompensation = 0.15
--
        local bloom = Instance.new("BloomEffect")
        bloom.Name = "WE_Bloom"
        bloom.Intensity = 1.5
        bloom.Size = 45
        bloom.Threshold = 0.3
        bloom.Parent = Lt
--
        local cc = Instance.new("ColorCorrectionEffect")
        cc.Name = "WE_ColorCorrection"
        cc.Brightness = 0.05
        cc.Contrast = 0.4
        cc.Saturation = 0.6
        cc.TintColor = Color3.fromRGB(255, 150, 255)
        cc.Parent = Lt
--
        local time = 0
        table.insert(WorldEffects.Connections, RS.Heartbeat:Connect(function(dt)
            time = time + dt
            local wave1 = math.sin(time * 2.5) * 0.5 + 0.5
            local wave2 = math.cos(time * 3) * 0.5 + 0.5
            Lt.ColorShift_Top = Color3.fromRGB(
                255 * wave1,
                0,
                200 + 55 * wave2
            )
            Lt.ColorShift_Bottom = Color3.fromRGB(
                0,
                200 * wave2,
                255 * wave1
            )
        end))
    end
}
--
WorldEffects.Effects["Volcanic Ash"] = {
    Apply = function()
        Lt.ClockTime = 15
        Lt.Brightness = 1.5
        Lt.Ambient = Color3.fromRGB(120, 60, 40)
        Lt.OutdoorAmbient = Color3.fromRGB(160, 80, 50)
        Lt.ColorShift_Top = Color3.fromRGB(255, 120, 60)
        Lt.ColorShift_Bottom = Color3.fromRGB(180, 70, 30)
        Lt.FogColor = Color3.fromRGB(140, 80, 50)
        Lt.FogStart = 20
        Lt.FogEnd = 3500
        Lt.ExposureCompensation = 0
--
        local bloom = Instance.new("BloomEffect")
        bloom.Name = "WE_Bloom"
        bloom.Intensity = 0.85
        bloom.Size = 33
        bloom.Threshold = 0.55
        bloom.Parent = Lt
--
        local cc = Instance.new("ColorCorrectionEffect")
        cc.Name = "WE_ColorCorrection"
        cc.Brightness = -0.08
        cc.Contrast = 0.28
        cc.Saturation = 0.15
        cc.TintColor = Color3.fromRGB(255, 200, 180)
        cc.Parent = Lt
--
        local time = 0
        table.insert(WorldEffects.Connections, RS.Heartbeat:Connect(function(dt)
            time = time + dt
            local flicker = math.sin(time * 5) * 0.1 + 0.9
            Lt.Brightness = 1.5 * flicker
        end))
    end
}
--
WorldEffects.Effects["Mystic Forest"] = {
    Apply = function()
        Lt.ClockTime = 8
        Lt.Brightness = 2.2
        Lt.Ambient = Color3.fromRGB(60, 120, 80)
        Lt.OutdoorAmbient = Color3.fromRGB(80, 160, 100)
        Lt.ColorShift_Top = Color3.fromRGB(120, 220, 140)
        Lt.ColorShift_Bottom = Color3.fromRGB(60, 140, 80)
        Lt.FogColor = Color3.fromRGB(100, 180, 120)
        Lt.FogStart = 50
        Lt.FogEnd = 5500
        Lt.ExposureCompensation = 0.1
--
        local bloom = Instance.new("BloomEffect")
        bloom.Name = "WE_Bloom"
        bloom.Intensity = 0.65
        bloom.Size = 27
        bloom.Threshold = 0.7
        bloom.Parent = Lt
--
        local cc = Instance.new("ColorCorrectionEffect")
        cc.Name = "WE_ColorCorrection"
        cc.Brightness = 0.05
        cc.Contrast = 0.18
        cc.Saturation = 0.35
        cc.TintColor = Color3.fromRGB(200, 255, 220)
        cc.Parent = Lt
--
        local sr = Instance.new("SunRaysEffect")
        sr.Name = "WE_SunRays"
        sr.Intensity = 0.08
        sr.Spread = 0.3
        sr.Parent = Lt
    end
}
--
WorldEffects.Effects["Desert Storm"] = {
    Apply = function()
        Lt.ClockTime = 13
        Lt.Brightness = 2.5
        Lt.Ambient = Color3.fromRGB(200, 160, 100)
        Lt.OutdoorAmbient = Color3.fromRGB(240, 200, 120)
        Lt.ColorShift_Top = Color3.fromRGB(255, 230, 150)
        Lt.ColorShift_Bottom = Color3.fromRGB(220, 180, 100)
        Lt.FogColor = Color3.fromRGB(230, 190, 130)
        Lt.FogStart = 100
        Lt.FogEnd = 4000
        Lt.ExposureCompensation = 0.25
--
        local bloom = Instance.new("BloomEffect")
        bloom.Name = "WE_Bloom"
        bloom.Intensity = 0.55
        bloom.Size = 26
        bloom.Threshold = 0.75
        bloom.Parent = Lt
--
        local cc = Instance.new("ColorCorrectionEffect")
        cc.Name = "WE_ColorCorrection"
        cc.Brightness = 0.08
        cc.Contrast = 0.15
        cc.Saturation = 0.1
        cc.TintColor = Color3.fromRGB(255, 240, 200)
        cc.Parent = Lt
--
        local blur = Instance.new("BlurEffect")
        blur.Name = "WE_Blur"
        blur.Size = 2
        blur.Parent = Lt
    end
}
--
WorldEffects.Effects["Aurora Night"] = {
    Apply = function()
        Lt.ClockTime = 1
        Lt.Brightness = 1.3
        Lt.Ambient = Color3.fromRGB(40, 80, 120)
        Lt.OutdoorAmbient = Color3.fromRGB(60, 120, 180)
        Lt.ColorShift_Top = Color3.fromRGB(100, 200, 255)
        Lt.ColorShift_Bottom = Color3.fromRGB(150, 100, 200)
        Lt.FogColor = Color3.fromRGB(80, 140, 200)
        Lt.FogStart = 80
        Lt.FogEnd = 6000
        Lt.ExposureCompensation = 0.05
--
        local bloom = Instance.new("BloomEffect")
        bloom.Name = "WE_Bloom"
        bloom.Intensity = 1.1
        bloom.Size = 36
        bloom.Threshold = 0.5
        bloom.Parent = Lt
--
        local cc = Instance.new("ColorCorrectionEffect")
        cc.Name = "WE_ColorCorrection"
        cc.Brightness = 0
        cc.Contrast = 0.22
        cc.Saturation = 0.45
        cc.TintColor = Color3.fromRGB(200, 220, 255)
        cc.Parent = Lt
--
        local time = 0
        table.insert(WorldEffects.Connections, RS.Heartbeat:Connect(function(dt)
            time = time + dt
            local wave1 = math.sin(time * 1.5) * 0.5 + 0.5
            local wave2 = math.cos(time * 2) * 0.5 + 0.5
            Lt.ColorShift_Top = Color3.fromRGB(
                100 + wave1 * 100,
                200 * wave2,
                255
            )
            Lt.ColorShift_Bottom = Color3.fromRGB(
                150 * wave2,
                100 + wave1 * 100,
                200
            )
        end))
    end
}
--
WorldEffects.Effects["Retro Wave"] = {
    Apply = function()
        Lt.ClockTime = 20
        Lt.Brightness = 2
        Lt.Ambient = Color3.fromRGB(120, 40, 100)
        Lt.OutdoorAmbient = Color3.fromRGB(180, 60, 150)
        Lt.ColorShift_Top = Color3.fromRGB(255, 100, 200)
        Lt.ColorShift_Bottom = Color3.fromRGB(100, 50, 200)
        Lt.FogColor = Color3.fromRGB(200, 80, 180)
        Lt.FogStart = 60
        Lt.FogEnd = 5000
        Lt.ExposureCompensation = 0.2
--
        local bloom = Instance.new("BloomEffect")
        bloom.Name = "WE_Bloom"
        bloom.Intensity = 1.3
        bloom.Size = 42
        bloom.Threshold = 0.4
        bloom.Parent = Lt
--
        local cc = Instance.new("ColorCorrectionEffect")
        cc.Name = "WE_ColorCorrection"
        cc.Brightness = 0.03
        cc.Contrast = 0.32
        cc.Saturation = 0.55
        cc.TintColor = Color3.fromRGB(255, 180, 240)
        cc.Parent = Lt
--
        local time = 0
        table.insert(WorldEffects.Connections, RS.Heartbeat:Connect(function(dt)
            time = time + dt
            local grid = math.sin(time * 4) * 0.3 + 0.7
            bloom.Intensity = grid * 1.5
        end))
    end
}
--
WorldEffects.Effects["Apocalypse"] = {
    Apply = function()
        Lt.ClockTime = 16.5
        Lt.Brightness = 1.4
        Lt.Ambient = Color3.fromRGB(100, 80, 60)
        Lt.OutdoorAmbient = Color3.fromRGB(140, 100, 70)
        Lt.ColorShift_Top = Color3.fromRGB(200, 140, 80)
        Lt.ColorShift_Bottom = Color3.fromRGB(120, 80, 50)
        Lt.FogColor = Color3.fromRGB(150, 110, 70)
        Lt.FogStart = 30
        Lt.FogEnd = 3000
        Lt.ExposureCompensation = -0.05
--
        local bloom = Instance.new("BloomEffect")
        bloom.Name = "WE_Bloom"
        bloom.Intensity = 0.75
        bloom.Size = 31
        bloom.Threshold = 0.6
        bloom.Parent = Lt
--
        local cc = Instance.new("ColorCorrectionEffect")
        cc.Name = "WE_ColorCorrection"
        cc.Brightness = -0.12
        cc.Contrast = 0.3
        cc.Saturation = -0.2
        cc.TintColor = Color3.fromRGB(200, 180, 160)
        cc.Parent = Lt
--
        local blur = Instance.new("BlurEffect")
        blur.Name = "WE_Blur"
        blur.Size = 4
        blur.Parent = Lt
    end
}
--
WorldEffects.Effects["Crystal Cave"] = {
    Apply = function()
        Lt.ClockTime = 10
        Lt.Brightness = 2.8
        Lt.Ambient = Color3.fromRGB(150, 200, 255)
        Lt.OutdoorAmbient = Color3.fromRGB(180, 220, 255)
        Lt.ColorShift_Top = Color3.fromRGB(200, 240, 255)
        Lt.ColorShift_Bottom = Color3.fromRGB(140, 180, 230)
        Lt.FogColor = Color3.fromRGB(170, 210, 255)
        Lt.FogStart = 70
        Lt.FogEnd = 5500
        Lt.ExposureCompensation = 0.3
--
        local bloom = Instance.new("BloomEffect")
        bloom.Name = "WE_Bloom"
        bloom.Intensity = 1.4
        bloom.Size = 38
        bloom.Threshold = 0.35
        bloom.Parent = Lt
--
        local cc = Instance.new("ColorCorrectionEffect")
        cc.Name = "WE_ColorCorrection"
        cc.Brightness = 0.15
        cc.Contrast = 0.2
        cc.Saturation = 0.4
        cc.TintColor = Color3.fromRGB(220, 240, 255)
        cc.Parent = Lt
--
        local time = 0
        table.insert(WorldEffects.Connections, RS.Heartbeat:Connect(function(dt)
            time = time + dt
            local sparkle = math.sin(time * 6) * 0.4 + 1
            bloom.Intensity = sparkle * 1.2
        end))
    end
}
--
function WorldEffects:Enable(effectName)
    if self.Enabled and self.CurrentEffect == effectName then return end
--
    self:SaveOriginal()
    self:ClearEffects()
--
    self.Enabled = true
    self.CurrentEffect = effectName
--
    self:ApplyEffect(effectName)
end
--
function WorldEffects:Disable()
    if not self.Enabled then return end
--
    self.Enabled = false
    self.CurrentEffect = "None"
--
    self:ClearEffects()
    self:RestoreOriginal()
end
--
WorldEffects:SaveOriginal()
--
-- ==================== KOHETs DOБABLEHHЫX FYHKTsIY ====================
--
-- END ORIGINAL SOURCE LINES 1368-2040

-- BEGIN ORIGINAL SOURCE LINES 2755-2892
-- ==================== OБHOBLEHHAYa ESP CICTEMA ====================
--
local function updESP()
    for _, p in pairs(Plrs:GetPlayers()) do
        if p ~= LP then
            local c = p.Character; if c then
                local hl = c:FindFirstChild("Highlight")
                if S.ESP.HlOn and S.ESP.On then
                    local localRoot = LP.Character and LP.Character:FindFirstChild("HumanoidRootPart")
                    local targetRoot = c:FindFirstChild("HumanoidRootPart")
--
                    if localRoot and targetRoot then
                        local distance = (localRoot.Position - targetRoot.Position).Magnitude
                        if distance > S.ESPDistance.Value then
                            if hl then hl:Destroy() end
                            continue
                        end
                    end
--
                    if not hl then hl = Instance.new("Highlight"); hl.Parent = c; hl.FillTransparency = 1; hl.OutlineTransparency = 0 end
                    hl.OutlineColor = S.ESP.HlCol
                    hl.Enabled = true
                else 
                    if hl then hl:Destroy() end 
                end
            end
        end
    end
end
--
local function updAllHL()
    for _, p in pairs(Plrs:GetPlayers()) do
        if p ~= LP then 
            local c = p.Character; if c then 
                local hl = c:FindFirstChild("Highlight")
                if hl and S.ESP.HlOn and S.ESP.On then 
                    local localRoot = LP.Character and LP.Character:FindFirstChild("HumanoidRootPart")
                    local targetRoot = c:FindFirstChild("HumanoidRootPart")
--
                    if localRoot and targetRoot then
                        local distance = (localRoot.Position - targetRoot.Position).Magnitude
                        if distance > S.ESPDistance.Value then
                            hl.Enabled = false
                        else
                            hl.Enabled = true
                            hl.OutlineColor = S.ESP.HlCol 
                        end
                    end
                end 
            end 
        end 
    end
end
--
local function updArms()
    local cam = Ws.CurrentCamera; local vf = cam:FindFirstChild("ViewModel"); if not vf then return end
    local la = vf:FindFirstChild("Left Arm"); local ra = vf:FindFirstChild("Right Arm")
    if la and ra then
        if S.ESP.ArmsOn and S.ESP.On then
            if not la:GetAttribute("OrigMat") then la:SetAttribute("OrigMat", la.Material); la:SetAttribute("OrigCol", la.Color) end
            if not ra:GetAttribute("OrigMat") then ra:SetAttribute("OrigMat", ra.Material); ra:SetAttribute("OrigCol", ra.Color) end
            la.Material = Enum.Material.ForceField; ra.Material = Enum.Material.ForceField
            la.Color = S.ESP.ArmsCol; ra.Color = S.ESP.ArmsCol
        else
            local lom = la:GetAttribute("OrigMat"); local loc = la:GetAttribute("OrigCol")
            local rom = ra:GetAttribute("OrigMat"); local roc = ra:GetAttribute("OrigCol")
            la.Material = lom or Enum.Material.Plastic; la.Color = loc or Color3.fromRGB(255,255,255)
            ra.Material = rom or Enum.Material.Plastic; ra.Color = roc or Color3.fromRGB(255,255,255)
        end
    end
end
--
local function setArmsCol(cName)
    if hlCols[cName] then S.ESP.ArmsCol = hlCols[cName]; updArms(); Lib:Notify("Arms col: "..cName, 2) end
end
--
local function toggleArms(state)
    if not S.ESP.On then Lib:Notify("ESP system must be enabled first!", 2); return false end
    S.ESP.ArmsOn = state
    if state then
        updArms()
        if not S.ESP.VMConn then
            S.ESP.VMConn = Ws.CurrentCamera.ChildAdded:Connect(function(ch)
                if ch.Name == "ViewModel" then task.wait(0.5); if S.ESP.ArmsOn and S.ESP.On then updArms() end end
            end)
        end
        if not S.ESP.CharConn then
            S.ESP.CharConn = LP.CharacterAdded:Connect(function() task.wait(1); if S.ESP.ArmsOn and S.ESP.On then updArms() end end)
        end
        Lib:Notify("Arms on", 2)
    else
        updArms()
        if S.ESP.VMConn then S.ESP.VMConn:Disconnect(); S.ESP.VMConn = nil end
        if S.ESP.CharConn then S.ESP.CharConn:Disconnect(); S.ESP.CharConn = nil end
        Lib:Notify("Arms off", 2)
    end
    return S.ESP.ArmsOn
end
--
local function setHLCol(cName)
    if hlCols[cName] then S.ESP.HlCol = hlCols[cName]; updAllHL(); Lib:Notify("HL col: "..cName, 2) end
end
--
local function toggleHL(state)
    if not S.ESP.On then Lib:Notify("ESP system must be enabled first!", 2); return false end
    S.ESP.HlOn = state
    if S.ESP.HlOn then
        updESP()
        if not S.ESP.Conn then S.ESP.Conn = RS.Heartbeat:Connect(updESP) end
        Plrs.PlayerAdded:Connect(function(p) p.CharacterAdded:Connect(function(c) if S.ESP.On and S.ESP.HlOn then task.wait(0.5); updESP() end end) end)
        Lib:Notify("HL on", 2)
    else
        for _, p in pairs(Plrs:GetPlayers()) do if p ~= LP then local c = p.Character; if c then local hl = c:FindFirstChild("Highlight"); if hl then hl:Destroy() end end end end
        Lib:Notify("HL off", 2)
    end
    return S.ESP.HlOn
end
--
local function toggleSys(state)
    S.ESP.On = state
    if S.ESP.On then
        if S.ESP.HlOn then updESP(); S.ESP.Conn = RS.Heartbeat:Connect(updESP)
            Plrs.PlayerAdded:Connect(function(p) p.CharacterAdded:Connect(function(c) if S.ESP.On and S.ESP.HlOn then task.wait(0.5); updESP() end end) end) end
        if S.ESP.ArmsOn then updArms() end
        Lib:Notify("ESP on", 2)
    else
        if S.ChinaHat.Enabled then toggleChinaHat(false) end
        if S.PlayerChams.Enabled then togglePlayerChams(false) end
--
        if S.ESP.Conn then S.ESP.Conn:Disconnect(); S.ESP.Conn = nil end
        if S.ESP.VMConn then S.ESP.VMConn:Disconnect(); S.ESP.VMConn = nil end
        if S.ESP.CharConn then S.ESP.CharConn:Disconnect(); S.ESP.CharConn = nil end
        for _, p in pairs(Plrs:GetPlayers()) do if p ~= LP then local c = p.Character; if c then local hl = c:FindFirstChild("Highlight"); if hl then hl:Destroy() end end end end
        updArms()
        Lib:Notify("ESP off", 2)
    end
end
--
-- END ORIGINAL SOURCE LINES 2755-2892

-- BEGIN ORIGINAL SOURCE LINES 3550-3642
local function enFB()
    if S.FullBright.On then return end
    S.FullBright.On = true; _G.FBPersist = true
    Lt.Brightness = 5; Lt.ClockTime = 14; Lt.Ambient = Color3.new(1,1,1); Lt.OutdoorAmbient = Color3.new(1,1,1)
    Lt.ColorShift_Top = Color3.new(0,0,0); Lt.FogStart = 100000; Lt.FogEnd = 100000
    S.FullBright.Conn = RS.RenderStepped:Connect(function()
        if not S.FullBright.On then if S.FullBright.Conn then S.FullBright.Conn:Disconnect(); S.FullBright.Conn = nil end return end
        if Lt.Brightness ~= 5 then Lt.Brightness = 5 end
        if Lt.ClockTime ~= 14 then Lt.ClockTime = 14 end
        if Lt.Ambient ~= Color3.new(1,1,1) then Lt.Ambient = Color3.new(1,1,1) end
        if Lt.OutdoorAmbient ~= Color3.new(1,1,1) then Lt.OutdoorAmbient = Color3.new(1,1,1) end
        if Lt.ColorShift_Top ~= Color3.new(0,0,0) then Lt.ColorShift_Top = Color3.new(0,0,0) end
        if Lt.FogStart ~= 100000 then Lt.FogStart = 100000 end
        if Lt.FogEnd ~= 100000 then Lt.FogEnd = 100000 end
    end)
    Lib:Notify("FullBright on!", 2)
end
--
local function disFB()
    if not S.FullBright.On then return end
    S.FullBright.On = false; _G.FBPersist = false
    if S.FullBright.Conn then S.FullBright.Conn:Disconnect(); S.FullBright.Conn = nil end
    Lt.Brightness = S.FullBright.OrigVals.Brightness; Lt.ClockTime = S.FullBright.OrigVals.ClockTime
    Lt.Ambient = S.FullBright.OrigVals.Ambient; Lt.OutdoorAmbient = S.FullBright.OrigVals.OutdoorAmbient
    Lt.ColorShift_Top = S.FullBright.OrigVals.ColorShift_Top; Lt.FogStart = S.FullBright.OrigVals.FogStart; Lt.FogEnd = S.FullBright.OrigVals.FogEnd
    Lib:Notify("FullBright off!", 2)
end
--
local function toggleFB(state) if state then enFB() else disFB() end end
--
task.spawn(function()
    while true do
        task.wait(10)
        if not S.FullBright.On then
            S.FullBright.OrigVals = {
                ClockTime = Lt.ClockTime, Brightness = Lt.Brightness, Ambient = Lt.Ambient,
                OutdoorAmbient = Lt.OutdoorAmbient, ColorShift_Top = Lt.ColorShift_Top,
                FogStart = Lt.FogStart, FogEnd = Lt.FogEnd,
            }
        end
    end
end)
--
local function FOV_on()
    if S.FOV.On then return end; S.FOV.On = true; _G.FOVPersist = true
    if S.FOV.Conn then S.FOV.Conn:Disconnect() end
    S.FOV.Conn = RS.RenderStepped:Connect(function() if S.FOV.On then Cam.FieldOfView = S.FOV.Val end end)
    Lib:Notify("FOV on", 2)
end
--
local function FOV_off()
    if not S.FOV.On then return end; S.FOV.On = false; _G.FOVPersist = false
    if S.FOV.Conn then S.FOV.Conn:Disconnect(); S.FOV.Conn = nil end
    Cam.FieldOfView = S.FOV.OrigVal; Lib:Notify("FOV off", 2)
end
--
local function toggleFOV(state) if state then FOV_on() else FOV_off() end end
--
local skyboxes = {
    ["Nebula"] = {MoonTex="rbxassetid://1075087760", SkyBk="rbxassetid://2118763079", SkyDn="rbxassetid://2118766919", SkyFt="rbxassetid://2118765204", SkyLf="rbxassetid://2118764070", SkyRt="rbxassetid://2118761853", SkyUp="rbxassetid://2118766003", Stars=0},
    ["Red Nebula"] = {MoonTex="rbxassetid://1075087760", SkyBk="rbxassetid://75202130006087", SkyDn="rbxassetid://84899615600068", SkyFt="rbxassetid://123583852168685", SkyLf="rbxassetid://91852061002963", SkyRt="rbxassetid://138329424663418", SkyUp="rbxassetid://98269626597694", Stars=0},
    ["Nebula Pink"] = {MoonTex="rbxasset://sky/moon.jpg", SkyBk="rbxassetid://13581437029", SkyDn="rbxassetid://13581439832", SkyFt="rbxassetid://13581447312", SkyLf="rbxassetid://13581443463", SkyRt="rbxassetid://13581452875", SkyUp="rbxassetid://13581450222", Stars=3000},
    ["White Galaxy"] = {MoonTex="rbxasset://sky/moon.jpg", SkyBk="rbxassetid://5540798456", SkyDn="rbxassetid://5540799894", SkyFt="rbxassetid://5540801779", SkyLf="rbxassetid://5540801192", SkyRt="rbxassetid://5540799108", SkyUp="rbxassetid://5540800635", Stars=5000, SunSize=1, SunTex="rbxasset://sky/sun.jpg"},
    ["Purple Nebula"] = {MoonTex="rbxasset://sky/moon.jpg", SkyBk="rbxassetid://94797807540176", SkyDn="rbxassetid://135040133024386", SkyFt="rbxassetid://134956217810021", SkyLf="rbxassetid://77274943792368", SkyRt="rbxassetid://86193107896056", SkyUp="rbxassetid://72286287669628", Stars=3000, SunSize=11, SunTex="rbxasset://sky/sun.jpg"}
}
--
local function enSky(sName)
    if not skyboxes[sName] then Lib:Notify("Invalid sky!", 2); return false end
    local data = skyboxes[sName]
    if not S.Sky.Orig then
        local ex = Lt:FindFirstChildOfClass("Sky")
        if ex then S.Sky.Orig = ex:Clone() end
    end
    for _, ch in pairs(Lt:GetChildren()) do if ch:IsA("Sky") then ch:Destroy() end end
    local sk = Instance.new("Sky"); sk.Name = "CustomSky"; sk.Parent = Lt
    sk.MoonTextureId = data.MoonTex; sk.SkyboxBk = data.SkyBk; sk.SkyboxDn = data.SkyDn
    sk.SkyboxFt = data.SkyFt; sk.SkyboxLf = data.SkyLf; sk.SkyboxRt = data.SkyRt; sk.SkyboxUp = data.SkyUp
    sk.SkyboxOrientation = Vector3.new(0,0,0); sk.StarCount = data.Stars
    if data.SunSize then sk.SunAngularSize = data.SunSize end
    if data.SunTex then sk.SunTextureId = data.SunTex end
    S.Sky.Custom = sk; S.Sky.Selected = sName; S.Sky.On = true
    Lib:Notify(sName.." sky on!", 2); return true
end
--
local function disSky()
    for _, ch in pairs(Lt:GetChildren()) do if ch:IsA("Sky") then ch:Destroy() end end
    if S.Sky.Custom then S.Sky.Custom:Destroy(); S.Sky.Custom = nil end
    if S.Sky.Orig then S.Sky.Orig:Clone().Parent = Lt; Lib:Notify("Orig sky back", 2) else Lib:Notify("Sky off", 2) end
    S.Sky.On = false; S.Sky.Selected = nil
end
--
local function setFOVVal(v) S.FOV.Val = v; if S.FOV.On then Cam.FieldOfView = v end; Lib:Notify("FOV: "..v, 2) end
--
-- END ORIGINAL SOURCE LINES 3550-3642

-- BEGIN ORIGINAL SOURCE LINES 7543-7886
-- ==================== KEY STROKES ====================
--
Tabs.Player:AddRightGroupbox("Key Strokes"):AddToggle("KeyStrokesToggle", {
    Text = "Enable Key Strokes",
    Default = false,
    Tooltip = "Shows WASD, FPS, CPS and Ping on screen",
    Callback = function(state)
        if state then
            pcall(function()
                -- Chachaлa yдaлyaem bce ctapye GUI c WASD
                local coreGui = game:GetService("CoreGui")
                for _, gui in pairs(coreGui:GetChildren()) do
                    if gui:IsA("ScreenGui") then
                        for _, child in pairs(gui:GetDescendants()) do
                            if child:IsA("TextLabel") and child.Text == "W" then
                                gui:Destroy()
                                break
                            end
                        end
                    end
                end
--
                -- Heboльshaya zaдepжka chtoby гapahtipobahho yдaлitь
                task.wait(0.1)
--
                -- Зaгpyжaem hobyy
                getgenv().k1 = "W"
                getgenv().k2 = "A"
                getgenv().k3 = "S"
                getgenv().k4 = "D"
                getgenv().backdrop = false
                getgenv().showms = true
                getgenv().showfps = true
                getgenv().showkps = true
                getgenv().animated = true
                getgenv().showarrows = false
                getgenv().keydrag = false
--
                loadstring(game:HttpGet("https://raw.githubusercontent.com/Zirmith/Util-Tools/main/keyStrokes.lua"))()
                Lib:Notify("Key Strokes enabled", 2)
            end)
        else
            pcall(function()
                local coreGui = game:GetService("CoreGui")
                for _, gui in pairs(coreGui:GetChildren()) do
                    if gui:IsA("ScreenGui") then
                        for _, child in pairs(gui:GetDescendants()) do
                            if child:IsA("TextLabel") and child.Text == "W" then
                                gui:Destroy()
                                break
                            end
                        end
                    end
                end
            end)
            Lib:Notify("Key Strokes disabled", 2)
        end
    end
})
--
Crosshair = {On=false, Size=12, Thick=1, Gap=5, Col=Color3.fromRGB(255,255,255), Outline=true, OutlineCol=Color3.fromRGB(0,0,0), Style="Cross", Dynamic=false, ShowTarget=false, Hitmarker=true}
CLLines = {}; CLDot = nil; CLCircle = nil; TargInd = nil; HitInd = nil
--
function Crosshair:Setup()
    self:Remove()
    for i=1,4 do CLLines[i] = Drawing.new("Line"); CLLines[i].Visible = false; CLLines[i].Color = self.Col; CLLines[i].Thickness = self.Thick; CLLines[i].ZIndex = 999 end
    CLDot = Drawing.new("Circle"); CLDot.Visible = false; CLDot.Color = self.Col; CLDot.Thickness = self.Thick; CLDot.Filled = true; CLDot.NumSides = 12; CLDot.Radius = 2; CLDot.ZIndex = 999
    TargInd = Drawing.new("Circle"); TargInd.Visible = false; TargInd.Color = Color3.fromRGB(255,0,0); TargInd.Thickness = 2; TargInd.Filled = false; TargInd.NumSides = 24; TargInd.Radius = 20; TargInd.ZIndex = 998
    HitInd = Drawing.new("Square"); HitInd.Visible = false; HitInd.Color = Color3.fromRGB(255,255,255); HitInd.Thickness = 2; HitInd.Filled = false; HitInd.Size = Vector2.new(10,10); HitInd.ZIndex = 1000
    Lib:Notify("Crosshair init", 2)
end
--
function Crosshair:Update()
    if not self.On then for i=1,4 do if CLLines[i] then CLLines[i].Visible = false end end; if CLDot then CLDot.Visible = false end; if CLCircle then CLCircle.Visible = false end; if TargInd then TargInd.Visible = false end; return end
    local sc = Vector2.new(Cam.ViewportSize.X/2, Cam.ViewportSize.Y/2)
    if self.Style == "Cross" then
        CLLines[1].From = Vector2.new(sc.X, sc.Y - self.Gap - self.Size); CLLines[1].To = Vector2.new(sc.X, sc.Y - self.Gap); CLLines[1].Visible = true
        CLLines[2].From = Vector2.new(sc.X, sc.Y + self.Gap); CLLines[2].To = Vector2.new(sc.X, sc.Y + self.Gap + self.Size); CLLines[2].Visible = true
        CLLines[3].From = Vector2.new(sc.X - self.Gap - self.Size, sc.Y); CLLines[3].To = Vector2.new(sc.X - self.Gap, sc.Y); CLLines[3].Visible = true
        CLLines[4].From = Vector2.new(sc.X + self.Gap, sc.Y); CLLines[4].To = Vector2.new(sc.X + self.Gap + self.Size, sc.Y); CLLines[4].Visible = true
        if CLDot then CLDot.Visible = false end; if CLCircle then CLCircle.Visible = false end
    elseif self.Style == "Dot" then
        for i=1,4 do if CLLines[i] then CLLines[i].Visible = false end end; if CLCircle then CLCircle.Visible = false end
        if CLDot then CLDot.Position = sc; CLDot.Visible = true end
    elseif self.Style == "Circle" then
        for i=1,4 do if CLLines[i] then CLLines[i].Visible = false end end; if CLDot then CLDot.Visible = false end
        if not CLCircle then CLCircle = Drawing.new("Circle"); CLCircle.Visible = true; CLCircle.Color = self.Col; CLCircle.Thickness = self.Thick; CLCircle.Filled = false; CLCircle.NumSides = 24; CLCircle.Radius = self.Size; CLCircle.ZIndex = 999 end
        CLCircle.Position = sc; CLCircle.Visible = true
    end
    if self.ShowTarget then
        local t = self:GetAimT(); if t then local sp = Cam:WorldToViewportPoint(t.Position); if sp.Z > 0 then TargInd.Position = Vector2.new(sp.X, sp.Y); TargInd.Visible = true else TargInd.Visible = false end else TargInd.Visible = false end
    end
end
--
function Crosshair:GetAimT()
    local maxD = 1000; local mPos = UIS:GetMouseLocation(); local ur = Cam:ViewportPointToRay(mPos.X, mPos.Y)
    local rp = RaycastParams.new(); rp.FilterType = Enum.RaycastFilterType.Blacklist; rp.FilterDescendantsInstances = {LP.Character}
    local rr = workspace:Raycast(ur.Origin, ur.Direction * maxD, rp)
    if rr and rr.Instance then local hp = rr.Instance; local c = hp.Parent; if c and c:FindFirstChild("Humanoid") then return c end end
    return nil
end
--
function Crosshair:ShowHit() if not self.Hitmarker then return end; if not HitInd then return end
    HitInd.Position = Vector2.new(Cam.ViewportSize.X/2-5, Cam.ViewportSize.Y/2-5); HitInd.Visible = true
    task.spawn(function() task.wait(0.1); if HitInd then HitInd.Visible = false end end) end
--
function Crosshair:Remove()
    for i=1,4 do if CLLines[i] then CLLines[i]:Remove() end end
    if CLDot then CLDot:Remove(); CLDot = nil end
    if CLCircle then CLCircle:Remove(); CLCircle = nil end
    if TargInd then TargInd:Remove(); TargInd = nil end
    if HitInd then HitInd:Remove(); HitInd = nil end
end
--
task.spawn(function() task.wait(2); Crosshair:Setup() end)
--
CLGroup = Tabs.Visuals:AddLeftGroupbox("Crosshair")
CLGroup:AddToggle("CLToggle", {Text="Enable Crosshair", Default=false, Callback=function(v) Crosshair.On = v; Crosshair:Update() end})
CLGroup:AddDropdown("CLStyle", {Values={"Cross","Dot","Circle"}, Default="Cross", Multi=false, Text="Style", Callback=function(v) Crosshair.Style = v; Crosshair:Setup(); Crosshair:Update() end})
CLGroup:AddLabel("Color:"):AddColorPicker("CLColor", {Default=Crosshair.Col, Title="Color", Callback=function(v) Crosshair.Col = v; for i=1,4 do if CLLines[i] then CLLines[i].Color = v end end; if CLDot then CLDot.Color = v end; if CLCircle then CLCircle.Color = v end end})
CLGroup:AddSlider("CLSize", {Text="Size", Default=12, Min=1, Max=50, Rounding=0, Compact=false, Callback=function(v) Crosshair.Size = v; Crosshair:Update() end})
CLGroup:AddSlider("CLGap", {Text="Gap", Default=5, Min=0, Max=20, Rounding=0, Compact=false, Callback=function(v) Crosshair.Gap = v; Crosshair:Update() end})
CLGroup:AddSlider("CLThick", {Text="Thickness", Default=1, Min=1, Max=5, Rounding=0, Compact=false, Callback=function(v) Crosshair.Thick = v; for i=1,4 do if CLLines[i] then CLLines[i].Thickness = v end end; if CLDot then CLDot.Thickness = v end; if CLCircle then CLCircle.Thickness = v end end})
CLGroup:AddToggle("CLShowTarget", {Text="Show Target", Default=false, Callback=function(v) Crosshair.ShowTarget = v end})
CLGroup:AddToggle("CLHitmarker", {Text="Hitmarker", Default=true, Callback=function(v) Crosshair.Hitmarker = v end})
CLGroup:AddToggle("CLDynamic", {Text="Dynamic Crosshair", Default=false, Callback=function(v) Crosshair.Dynamic = v end})
--
CLConn = RS.RenderStepped:Connect(function() if Crosshair.On then Crosshair:Update() end end)
--
task.spawn(function()
    task.wait(3)
    if GNX then GNX.OnClientEvent:Connect(function(st,sc,gun,ft,sPos,dirs,silenced) if Crosshair.Hitmarker then Crosshair:ShowHit() end end) end
end)
--
_G.CleanupCL = function() if CLConn then CLConn:Disconnect() end; Crosshair:Remove() end
--
-- ==================== VIEW VISUALS SECTION ====================
--
local ViewVisualsGroup = Tabs.Visuals:AddRightGroupbox("View Visuals")
--
Map Lighting Button with Color Picker
local MapLightingToggle = ViewVisualsGroup:AddToggle("MapLightingToggle", {
    Text = "Map Lighting",
    Default = false,
    Callback = function(state)
        if state then
            MapLighting:Enable()
            Lib:Notify("Map Lighting enabled", 2)
        else
            MapLighting:Disable()
            Lib:Notify("Map Lighting disabled", 2)
        end
    end
})
--
Color Picker for Map Lighting
MapLightingToggle:AddColorPicker("MapLightingColor", {
    Default = MapLighting.LightingColors[1].MainColor,
    Title = "Map Lighting Color",
    Callback = function(color)
        -- Find the closest color in our table
        local closestIndex = 1
        local closestDistance = math.huge
--
        for i, colorInfo in ipairs(MapLighting.LightingColors) do
            local distance = math.sqrt(
                (color.R - colorInfo.MainColor.R)^2 +
                (color.G - colorInfo.MainColor.G)^2 +
                (color.B - colorInfo.MainColor.B)^2
            )
--
            if distance < closestDistance then
                closestDistance = distance
                closestIndex = i
            end
        end
--
        MapLighting.CurrentColorIndex = closestIndex
        if MapLighting.Enabled then
            MapLighting:ApplyLighting()
            Lib:Notify("Map Lighting color changed to " .. MapLighting.LightingColors[closestIndex].Name, 2)
        end
    end
})
--
Map Blur Button
ViewVisualsGroup:AddToggle("MapBlurToggle", {
    Text = "Map Blur",
    Default = false,
    Callback = function(state)
        if state then
            MapBlur:Toggle()
            Lib:Notify("Map Blur enabled", 2)
        else
            MapBlur:Toggle()
            Lib:Notify("Map Blur disabled", 2)
        end
    end
})
--
-- ==================== OБHOBLEHHЫY ESP SECTION ====================
--
VisL = Tabs.Visuals:AddLeftGroupbox("ESP")
VisL:AddToggle("ESPSys", {Text="ESP", Default=false, Callback=function(v) toggleSys(v) end})
VisL:AddToggle("PlayerHL", {Text="Player Highlight", Default=false, Callback=function(v) 
    local ns = toggleHL(v); 
    if ns ~= v then 
        Toggles.PlayerHL:SetValue(ns) 
    end 
end}):AddColorPicker("PlayerHLColor", {
    Default = S.ESP.HlCol,
    Title = "HL Color",
    Callback = function(v) 
        S.ESP.HlCol = v
        updAllHL()
        Lib:Notify("HL Color changed", 2)
    end
})
--
VisL:AddToggle("ArmsChams", {Text="Arms Chams", Default=false, Callback=function(v) 
    local ns = toggleArms(v); 
    if ns ~= v then 
        Toggles.ArmsChams:SetValue(ns) 
    end 
end}):AddColorPicker("ArmsCol", {
    Default = S.ESP.ArmsCol,
    Title = "Arms Color",
    Callback = function(v) 
        S.ESP.ArmsCol = v
        if S.ESP.ArmsOn and S.ESP.On then 
            updArms() 
        end
        Lib:Notify("Arms Color changed", 2)
    end
})
--
China Hat (toльko ha cebya)
VisL:AddToggle("ChinaHatToggle", {
    Text = "China Hat",
    Default = false,
    Callback = function(v)
        if v and not S.ESP.On then
            Toggles.ChinaHatToggle:SetValue(false)
            Lib:Notify("ESP system must be enabled first!", 2)
            return
        end
        toggleChinaHat(v)
    end
}):AddColorPicker("ChinaHatColor", {
    Default = S.ChinaHat.Color,
    Title = "China Hat Color",
    Callback = function(v)
        S.ChinaHat.Color = v
        if S.ChinaHat.Hat then
            local highlight = S.ChinaHat.Hat:FindFirstChildOfClass("Highlight")
            if highlight then
                highlight.FillColor = v
                highlight.OutlineColor = v
            end
        end
        Lib:Notify("China Hat Color changed", 2)
    end
})
--
Player Chams
local ChamsToggle = VisL:AddToggle("PlayerChamsToggle", {
    Text = "Player Chams",
    Default = false,
    Callback = function(v)
        if v and not S.ESP.On then
            Toggles.PlayerChamsToggle:SetValue(false)
            Lib:Notify("ESP system must be enabled first!", 2)
            return
        end
        togglePlayerChams(v)
    end
})
--
ChamsToggle:AddColorPicker("PlayerChamsVisibleColor", {
    Default = S.PlayerChams.VisibleColor,
    Title = "Visible Color",
    Transparency = 0.5,
    Callback = function(v)
        S.PlayerChams.VisibleColor = v
        for _, playerData in pairs(S.PlayerChams.Adornments) do
            for _, adornmentsTable in pairs(playerData) do
                if adornmentsTable[2] then
                    adornmentsTable[2].Color3 = v
                end
            end
        end
        Lib:Notify("Visible Color changed", 2)
    end
})
--
ChamsToggle:AddColorPicker("PlayerChamsOccludedColor", {
    Default = S.PlayerChams.OccludedColor,
    Title = "Occluded Color",
    Transparency = 0,
    Callback = function(v)
        S.PlayerChams.OccludedColor = v
        for _, playerData in pairs(S.PlayerChams.Adornments) do
            for _, adornmentsTable in pairs(playerData) do
                if adornmentsTable[1] then
                    adornmentsTable[1].Color3 = v
                end
            end
        end
        Lib:Notify("Occluded Color changed", 2)
    end
})
--
ESP Distance Slider
VisL:AddSlider("ESPDistance", {
    Text = "ESP Distance",
    Default = S.ESPDistance.Value,
    Min = S.ESPDistance.Min,
    Max = S.ESPDistance.Max,
    Rounding = 0,
    Compact = false,
    Callback = function(v)
        S.ESPDistance.Value = v
        Lib:Notify("ESP Distance: " .. v, 2)
    end
})
--
GunsVisR = Tabs.Visuals:AddRightGroupbox("Guns Visuals")
GunsVisR:AddToggle("BBToggle", {Text="BulletBeam", Default=false, Callback=function(s) _G.BBPersist = s; toggleBB(s) end})
GunsVisR:AddLabel("Beam Color:"):AddColorPicker("BBColor", {Default=BB.Col, Title="BB Color", Callback=function(v) setBBCol(v.r,v.g,v.b); Lib:Notify("BB color changed", 2) end})
GunsVisR:AddSlider("BBThick", {Text="Thickness", Default=0.1, Min=0.01, Max=0.5, Rounding=2, Compact=false, Suffix=" studs", Callback=function(v) BB.Thick = v; Lib:Notify("Thick: "..v, 2) end})
GunsVisR:AddSlider("BBLife", {Text="Lifetime", Default=2, Min=0.1, Max=5, Rounding=1, Compact=false, Suffix="s", Callback=function(v) BB.Life = v; Lib:Notify("Life: "..v.."s", 2) end})
GunsVisR:AddSlider("BBTrans", {Text="Transparency", Default=0.7, Min=0, Max=1, Rounding=2, Compact=false, Callback=function(v) BB.Trans = v; Lib:Notify("Trans: "..math.round(v*100).."%", 2) end})
GunsVisR:AddDropdown("BBType", {Values={"Beam","Line"}, Default="Beam", Multi=false, Text="Type", Callback=function(v) BB.Type = v; clrTracers(); Lib:Notify("Type: "..v, 2) end})
GunsVisR:AddDropdown("BBTex", {Values={"Classic","Lightning","Rainbow","Smoke","Energy","Glitch","Custom"}, Default="Classic", Multi=false, Text="Texture", Callback=function(v) BB.CurTex = v; Lib:Notify("Tex: "..v, 2) end})
GunsVisR:AddInput("CustomTexIn", {Text="Custom Texture ID", Placeholder="rbxassetid://...", Default="", Callback=function(v) if v ~= "" and v:match("^rbxassetid://%d+$") then BB.CustomTex = v; if BB.CurTex == "Custom" then Lib:Notify("Custom tex updated", 2) end elseif v ~= "" then Lib:Notify("Invalid ID", 2) end end})
GunsVisR:AddButton({Text="Clear Tracers", Func=function() clrTracers(); Lib:Notify("Tracers cleared", 2) end, DoubleClick=false})
tcLabel = GunsVisR:AddLabel("Active: 0")
task.spawn(function() while task.wait(0.5) do local cnt=0; for _ in pairs(BB.Active) do cnt=cnt+1 end; tcLabel:SetText("Active: "..cnt) end end)
--
ViewG = Tabs.Visuals:AddRightGroupbox("View")
ViewG:AddToggle("FBToggle", {Text="Full Bright", Default=false, Callback=function(v) toggleFB(v) end})
ViewG:AddToggle("FOVToggle", {Text="FOV Changer", Default=false, Callback=function(v) toggleFOV(v) end})
ViewG:AddSlider("FOVVal", {Text="FOV Value", Default=80, Min=1, Max=120, Rounding=0, Compact=false, Callback=function(v) setFOVVal(v) end})
--
-- END ORIGINAL SOURCE LINES 7543-7886
