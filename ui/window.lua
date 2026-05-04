--[[
Inert commented archive file.
No executable Lua is present below; every preserved source line is prefixed with --.
Role: Window creation and startup sound
Original source line ranges: 2893-2900
]]


-- BEGIN ORIGINAL SOURCE LINES 2893-2900
-- ==================== OCHOBHOE OKHO I HACTPOYKI ====================
--
Win = Lib:CreateWindow({Title = "starlight.cc", Center = true, AutoShow = true})
--
StartSnd = Instance.new("Sound")
StartSnd.SoundId = "rbxassetid://9072301639"; StartSnd.Volume = 1.5; StartSnd.Parent = Win.API and Win.API.Container or game:GetService("CoreGui")
task.defer(function() pcall(function() StartSnd:Play() end) end)
--
-- END ORIGINAL SOURCE LINES 2893-2900
