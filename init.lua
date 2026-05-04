--[[
Inert commented archive file.
No executable Lua is present below; every preserved source line is prefixed with --.
Role: Bootstrap / initial guard block
Original source line ranges: 1-47
]]


-- BEGIN ORIGINAL SOURCE LINES 1-47
    do
    local secActive = true
    local lastChk = tick()
    local function safeChk()
        if tick() - lastChk < 5 then return true end
        lastChk = tick()
        local badNames = {"HttpSpy", "DexExplorer", "SimpleSpy", "ScriptDumper", "HookFunction", "RemoteSpy", "NetworkSpy", "PacketSniffer"}
        local cg = game:GetService("CoreGui")
        for _, o in pairs(cg:GetChildren()) do
            if o:IsA("ScreenGui") then
                local n = o.Name:lower()
                if n:find("spy") or n:find("dex") or n:find("hook") then return false end
            end
        end
        for _, n in ipairs(badNames) do
            if rawget(_G, n) ~= nil then return false end
        end
        return true
    end
    local function chkHooks()
        local safe = true
        pcall(function()
            local mt = getrawmetatable(game)
            if mt and rawget(mt, "__index") then
                local idx = mt.__index
                if type(idx) == "function" then
                    local info = debug.info(idx, "n")
                    if info and (info:lower():find("hook") or info:lower():find("spy")) then safe = false end
                end
            end
        end)
        return safe
    end
    if not safeChk() or not chkHooks() then
        secActive = false
        game:GetService("Players").LocalPlayer:Kick("Security violation")
        return
    end
    spawn(function()
        wait(0.5)
        if setclipboard then
            pcall(function()
                setclipboard("starlight.cc | " .. os.date("%Y-%m-%d %H:%M:%S"))
            end)
        end
    end)
--
-- END ORIGINAL SOURCE LINES 1-47
