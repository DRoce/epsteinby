--[[
Inert commented archive file.
No executable Lua is present below; every preserved source line is prefixed with --.
Role: About tab UI and Discord button block
Original source line ranges: 2915-2984
]]


-- BEGIN ORIGINAL SOURCE LINES 2915-2984
Лebaя чactь bkлaдkи About: Coders
local AboutLeftGroup = Tabs.About:AddLeftGroupbox("Coders")
AboutLeftGroup:AddLabel("cw.yw")
AboutLeftGroup:AddLabel("7wk5")
AboutLeftGroup:AddDivider()
AboutLeftGroup:AddLabel("starlight.cc Script")
AboutLeftGroup:AddLabel("Version: 1.2.0")
AboutLeftGroup:AddLabel("Updated: 26.02.2026")
--
local AboutLeftGroup = Tabs.About:AddLeftGroupbox("ChangeLogs")
AboutLeftGroup:AddLabel("Added:Aimbot System ")
AboutLeftGroup:AddLabel("Added:Map Lighting")
AboutLeftGroup:AddLabel("Updated:ESP")
AboutLeftGroup:AddLabel("Infinite stamina")
AboutLeftGroup:AddLabel("Free cam and blur")
AboutLeftGroup:AddLabel("Added Sticky Aim")
--
Пpabaя чactь bkлaдkи About: Discord
local AboutRightGroup = Tabs.About:AddRightGroupbox("Discord")
AboutRightGroup:AddButton({
    Text = "Discord",
    Func = function()
        local discordLink = "https://discord.gg/qUHPc66JXJ"
        if setclipboard then
            setclipboard(discordLink)
            Lib:Notify("Discord link copied to clipboard!", 3)
        end
        -- Otkpыbaem ccылky b бpayзepe
        pcall(function()
            local HttpService = game:GetService("HttpService")
            local success, result = pcall(function()
                HttpService:RequestAsync({
                    Url = "http://localhost:6463/rpc?v=1",
                    Method = "POST",
                    Headers = {
                        ["Content-Type"] = "application/json",
                        ["Origin"] = "https://discord.com"
                    },
                    Body = HttpService:JSONEncode({
                        cmd = "INVITE_BROWSER",
                        args = {
                            code = "qUHPc66JXJ"
                        },
                        nonce = HttpService:GenerateGUID(false)
                    })
                })
            end)
--
            if not success then
                -- Ecли Discord he yctahobлeh или he зaпyщeh, otkpыbaem b beб-бpayзepe
                game:GetService("StarterGui"):SetCore("OpenBrowserWindow", {
                    Url = discordLink
                })
            end
        end)
    end,
    DoubleClick = false
})
AboutRightGroup:AddLabel("Join our Discord server")
AboutRightGroup:AddLabel("Click to get a link")
AboutRightGroup:AddLabel("for updates and support")
AboutRightGroup:AddDivider()
AboutRightGroup:AddLabel("Features:")
AboutRightGroup:AddLabel("- ESP System")
AboutRightGroup:AddLabel("- Silent Aim & Aimbot")
AboutRightGroup:AddLabel("- Safe ESP & Auto Farm")
AboutRightGroup:AddLabel("- Player Chams & China Hat")
AboutRightGroup:AddLabel("- Skin Changer")
AboutRightGroup:AddLabel("- And much more...")
--
-- END ORIGINAL SOURCE LINES 2915-2984
