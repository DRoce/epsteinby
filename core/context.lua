--[[
Inert commented archive file.
No executable Lua is present below; every preserved source line is prefixed with --.
Role: External library loads, Roblox services, player/camera references, remotes
Original source line ranges: 48-67
]]


-- BEGIN ORIGINAL SOURCE LINES 48-67
local Lib = loadstring(game:HttpGet("https://raw.githubusercontent.com/violin-suzutsuki/LinoriaLib/main/Library.lua"))()
local TM = loadstring(game:HttpGet("https://raw.githubusercontent.com/eradicator2/starlight-criminality/refs/heads/main/ThemeManager.lua"))()
local SM = loadstring(game:HttpGet("https://raw.githubusercontent.com/violin-suzutsuki/LinoriaLib/main/addons/SaveManager.lua"))()
--
local Plrs = game:GetService("Players")
local RepSt = game:GetService("ReplicatedStorage")
local RS = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local VU = game:GetService("VirtualUser")
local Ws = game:GetService("Workspace")
local Lt = game:GetService("Lighting")
--
local LP = Plrs.LocalPlayer
local Cam = workspace.CurrentCamera
--
local EvFolder = RepSt:WaitForChild("Events")
local GNX = EvFolder:WaitForChild("GNX_S")
local ZFK = EvFolder:WaitForChild("ZFKLF__H")
local deathEv = EvFolder:WaitForChild("DeathRespawn")
--
-- END ORIGINAL SOURCE LINES 48-67
