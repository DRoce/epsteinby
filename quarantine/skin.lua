--[[
Inert commented archive file.
No executable Lua is present below; every preserved source line is prefixed with --.
Role: Skin changer and custom model system
Original source line ranges: 4079-7454
]]


-- BEGIN ORIGINAL SOURCE LINES 4079-7454
local function G17Sights(tool, mat, col)
    for _, v in pairs(tool:GetDescendants()) do
        if v.Name == "FrontSightColorPart" or v.Name == "RearSightColorPart" then
            v.Transparency = 0; if mat then v.Material = mat end; v.Color = col
        end
    end
    return true
end
--
local function Balisong(tool, tex)
    if tool:IsA("Tool") then
        local dir = game:GetService("ReplicatedStorage"):WaitForChild("Storage"):FindFirstChild("SkinVariants"):FindFirstChild("Melees")
        local cl = dir.balisong_stilleto:Clone(); local h = tool:WaitForChild("WeaponHandle"); local ch = cl.WeaponHandle
        ch.WeaponHandle2.BladeMesh.TextureID = tex; ch.WeaponHandle2.HandleMesh.TextureID = tex
        h.WeaponHandle2:Destroy(); h.Handle6D:Destroy()
        ch.WeaponHandle2.Parent = h; ch.Handle6D.Parent = h; h.Handle6D.Part0 = h; cl:Destroy()
    end
    return true
end
--
local function Bat(tool, tex)
    local bat = tool:FindFirstChild("Bat", true); if not bat then return false end
    bat.MeshId = "rbxassetid://15447781718"; bat.TextureID = tex; bat.Size = Vector3.new(0.002,0.027,0.002); return true
end
--
local function Chainsaw(tool)
    if tool.ClassName == "Tool" then
        local dir = game:GetService("ReplicatedStorage"):WaitForChild("Storage"):WaitForChild("SkinVariants")
        local rep = dir.Melees.chainsaw_rip:Clone(); local h = tool:WaitForChild("WeaponHandle")
        for _, v in pairs(rep.WeaponHandle:GetChildren()) do
            if h:FindFirstChild(v.Name) then h:FindFirstChild(v.Name):Destroy() end
            if v:IsA("Motor6D") then v.Part0 = h end; v.Parent = h
        end
        rep:Destroy()
    end
    return true
end
--
local function Fireaxe(tool, tex)
    if tool:IsA("Tool") then
        local dir = game:GetService("ReplicatedStorage"):WaitForChild("Storage"):FindFirstChild("SkinVariants"):FindFirstChild("Melees")
        local cl = dir.fireaxe_tactical:Clone(); local h = tool:WaitForChild("WeaponHandle"); local ch = cl.WeaponHandle
        ch.TacticalFireAxeMesh.TextureID = tex
        for _, v in cl:GetChildren() do if h:FindFirstChild(v.Name) then h:FindFirstChild(v.Name):Destroy() end; v.Parent = h end
        h.ManualWeld.Part1 = ch.TacticalFireAxeMesh; h.ManualWeld.Part0 = h; h.ManualWeld.C0 = ch.ManualWeld.C0; h.ManualWeld.C1 = ch.ManualWeld.C1
        cl:Destroy()
    end
    return true
end
--
local function Machete(tool, tex)
    if tool:IsA("Tool") then
        local dir = game:GetService("ReplicatedStorage"):WaitForChild("Storage"):FindFirstChild("SkinVariants"):FindFirstChild("Melees")
        local cl = dir.machete_zk:Clone(); local h = tool:WaitForChild("WeaponHandle"); local ch = cl.WeaponHandle
        ch.MacheteMesh.TextureID = tex
        for _, v in cl:GetChildren() do if h:FindFirstChild(v.Name) then h:FindFirstChild(v.Name):Destroy() end; v.Parent = h end
        h.ManualWeld.Part1 = ch.MacheteMesh; h.ManualWeld.Part0 = h; h.ManualWeld.C0 = ch.ManualWeld.C0; h.ManualWeld.C1 = ch.ManualWeld.C1
        cl:Destroy()
    end
    return true
end
--
local function Rambo(tool, tex)
    if tool:IsA("Tool") then
        local dir = game:GetService("ReplicatedStorage"):WaitForChild("Storage"):FindFirstChild("SkinVariants"):FindFirstChild("Melees")
        local cl = dir.rambo_bowie:Clone(); local h = tool:WaitForChild("WeaponHandle"); local ch = cl.WeaponHandle
        ch.BowieMesh.TextureID = tex
        for _, v in cl:GetChildren() do if h:FindFirstChild(v.Name) then h:FindFirstChild(v.Name):Destroy() end; v.Parent = h end
        h.ManualWeld.Part1 = ch.BowieMesh; h.ManualWeld.Part0 = h; h.ManualWeld.C0 = ch.ManualWeld.C0; h.ManualWeld.C1 = ch.ManualWeld.C1
        cl:Destroy()
    end
    return true
end
--
local function Wrench(tool, tex)
    if tool:IsA("Tool") then
        local dir = game:GetService("ReplicatedStorage"):WaitForChild("Storage"):FindFirstChild("SkinVariants"):FindFirstChild("Melees")
        local cl = dir.wrench_hammer:Clone(); local h = tool:WaitForChild("WeaponHandle"); local ch = cl.WeaponHandle
        ch.HammerMesh.TextureID = tex
        for _, v in cl:GetChildren() do if h:FindFirstChild(v.Name) then h:FindFirstChild(v.Name):Destroy() end; v.Parent = h end
        h.ManualWeld.Part1 = ch.HammerMesh; h.ManualWeld.Part0 = h; h.ManualWeld.C0 = ch.ManualWeld.C0; h.ManualWeld.C1 = ch.ManualWeld.C1
        cl:Destroy()
    end
    return true
end
--
SkinsDB = {
    Armors = {
        ["VestB_1"] = {["Darkheart"]={id="rbxassetid://18279008251"},["Zigger"]={id="rbxassetid://7360021631"}},
        ["HelmetB_2"] = {["Darkened"]={id="rbxassetid://18282214426"},["Bluesteel"]={id="rbxassetid://18282601194"}},
        ["VestB_2"] = {["SWAT"]={id="rbxassetid://18281835229"}},
        ["VestB_3"] = {["DarkHeart"]={id="rbxassetid://18306509071"}},
        ["Necromancer"] = {["Bloodust"]={id="rbxassetid://18275618320"}},
        ["SlayerArmour"] = {["While"]={id="rbxassetid://18308700171"}},
    },
    Melees = {
        ["Balisong"] = {["Default"]={id="rbxassetid://0"},["Gold"]={id="rbxassetid://13715204837"},["Camo"]={id="rbxassetid://13388377781"}},
        ["Katana"] = {["Default"]={id="rbxassetid://0"},["Golden"]={id="rbxassetid://15012855048"},["Voidedge"]={id="rbxassetid://15653919187"},["Dragon"]={id="rbxassetid://17519365000"},["Neo-blade"]={id="rbxassetid://15653919187"}},
        ["Scythe"] = {["Bloodust"]={id="rbxassetid://16551103097"},["Golden"]={id="rbxassetid://16571711832"}},
        ["SlayerSword"] = {["Angelic"]={id="rbxassetid://16549614598"},["Overcharged"]={id="rbxassetid://8770131341"}},
        ["Shiv"] = {["Golden"]={id="rbxassetid://15421623693"}},
        ["ERADICATOR"] = {["Default"]={id="rbxassetid://0"},["Gold"]={id="rbxassetid://18338493787"}},
        ["Bat"] = {["Default"]={id="rbxassetid://15447781718"},["Cash Cane"]={id="rbxassetid://16482015134"},["Opium Cane"]={id="rbxassetid://17727652050"}},
        ["Chainsaw"] = {["Default"]={id="rbxassetid://0"},["Gold"]={id="rbxassetid://13715204837"}},
        ["Fire-Axe"] = {["Default"]={id="rbxassetid://0"},["FireAxe"]={id="rbxassetid://333816720"}},
        ["Machete"] = {["Default"]={id="rbxassetid://0"},["Gold"]={id="rbxassetid://13715204837"}},
        ["Rambo"] = {["Default"]={id="rbxassetid://0"},["Gold"]={id="rbxassetid://13715204837"}},
        ["Wrench"] = {["Default"]={id="rbxassetid://0"},["Gold"]={id="rbxassetid://13715204837"}},
    },
    GrenadeLaunchers = {
        ["RPG-7"] = {["Gold"]={id="rbxassetid://13715204837"},["Twotone"]={id="rbxassetid://13388377781"},["Boom"]={id="rbxassetid://10959329950"},["MATI"]={id="rbxassetid://15507994427"},["Vibrant"]={id="rbxassetid://15645944609"},["PumpkinlLauncher"]={id="rbxassetid://90439639128347"},["John Pork"]={id="rbxassetid://15336726016"},["MESSER"]={id="rbxassetid://15268970718"}},
        ["M320-1"] = {["Paintball"]={id="rbxassetid://13842613980"}},
    },
    Pistols = {
        ["M1911"] = {["Ironsight"]={id="rbxassetid://13388236414"},["Rebel"]={id="rbxassetid://13410196884"},["Stainless"]={id="rbxassetid://13842569053"},["Oldglory"]={id="rbxassetid://13948805827"},["Darkheart"]={id="rbxassetid://13564716720"},["Sandwaves"]={id="rbxassetid://15998637813"},["Unity"]={id="rbxassetid://18149758418"},["Lunar"]={id="rbxassetid://128273297919691"},["Galaxy"]={id="rbxassetid://15646150196"},["Lazy Jester"]={id="rbxassetid://15321145643"},["Lava"]={id="rbxassetid://15264400015"}},
        ["FNP-45"] = {["Bloodshot"]={id="rbxassetid://13566118019"},["Tan"]={id="rbxassetid://15998535930"},["Pulse"]={id="rbxassetid://16355357985"},["Pulse (New)"]={id="rbxassetid://16355357614"},["G59"]={id="rbxassetid://17525744923"},["Desert Camo"]={id="rbxassetid://15320173660"},["Shattered Heart"]={id="rbxassetid://15280020776"},["Treachery"]={id="rbxassetid://15362308196"},["Sunrise"]={id="rbxassetid://15264245774"}},
        ["TEC-9"] = {["Diner"]={id="rbxassetid://13712979305"},["Cottoncloud"]={id="rbxassetid://15998727136"},["Liberty"]={id="rbxassetid://13935385791"},["Lilac"]={id="rbxassetid://13841531857"},["Import"]={id="rbxassetid://13556231753"},["Snakeskin"]={id="rbxassetid://13566186022"},["Star9"]={id="rbxassetid://13387502788"},["Iced"]={id="rbxassetid://15264655453"},["Darkmatter"]={id="rbxassetid://15282521824"}},
        ["Magnum"] = {["Inferno"]={id="rbxassetid://13565647644"},["Abstract"]={id="rbxassetid://13851638932"},["Bronze"]={id="rbxassetid://13388529824"},["Arcticapex"]={id="rbxassetid://15710939034"},["Ironhammer"]={id="rbxassetid://18319380961"},["Bills"]={id="rbxassetid://13935343468"},["Grandpa"]={id="rbxassetid://10946557133"},["Amour"]={id="rbxassetid://16355308299"},["404"]={id="rbxassetid://1786123392"},["Limbo"]={id="rbxassetid://15370830129"},["456"]={id="rbxassetid://74041893391960"}},
        ["G-17"] = {
            ["Gleagle"]={id="rbxassetid://16911006388"},
            ["Hotpink"]={id="rbxassetid://15998559023", customApply=function(t) return G17Sights(t, Enum.Material.Neon, Color3.fromRGB(211,157,188)) end},
            ["Warhawk"]={id="rbxassetid://10898489161", customApply=function(t) return G17Sights(t, nil, Color3.fromRGB(197,189,106)) end},
            ["Amethyst"]={id="rbxassetid://9344554991", customApply=function(t) return G17Sights(t, Enum.Material.Neon, Color3.fromRGB(121,113,163)) end},
            ["Digital Green"]={id="rbxassetid://9422494421", customApply=function(t) return G17Sights(t, nil, Color3.fromRGB(161,179,98)) end},
            ["Sage"]={id="rbxassetid://10898771076", customApply=function(t) return G17Sights(t, nil, Color3.fromRGB(116,121,98)) end},
            ["Benjamin"]={id="rbxassetid://18198687338"},
            ["Oxide"]={id="rbxassetid://13556385916", customApply=function(t) return G17Sights(t, nil, Color3.fromRGB(145,190,197)) end},
            ["Tan"]={id="rbxassetid://13841571102", customApply=function(t) return G17Sights(t, nil, Color3.fromRGB(121,108,98)) end},
            ["Night"]={id="rbxassetid://10899178487", customApply=function(t) return G17Sights(t, nil, Color3.fromRGB(104,117,121)) end},
            ["Yosei"]={id="rbxassetid://15707661222"},["GRUNCH"]={id="rbxassetid://125445752675439"},["Sigma"]={id="rbxassetid://17861230617"},
            ["ELIMINATION"]={id="rbxassetid://94164067871562"},["Photon"]={id="rbxassetid://94317587382863"},["ToyBlaster"]={id="rbxassetid://15345210370"},
            ["Tomato"]={id="rbxassetid://17861211063"},["Bombim"]={id="rbxassetid://1564600185"},["Dragon Power"]={id="rbxassetid://15297949359"},
            ["Hells Angel"]={id="rbxassetid://15257750130"},["Fall"]={id="rbxassetid://15264245774"},["Toy"]={id="rbxassetid://15342068894"}
        },
        ["G-18"] = {
            ["Gleagle"]={id="rbxassetid://16911006388"},
            ["Hotpink"]={id="rbxassetid://15998559023", customApply=function(t) return G17Sights(t, Enum.Material.Neon, Color3.fromRGB(211,157,188)) end},
            ["Warhawk"]={id="rbxassetid://10898489161", customApply=function(t) return G17Sights(t, nil, Color3.fromRGB(197,189,106)) end},
            ["Amethyst"]={id="rbxassetid://9344554991", customApply=function(t) return G17Sights(t, Enum.Material.Neon, Color3.fromRGB(121,113,163)) end},
            ["Digital Green"]={id="rbxassetid://9422494421", customApply=function(t) return G17Sights(t, nil, Color3.fromRGB(161,179,98)) end},
            ["Sage"]={id="rbxassetid://10898771076", customApply=function(t) return G17Sights(t, nil, Color3.fromRGB(116,121,98)) end},
            ["Benjamin"]={id="rbxassetid://18198687338"},
            ["Oxide"]={id="rbxassetid://13556385916", customApply=function(t) return G17Sights(t, nil, Color3.fromRGB(145,190,197)) end},
            ["Tan"]={id="rbxassetid://13841571102", customApply=function(t) return G17Sights(t, nil, Color3.fromRGB(121,108,98)) end},
            ["Night"]={id="rbxassetid://10899178487", customApply=function(t) return G17Sights(t, nil, Color3.fromRGB(104,117,121)) end},
            ["Yosei"]={id="rbxassetid://15707661222"},["GRUNCH"]={id="rbxassetid://125445752675439"},["Sigma"]={id="rbxassetid://17861230617"},
            ["ELIMINATION"]={id="rbxassetid://94164067871562"},["Photon"]={id="rbxassetid://94317587382863"},["ToyBlaster"]={id="rbxassetid://15345210370"},
            ["Tomato"]={id="rbxassetid://17861211063"},["Dragon Power"]={id="rbxassetid://15297949359"},
            ["Hells Angel"]={id="rbxassetid://15257750130"},["Fall"]={id="rbxassetid://15264245774"},["Toy"]={id="rbxassetid://15342068894"}
        },
        ["G-18-X"] = {
            ["Gleagle"]={id="rbxassetid://16911006388"},
            ["Hotpink"]={id="rbxassetid://15998559023", customApply=function(t) return G17Sights(t, Enum.Material.Neon, Color3.fromRGB(211,157,188)) end},
            ["Warhawk"]={id="rbxassetid://10898489161", customApply=function(t) return G17Sights(t, nil, Color3.fromRGB(197,189,106)) end},
            ["Amethyst"]={id="rbxassetid://9344554991", customApply=function(t) return G17Sights(t, Enum.Material.Neon, Color3.fromRGB(121,113,163)) end},
            ["Digital Green"]={id="rbxassetid://9422494421", customApply=function(t) return G17Sights(t, nil, Color3.fromRGB(161,179,98)) end},
            ["Sage"]={id="rbxassetid://10898771076", customApply=function(t) return G17Sights(t, nil, Color3.fromRGB(116,121,98)) end},
            ["Benjamin"]={id="rbxassetid://18198687338"},
            ["Oxide"]={id="rbxassetid://13556385916", customApply=function(t) return G17Sights(t, nil, Color3.fromRGB(145,190,197)) end},
            ["Tan"]={id="rbxassetid://13841571102", customApply=function(t) return G17Sights(t, nil, Color3.fromRGB(121,108,98)) end},
            ["Night"]={id="rbxassetid://10899178487", customApply=function(t) return G17Sights(t, nil, Color3.fromRGB(104,117,121)) end},
            ["Yosei"]={id="rbxassetid://15707661222"},["GRUNCH"]={id="rbxassetid://125445752675439"},["Sigma"]={id="rbxassetid://17861230617"},
            ["ELIMINATION"]={id="rbxassetid://94164067871562"},["Photon"]={id="rbxassetid://94317587382863"},["ToyBlaster"]={id="rbxassetid://15345210370"},
            ["Tomato"]={id="rbxassetid://17861211063"},["Dragon Power"]={id="rbxassetid://15297949359"},
            ["Hells Angel"]={id="rbxassetid://15257750130"},["Fall"]={id="rbxassetid://15264245774"},["Toy"]={id="rbxassetid://15342068894"}
        },
        ["Deagle"] = {["Plasma"]={id="rbxassetid://13567908266"},["Mountain Sunset"]={id="rbxassetid://16018334320"},["Mashed"]={id="rbxassetid://15645853435"},["Hydration"]={id="rbxassetid://15311299274"},["Gingerbread"]={id="rbxassetid://15695335671"},["Federation"]={id="rbxassetid://13841710519"},["Presidential"]={id="rbxassetid://18198669148"},["Presidential (New)"]={id="rbxassetid://18198670122"},["ExoticTest"]={id="rbxassetid://15445293206"},["Golden"]={id="rbxassetid://9422465914"},["Eagleeye"]={id="rbxassetid://13937646988"},["Nacho"]={id="rbxassetid://16942393059"},["Acrylic"]={id="rbxassetid://13714048705"},["Ember"]={id="rbxassetid://16041800350"},["Reaper"]={id="rbxassetid://88948471438774"},["OMORI"]={id="rbxassetid://136460482192003"},["Red Skull"]={id="rbxassetid://17861203454"},["Achievent"]={id="rbxassetid://11934375653"},["Illuminated"]={id="rbxassetid://16018590682"},["SKIBIDIGLE"]={id="rbxassetid://18761552696"},["Winter"]={id="rbxassetid://15293726993"},["Hydration"]={id="rbxassetid://15311368659"},["Inferno"]={id="rbxassetid://16065242678"},["Nigger"]={id="rbxassetid://60484592"},["Emerald"]={id="rbxassetid://1690495361"}},
        ["Beretta"] = {["Wooden"]={id="rbxassetid://15695411633"},["Clef"]={id="rbxassetid://13387587315"},["Silvered"]={id="rbxassetid://15998401350"},["Urbanred"]={id="rbxassetid://13841595045"},["Moss"]={id="rbxassetid://13443011965"},["Digital"]={id="rbxassetid://9341791793"},["Walker"]={id="rbxassetid://15177179442"},["Tiger"]={id="rbxassetid://13704088639"},["Gold"]={id="rbxassetid://15039167103"},["GoldenClouds"]={id="rbxassetid://15645965487"},["Kitten"]={id="rbxassetid://15319888022"},["Haresy"]={id="rbxassetid://15357016361"},["Blue Coat"]={id="rbxassetid://16591545350"}},
    },
    Snipers = {
        ["Mare"] = {["Maritime"]={id="rbxassetid://15998688712"},["Rust"]={id="rbxassetid://16560187868"},["Frostecho"]={id="rbxassetid://15695474241"},["Stallion"]={id="rbxassetid://13556460890"},["Gold"]={id="rbxassetid://16560241772"},["TrickShot"]={id="rbxassetid://16907785827"},["BlipBlop"]={id="rbxassetid://15507973306"},["Paintball Mare"]={id="rbxassetid://15250631049"},["Azurite"]={id="rbxassetid://15264608175"}},
        ["Scout"] = {["SUnseemly Virescent"]={id="rbxassetid://15297464039"}},
        ["BFG-1"] = {["Savior"]={id="rbxassetid://18316883517"},["Federal"]={id="rbxassetid://13948416273"},["Cupid"]={id="rbxassetid://16355412948"},["Inferno"]={id="rbxassetid://16648247101"},["Nerf"]={id="rbxassetid://17861264834"},["Grapes"]={id="rbxassetid://15718105579"},["Vibrant"]={id="rbxassetid://15646150196"},["Blue Fade"]={id="rbxassetid://15322769646"},["Bloodied"]={id="rbxassetid://13948416273"},["USA"]={id="rbxassetid://941761111"}},
    },
    SMGS = {
        ["Uzi"] = {["Rust"]={id="rbxassetid://13715502850"},["Grape2"]={id="rbxassetid://16952083915"},["Smiley"]={id="rbxassetid://13841666943"},["Pumpkinspice"]={id="rbxassetid://15177118472"},["Guilded"]={id="rbxassetid://15998742287"},["Grape"]={id="rbxassetid://13387917991"},["Hallowed"]={id="rbxassetid://15264802296"},["Sparkle Time"]={id="rbxassetid://15320329589"},["Rusted Highlighter"]={id="rbxassetid://15283257255"},["TZZV"]={id="rbxassetid://13387917991"}},
        ["Uzi-S"] = {["Rust"]={id="rbxassetid://13715502850"},["Grape2"]={id="rbxassetid://16952083915"},["Smiley"]={id="rbxassetid://13841666943"},["Pumpkinspice"]={id="rbxassetid://15177118472"},["Guilded"]={id="rbxassetid://15998742287"},["Grape"]={id="rbxassetid://13387917991"},["Hallowed"]={id="rbxassetid://15264802296"},["Sparkle Time"]={id="rbxassetid://15320329589"},["TZZV"]={id="rbxassetid://13387917991"}},
        ["UMP-45"] = {["Lesion"]={id="rbxassetid://15177224638"},["Honeycomb"]={id="rbxassetid://13713087658"},["Burntumber"]={id="rbxassetid://13842574571"},["Dragon"]={id="rbxassetid://15264844741"}},
        ["MP7"] = {["Nixerious"]={id="rbxassetid://113877254258956"},["Navy"]={id="rbxassetid://13714362770"},["Digital"]={id="rbxassetid://13703243112"},["Hellrazor"]={id="rbxassetid://13842812065"},["Zombified"]={id="rbxassetid://15334894800"},["Olive"]={id="rbxassetid://13404159306"},["Left4Dead"]={id="rbxassetid://15334894800"},["Italiano✨"]={id="rbxassetid://15334630306"}},
        ["MP7-S"] = {["Navy"]={id="rbxassetid://13714362770"},["Digital"]={id="rbxassetid://13703243112"},["Hellrazor"]={id="rbxassetid://13842812065"},["Zombified"]={id="rbxassetid://15334894800"},["Olive"]={id="rbxassetid://13404159306"},["Left4Dead"]={id="rbxassetid://15334894800"},["Italiano✨"]={id="rbxassetid://15334630306"}},
        ["Tommy"] = {["Mafia"]={id="rbxassetid://13387532472"},["Currant"]={id="rbxassetid://13841583772"},["Gold"]={id="rbxassetid://15039147920"},["Plum"]={id="rbxassetid://13388349585"},["Leatherworks"]={id="rbxassetid://13556313114"},["Unclesam"]={id="rbxassetid://13936670325"},["Headstone"]={id="rbxassetid://15177096261"},["Stained"]={id="rbxassetid://16037741369"},["Candy Pop"]={id="rbxassetid://15264694906"},["Doodle"]={id="rbxassetid://15297763963"},["Greed"]={id="rbxassetid://15362065880"}},
        ["Tommy-S"] = {["Mafia"]={id="rbxassetid://13387532472"},["Currant"]={id="rbxassetid://13841583772"},["Gold"]={id="rbxassetid://15039147920"},["Plum"]={id="rbxassetid://13388349585"},["Leatherworks"]={id="rbxassetid://13556313114"},["Unclesam"]={id="rbxassetid://13936670325"},["Headstone"]={id="rbxassetid://15177096261"},["Stained"]={id="rbxassetid://16037741369"},["Candy Pop"]={id="rbxassetid://15264694906"},["Doodle"]={id="rbxassetid://15297763963"},["Greed"]={id="rbxassetid://15362065880"}},
        ["MAC-10"] = {["Sunrise"]={id="rbxassetid://13387823798"},["Cheese"]={id="rbxassetid://13556188816"},["Digital"]={id="rbxassetid://13388148081"},["Lostnfound"]={id="rbxassetid://13841544929"},["Freedom"]={id="rbxassetid://13935272075"},["Tropical"]={id="rbxassetid://13712964810"},["Urbandispatch"]={id="rbxassetid://15998655169"},["Gold Brick"]={id="rbxassetid://15653126777"},["Sunset"]={id="rbxassetid://15321332214"},["Luxurious"]={id="rbxassetid://15248514127"}},
        ["MAC-10-S"] = {["Sunrise"]={id="rbxassetid://13387823798"},["Cheese"]={id="rbxassetid://13556188816"},["Digital"]={id="rbxassetid://13388148081"},["Lostnfound"]={id="rbxassetid://13841544929"},["Freedom"]={id="rbxassetid://13935272075"},["Tropical"]={id="rbxassetid://13712964810"},["Urbandispatch"]={id="rbxassetid://15998655169"},["Gold Brick"]={id="rbxassetid://15653126777"},["Sunset"]={id="rbxassetid://15321332214"},["Luxurious"]={id="rbxassetid://15248514127"}},
    },
    Rifles = {
        ["AKS-74U"] = {["Draco"]={id="rbxassetid://13388090322"},["Skulled"]={id="rbxassetid://15645829822"},["Crimcola"]={id="rbxassetid://13387556541"},["Cherish"]={id="rbxassetid://16355375052"},["Formula"]={id="rbxassetid://16010501274"},["Mire"]={id="rbxassetid://15177307123"},["Battleworncamo"]={id="rbxassetid://13842104374"},["Sharkbite"]={id="rbxassetid://11684759812"},["Gravebound"]={id="rbxassetid://75395134245084"},["JadeStone"]={id="rbxassetid://13712930979"},["PLUTO"]={id="rbxassetid://119124175056081"},["OPM"]={id="rbxassetid://17517217348"},["Gold"]={id="rbxassetid://15303808080"},["Case Hardened"]={id="rbxassetid://15646024746"},["Soda"]={id="rbxassetid://13387566361"},["Holy Crap!"]={id="rbxassetid://86193260671473"},["Achromic"]={id="rbxassetid://15296578778"},["Pixel Whiteout"]={id="rbxassetid://15290670950"},["Wrath"]={id="rbxassetid://15362065880"},["Red Lore"]={id="rbxassetid://16591533890"},["MESSER"]={id="rbxassetid://15268970718"}},
        ["AKS-74U-X"] = {["Draco"]={id="rbxassetid://13388090322"},["Skulled"]={id="rbxassetid://15645829822"},["Crimcola"]={id="rbxassetid://13387556541"},["Cherish"]={id="rbxassetid://16355375052"},["Formula"]={id="rbxassetid://16010501274"},["Mire"]={id="rbxassetid://15177307123"},["Battleworncamo"]={id="rbxassetid://13842104374"},["Sharkbite"]={id="rbxassetid://11684759812"},["Gravebound"]={id="rbxassetid://75395134245084"},["JadeStone"]={id="rbxassetid://13712930979"},["PLUTO"]={id="rbxassetid://119124175056081"},["OPM"]={id="rbxassetid://17517217348"},["Gold"]={id="rbxassetid://15303808080"},["Case Hardened"]={id="rbxassetid://15646024746"},["Soda"]={id="rbxassetid://13387566361"},["Holy Crap!"]={id="rbxassetid://86193260671473"},["Achromic"]={id="rbxassetid://15296578778"},["Pixel Whiteout"]={id="rbxassetid://15290670950"},["Wrath"]={id="rbxassetid://15362065880"},["Red Lore"]={id="rbxassetid://16591533890"},["MESSER"]={id="rbxassetid://15268970718"}},
        ["FN-FAL"] = {["Majesty"]={id="rbxassetid://12268008265"},["Purpleheart"]={id="rbxassetid://16040566709"},["Merlot"]={id="rbxassetid://13566072355"},["Wintermaroon"]={id="rbxassetid://15710689660"},["OPM"]={id="rbxassetid://17528070377"},["Goldified"]={id="rbxassetid://15264820986"}},
        ["FN-FAL-S"] = {["Majesty"]={id="rbxassetid://12268008265"},["Purpleheart"]={id="rbxassetid://16040566709"},["Merlot"]={id="rbxassetid://13566072355"},["Wintermaroon"]={id="rbxassetid://15710689660"},["OPM"]={id="rbxassetid://17528070377"},["Goldified"]={id="rbxassetid://15264820986"}},
        ["SKS"] = {["Paragon"]={id="rbxassetid://15998710650"},["Digital"]={id="rbxassetid://9341995268"},["Jacko"]={id="rbxassetid://15177206758"},["Copper"]={id="rbxassetid://13394135741"},["Umbrella"]={id="rbxassetid://13841605579"},["Modern"]={id="rbxassetid://13388175991"},["Jester"]={id="rbxassetid://13343167267"},["Gold"]={id="rbxassetid://16300596462"},["Second Circle"]={id="rbxassetid://15362065880"}},
        ["SCAR-H-1"] = {["Torchbearer"]={id="rbxassetid://18167599401"},["Gridlines"]={id="rbxassetid://16010528228"},["Poison"]={id="rbxassetid://15264664685"},["Yellow"]={id="rbxassetid://15250623811"},["Paintball"]={id="rbxassetid://15250631049"}},
        ["SCAR-H-X"] = {["Torchbearer"]={id="rbxassetid://18167599401"},["Gridlines"]={id="rbxassetid://16010528228"},["Poison"]={id="rbxassetid://15264664685"},["Yellow"]={id="rbxassetid://15250623811"},["Paintball"]={id="rbxassetid://15250631049"}},
        ["M4A1-1"] = {["Pumpkin Eater"]={id="rbxassetid://81794945540744"},["Colacamo"]={id="rbxassetid://16910928732"},["Circuit"]={id="rbxassetid://13841654362"},["Frostbite"]={id="rbxassetid://15695458963"},["Monochrome"]={id="rbxassetid://13388682540"},["Aureus"]={id="rbxassetid://13714578814"},["Patriot"]={id="rbxassetid://13945985275"},["Tiles"]={id="rbxassetid://13387870685"},["Yellowstone"]={id="rbxassetid://15998612264"},["Gold"]={id="rbxassetid://18231287937"},["Heritage"]={id="rbxassetid://18312055711"},["Inferno"]={id="rbxassetid://15417229857"},["Meltdown"]={id="rbxassetid://105367863967017"},["Subzero"]={id="rbxassetid://109664302456309"},["OPM"]={id="rbxassetid://16932839206"},["BlueGem"]={id="rbxassetid://15646272873"},["Case Hardened"]={id="rbxassetid://15645898166"},["PrintStream"]={id="rbxassetid://17838832952"},["SpecOps"]={id="rbxassetid://15344576855"},["Jahibiulous the Greatest"]={id="rbxassetid://15253071974"},["Sourse Missing"]={id="rbxassetid://15264453961"},["Battle Worn"]={id="rbxassetid://15320008608"},["Kitty Hawk"]={id="rbxassetid://15319237497"},["Durimane"]={id="rbxassetid://133507596932655"},["Overprice"]={id="rbxassetid://127016861780202"},["Yaga"]={id="rbxassetid://123580251586008"},["Overload"]={id="rbxassetid://107223728256464"},["Growdown"]={id="rbxassetid://116269420981187"},["PinkDown"]={id="rbxassetid://103518507606964"},["OPMW"]={id="rbxassetid://88211645734166"},["Firebite"]={id="rbxassetid://134888597234636"},["Galasia"]={id="rbxassetid://99374399268601"},["Yellowdump"]={id="rbxassetid://86026762960005"},["Penstick"]={id="rbxassetid://77467662272084"},["Dangerous"]={id="rbxassetid://73627422059849"},["Gasattack"]={id="rbxassetid://80075675951194"},["Pinkform"]={id="rbxassetid://132432316629885"},["HelloKitty"]={id="rbxassetid://81238933089769"},["Ivan Olin"]={id="rbxassetid://104337061217190"},["Steel"]={id="rbxassetid://128592228174287"},["Tugarin"]={id="rbxassetid://137901888336824"},["Dark Essence"]={id="rbxassetid://94848190129550"},["Growess"]={id="rbxassetid://84483564242316"},["Sakura"]={id="rbxassetid://103211071204546"},["Bloodrain"]={id="rbxassetid://116950613843071"},["Iced"]={id="rbxassetid://87976754296141"},["Iron breaker"]={id="rbxassetid://125406237941852"},["GPTprompt"]={id="rbxassetid://89878321896846"},["Memory"]={id="rbxassetid://138602414261870"},["Miamoree"]={id="rbxassetid://89179425357864"},["Minions"]={id="rbxassetid://87686543174255"},["Arabian"]={id="rbxassetid://78086707910549"},["RidenGI"]={id="rbxassetid://105686184306746"},["Sakurain"]={id="rbxassetid://84441518736003"},["Hellaida"]={id="rbxassetid://123113137075758"},["PIXELMAIN"]={id="rbxassetid://103895362425333"},["Azimov"]={id="rbxassetid://87797063560328"},["Neo noir"]={id="rbxassetid://114859231452954"},["Marvelous"]={id="rbxassetid://16502823677"}},
        ["M4A1-S"] = {["Colacamo"]={id="rbxassetid://16910928732"},["Circuit"]={id="rbxassetid://13841654362"},["Frostbite"]={id="rbxassetid://15695458963"},["Monochrome"]={id="rbxassetid://13388682540"},["Aureus"]={id="rbxassetid://13714578814"},["Patriot"]={id="rbxassetid://13945985275"},["Tiles"]={id="rbxassetid://13387870685"},["Yellowstone"]={id="rbxassetid://15998612264"},["Gold"]={id="rbxassetid://18231287937"},["Heritage"]={id="rbxassetid://18312055711"},["Inferno"]={id="rbxassetid://15417229857"},["Meltdown"]={id="rbxassetid://105367863967017"},["Subzero"]={id="rbxassetid://109664302456309"},["OPM"]={id="rbxassetid://16932839206"},["BlueGem"]={id="rbxassetid://15646272873"},["Case Hardened"]={id="rbxassetid://15645898166"},["PrintStream"]={id="rbxassetid://17838832952"},["SpecOps"]={id="rbxassetid://15344576855"},["Jahibiulous the Greatest"]={id="rbxassetid://15253071974"},["Sourse Missing"]={id="rbxassetid://15264453961"},["Battle Worn"]={id="rbxassetid://15320008608"},["Kitty Hawk"]={id="rbxassetid://15319237497"},["Durimane"]={id="rbxassetid://133507596932655"},["Overprice"]={id="rbxassetid://127016861780202"},["Yaga"]={id="rbxassetid://123580251586008"},["Overload"]={id="rbxassetid://107223728256464"},["Growdown"]={id="rbxassetid://116269420981187"},["PinkDown"]={id="rbxassetid://103518507606964"},["OPMW"]={id="rbxassetid://88211645734166"},["Firebite"]={id="rbxassetid://134888597234636"},["Galasia"]={id="rbxassetid://99374399268601"},["Yellowdump"]={id="rbxassetid://86026762960005"},["Penstick"]={id="rbxassetid://77467662272084"},["Dangerous"]={id="rbxassetid://73627422059849"},["Gasattack"]={id="rbxassetid://80075675951194"},["Ivan Olin"]={id="rbxassetid://104337061217190"},["Steel"]={id="rbxassetid://128592228174287"},["Tugarin"]={id="rbxassetid://137901888336824"},["Dark Essence"]={id="rbxassetid://94848190129550"},["Growess"]={id="rbxassetid://84483564242316"},["Sakura"]={id="rbxassetid://103211071204546"},["Bloodrain"]={id="rbxassetid://116950613843071"},["Iced"]={id="rbxassetid://87976754296141"},["Iron breaker"]={id="rbxassetid://125406237941852"},["GPTprompt"]={id="rbxassetid://89878321896846"},["Memory"]={id="rbxassetid://138602414261870"},["Miamoree"]={id="rbxassetid://89179425357864"},["Minions"]={id="rbxassetid://87686543174255"},["Arabian"]={id="rbxassetid://78086707910549"},["RidenGI"]={id="rbxassetid://105686184306746"},["Sakurain"]={id="rbxassetid://84441518736003"},["Hellaida"]={id="rbxassetid://123113137075758"},["PIXELMAIN"]={id="rbxassetid://103895362425333"},["Azimov"]={id="rbxassetid://87797063560328"},["Neo noir"]={id="rbxassetid://114859231452954"}},
        ["AKM"] = {["Whitestring"]={id="rbxassetid://15282661456"},["Gildedfury"]={id="rbxassetid://15282807876"},["Stars"]={id="rbxassetid://16090684967"},["Insurgent"]={id="rbxassetid://15282115851"},["Lab Grown"]={id="rbxassetid://16591522484"}},
    },
    Shotguns = {
        ["Sawn-Off"] = {["Multicam"]={id="rbxassetid://15998421683"},["Webs"]={id="rbxassetid://15177076142"},["Banana"]={id="rbxassetid://13387455222"},["Glacial"]={id="rbxassetid://13030805318"},["Grandprix"]={id="rbxassetid://13841748041"},["Caution"]={id="rbxassetid://10959371093"},["Logs"]={id="rbxassetid://13556252494"},["Gold"]={id="rbxassetid://13714495559"},["Eros"]={id="rbxassetid://124136583812651"},["Grapey"]={id="rbxassetid://15303443830"}},
        ["Ithaca-37"] = {["Homedefense"]={id="rbxassetid://13935302367"},["Sightings"]={id="rbxassetid://15183702458"},["Reserve"]={id="rbxassetid://13841781874"},["Darkmatter"]={id="rbxassetid://15998588320"},["Blaze"]={id="rbxassetid://13703922904"},["Ithcuh"]={id="rbxassetid://16910987164"},["Engraved"]={id="rbxassetid://13388409062"},["Hellfire"]={id="rbxassetid://88337624827127"},["Platinum"]={id="rbxassetid://15344307680"}},
        ["Super-Shorty"] = {["Firecracker"]={id="rbxassetid://18149800264"},["Checkmate"]={id="rbxassetid://13713146952"},["Steel"]={id="rbxassetid://13394161570"},["Loveletter"]={id="rbxassetid://16355340290"},["Fade"]={id="rbxassetid://15645983643"},["Hell Burner"]={id="rbxassetid://15093033212"}},
    }
}
--
local function getWepsInClass(cls) if not SkinsDB[cls] then return {} end; local w = {}; for wn, _ in pairs(SkinsDB[cls]) do table.insert(w, wn) end; table.sort(w); return w end
local function getSkinsForWep(cls, wn) if not SkinsDB[cls] or not SkinsDB[cls][wn] then return {} end; local s = {}; for sn, _ in pairs(SkinsDB[cls][wn]) do table.insert(s, sn) end; table.sort(s); return s end
--
local function applySkin()
    if not SkinState.On then Lib:Notify("Enable SkinChanger first!", 2); return false end
    if not SkinState.Weapon or not SkinState.Skin then Lib:Notify("Select weapon and skin!", 2); return false end
    local c = LP.Character; if not c then Lib:Notify("No char!", 2); return false end
    local t = c:FindFirstChild(SkinState.Weapon); if not t then Lib:Notify("Equip "..SkinState.Weapon.." first!", 2); return false end
    local sData = SkinsDB[SkinState.Class][SkinState.Weapon][SkinState.Skin]; if not sData then Lib:Notify("No skin data!", 2); return false end
    local suc, err = pcall(function()
        for _, d in pairs(t:GetDescendants()) do if d:IsA("MeshPart") then d.TextureID = sData.id; if d:FindFirstChildOfClass("SurfaceAppearance") then d:FindFirstChildOfClass("SurfaceAppearance"):Destroy() end end end
        if sData.customApply then sData.customApply(t) end
    end)
    if suc then Lib:Notify("Skin to "..SkinState.Weapon, 2); return true else warn("Skin err:", err); Lib:Notify("Skin fail!", 2); return false end
end
--
local function setupAutoApply()
    for _, c in pairs(SkinState.Conns) do if c then c:Disconnect() end end; SkinState.Conns = {}
    if SkinState.On and SkinState.Auto then
        local function chkAndApply()
            if not SkinState.Auto or not SkinState.On then return end
            local c = LP.Character; if not c then return end
            local t = c:FindFirstChild(SkinState.Weapon); if not t then return end
            if SkinState.Weapon and SkinState.Skin then task.wait(0.5); applySkin() end
        end
        if LP.Character then local t = LP.Character:FindFirstChild(SkinState.Weapon); if t then task.spawn(function() task.wait(1); chkAndApply() end) end end
        local c1 = LP.CharacterAdded:Connect(function(c) task.wait(2); chkAndApply() end)
        local function setupCharMon(c) local c2 = c.ChildAdded:Connect(function(ch) if ch:IsA("Tool") and ch.Name == SkinState.Weapon then task.wait(0.5); chkAndApply() end end); table.insert(SkinState.Conns, c2) end
        if LP.Character then setupCharMon(LP.Character) end
        local c3 = LP.CharacterAdded:Connect(function(c) task.wait(1); setupCharMon(c); chkAndApply() end)
        table.insert(SkinState.Conns, c1); table.insert(SkinState.Conns, c3)
    end
end
--
local function saveSkins() if writefile then pcall(function() writefile("starlight_skins.json", game:GetService("HttpService"):JSONEncode(SkinState.Equipped)) end) else Lib:Notify("No writefile", 2) end end
local function loadSkins() if readfile and isfile then pcall(function() if isfile("starlight_skins.json") then SkinState.Equipped = game:GetService("HttpService"):JSONDecode(readfile("starlight_skins.json")) end end) end end
--
task.spawn(function()
    repeat task.wait() until Tabs and Win; task.wait(2)
    if not Tabs.Skin then Tabs.Skin = Win:AddTab("SkinChanger") end
    local SkinTab = Tabs.Skin; local SkinL = SkinTab:AddLeftGroupbox("Skin Changer"); local SkinR = SkinTab:AddRightGroupbox("Controls")
-- ==================== CUSTOM MODELS SYSTEM ====================
--
local CustomModelsGroup = SkinTab:AddLeftGroupbox("Custom Models")
--
local currentCMType = "M4:Subzero"
local isCMEnabled = false
local cmConnections = {}
local cmHeartbeatConnection = nil
--
Subzero
local cmSubzeroModel = nil
local cmSubzeroCurrentSkinClone = nil
local cmSubzeroLastWeapon = nil
local cmSubzeroIsApplyingSkin = false
local cmSubzeroOriginalPartsTransparency = {}
local cmSubzeroOriginalEffectsProperties = {}
local CM_SUBZERO_BLUE_COLOR = Color3.fromRGB(0, 150, 255)
local cmSubzeroLastCheckTime = 0
local CM_SUBZERO_CHECK_INTERVAL = 0.3
local CM_SUBZERO_FIRE_SOUND_ID = "rbxassetid://747238556"
local cmSubzeroCreatedFFireSoundTWO = nil
--
Dragon (YПPOЩEHHAЯ BEPCИЯ БEЗ OГHЯ)
local cmDragonModel = nil
local cmDragonCurrentSkinClone = nil
local cmDragonLastWeapon = nil
local cmDragonIsApplyingSkin = false
local cmDragonOriginalPartsTransparency = {}
local cmDragonOriginalFireSounds = {}
local cmDragonLastCheckTime = 0
local CM_DRAGON_CHECK_INTERVAL = 0.3
local CM_DRAGON_FIRE_SOUND_TWO_ID = "rbxassetid://4547663256"
local cmDragonCreatedFFireSoundTWO = nil
local CM_DRAGON_RED_COLOR = Color3.fromRGB(255, 50, 50)
local CM_DRAGON_ORANGE_COLOR = Color3.fromRGB(255, 150, 50)
--
Cryogen
local cmCryogenModel = nil
local cmCryogenCurrentSkinClone = nil
local cmCryogenLastWeapon = nil
local cmCryogenIsApplyingSkin = false
local cmCryogenOriginalPartsTransparency = {}
local cmCryogenLastCheckTime = 0
local CM_CRYOGEN_CHECK_INTERVAL = 0.1
--
Heritage
local cmHeritageModel = nil
local cmHeritageCurrentSkinClone = nil
local cmHeritageLastWeapon = nil
local cmHeritageIsApplyingSkin = false
local cmHeritageOriginalPartsTransparency = {}
local cmHeritageOriginalColors = {}
local cmHeritageOriginalBrightness = {}
local cmHeritageOriginalParticleColors = {}
local cmHeritageOriginalFireSounds = {}
local CM_HERITAGE_TEXTURE_ID = "rbxassetid://18312058779"
local cmHeritageLastCheckTime = 0
local CM_HERITAGE_CHECK_INTERVAL = 0.3
--
WOGW
local cmWogwModel = nil
local cmWogwCurrentSkinClone = nil
local cmWogwLastWeapon = nil
local cmWogwIsApplyingSkin = false
local cmWogwOriginalPartsTransparency = {}
local cmWogwOriginalColors = {}
local cmWogwOriginalBrightness = {}
local cmWogwOriginalParticleColors = {}
local cmWogwOriginalFireSounds = {}
local CM_WOGW_TEXTURE_ID = "rbxassetid://18447364551"
local CM_WOGW_RED_COLOR = Color3.fromRGB(255, 0, 0)
local cmWogwLastCheckTime = 0
local CM_WOGW_CHECK_INTERVAL = 0.3
--
OPM
local cmOpmModel = nil
local cmOpmCurrentSkinClone = nil
local cmOpmLastWeapon = nil
local cmOpmIsApplyingSkin = false
local cmOpmOriginalPartsTransparency = {}
local cmOpmLastCheckTime = 0
local CM_OPM_CHECK_INTERVAL = 0.3
local CM_M4A1_TEXTURE_ID = "rbxassetid://17517217348"
local CM_WINGS_TEXTURE_ID = "rbxassetid://16932839206"
--
Showdown
local cmShowdownModel = nil
local cmShowdownCurrentSkinClone = nil
local cmShowdownLastWeapon = nil
local cmShowdownIsApplyingSkin = false
local cmShowdownOriginalPartsTransparency = {}
local cmShowdownOriginalSoundEffects = {}
local cmShowdownLastCheckTime = 0
local CM_SHOWDOWN_CHECK_INTERVAL = 0.3
local CM_SHOWDOWN_TEXTURE_ID = "rbxassetid://92440380770170"
local CM_STEELDOWN_TEXTURE_ID = "rbxassetid://84378650452943"
local CM_GHOST_GREY_COLOR = Color3.fromRGB(163, 162, 165)
local CM_FIRE_SOUND_IDS = {
    "rbxassetid://101102493447462",
    "rbxassetid://82242797766568"
}
--
Eros
local cmErosModel = nil
local cmErosCurrentSkinClone = nil
local cmErosLastWeapon = nil
local cmErosIsApplyingSkin = false
local cmErosOriginalPartsTransparency = {}
local cmErosOriginalEffectsProperties = {}
local CM_EROS_PINK_COLOR = Color3.fromRGB(255, 105, 180)
local CM_EROS_TEXTURE_ID = "rbxassetid://94543327437589"
local cmErosLastCheckTime = 0
local CM_EROS_CHECK_INTERVAL = 0.3
--
Mare (TrickShot & White)
local cmMareModel = nil
local cmMareCurrentSkinClone = nil
local cmMareLastWeapon = nil
local cmMareIsApplyingSkin = false
local cmMareOriginalPartsTransparency = {}
local cmMareOriginalMaterials = {}
local cmMareOriginalColors = {}
local cmMareOriginalEffectsProperties = {}
local cmMareLastCheckTime = 0
local CM_MARE_CHECK_INTERVAL = 0.3
local CM_MARE_FIRE_SOUND_ID = "rbxassetid://5033272182"
local cmMareCreatedFFireSoundTWO = nil
--
Maccиb ckиhob для Mare
local cmMareSkins = {
    ["TrickShot"] = {
        texture = "rbxassetid://16907785827",
        color = Color3.fromRGB(0, 255, 0),
        brightColor = Color3.fromRGB(100, 255, 100),
        effectColor = Color3.fromRGB(0, 255, 0),
        smokeColor = Color3.new(0.5, 1, 0.5)
    },
    ["White"] = {
        texture = "rbxassetid://16907786165",
        color = Color3.fromRGB(255, 255, 255),
        brightColor = Color3.fromRGB(255, 255, 255),
        effectColor = Color3.fromRGB(255, 255, 255),
        smokeColor = Color3.new(0.9, 0.9, 0.9)
    }
}
--
local currentMareSkin = "TrickShot"
--
local function changeCMFireSoundsPlaybackSpeed(weapon, soundEffectsTable)
    if not weapon then return end
    local weaponHandle = weapon:FindFirstChild("WeaponHandle") or weapon:FindFirstChild("Handle")
    if not weaponHandle then return end
    local muzzle = weaponHandle:FindFirstChild("Muzzle")
    if muzzle then
        for i = 1, 3 do
            local fireSound = muzzle:FindFirstChild("FireSound" .. i)
            if fireSound and fireSound:IsA("Sound") then
                soundEffectsTable[fireSound] = {PlaybackSpeed = fireSound.PlaybackSpeed, SoundId = fireSound.SoundId}
                fireSound.PlaybackSpeed = 0.952
            end
        end
        local alternativeSoundNames = {"Fire", "Shoot", "Gunshot", "Shot", "FireSound"}
        for _, soundName in pairs(alternativeSoundNames) do
            local sound = muzzle:FindFirstChild(soundName)
            if sound and sound:IsA("Sound") and not soundEffectsTable[sound] then
                soundEffectsTable[sound] = {PlaybackSpeed = sound.PlaybackSpeed, SoundId = sound.SoundId}
                sound.PlaybackSpeed = 0.8
            end
        end
    end
    for _, sound in pairs(weaponHandle:GetChildren()) do
        if sound:IsA("Sound") and not soundEffectsTable[sound] then
            local soundName = sound.Name:lower()
            if string.find(soundName, "fire") or string.find(soundName, "shoot") or string.find(soundName, "shot") or string.find(soundName, "firesound") then
                soundEffectsTable[sound] = {PlaybackSpeed = sound.PlaybackSpeed, SoundId = sound.SoundId}
                sound.PlaybackSpeed = 0.8
            end
        end
    end
    for _, sound in pairs(weapon:GetDescendants()) do
        if sound:IsA("Sound") and not soundEffectsTable[sound] then
            local soundName = sound.Name:lower()
            if string.find(soundName, "fire") or string.find(soundName, "shoot") or string.find(soundName, "shot") or string.find(soundName, "firesound") then
                soundEffectsTable[sound] = {PlaybackSpeed = sound.PlaybackSpeed, SoundId = sound.SoundId}
                sound.PlaybackSpeed = 0.8
            end
        end
    end
end
--
local function restoreCMFireSoundsPlaybackSpeed(soundEffectsTable)
    for sound, originalData in pairs(soundEffectsTable) do
        if sound and sound.Parent then
            pcall(function() sound.PlaybackSpeed = originalData.PlaybackSpeed end)
        end
    end
    soundEffectsTable = {}
end
--
Subzero фyhkции
local function hideCMSubzeroOriginalParts(weapon)
    if not weapon then return end
    cmSubzeroOriginalPartsTransparency = {}
    for _, part in ipairs(weapon:GetDescendants()) do
        if (part:IsA("BasePart") or part:IsA("MeshPart")) and part.Transparency < 1 then
            cmSubzeroOriginalPartsTransparency[part] = part.Transparency
            part.Transparency = 1
        end
    end
end
--
local function restoreCMSubzeroOriginalParts()
    for part, transparency in pairs(cmSubzeroOriginalPartsTransparency) do
        if part and part.Parent then part.Transparency = transparency end
    end
    cmSubzeroOriginalPartsTransparency = {}
end
--
local function addCMSubzeroFFireSoundTWO(weapon)
    if not weapon then return nil end
    local weaponHandle = weapon:FindFirstChild("WeaponHandle") or weapon:FindFirstChild("Handle")
    if not weaponHandle then return nil end
    local muzzle = weaponHandle:FindFirstChild("Muzzle")
    if not muzzle then
        muzzle = Instance.new("Part")
        muzzle.Name = "Muzzle"
        muzzle.Size = Vector3.new(0.2, 0.2, 0.2)
        muzzle.Transparency = 1
        muzzle.CanCollide = false
        muzzle.CanTouch = false
        muzzle.Anchored = false
        muzzle.Massless = true
        muzzle.Parent = weaponHandle
        local weld = Instance.new("Weld")
        weld.Part0 = weaponHandle
        weld.Part1 = muzzle
        weld.C0 = CFrame.new(0, 0, 1.5)
        weld.Parent = muzzle
    end
    local existingSound = muzzle:FindFirstChild("FFireSoundTWO")
    if existingSound then
        existingSound.SoundId = CM_SUBZERO_FIRE_SOUND_ID
        existingSound.Volume = 0.5
        existingSound.PlaybackSpeed = 3
        cmSubzeroCreatedFFireSoundTWO = existingSound
        return existingSound
    end
    local newFireSound = Instance.new("Sound")
    newFireSound.Name = "FFireSoundTWO"
    newFireSound.SoundId = CM_SUBZERO_FIRE_SOUND_ID
    newFireSound.Volume = 0.5
    newFireSound.MaxDistance = 200
    newFireSound.RollOffMode = Enum.RollOffMode.Linear
    newFireSound.PlaybackSpeed = 3
    newFireSound.Looped = false
    newFireSound.Parent = muzzle
    pcall(function() newFireSound:SetAttribute("Priority", 1) end)
    cmSubzeroCreatedFFireSoundTWO = newFireSound
    return newFireSound
end
--
local function removeCMSubzeroFFireSoundTWO()
    if cmSubzeroCreatedFFireSoundTWO and cmSubzeroCreatedFFireSoundTWO.Parent then
        pcall(function() cmSubzeroCreatedFFireSoundTWO:Destroy() end)
        cmSubzeroCreatedFFireSoundTWO = nil
    end
    local player = game.Players.LocalPlayer
    if player and player.Character then
        for _, tool in ipairs(player.Character:GetChildren()) do
            if tool:IsA("Tool") then
                local weaponHandle = tool:FindFirstChild("WeaponHandle") or tool:FindFirstChild("Handle")
                if weaponHandle then
                    local muzzle = weaponHandle:FindFirstChild("Muzzle")
                    if muzzle then
                        local sound = muzzle:FindFirstChild("FFireSoundTWO")
                        if sound then pcall(function() sound:Destroy() end) end
                    end
                end
            end
        end
    end
end
--
local function changeCMSubzeroEffectsToBlue(weapon)
    if not weapon then return end
    local weaponHandle = weapon:FindFirstChild("WeaponHandle") or weapon:FindFirstChild("Handle")
    if not weaponHandle then return end
    local muzzle = weaponHandle:FindFirstChild("Muzzle")
    if not muzzle then return end
    local effectNames = {"Barrel Smoke","FlashEmitter","Gas","Gas2","Lens Flare","Muzzle Flash 1","SmokeEmitter","Sparkles"}
    cmSubzeroOriginalEffectsProperties = {}
    for _, effectName in ipairs(effectNames) do
        local effect = muzzle:FindFirstChild(effectName)
        if effect then
            cmSubzeroOriginalEffectsProperties[effect] = {}
            if effect:IsA("ParticleEmitter") then
                cmSubzeroOriginalEffectsProperties[effect].Color = effect.Color
                effect.Color = ColorSequence.new(CM_SUBZERO_BLUE_COLOR)
            elseif effect:IsA("Beam") then
                cmSubzeroOriginalEffectsProperties[effect].Color = effect.Color
                effect.Color = ColorSequence.new(CM_SUBZERO_BLUE_COLOR)
            elseif effect:IsA("PointLight") then
                cmSubzeroOriginalEffectsProperties[effect].Color = effect.Color
                effect.Color = CM_SUBZERO_BLUE_COLOR
            elseif effect:IsA("Sparkles") then
                cmSubzeroOriginalEffectsProperties[effect].SparkleColor = effect.SparkleColor
                effect.SparkleColor = CM_SUBZERO_BLUE_COLOR
            elseif effect:IsA("Smoke") then
                cmSubzeroOriginalEffectsProperties[effect].Color = effect.Color
                effect.Color = Color3.new(0.6, 0.8, 1)
            elseif effect:IsA("Fire") then
                cmSubzeroOriginalEffectsProperties[effect].Color = effect.Color
                cmSubzeroOriginalEffectsProperties[effect].SecondaryColor = effect.SecondaryColor
                effect.Color = CM_SUBZERO_BLUE_COLOR
                effect.SecondaryColor = CM_SUBZERO_BLUE_COLOR
            end
        end
    end
    for _, child in ipairs(muzzle:GetChildren()) do
        if (child:IsA("ParticleEmitter") or child:IsA("Beam") or child:IsA("PointLight") or child:IsA("Sparkles") or child:IsA("Smoke") or child:IsA("Fire")) and not cmSubzeroOriginalEffectsProperties[child] then
            cmSubzeroOriginalEffectsProperties[child] = {}
            if child:IsA("ParticleEmitter") then
                cmSubzeroOriginalEffectsProperties[child].Color = child.Color
                child.Color = ColorSequence.new(CM_SUBZERO_BLUE_COLOR)
            elseif child:IsA("Beam") then
                cmSubzeroOriginalEffectsProperties[child].Color = child.Color
                child.Color = ColorSequence.new(CM_SUBZERO_BLUE_COLOR)
            elseif child:IsA("PointLight") then
                cmSubzeroOriginalEffectsProperties[child].Color = child.Color
                child.Color = CM_SUBZERO_BLUE_COLOR
            elseif child:IsA("Sparkles") then
                cmSubzeroOriginalEffectsProperties[child].SparkleColor = child.SparkleColor
                child.SparkleColor = CM_SUBZERO_BLUE_COLOR
            elseif child:IsA("Smoke") then
                cmSubzeroOriginalEffectsProperties[child].Color = child.Color
                child.Color = Color3.new(0.6, 0.8, 1)
            elseif child:IsA("Fire") then
                cmSubzeroOriginalEffectsProperties[child].Color = child.Color
                cmSubzeroOriginalEffectsProperties[child].SecondaryColor = child.SecondaryColor
                child.Color = CM_SUBZERO_BLUE_COLOR
                child.SecondaryColor = CM_SUBZERO_BLUE_COLOR
            end
        end
    end
end
--
local function restoreCMSubzeroOriginalEffects()
    for effect, properties in pairs(cmSubzeroOriginalEffectsProperties) do
        if effect and effect.Parent then
            pcall(function()
                if properties.Color then effect.Color = properties.Color end
                if properties.SparkleColor then effect.SparkleColor = properties.SparkleColor end
                if properties.SecondaryColor then effect.SecondaryColor = properties.SecondaryColor end
            end)
        end
    end
    cmSubzeroOriginalEffectsProperties = {}
end
--
local function loadCMSubzeroModel()
    local success = pcall(function()
        local possibleNames = {"subzero","m4a1_subzero","m4_subzero","subzero_m4","subzero_m4a1","ice","frost","frozen"}
        local searchLocations = {game:GetService("ReplicatedStorage"),game:GetService("Workspace"),game:GetService("Lighting"),game:GetService("StarterPack"),game:GetService("StarterGui"),game:GetService("ServerStorage")}
        local storage = game:GetService("ReplicatedStorage"):FindFirstChild("Storage")
        if storage then
            for _, child in ipairs(storage:GetChildren()) do
                local childName = child.Name:lower()
                for _, name in ipairs(possibleNames) do
                    if string.find(childName, name) then
                        cmSubzeroModel = child:Clone()
                        return true
                    end
                end
            end
        end
        for _, location in ipairs(searchLocations) do
            if location then
                local function searchInContainer(container, depth)
                    if depth > 3 then return false end
                    for _, item in ipairs(container:GetChildren()) do
                        local itemName = item.Name:lower()
                        for _, name in ipairs(possibleNames) do
                            if string.find(itemName, name) then
                                if item:IsA("Model") or item:IsA("BasePart") or item:IsA("MeshPart") then
                                    cmSubzeroModel = item:Clone()
                                    return true
                                end
                            end
                        end
                        if #item:GetChildren() > 0 then
                            if searchInContainer(item, depth + 1) then return true end
                        end
                    end
                    return false
                end
                if searchInContainer(location, 0) then return true end
            end
        end
        local function findAnyWeaponModel(container)
            for _, item in ipairs(container:GetChildren()) do
                local itemName = item.Name:lower()
                if string.find(itemName, "weapon") or string.find(itemName, "gun") or string.find(itemName, "rifle") or string.find(itemName, "m4") then
                    if item:IsA("Model") or item:IsA("BasePart") then
                        cmSubzeroModel = item:Clone()
                        return true
                    end
                end
                if #item:GetChildren() > 0 then
                    if findAnyWeaponModel(item) then return true end
                end
            end
            return false
        end
        if storage and findAnyWeaponModel(storage) then return true end
        return false
    end)
    if success and cmSubzeroModel then
        for _, obj in ipairs(cmSubzeroModel:GetDescendants()) do
            if obj:IsA("BasePart") then
                obj.CanCollide = false
                obj.Massless = true
                obj.CastShadow = false
                obj.CanQuery = false
                local complexMaterials = {Enum.Material.Neon,Enum.Material.Glass,Enum.Material.Foil,Enum.Material.ForceField}
                for _, material in ipairs(complexMaterials) do
                    if obj.Material == material then obj.Material = Enum.Material.Plastic end
                end
            end
        end
        return true
    else
        return false
    end
end
--
local function applyCMSubzeroSkin(weapon)
    if not weapon or not cmSubzeroModel or cmSubzeroIsApplyingSkin then return false end
    cmSubzeroIsApplyingSkin = true
    if cmSubzeroCurrentSkinClone then
        pcall(function() cmSubzeroCurrentSkinClone:Destroy() end)
        cmSubzeroCurrentSkinClone = nil
    end
    hideCMSubzeroOriginalParts(weapon)
    changeCMSubzeroEffectsToBlue(weapon)
    addCMSubzeroFFireSoundTWO(weapon)
    local success = pcall(function()
        local skinClone = cmSubzeroModel:Clone()
        local handle = weapon:FindFirstChild("Handle") or weapon:FindFirstChildWhichIsA("BasePart")
        if not handle then skinClone:Destroy(); return false end
        local skinPrimary
        if skinClone:IsA("BasePart") then
            skinPrimary = skinClone
        else
            skinPrimary = skinClone:FindFirstChildWhichIsA("BasePart")
        end
        if not skinPrimary then
            skinPrimary = skinClone:FindFirstChildWhichIsA("Model")
            if skinPrimary then skinPrimary = skinPrimary:FindFirstChildWhichIsA("BasePart") end
        end
        if skinPrimary then
            skinPrimary.CFrame = handle.CFrame
            local weld = Instance.new("Weld")
            weld.Part0 = handle
            weld.Part1 = skinPrimary
            weld.C0 = CFrame.new()
            weld.C1 = CFrame.new()
            weld.Parent = skinPrimary
            for _, part in ipairs(skinClone:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.Massless = true
                    part.CanCollide = false
                    part.CastShadow = false
                    part.CanQuery = false
                end
            end
            skinClone.Parent = weapon
            cmSubzeroCurrentSkinClone = skinClone
            cmSubzeroLastWeapon = weapon
            return true
        else
            skinClone:Destroy()
            return false
        end
    end)
    cmSubzeroIsApplyingSkin = false
    return success
end
--
local function removeCMSubzeroSkin()
    restoreCMSubzeroOriginalEffects()
    removeCMSubzeroFFireSoundTWO()
    if cmSubzeroCurrentSkinClone then
        pcall(function() cmSubzeroCurrentSkinClone:Destroy(); cmSubzeroCurrentSkinClone = nil end)
    end
    restoreCMSubzeroOriginalParts()
    cmSubzeroLastWeapon = nil
end
--
Dragon фyhkции (YПPOЩEHHЫE БEЗ ЭФФEKTOB OГHЯ)
local function processCMDragonModelParts(model)
    if not model then return nil end
    local partsToRemove = {"LaserPart","OpticPart","SuppressorPart"}
    local partsToHide = {"Bolt","ChargingHandle","Dustcover","HoloSightPart"}
    for _, descendant in pairs(model:GetDescendants()) do
        if descendant:IsA("BasePart") or descendant:IsA("MeshPart") then
            local partName = descendant.Name
            for _, unwantedName in pairs(partsToRemove) do
                if partName == unwantedName then descendant:Destroy(); break end
            end
            for _, hideName in pairs(partsToHide) do
                if partName == hideName then descendant.Transparency = 1; descendant.CanCollide = false; descendant.CanTouch = false; break end
            end
        end
    end
    return true
end
--
local function loadCMDragonModel()
    local isSearching = false
    if isSearching then return nil end
    isSearching = true
    local foundModel = nil
    local searchLocations = {game:GetService("ReplicatedStorage"),game:GetService("ServerStorage"),game:GetService("Workspace"),game:GetService("StarterPack"),game:GetService("StarterGui"),game:GetService("Lighting")}
    local storage = game:GetService("ReplicatedStorage"):FindFirstChild("Storage")
    if storage then
        for _, child in ipairs(storage:GetChildren()) do
            if string.lower(child.Name) == "m4a1_c_sm" then foundModel = child; break end
        end
    end
    if not foundModel then
        for _, location in ipairs(searchLocations) do
            if location then
                local function searchInContainer(container, depth)
                    if depth > 3 then return false end
                    for _, item in ipairs(container:GetChildren()) do
                        if string.lower(item.Name) == "m4a1_c_sm" then
                            if item:IsA("Model") or item:IsA("BasePart") or item:IsA("MeshPart") then foundModel = item; return true end
                        end
                        if #item:GetChildren() > 0 then if searchInContainer(item, depth + 1) then return true end end
                    end
                    return false
                end
                if searchInContainer(location, 0) then break end
            end
        end
    end
    if foundModel then
        cmDragonModel = foundModel:Clone()
        processCMDragonModelParts(cmDragonModel)
        for _, part in pairs(cmDragonModel:GetDescendants()) do
            if part:IsA("BasePart") or part:IsA("MeshPart") then
                part.CastShadow = false
                part.CanCollide = false
                part.CanTouch = false
                part.Massless = true
                part.Locked = true
                if part.Material == Enum.Material.Plastic or part.Material == Enum.Material.SmoothPlastic then 
                    part.Color = CM_DRAGON_RED_COLOR 
                end
            end
        end
    end
    isSearching = false
    return cmDragonModel ~= nil
end
--
local function hideCMDragonOriginalParts(weapon)
    if not weapon then return end
    cmDragonOriginalPartsTransparency = {}
    for _, part in ipairs(weapon:GetDescendants()) do
        if (part:IsA("BasePart") or part:IsA("MeshPart")) and part.Transparency < 1 then
            cmDragonOriginalPartsTransparency[part] = part.Transparency
            part.Transparency = 1
        end
    end
end
--
local function restoreCMDragonOriginalParts()
    for part, transparency in pairs(cmDragonOriginalPartsTransparency) do
        if part and part.Parent then pcall(function() part.Transparency = transparency end) end
    end
    cmDragonOriginalPartsTransparency = {}
end
--
local function addCMDragonFFireSoundTWO(weapon)
    if not weapon then return nil end
    local weaponHandle = weapon:FindFirstChild("WeaponHandle") or weapon:FindFirstChild("Handle")
    if not weaponHandle then return nil end
    local muzzle = weaponHandle:FindFirstChild("Muzzle")
    if not muzzle then
        muzzle = Instance.new("Part")
        muzzle.Name = "Muzzle"
        muzzle.Size = Vector3.new(0.2, 0.2, 0.2)
        muzzle.Transparency = 1
        muzzle.CanCollide = false
        muzzle.CanTouch = false
        muzzle.Anchored = false
        muzzle.Massless = true
        muzzle.Parent = weaponHandle
        local weld = Instance.new("Weld")
        weld.Part0 = weaponHandle
        weld.Part1 = muzzle
        weld.C0 = CFrame.new(0, 0, 1.5)
        weld.Parent = muzzle
    end
    local existingSound = muzzle:FindFirstChild("FFireSoundTWO")
    if existingSound then
        existingSound.SoundId = CM_DRAGON_FIRE_SOUND_TWO_ID
        existingSound.Volume = 0.5
        existingSound.PlaybackSpeed = 1
        cmDragonCreatedFFireSoundTWO = existingSound
        return existingSound
    end
    local newFireSound = Instance.new("Sound")
    newFireSound.Name = "FFireSoundTWO"
    newFireSound.SoundId = CM_DRAGON_FIRE_SOUND_TWO_ID
    newFireSound.Volume = 0.5
    newFireSound.MaxDistance = 200
    newFireSound.RollOffMode = Enum.RollOffMode.Linear
    newFireSound.PlaybackSpeed = 0.8
    newFireSound.Looped = false
    newFireSound.Parent = muzzle
    pcall(function() newFireSound:SetAttribute("Priority", 1) end)
    cmDragonCreatedFFireSoundTWO = newFireSound
    return newFireSound
end
--
local function removeCMDragonFFireSoundTWO()
    if cmDragonCreatedFFireSoundTWO and cmDragonCreatedFFireSoundTWO.Parent then
        pcall(function() cmDragonCreatedFFireSoundTWO:Destroy() end)
        cmDragonCreatedFFireSoundTWO = nil
    end
    local player = game.Players.LocalPlayer
    if player and player.Character then
        for _, tool in ipairs(player.Character:GetChildren()) do
            if tool:IsA("Tool") then
                local weaponHandle = tool:FindFirstChild("WeaponHandle") or tool:FindFirstChild("Handle")
                if weaponHandle then
                    local muzzle = weaponHandle:FindFirstChild("Muzzle")
                    if muzzle then
                        local sound = muzzle:FindFirstChild("FFireSoundTWO")
                        if sound then pcall(function() sound:Destroy() end) end
                    end
                end
            end
        end
    end
end
--
local function changeCMDragonFireSoundsPlaybackSpeed(weapon)
    if not weapon then return end
    cmDragonOriginalFireSounds = {}
    local weaponHandle = weapon:FindFirstChild("WeaponHandle") or weapon:FindFirstChild("Handle")
    if weaponHandle then
        local muzzle = weaponHandle:FindFirstChild("Muzzle")
        if muzzle then
            for i = 1, 3 do
                local fireSound = muzzle:FindFirstChild("FireSound" .. i)
                if fireSound and fireSound:IsA("Sound") then
                    cmDragonOriginalFireSounds[fireSound] = {PlaybackSpeed = fireSound.PlaybackSpeed,SoundId = fireSound.SoundId}
                    fireSound.PlaybackSpeed = 0.952
                end
            end
        end
    end
end
--
local function restoreCMDragonFireSounds()
    for sound, originalData in pairs(cmDragonOriginalFireSounds) do
        if sound and sound.Parent then pcall(function() sound.PlaybackSpeed = originalData.PlaybackSpeed end) end
    end
    cmDragonOriginalFireSounds = {}
end
--
local function applyCMDragonSkin(weapon)
    if not weapon or not cmDragonModel or cmDragonIsApplyingSkin then return false end
    cmDragonIsApplyingSkin = true
    if cmDragonCurrentSkinClone then
        pcall(function() cmDragonCurrentSkinClone:Destroy() end)
        cmDragonCurrentSkinClone = nil
    end
    hideCMDragonOriginalParts(weapon)
    changeCMDragonFireSoundsPlaybackSpeed(weapon)
    addCMDragonFFireSoundTWO(weapon)
--
    local success = pcall(function()
        local skinClone = cmDragonModel:Clone()
        local handle = weapon:FindFirstChild("Handle") or weapon:FindFirstChildWhichIsA("BasePart")
        if not handle then skinClone:Destroy(); return false end
        local skinPrimary
        if skinClone:IsA("BasePart") then skinPrimary = skinClone
        else skinPrimary = skinClone:FindFirstChildWhichIsA("BasePart") end
        if not skinPrimary then
            skinPrimary = skinClone:FindFirstChildWhichIsA("Model")
            if skinPrimary then skinPrimary = skinPrimary:FindFirstChildWhichIsA("BasePart") end
        end
        if skinPrimary then
            skinPrimary.CFrame = handle.CFrame
            local weld = Instance.new("Weld")
            weld.Part0 = handle
            weld.Part1 = skinPrimary
            weld.C0 = CFrame.new()
            weld.C1 = CFrame.new()
            weld.Parent = skinPrimary
            for _, part in ipairs(skinClone:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.Massless = true
                    part.CanCollide = false
                    part.CastShadow = false
                    part.CanQuery = false
                    part.LocalTransparencyModifier = 0
                end
            end
            skinClone.Parent = weapon
            cmDragonCurrentSkinClone = skinClone
            cmDragonLastWeapon = weapon
            return true
        else
            skinClone:Destroy()
            return false
        end
    end)
    cmDragonIsApplyingSkin = false
    return success
end
--
local function removeCMDragonSkin()
    restoreCMDragonFireSounds()
    removeCMDragonFFireSoundTWO()
    if cmDragonCurrentSkinClone then
        pcall(function() cmDragonCurrentSkinClone:Destroy(); cmDragonCurrentSkinClone = nil end)
    end
    restoreCMDragonOriginalParts()
    cmDragonLastWeapon = nil
end
--
Cryogen фyhkции
local function hideCMPartCompletely(part)
    if part:IsA("BasePart") or part:IsA("MeshPart") then
        part.Transparency = 1
        part.LocalTransparencyModifier = 1
        part.CastShadow = false
        part.CanCollide = false
        part.CanTouch = false
        part.Massless = true
        part.Material = Enum.Material.ForceField
        for _, child in ipairs(part:GetChildren()) do
            if child:IsA("Decal") or child:IsA("Texture") or child:IsA("SurfaceAppearance") then child:Destroy() end
        end
    end
end
--
local function processCMCryogenModelParts(model)
    if not model then return nil end
    local partsToRemove = {"LaserPart","OpticPart","SuppressorPart"}
    local partsToHide = {"Bolt","ChargingHandle","Dustcover","HoloSightPart","OpticLensPart","OpticLensPart2","Neonpart","HandlePart","WeaponHandle"}
    for _, descendant in pairs(model:GetDescendants()) do
        if descendant:IsA("BasePart") or descendant:IsA("MeshPart") then
            local partName = descendant.Name
            for _, unwantedName in pairs(partsToRemove) do
                if partName == unwantedName then descendant:Destroy(); break end
            end
            for _, hideName in pairs(partsToHide) do
                if partName == hideName then hideCMPartCompletely(descendant); break end
            end
        end
    end
    for _, obj in pairs(model:GetDescendants()) do
        if obj.Name == "ParticleParts" then
            for _, part in pairs(obj:GetDescendants()) do
                if part:IsA("BasePart") or part:IsA("MeshPart") then hideCMPartCompletely(part) end
            end
        end
    end
    return true
end
--
local function loadCMCryogenModel()
    local isSearching = false
    if isSearching then return nil end
    isSearching = true
    local foundModel = nil
    local searchLocations = {game:GetService("ReplicatedStorage"),game:GetService("ServerStorage"),game:GetService("Workspace"),game:GetService("StarterPack"),game:GetService("StarterGui"),game:GetService("Lighting")}
    local storage = game:GetService("ReplicatedStorage"):FindFirstChild("Storage")
    if storage then
        for _, child in ipairs(storage:GetChildren()) do
            if string.lower(child.Name) == "mp7_cryogen" then foundModel = child; break end
        end
    end
    if not foundModel then
        for _, location in ipairs(searchLocations) do
            if location then
                local function searchInContainer(container, depth)
                    if depth > 3 then return false end
                    for _, item in ipairs(container:GetChildren()) do
                        if string.lower(item.Name) == "mp7_cryogen" then
                            if item:IsA("Model") or item:IsA("BasePart") or item:IsA("MeshPart") then foundModel = item; return true end
                        end
                        if #item:GetChildren() > 0 then if searchInContainer(item, depth + 1) then return true end end
                    end
                    return false
                end
                if searchInContainer(location, 0) then break end
            end
        end
    end
    if foundModel then
        cmCryogenModel = foundModel:Clone()
        processCMCryogenModelParts(cmCryogenModel)
        for _, part in pairs(cmCryogenModel:GetDescendants()) do
            if part:IsA("BasePart") or part:IsA("MeshPart") then
                local shouldHide = false
                local hideNames = {"Bolt","ChargingHandle","Dustcover","HoloSightPart","OpticLensPart","OpticLensPart2","Neonpart","HandlePart","WeaponHandle"}
                for _, hideName in pairs(hideNames) do if part.Name == hideName then shouldHide = true; break end end
                if not shouldHide then
                    local ancestor = part.Parent
                    while ancestor do if ancestor.Name == "ParticleParts" then shouldHide = true; break end; ancestor = ancestor.Parent end
                end
                if shouldHide then hideCMPartCompletely(part) else part.Transparency = 0; part.LocalTransparencyModifier = 0 end
                part.CastShadow = false; part.CanCollide = false; part.CanTouch = false; part.Massless = true; part.Locked = true
            end
        end
    end
    isSearching = false
    return cmCryogenModel ~= nil
end
--
local function hideCMCryogenOriginalParts(weapon)
    if not weapon then return end
    cmCryogenOriginalPartsTransparency = {}
    for _, part in ipairs(weapon:GetDescendants()) do
        if (part:IsA("BasePart") or part:IsA("MeshPart")) and part.Transparency < 1 then
            cmCryogenOriginalPartsTransparency[part] = part.Transparency
            part.Transparency = 1
            part.LocalTransparencyModifier = 1
        end
    end
end
--
local function restoreCMCryogenOriginalParts()
    for part, transparency in pairs(cmCryogenOriginalPartsTransparency) do
        if part and part.Parent then pcall(function() part.Transparency = transparency; part.LocalTransparencyModifier = 0 end) end
    end
    cmCryogenOriginalPartsTransparency = {}
end
--
local function applyCMCryogenSkin(weapon)
    if not weapon or not cmCryogenModel or cmCryogenIsApplyingSkin then return false end
    cmCryogenIsApplyingSkin = true
    if cmCryogenCurrentSkinClone then
        pcall(function() cmCryogenCurrentSkinClone:Destroy() end)
        cmCryogenCurrentSkinClone = nil
    end
    hideCMCryogenOriginalParts(weapon)
    local success = pcall(function()
        local skinClone = cmCryogenModel:Clone()
        local handle = weapon:FindFirstChild("Handle") or weapon:FindFirstChildWhichIsA("BasePart")
        if not handle then skinClone:Destroy(); return false end
        local primaryPart = skinClone.PrimaryPart
        if not primaryPart and skinClone:IsA("Model") then
            for _, part in ipairs(skinClone:GetDescendants()) do
                if part:IsA("BasePart") and part.Name:lower():find("handle") then primaryPart = part; break end
            end
            if not primaryPart then primaryPart = skinClone:FindFirstChildWhichIsA("BasePart") end
        elseif not primaryPart and skinClone:IsA("BasePart") then primaryPart = skinClone end
        if not primaryPart then skinClone:Destroy(); return false end
        if skinClone:IsA("Model") then skinClone.PrimaryPart = primaryPart; skinClone:SetPrimaryPartCFrame(handle.CFrame)
        else primaryPart.CFrame = handle.CFrame end
        local weld = Instance.new("WeldConstraint")
        weld.Part0 = handle; weld.Part1 = primaryPart; weld.Parent = primaryPart
        if skinClone:IsA("Model") then
            for _, part in ipairs(skinClone:GetDescendants()) do
                if part:IsA("BasePart") and part ~= primaryPart then
                    local partWeld = Instance.new("WeldConstraint")
                    partWeld.Part0 = primaryPart; partWeld.Part1 = part; partWeld.Parent = part
                end
            end
        end
        for _, part in ipairs(skinClone:GetDescendants()) do
            if part:IsA("BasePart") or part:IsA("MeshPart") then
                part.Massless = true; part.CanCollide = false; part.CastShadow = false; part.CanQuery = false
                local shouldHide = false
                local hideNames = {"Bolt","ChargingHandle","Dustcover","HoloSightPart","OpticLensPart","OpticLensPart2","Neonpart","HandlePart","WeaponHandle"}
                for _, hideName in pairs(hideNames) do if part.Name == hideName then shouldHide = true; break end end
                if not shouldHide then
                    local ancestor = part.Parent
                    while ancestor do if ancestor.Name == "ParticleParts" then shouldHide = true; break end; ancestor = ancestor.Parent end
                end
                if shouldHide then hideCMPartCompletely(part) else part.Transparency = 0; part.LocalTransparencyModifier = 0 end
            end
        end
        skinClone.Parent = weapon
        cmCryogenCurrentSkinClone = skinClone
        cmCryogenLastWeapon = weapon
        return true
    end)
    cmCryogenIsApplyingSkin = false
    return success
end
--
local function removeCMCryogenSkin()
    if cmCryogenCurrentSkinClone then pcall(function() cmCryogenCurrentSkinClone:Destroy(); cmCryogenCurrentSkinClone = nil end) end
    restoreCMCryogenOriginalParts()
    cmCryogenLastWeapon = nil
end
--
Heritage фyhkции
local function findAndLoadCMHeritageModel()
    if cmHeritageModel then return true end
    local foundModel = nil
    local replicatedStorage = game:GetService("ReplicatedStorage")
    local storage = replicatedStorage:FindFirstChild("Storage")
    if storage then
        for _, child in ipairs(storage:GetChildren()) do
            local childName = child.Name:lower()
            if childName == "m4a1_heritage" then foundModel = child; break end
        end
        if not foundModel then
            for _, child in ipairs(storage:GetChildren()) do
                local childName = child.Name:lower()
                if string.find(childName, "heritage") and (string.find(childName, "m4") or string.find(childName, "rifle")) then foundModel = child; break end
            end
        end
    end
    if not foundModel then
        local function searchDeep(container, depth) if depth > 5 then return nil end
            for _, item in ipairs(container:GetChildren()) do
                local itemName = item.Name:lower()
                if itemName == "m4a1_heritage" then return item end
                if #item:GetChildren() > 0 then local result = searchDeep(item, depth + 1); if result then return result end end
            end
            return nil
        end
        foundModel = searchDeep(replicatedStorage, 0)
    end
    if not foundModel then
        local serverStorage = game:GetService("ServerStorage")
        if serverStorage then
            for _, item in ipairs(serverStorage:GetChildren()) do
                local itemName = item.Name:lower()
                if itemName == "m4a1_heritage" then foundModel = item; break end
            end
        end
    end
    if foundModel then
        cmHeritageModel = foundModel:Clone()
        for _, part in pairs(cmHeritageModel:GetDescendants()) do
            if part:IsA("BasePart") or part:IsA("MeshPart") then
                part.CanCollide = false; part.Anchored = false; part.Massless = true; part.CanTouch = false; part.CastShadow = false; part.CanQuery = false; part.Locked = true; part.Transparency = 0; part.LocalTransparencyModifier = 0
                if part:IsA("MeshPart") then part.CollisionFidelity = Enum.CollisionFidelity.Box end
            end
        end
        if cmHeritageModel:IsA("Model") then
            local primaryPart = cmHeritageModel.PrimaryPart
            if not primaryPart then
                for _, part in pairs(cmHeritageModel:GetDescendants()) do
                    if part:IsA("BasePart") or part:IsA("MeshPart") then cmHeritageModel.PrimaryPart = part; break end
                end
            end
        end
    end
    return cmHeritageModel ~= nil
end
--
local function hideCMHeritageOriginalParts(weapon)
    if not weapon then return end
    cmHeritageOriginalPartsTransparency = {}
    local yellowParts = {"BarrelSmore","FlashEmitter","Gas","Gas2","Lens flare","Muzzle Flash 1","Smoke Emitter","Sparkless"}
    for _, part in ipairs(weapon:GetDescendants()) do
        if (part:IsA("BasePart") or part:IsA("MeshPart")) and part.Transparency < 1 then
            local isYellowPart = false
            for _, yellowPartName in ipairs(yellowParts) do if part.Name == yellowPartName then isYellowPart = true; break end end
            if not isYellowPart then
                cmHeritageOriginalPartsTransparency[part] = part.Transparency
                part.Transparency = 1
            end
        end
    end
end
--
local function restoreCMHeritageOriginalParts()
    for part, transparency in pairs(cmHeritageOriginalPartsTransparency) do
        if part and part.Parent then pcall(function() part.Transparency = transparency; part.LocalTransparencyModifier = 0 end) end
    end
    cmHeritageOriginalPartsTransparency = {}
end
--
local function removeCMUnwantedParts(model)
    if not model then return end
    local partsToRemove = {"OpticPart","SuppressorPart","LaserPart","UpperRailPart"}
    for _, partName in ipairs(partsToRemove) do
        local part = model:FindFirstChild(partName, true)
        if part then pcall(function() part:Destroy() end) end
    end
end
--
local function hideCMSpecificParts(model)
    if not model then return end
    local partsToHide = {"WeaponHandle","Bolt","ChargingHandle","Dustcover","HandlePart"}
    for _, partName in ipairs(partsToHide) do
        local part = model:FindFirstChild(partName, true)
        if part and (part:IsA("BasePart") or part:IsA("MeshPart")) then
            pcall(function() part.Transparency = 1; part.LocalTransparencyModifier = 1 end)
        end
    end
    local handlePart = model:FindFirstChild("HandlePart")
    if handlePart and (handlePart:IsA("BasePart") or handlePart:IsA("MeshPart")) then pcall(function() handlePart.Transparency = 1; handlePart.LocalTransparencyModifier = 1 end) end
end
--
local function makeCMPartsYellow(weapon)
    if not weapon then return end
    cmHeritageOriginalColors = {}; cmHeritageOriginalBrightness = {}; cmHeritageOriginalParticleColors = {}
    local yellowColor = Color3.fromRGB(255, 255, 0); local brightYellow = Color3.fromRGB(255, 255, 100)
    local weaponHandle = weapon:FindFirstChild("WeaponHandle") or weapon:FindFirstChild("Handle")
    if not weaponHandle then return end
    local muzzle = weaponHandle:FindFirstChild("Muzzle"); if not muzzle then return end
    local partsToColor = {"BarrelSmore","FlashEmitter","Gas","Gas2","Lens flare","Muzzle Flash 1","Smoke Emitter","Sparkless"}
    for _, partName in ipairs(partsToColor) do
        local part = muzzle:FindFirstChild(partName)
        if part then
            pcall(function()
                if part:IsA("BasePart") or part:IsA("MeshPart") then
                    cmHeritageOriginalColors[part] = part.Color
                    part.Color = yellowColor
                    part.Material = Enum.Material.Neon
                elseif part:IsA("ParticleEmitter") then
                    if part.Color then cmHeritageOriginalParticleColors[part] = {Color = part.Color}; part.Color = ColorSequence.new(yellowColor) end
                elseif part:IsA("PointLight") or part:IsA("SpotLight") then
                    cmHeritageOriginalColors[part] = part.Color; cmHeritageOriginalBrightness[part] = part.Brightness
                    part.Color = brightYellow; part.Brightness = 10; part.Range = 20
                elseif part:IsA("LensFlare") then cmHeritageOriginalColors[part] = part.Color; part.Color = yellowColor; part.Brightness = 5
                elseif part:IsA("Fire") then
                    cmHeritageOriginalColors[part] = part.Color; cmHeritageOriginalBrightness[part] = part.Heat
                    part.Color = yellowColor; part.Heat = 15; part.Size = 5
                elseif part:IsA("Smoke") then cmHeritageOriginalColors[part] = part.Color; part.Color = Color3.new(1, 1, 0.5); part.Opacity = 0.8; part.Size = 3
                elseif part:IsA("Sparkles") then cmHeritageOriginalColors[part] = part.SparkleColor; part.SparkleColor = yellowColor end
            end)
        end
    end
end
--
local function restoreCMHeritageOriginalColors()
    for part, color in pairs(cmHeritageOriginalColors) do
        if part and part.Parent then
            pcall(function()
                if part:IsA("BasePart") or part:IsA("MeshPart") then part.Color = color; part.Material = Enum.Material.Plastic
                elseif part:IsA("PointLight") or part:IsA("SpotLight") then
                    part.Color = color; if cmHeritageOriginalBrightness[part] then part.Brightness = cmHeritageOriginalBrightness[part] end; part.Range = 10
                elseif part:IsA("LensFlare") then part.Color = color; part.Brightness = 2
                elseif part:IsA("Fire") then part.Color = color; if cmHeritageOriginalBrightness[part] then part.Heat = cmHeritageOriginalBrightness[part] end; part.Size = 2
                elseif part:IsA("Smoke") then part.Color = color; part.Opacity = 0.5; part.Size = 1
                elseif part:IsA("Sparkles") then part.SparkleColor = color end
            end)
        end
    end
    for emitter, colors in pairs(cmHeritageOriginalParticleColors) do
        if emitter and emitter.Parent then pcall(function() if colors.Color then emitter.Color = colors.Color end end) end
    end
    cmHeritageOriginalColors = {}; cmHeritageOriginalBrightness = {}; cmHeritageOriginalParticleColors = {}
end
--
local function applyCMHeritageSkin(weapon)
    if not weapon or not cmHeritageModel or cmHeritageIsApplyingSkin then return false end
    cmHeritageIsApplyingSkin = true
    if cmHeritageCurrentSkinClone then pcall(function() cmHeritageCurrentSkinClone:Destroy() end); cmHeritageCurrentSkinClone = nil end
    hideCMHeritageOriginalParts(weapon)
    makeCMPartsYellow(weapon)
    changeCMFireSoundsPlaybackSpeed(weapon, cmHeritageOriginalFireSounds)
    local success = pcall(function()
        local skinClone = cmHeritageModel:Clone()
        removeCMUnwantedParts(skinClone)
        local weaponHandle = weapon:FindFirstChild("Handle")
        if not weaponHandle then
            for _, part in ipairs(weapon:GetDescendants()) do
                if (part:IsA("BasePart") or part:IsA("MeshPart")) and part.Name:lower():find("handle") then weaponHandle = part; break end
            end
            if not weaponHandle then weaponHandle = weapon:FindFirstChildWhichIsA("BasePart") end
        end
        if not weaponHandle then skinClone:Destroy(); return false end
        for _, part in ipairs(skinClone:GetDescendants()) do
            if part:IsA("BasePart") or part:IsA("MeshPart") then
                part.CanCollide = false; part.Anchored = false; part.Massless = true; part.CanTouch = false; part.CastShadow = false; part.CanQuery = false; part.Transparency = 0; part.LocalTransparencyModifier = 0
                if part:IsA("MeshPart") then part.CollisionFidelity = Enum.CollisionFidelity.Box end
            end
        end
        hideCMSpecificParts(skinClone)
        local partsFolder = skinClone:FindFirstChild("parts")
        if partsFolder then for _, meshPart in ipairs(partsFolder:GetDescendants()) do if meshPart:IsA("MeshPart") then meshPart.TextureID = CM_HERITAGE_TEXTURE_ID end end
        else for _, meshPart in ipairs(skinClone:GetDescendants()) do if meshPart:IsA("MeshPart") then meshPart.TextureID = CM_HERITAGE_TEXTURE_ID end end end
        local skinPrimary = nil
        if skinClone:IsA("BasePart") then skinPrimary = skinClone
        else
            if skinClone:IsA("Model") then
                skinPrimary = skinClone.PrimaryPart
                if not skinPrimary then for _, part in ipairs(skinClone:GetDescendants()) do if part:IsA("BasePart") or part:IsA("MeshPart") then skinPrimary = part; break end end end
            else skinPrimary = skinClone:FindFirstChildWhichIsA("BasePart") end
        end
        if skinPrimary then
            skinPrimary.CFrame = weaponHandle.CFrame
            local weld = Instance.new("Weld"); weld.Name = "HeritageSkinWeld"; weld.Part0 = weaponHandle; weld.Part1 = skinPrimary; weld.C0 = CFrame.new(); weld.C1 = CFrame.new(); weld.Parent = skinPrimary
            skinClone.Parent = weapon
            cmHeritageCurrentSkinClone = skinClone; cmHeritageLastWeapon = weapon
            return true
        else skinClone:Destroy(); return false end
    end)
    cmHeritageIsApplyingSkin = false
    return success
end
--
local function removeCMHeritageSkin()
    restoreCMFireSoundsPlaybackSpeed(cmHeritageOriginalFireSounds)
    restoreCMHeritageOriginalColors()
    if cmHeritageCurrentSkinClone then pcall(function() cmHeritageCurrentSkinClone:Destroy() end); cmHeritageCurrentSkinClone = nil end
    restoreCMHeritageOriginalParts()
    cmHeritageLastWeapon = nil
end
--
WOGW фyhkции
local function findAndLoadCMWogwModel()
    if cmWogwModel then return true end
    local foundModel = nil
    local replicatedStorage = game:GetService("ReplicatedStorage")
    local storage = replicatedStorage:FindFirstChild("Storage")
    if storage then
        for _, child in ipairs(storage:GetChildren()) do
            local childName = child.Name:lower()
            if childName == "m4a1_heritage" then foundModel = child; break end
        end
        if not foundModel then
            for _, child in ipairs(storage:GetChildren()) do
                local childName = child.Name:lower()
                if string.find(childName, "heritage") and (string.find(childName, "m4") or string.find(childName, "rifle")) then foundModel = child; break end
            end
        end
    end
    if not foundModel then
        local function searchDeep(container, depth) if depth > 5 then return nil end
            for _, item in ipairs(container:GetChildren()) do
                local itemName = item.Name:lower()
                if itemName == "m4a1_heritage" then return item end
                if #item:GetChildren() > 0 then local result = searchDeep(item, depth + 1); if result then return result end end
            end
            return nil
        end
        foundModel = searchDeep(replicatedStorage, 0)
    end
    if not foundModel then
        local serverStorage = game:GetService("ServerStorage")
        if serverStorage then
            for _, item in ipairs(serverStorage:GetChildren()) do
                local itemName = item.Name:lower()
                if itemName == "m4a1_heritage" then foundModel = item; break end
            end
        end
    end
    if foundModel then
        cmWogwModel = foundModel:Clone()
        for _, part in pairs(cmWogwModel:GetDescendants()) do
            if part:IsA("BasePart") or part:IsA("MeshPart") then
                part.CanCollide = false; part.Anchored = false; part.Massless = true; part.CanTouch = false; part.CastShadow = false; part.CanQuery = false; part.Locked = true; part.Transparency = 0; part.LocalTransparencyModifier = 0
                if part:IsA("MeshPart") then part.CollisionFidelity = Enum.CollisionFidelity.Box end
            end
        end
        if cmWogwModel:IsA("Model") then
            local primaryPart = cmWogwModel.PrimaryPart
            if not primaryPart then for _, part in pairs(cmWogwModel:GetDescendants()) do if part:IsA("BasePart") or part:IsA("MeshPart") then cmWogwModel.PrimaryPart = part; break end end end
        end
    else if cmHeritageModel then cmWogwModel = cmHeritageModel:Clone(); return true end end
    return cmWogwModel ~= nil
end
--
local function hideCMWogwOriginalParts(weapon)
    if not weapon then return end
    cmWogwOriginalPartsTransparency = {}
    local redParts = {"BarrelSmore","FlashEmitter","Gas","Gas2","Lens flare","Muzzle Flash 1","Smoke Emitter","Sparkless"}
    for _, part in ipairs(weapon:GetDescendants()) do
        if (part:IsA("BasePart") or part:IsA("MeshPart")) and part.Transparency < 1 then
            local isRedPart = false
            for _, redPartName in ipairs(redParts) do if part.Name == redPartName then isRedPart = true; break end end
            if not isRedPart then cmWogwOriginalPartsTransparency[part] = part.Transparency; part.Transparency = 1 end
        end
    end
end
--
local function restoreCMWogwOriginalParts()
    for part, transparency in pairs(cmWogwOriginalPartsTransparency) do
        if part and part.Parent then pcall(function() part.Transparency = transparency; part.LocalTransparencyModifier = 0 end) end
    end
    cmWogwOriginalPartsTransparency = {}
end
--
local function makeCMPartsRed(weapon)
    if not weapon then return end
    cmWogwOriginalColors = {}; cmWogwOriginalBrightness = {}; cmWogwOriginalParticleColors = {}
    local redColor = CM_WOGW_RED_COLOR; local brightRed = Color3.fromRGB(255, 100, 100)
    local weaponHandle = weapon:FindFirstChild("WeaponHandle") or weapon:FindFirstChild("Handle")
    if not weaponHandle then return end
    local muzzle = weaponHandle:FindFirstChild("Muzzle"); if not muzzle then return end
    local partsToColor = {"BarrelSmore","FlashEmitter","Gas","Gas2","Lens flare","Muzzle Flash 1","Smoke Emitter","Sparkless"}
    for _, partName in ipairs(partsToColor) do
        local part = muzzle:FindFirstChild(partName)
        if part then
            pcall(function()
                if part:IsA("BasePart") or part:IsA("MeshPart") then
                    cmWogwOriginalColors[part] = part.Color; part.Color = redColor; part.Material = Enum.Material.Neon
                elseif part:IsA("ParticleEmitter") then
                    if part.Color then cmWogwOriginalParticleColors[part] = {Color = part.Color}; part.Color = ColorSequence.new(redColor) end
                elseif part:IsA("PointLight") or part:IsA("SpotLight") then
                    cmWogwOriginalColors[part] = part.Color; cmWogwOriginalBrightness[part] = part.Brightness
                    part.Color = brightRed; part.Brightness = 10; part.Range = 20
                elseif part:IsA("LensFlare") then cmWogwOriginalColors[part] = part.Color; part.Color = redColor; part.Brightness = 5
                elseif part:IsA("Fire") then
                    cmWogwOriginalColors[part] = part.Color; cmWogwOriginalBrightness[part] = part.Heat
                    part.Color = redColor; part.Heat = 15; part.Size = 5
                elseif part:IsA("Smoke") then cmWogwOriginalColors[part] = part.Color; part.Color = Color3.new(1, 0.5, 0.5); part.Opacity = 0.8; part.Size = 3
                elseif part:IsA("Sparkles") then cmWogwOriginalColors[part] = part.SparkleColor; part.SparkleColor = redColor end
            end)
        end
    end
    for _, child in ipairs(muzzle:GetChildren()) do
        if (child:IsA("ParticleEmitter") or child:IsA("Beam") or child:IsA("PointLight") or child:IsA("Sparkles") or child:IsA("Smoke") or child:IsA("Fire")) and not cmWogwOriginalColors[child] and not cmWogwOriginalParticleColors[child] then
            if child:IsA("ParticleEmitter") then cmWogwOriginalParticleColors[child] = {Color = child.Color}; child.Color = ColorSequence.new(redColor)
            elseif child:IsA("Beam") then cmWogwOriginalColors[child] = child.Color; child.Color = ColorSequence.new(redColor)
            elseif child:IsA("PointLight") then
                cmWogwOriginalColors[child] = child.Color; cmWogwOriginalBrightness[child] = child.Brightness
                child.Color = brightRed; child.Brightness = 10
            elseif child:IsA("Sparkles") then cmWogwOriginalColors[child] = child.SparkleColor; child.SparkleColor = redColor
            elseif child:IsA("Smoke") then cmWogwOriginalColors[child] = child.Color; child.Color = Color3.new(1, 0.5, 0.5)
            elseif child:IsA("Fire") then
                cmWogwOriginalColors[child] = child.Color; cmWogwOriginalBrightness[child] = child.Heat
                child.Color = redColor; child.SecondaryColor = redColor end
        end
    end
end
--
local function restoreCMWogwOriginalColors()
    for part, color in pairs(cmWogwOriginalColors) do
        if part and part.Parent then
            pcall(function()
                if part:IsA("BasePart") or part:IsA("MeshPart") then part.Color = color; part.Material = Enum.Material.Plastic
                elseif part:IsA("PointLight") or part:IsA("SpotLight") then
                    part.Color = color; if cmWogwOriginalBrightness[part] then part.Brightness = cmWogwOriginalBrightness[part] end; part.Range = 10
                elseif part:IsA("LensFlare") then part.Color = color; part.Brightness = 2
                elseif part:IsA("Fire") then part.Color = color; if cmWogwOriginalBrightness[part] then part.Heat = cmWogwOriginalBrightness[part] end; part.Size = 2
                elseif part:IsA("Smoke") then part.Color = color; part.Opacity = 0.5; part.Size = 1
                elseif part:IsA("Sparkles") then part.SparkleColor = color
                elseif part:IsA("Beam") then part.Color = color end
            end)
        end
    end
    for emitter, colors in pairs(cmWogwOriginalParticleColors) do
        if emitter and emitter.Parent then pcall(function() if colors.Color then emitter.Color = colors.Color end end) end
    end
    cmWogwOriginalColors = {}; cmWogwOriginalBrightness = {}; cmWogwOriginalParticleColors = {}
end
--
local function applyCMWogwSkin(weapon)
    if not weapon or not cmWogwModel or cmWogwIsApplyingSkin then return false end
    cmWogwIsApplyingSkin = true
    if cmWogwCurrentSkinClone then pcall(function() cmWogwCurrentSkinClone:Destroy() end); cmWogwCurrentSkinClone = nil end
    hideCMWogwOriginalParts(weapon)
    makeCMPartsRed(weapon)
    changeCMFireSoundsPlaybackSpeed(weapon, cmWogwOriginalFireSounds)
    local success = pcall(function()
        local skinClone = cmWogwModel:Clone()
        removeCMUnwantedParts(skinClone)
        local weaponHandle = weapon:FindFirstChild("Handle")
        if not weaponHandle then
            for _, part in ipairs(weapon:GetDescendants()) do
                if (part:IsA("BasePart") or part:IsA("MeshPart")) and part.Name:lower():find("handle") then weaponHandle = part; break end
            end
            if not weaponHandle then weaponHandle = weapon:FindFirstChildWhichIsA("BasePart") end
        end
        if not weaponHandle then skinClone:Destroy(); return false end
        for _, part in ipairs(skinClone:GetDescendants()) do
            if part:IsA("BasePart") or part:IsA("MeshPart") then
                part.CanCollide = false; part.Anchored = false; part.Massless = true; part.CanTouch = false; part.CastShadow = false; part.CanQuery = false; part.Transparency = 0; part.LocalTransparencyModifier = 0
                if part:IsA("MeshPart") then part.CollisionFidelity = Enum.CollisionFidelity.Box end
            end
        end
        hideCMSpecificParts(skinClone)
        local partsFolder = skinClone:FindFirstChild("parts")
        if partsFolder then for _, meshPart in ipairs(partsFolder:GetDescendants()) do if meshPart:IsA("MeshPart") then meshPart.TextureID = CM_WOGW_TEXTURE_ID end end
        else for _, meshPart in ipairs(skinClone:GetDescendants()) do if meshPart:IsA("MeshPart") then meshPart.TextureID = CM_WOGW_TEXTURE_ID end end end
        local skinPrimary = nil
        if skinClone:IsA("BasePart") then skinPrimary = skinClone
        else
            if skinClone:IsA("Model") then
                skinPrimary = skinClone.PrimaryPart
                if not skinPrimary then for _, part in ipairs(skinClone:GetDescendants()) do if part:IsA("BasePart") or part:IsA("MeshPart") then skinPrimary = part; break end end end
            else skinPrimary = skinClone:FindFirstChildWhichIsA("BasePart") end
        end
        if skinPrimary then
            skinPrimary.CFrame = weaponHandle.CFrame
            local weld = Instance.new("Weld"); weld.Name = "WOGWSkinWeld"; weld.Part0 = weaponHandle; weld.Part1 = skinPrimary; weld.C0 = CFrame.new(); weld.C1 = CFrame.new(); weld.Parent = skinPrimary
            skinClone.Parent = weapon; cmWogwCurrentSkinClone = skinClone; cmWogwLastWeapon = weapon
            return true
        else skinClone:Destroy(); return false end
    end)
    cmWogwIsApplyingSkin = false
    return success
end
--
local function removeCMWogwSkin()
    restoreCMFireSoundsPlaybackSpeed(cmWogwOriginalFireSounds)
    restoreCMWogwOriginalColors()
    if cmWogwCurrentSkinClone then pcall(function() cmWogwCurrentSkinClone:Destroy() end); cmWogwCurrentSkinClone = nil end
    restoreCMWogwOriginalParts()
    cmWogwLastWeapon = nil
end
--
OPM фyhkции
local function findAndLoadCMOpmModel()
    if cmOpmModel then return true end
    local foundModel = nil
    local replicatedStorage = game:GetService("ReplicatedStorage")
    local storage = replicatedStorage:FindFirstChild("Storage")
    if storage then
        for _, child in ipairs(storage:GetChildren()) do
            local childName = child.Name:lower()
            if childName == "m4a1_opm" then foundModel = child; break end
        end
        if not foundModel then
            for _, child in ipairs(storage:GetChildren()) do
                local childName = child.Name:lower()
                if string.find(childName, "opm") and (string.find(childName, "m4") or string.find(childName, "rifle")) then foundModel = child; break end
            end
        end
    end
    if not foundModel then
        local function searchDeep(container, depth) if depth > 5 then return nil end
            for _, item in ipairs(container:GetChildren()) do
                local itemName = item.Name:lower()
                if itemName == "m4a1_opm" then return item end
                if #item:GetChildren() > 0 then local result = searchDeep(item, depth + 1); if result then return result end end
            end
            return nil
        end
        foundModel = searchDeep(replicatedStorage, 0)
    end
    if not foundModel then
        local serverStorage = game:GetService("ServerStorage")
        if serverStorage then
            for _, item in ipairs(serverStorage:GetChildren()) do
                local itemName = item.Name:lower()
                if itemName == "m4a1_opm" then foundModel = item; break end
            end
        end
    end
    if foundModel then
        cmOpmModel = foundModel:Clone()
        for _, descendant in pairs(cmOpmModel:GetDescendants()) do
            if descendant:IsA("Sound") then descendant:Destroy()
            elseif descendant:IsA("ParticleEmitter") or descendant:IsA("Fire") or descendant:IsA("Smoke") or descendant:IsA("Sparkles") then descendant:Destroy()
            elseif descendant:IsA("Beam") then descendant:Destroy()
            elseif descendant:IsA("PointLight") or descendant:IsA("SpotLight") then descendant:Destroy()
            elseif descendant:IsA("Script") or descendant:IsA("LocalScript") then descendant:Destroy() end
            if descendant:IsA("BasePart") or descendant:IsA("MeshPart") then
                descendant.CanCollide = false; descendant.Anchored = false; descendant.Massless = true; descendant.CanTouch = false; descendant.CastShadow = false; descendant.CanQuery = false; descendant.Locked = true; descendant.Transparency = 0; descendant.LocalTransparencyModifier = 0
                if descendant:IsA("MeshPart") then descendant.CollisionFidelity = Enum.CollisionFidelity.Box end
            end
        end
        if cmOpmModel:IsA("Model") then
            local primaryPart = cmOpmModel.PrimaryPart
            if not primaryPart then for _, part in pairs(cmOpmModel:GetDescendants()) do if part:IsA("BasePart") or part:IsA("MeshPart") then cmOpmModel.PrimaryPart = part; break end end end
        end
    end
    return cmOpmModel ~= nil
end
--
local function hideCMOpmOriginalParts(weapon)
    if not weapon then return end
    cmOpmOriginalPartsTransparency = {}
    for _, part in ipairs(weapon:GetDescendants()) do
        if (part:IsA("BasePart") or part:IsA("MeshPart")) and part.Transparency < 1 then
            cmOpmOriginalPartsTransparency[part] = part.Transparency
            part.Transparency = 1
        end
    end
end
--
local function restoreCMOpmOriginalParts()
    for part, transparency in pairs(cmOpmOriginalPartsTransparency) do
        if part and part.Parent then pcall(function() part.Transparency = transparency end) end
    end
    cmOpmOriginalPartsTransparency = {}
end
--
local function removeCMOpmUnwantedParts(model)
    if not model then return end
    local partsToRemove = {"OpticPart","SuppressorPart","LaserPart","UpperRailPart"}
    for _, partName in ipairs(partsToRemove) do
        local part = model:FindFirstChild(partName, true)
        if part then pcall(function() part:Destroy() end) end
    end
end
--
local function applyCMOpmTextures(model)
    if not model then return end
    for _, descendant in ipairs(model:GetDescendants()) do
        if descendant:IsA("MeshPart") then
            local descendantName = descendant.Name:lower()
            local isWing = false
            local wingKeywords = {"wing","wingpart","wings","wingspart"}
            for _, keyword in ipairs(wingKeywords) do if string.find(descendantName, keyword) then isWing = true; break end end
            if isWing then descendant.TextureID = CM_WINGS_TEXTURE_ID else descendant.TextureID = CM_M4A1_TEXTURE_ID end
        end
    end
    local function checkSpecialParts(parent)
        for _, child in ipairs(parent:GetChildren()) do
            local childName = child.Name:lower()
            if string.find(childName, "wing") then if child:IsA("Model") or child:IsA("Folder") then checkSpecialParts(child) end end
            if child:IsA("MeshPart") and child.TextureID == "" then child.TextureID = CM_M4A1_TEXTURE_ID end
        end
    end
    checkSpecialParts(model)
end
--
local function applyCMOpmSkin(weapon)
    if not weapon or not cmOpmModel or cmOpmIsApplyingSkin then return false end
    cmOpmIsApplyingSkin = true
    if cmOpmCurrentSkinClone then pcall(function() cmOpmCurrentSkinClone:Destroy() end); cmOpmCurrentSkinClone = nil end
    local success = pcall(function()
        local skinClone = cmOpmModel:Clone()
        removeCMOpmUnwantedParts(skinClone)
        applyCMOpmTextures(skinClone)
        local weaponHandle = weapon:FindFirstChild("Handle")
        if not weaponHandle then
            for _, part in ipairs(weapon:GetDescendants()) do
                if (part:IsA("BasePart") or part:IsA("MeshPart")) and part.Name:lower():find("handle") then weaponHandle = part; break end
            end
            if not weaponHandle then weaponHandle = weapon:FindFirstChildWhichIsA("BasePart") end
        end
        if not weaponHandle then skinClone:Destroy(); return false end
        for _, part in ipairs(skinClone:GetDescendants()) do
            if part:IsA("BasePart") or part:IsA("MeshPart") then
                part.CanCollide = false; part.Anchored = false; part.Massless = true; part.CanTouch = false; part.CastShadow = false; part.CanQuery = false; part.Transparency = 0; part.LocalTransparencyModifier = 0
                if part:IsA("MeshPart") then part.CollisionFidelity = Enum.CollisionFidelity.Box end
            end
        end
        local skinPrimary = nil
        if skinClone:IsA("BasePart") then skinPrimary = skinClone
        else
            if skinClone:IsA("Model") then
                skinPrimary = skinClone.PrimaryPart
                if not skinPrimary then for _, part in ipairs(skinClone:GetDescendants()) do if part:IsA("BasePart") or part:IsA("MeshPart") then skinPrimary = part; break end end end
            else skinPrimary = skinClone:FindFirstChildWhichIsA("BasePart") end
        end
        if skinPrimary then
            skinPrimary.CFrame = weaponHandle.CFrame
            local weld = Instance.new("Weld"); weld.Name = "OPMSkinWeld"; weld.Part0 = weaponHandle; weld.Part1 = skinPrimary; weld.C0 = CFrame.new(); weld.C1 = CFrame.new(); weld.Parent = skinPrimary
            skinClone.Parent = weapon; cmOpmCurrentSkinClone = skinClone; cmOpmLastWeapon = weapon
            return true
        else skinClone:Destroy(); return false end
    end)
    cmOpmIsApplyingSkin = false
    return success
end
--
local function removeCMOpmSkin()
    if cmOpmCurrentSkinClone then pcall(function() cmOpmCurrentSkinClone:Destroy(); cmOpmCurrentSkinClone = nil end) end
    restoreCMOpmOriginalParts()
    cmOpmLastWeapon = nil
end
--
Showdown фyhkции
local function cleanCMShowdownSkinTextures(model)
    if not model then return end
--
    for _, descendant in ipairs(model:GetDescendants()) do
        if descendant.Name == "MagnumSkinTexture" then
            descendant:Destroy()
        end
    end
end
--
local function applyCMSurfaceAppearanceToPart(part, textureId)
    if not part then return end
--
    if part.Transparency == 1 or part.LocalTransparencyModifier == 1 then
        return
    end
--
    if part.Name == "OverlayPart" or part.Name == "L1" then
        return
    end
--
    for _, child in ipairs(part:GetChildren()) do
        if child:IsA("SurfaceAppearance") then
            child:Destroy()
        end
    end
--
    local surfaceAppearance = Instance.new("SurfaceAppearance")
    surfaceAppearance.Name = "MagnumSurfaceAppearance"
    surfaceAppearance.ColorMap = textureId or CM_SHOWDOWN_TEXTURE_ID
    surfaceAppearance.Parent = part
--
    part.Material = Enum.Material.SmoothPlastic
    part.Color = Color3.fromRGB(255, 255, 255)
end
--
local function processCMShowdownSpecialParts(model)
    if not model then return end
--
    for _, descendant in ipairs(model:GetDescendants()) do
        if (descendant:IsA("BasePart") or descendant:IsA("MeshPart")) and 
           (descendant.Name == "OverlayPart" or descendant.Name == "L1") then
--
            for _, child in ipairs(descendant:GetChildren()) do
                if child:IsA("SurfaceAppearance") then
                    child:Destroy()
                end
            end
--
            descendant.Material = Enum.Material.Neon
            descendant.Color = CM_GHOST_GREY_COLOR
            descendant.Transparency = 0
            descendant.LocalTransparencyModifier = 0
        end
    end
end
--
local function loadCMShowdownModel()
    local success = pcall(function()
        local targetName = "magnum_ind"
--
        local searchLocations = {
            game:GetService("ReplicatedStorage"),
            game:GetService("ServerStorage"),
            game:GetService("Workspace")
        }
--
        local storage = game:GetService("ReplicatedStorage"):FindFirstChild("Storage")
        if storage then
            for _, child in ipairs(storage:GetChildren()) do
                if string.lower(child.Name) == targetName then
                    cmShowdownModel = child:Clone()
--
                    cleanCMShowdownSkinTextures(cmShowdownModel)
--
                    for _, part in ipairs(cmShowdownModel:GetDescendants()) do
                        if (part:IsA("BasePart") or part:IsA("MeshPart")) and part.Transparency < 1 then
                            applyCMSurfaceAppearanceToPart(part)
                        end
                    end
--
                    processCMShowdownSpecialParts(cmShowdownModel)
                    return true
                end
            end
        end
--
        for _, location in ipairs(searchLocations) do
            if location then
                local function searchInContainer(container, depth)
                    if depth > 3 then return false end
--
                    for _, item in ipairs(container:GetChildren()) do
                        if string.lower(item.Name) == targetName then
                            if item:IsA("Model") or item:IsA("BasePart") or item:IsA("MeshPart") then
                                cmShowdownModel = item:Clone()
--
                                cleanCMShowdownSkinTextures(cmShowdownModel)
--
                                for _, part in ipairs(cmShowdownModel:GetDescendants()) do
                                    if (part:IsA("BasePart") or part:IsA("MeshPart")) and part.Transparency < 1 then
                                        applyCMSurfaceAppearanceToPart(part)
                                    end
                                end
--
                                processCMShowdownSpecialParts(cmShowdownModel)
                                return true
                            end
                        end
--
                        if #item:GetChildren() > 0 then
                            if searchInContainer(item, depth + 1) then
                                return true
                            end
                        end
                    end
                    return false
                end
--
                if searchInContainer(location, 0) then
                    return true
                end
            end
        end
        return false
    end)
--
    if success and cmShowdownModel then
        for _, obj in ipairs(cmShowdownModel:GetDescendants()) do
            if obj:IsA("BasePart") or obj:IsA("MeshPart") then
                obj.CanCollide = false
                obj.Massless = true
                obj.CastShadow = false
                obj.CanQuery = false
                obj.Transparency = 0
                obj.LocalTransparencyModifier = 0
--
                if obj:IsA("MeshPart") then
                    obj.CollisionFidelity = Enum.CollisionFidelity.Box
                end
            end
        end
        return true
    else
        return false
    end
end
--
local function hideCMShowdownOriginalParts(weapon)
    if not weapon then return end
--
    cmShowdownOriginalPartsTransparency = {}
--
    for _, part in ipairs(weapon:GetDescendants()) do
        if (part:IsA("BasePart") or part:IsA("MeshPart")) and part.Transparency < 1 then
            cmShowdownOriginalPartsTransparency[part] = part.Transparency
            part.Transparency = 1
        end
    end
end
--
local function restoreCMShowdownOriginalParts()
    for part, transparency in pairs(cmShowdownOriginalPartsTransparency) do
        if part and part.Parent then
            pcall(function()
                part.Transparency = transparency
                part.LocalTransparencyModifier = 0
            end)
        end
    end
    cmShowdownOriginalPartsTransparency = {}
end
--
local function hideCMShowdownSpecificPartsInSkin(model)
    if not model then return end
--
    local partsToHide = {
        "BulletRealPart", "BulletsReal",
        "Hammer",
        "HandlePart", "Handle",
        "Thing", "ThingPart",
        "DrumPart", "Drumpart",
        "SouvenirPart",
        "WeaponHandle"
    }
--
    local hideTable = {}
    for _, name in ipairs(partsToHide) do
        hideTable[name:lower()] = true
    end
--
    local function processObject(obj)
        if obj:IsA("BasePart") or obj:IsA("MeshPart") then
            if hideTable[obj.Name:lower()] then
                pcall(function()
                    obj.Transparency = 1
                    obj.LocalTransparencyModifier = 1
                end)
            end
        end
--
        for _, child in ipairs(obj:GetChildren()) do
            processObject(child)
        end
    end
--
    processObject(model)
end
--
local function modifyCMShowdownWeaponSounds(weapon)
    if not weapon then return end
--
    cmShowdownOriginalSoundEffects = {}
--
    for _, descendant in ipairs(weapon:GetDescendants()) do
        if descendant:IsA("Sound") then
            local soundName = descendant.Name:lower()
--
            if soundName == "firesound1" or soundName == "firesound2" or soundName == "firesound3" then
                cmShowdownOriginalSoundEffects[descendant] = {
                    PlaybackSpeed = descendant.PlaybackSpeed,
                    SoundId = descendant.SoundId
                }
                descendant.PlaybackSpeed = 0.9
            end
        end
    end
--
    local weaponHandle = weapon:FindFirstChild("WeaponHandle") or weapon:FindFirstChild("Handle")
    if not weaponHandle then return end
--
    local muzzle = weaponHandle:FindFirstChild("Muzzle")
    if not muzzle then
        muzzle = Instance.new("Part")
        muzzle.Name = "Muzzle"
        muzzle.Size = Vector3.new(0.2, 0.2, 0.2)
        muzzle.Transparency = 1
        muzzle.CanCollide = false
        muzzle.CanTouch = false
        muzzle.Anchored = false
        muzzle.Massless = true
        muzzle.Parent = weaponHandle
--
        local weld = Instance.new("Weld")
        weld.Part0 = weaponHandle
        weld.Part1 = muzzle
        weld.C0 = CFrame.new(0, 0, 1.5)
        weld.Parent = muzzle
    end
--
    local existingSound = muzzle:FindFirstChild("FFireSoundTWO")
    if existingSound then
        existingSound:Destroy()
    end
--
    local randomSoundId = CM_FIRE_SOUND_IDS[math.random(1, #CM_FIRE_SOUND_IDS)]
--
    local newFireSound = Instance.new("Sound")
    newFireSound.Name = "FFireSoundTWO"
    newFireSound.SoundId = randomSoundId
    newFireSound.Volume = 1
    newFireSound.MaxDistance = 500
    newFireSound.RollOffMode = Enum.RollOffMode.InverseTapered
    newFireSound.PlaybackSpeed = 1
    newFireSound.Looped = false
    newFireSound.Parent = muzzle
--
    local equalizer = Instance.new("EqualizerSoundEffect")
    equalizer.HighGain = 0
    equalizer.MidGain = 0
    equalizer.LowGain = 0
    equalizer.Enabled = true
    equalizer.Parent = newFireSound
--
    cmShowdownOriginalSoundEffects[newFireSound] = true
--
    task.spawn(function()
        while true do
            task.wait(0.1)
            if not newFireSound or not newFireSound.Parent then break end
--
            if not newFireSound.IsPlaying then
                local newRandomSoundId = CM_FIRE_SOUND_IDS[math.random(1, #CM_FIRE_SOUND_IDS)]
                if newFireSound.SoundId ~= newRandomSoundId then
                    newFireSound.SoundId = newRandomSoundId
                end
            end
        end
    end)
end
--
local function removeCMShowdownModifiedSounds()
    for sound, _ in pairs(cmShowdownOriginalSoundEffects) do
        if sound and sound.Parent then
            pcall(function()
                if sound.Name == "FFireSoundTWO" then
                    sound:Destroy()
                elseif sound.Name:lower():find("firesound") then
                    local originalData = cmShowdownOriginalSoundEffects[sound]
                    if originalData and type(originalData) == "table" then
                        sound.PlaybackSpeed = originalData.PlaybackSpeed
                    end
                end
            end)
        end
    end
    cmShowdownOriginalSoundEffects = {}
--
    local player = game.Players.LocalPlayer
    if player and player.Character then
        for _, tool in ipairs(player.Character:GetChildren()) do
            if tool:IsA("Tool") then
                local weaponHandle = tool:FindFirstChild("WeaponHandle") or tool:FindFirstChild("Handle")
                if weaponHandle then
                    local muzzle = weaponHandle:FindFirstChild("Muzzle")
                    if muzzle then
                        local sound = muzzle:FindFirstChild("FFireSoundTWO")
                        if sound then
                            pcall(function()
                                sound:Destroy()
                            end)
                        end
                    end
                end
            end
        end
    end
end
--
local function applyCMShowdownTextureToModel(model, isSteeldown)
    if not model then return end
--
    for _, descendant in ipairs(model:GetDescendants()) do
        if descendant:IsA("MeshPart") then
            local descendantName = descendant.Name:lower()
            if descendantName ~= "overlaypart" and descendantName ~= "l1" then
                if descendant:FindFirstChildOfClass("SurfaceAppearance") then
                    for _, surfaceApp in ipairs(descendant:GetChildren()) do
                        if surfaceApp:IsA("SurfaceAppearance") then
                            surfaceApp.ColorMap = isSteeldown and CM_STEELDOWN_TEXTURE_ID or CM_SHOWDOWN_TEXTURE_ID
                        end
                    end
                else
                    descendant.TextureID = isSteeldown and CM_STEELDOWN_TEXTURE_ID or CM_SHOWDOWN_TEXTURE_ID
                end
            end
        end
    end
end
--
local function applyCMShowdownSkin(weapon, isSteeldown)
    if not weapon or not cmShowdownModel or cmShowdownIsApplyingSkin then return false end
--
    cmShowdownIsApplyingSkin = true
--
    if cmShowdownCurrentSkinClone then
        pcall(function() cmShowdownCurrentSkinClone:Destroy() end)
        cmShowdownCurrentSkinClone = nil
    end
--
    removeCMShowdownModifiedSounds()
    hideCMShowdownOriginalParts(weapon)
--
    local success = pcall(function()
        modifyCMShowdownWeaponSounds(weapon)
--
        local skinClone = cmShowdownModel:Clone()
        hideCMShowdownSpecificPartsInSkin(skinClone)
        applyCMShowdownTextureToModel(skinClone, isSteeldown)
--
        local weaponHandle = weapon:FindFirstChild("Handle")
        if not weaponHandle then
            weaponHandle = weapon:FindFirstChildWhichIsA("BasePart")
        end
--
        if not weaponHandle then
            skinClone:Destroy()
            cmShowdownIsApplyingSkin = false
            return false
        end
--
        for _, part in ipairs(skinClone:GetDescendants()) do
            if part:IsA("BasePart") or part:IsA("MeshPart") then
                part.CanCollide = false
                part.Anchored = false
                part.Massless = true
                part.CanTouch = false
                part.CastShadow = false
                part.CanQuery = false
--
                if part.Transparency == 1 then
                    part.LocalTransparencyModifier = 1
                else
                    part.Transparency = 0
                    part.LocalTransparencyModifier = 0
                end
--
                if part:IsA("MeshPart") then
                    part.CollisionFidelity = Enum.CollisionFidelity.Box
                end
            end
        end
--
        local skinPrimary = nil
        if skinClone:IsA("BasePart") then
            skinPrimary = skinClone
        else
            if skinClone:IsA("Model") then
                skinPrimary = skinClone.PrimaryPart
                if not skinPrimary then
                    for _, part in ipairs(skinClone:GetDescendants()) do
                        if part:IsA("BasePart") or part:IsA("MeshPart") and part.Transparency < 1 then
                            skinPrimary = part
                            break
                        end
                    end
                end
            else
                skinPrimary = skinClone:FindFirstChildWhichIsA("BasePart")
            end
        end
--
        if skinPrimary then
            skinPrimary.CFrame = weaponHandle.CFrame
--
            local weld = Instance.new("Weld")
            weld.Name = "ShowdownSkinWeld"
            weld.Part0 = weaponHandle
            weld.Part1 = skinPrimary
            weld.C0 = CFrame.new()
            weld.C1 = CFrame.new()
            weld.Parent = skinPrimary
--
            skinClone.Parent = weapon
            cmShowdownCurrentSkinClone = skinClone
            cmShowdownLastWeapon = weapon
            cmShowdownIsApplyingSkin = false
            return true
        else
            skinClone:Destroy()
            cmShowdownIsApplyingSkin = false
            return false
        end
    end)
--
    if not success then
        cmShowdownIsApplyingSkin = false
    end
--
    return success
end
--
local function removeCMShowdownSkin()
    removeCMShowdownModifiedSounds()
--
    if cmShowdownCurrentSkinClone then
        pcall(function()
            cmShowdownCurrentSkinClone:Destroy()
        end)
        cmShowdownCurrentSkinClone = nil
    end
--
    restoreCMShowdownOriginalParts()
--
    cmShowdownLastWeapon = nil
end
--
Eros фyhkции
local function cleanCMErosSkinTextures(model)
    if not model then return end
    for _, descendant in ipairs(model:GetDescendants()) do if descendant.Name == "SawnoffSkinTexture" then descendant:Destroy() end end
end
--
local function applyCMErosSurfaceAppearanceToPart(part)
    if not part then return end
    if part.Name == "GlowPart" or part.Name == "WeaponHandle" or part.Name == "HandlePart" then part.Transparency = 1; part.LocalTransparencyModifier = 1; return end
    if part.Transparency == 1 or part.LocalTransparencyModifier == 1 then return end
    for _, child in ipairs(part:GetChildren()) do if child:IsA("SurfaceAppearance") then child:Destroy() end end
    local surfaceAppearance = Instance.new("SurfaceAppearance")
    surfaceAppearance.Name = "SawnoffSurfaceAppearance"
    surfaceAppearance.ColorMap = CM_EROS_TEXTURE_ID
    surfaceAppearance.Parent = part
    part.Material = Enum.Material.SmoothPlastic
    part.Color = Color3.fromRGB(255, 255, 255)
end
--
local function modifyCMErosGlowParts(model)
    if not model then return end
    local partsToHide = {"GlowPart","WeaponHandle","HandlePart"}
    for _, partName in ipairs(partsToHide) do
        local part = model:FindFirstChild(partName)
        if part and (part:IsA("BasePart") or part:IsA("MeshPart")) then
            part.Transparency = 1; part.LocalTransparencyModifier = 1
            for _, child in ipairs(part:GetChildren()) do
                if child:IsA("PointLight") then child.Enabled = false
                elseif child:IsA("ParticleEmitter") then child.Enabled = false
                elseif child:IsA("Beam") then child.Enabled = false
                elseif child:IsA("SurfaceAppearance") then child:Destroy() end
            end
        end
    end
end
--
local function loadCMErosModel()
    local success = pcall(function()
        local targetName = "sawnoff_eros"
        local searchLocations = {game:GetService("ReplicatedStorage"),game:GetService("ServerStorage"),game:GetService("Workspace")}
        local storage = game:GetService("ReplicatedStorage"):FindFirstChild("Storage")
        if storage then
            for _, child in ipairs(storage:GetChildren()) do
                if string.lower(child.Name) == targetName then
                    cmErosModel = child:Clone()
                    cleanCMErosSkinTextures(cmErosModel)
                    for _, part in ipairs(cmErosModel:GetDescendants()) do
                        if (part:IsA("BasePart") or part:IsA("MeshPart")) and part.Transparency < 1 then applyCMErosSurfaceAppearanceToPart(part) end
                    end
                    modifyCMErosGlowParts(cmErosModel)
                    return true
                end
            end
        end
        for _, location in ipairs(searchLocations) do
            if location then
                local function searchInContainer(container, depth) if depth > 3 then return false end
                    for _, item in ipairs(container:GetChildren()) do
                        if string.lower(item.Name) == targetName then
                            if item:IsA("Model") or item:IsA("BasePart") or item:IsA("MeshPart") then
                                cmErosModel = item:Clone()
                                cleanCMErosSkinTextures(cmErosModel)
                                for _, part in ipairs(cmErosModel:GetDescendants()) do
                                    if (part:IsA("BasePart") or part:IsA("MeshPart")) and part.Transparency < 1 then applyCMErosSurfaceAppearanceToPart(part) end
                                end
                                modifyCMErosGlowParts(cmErosModel)
                                return true
                            end
                        end
                        if #item:GetChildren() > 0 then if searchInContainer(item, depth + 1) then return true end end
                    end
                    return false
                end
                if searchInContainer(location, 0) then return true end
            end
        end
        return false
    end)
    if success and cmErosModel then
        for _, obj in ipairs(cmErosModel:GetDescendants()) do
            if obj:IsA("BasePart") or obj:IsA("MeshPart") then
                obj.CanCollide = false; obj.Massless = true; obj.CastShadow = false; obj.CanQuery = false
                if obj.Name == "GlowPart" or obj.Name == "WeaponHandle" or obj.Name == "HandlePart" then
                    obj.Transparency = 1; obj.LocalTransparencyModifier = 1
                else obj.Transparency = 0; obj.LocalTransparencyModifier = 0 end
                if obj:IsA("MeshPart") then obj.CollisionFidelity = Enum.CollisionFidelity.Box end
            end
        end
        return true
    else return false end
end
--
local function hideCMErosOriginalParts(weapon)
    if not weapon then return end
    cmErosOriginalPartsTransparency = {}
    for _, part in ipairs(weapon:GetDescendants()) do
        if (part:IsA("BasePart") or part:IsA("MeshPart")) and part.Transparency < 1 then
            cmErosOriginalPartsTransparency[part] = part.Transparency
            part.Transparency = 1
            part.LocalTransparencyModifier = 1
        end
    end
end
--
local function restoreCMErosOriginalParts()
    for part, transparency in pairs(cmErosOriginalPartsTransparency) do
        if part and part.Parent then pcall(function() part.Transparency = transparency; part.LocalTransparencyModifier = 0 end) end
    end
    cmErosOriginalPartsTransparency = {}
end
--
local function changeCMEffectsToPink(weapon)
    if not weapon then return end
    local weaponHandle = weapon:FindFirstChild("WeaponHandle") or weapon:FindFirstChild("Handle")
    if not weaponHandle then return end
    local muzzle = weaponHandle:FindFirstChild("Muzzle")
    if not muzzle then return end
    local effectNames = {"Barrel Smoke","FlashEmitter","Gas","Gas2","Lens Flare","Muzzle Flash 1","SmokeEmitter","Sparkles"}
    cmErosOriginalEffectsProperties = {}
    for _, effectName in ipairs(effectNames) do
        local effect = muzzle:FindFirstChild(effectName)
        if effect then
            cmErosOriginalEffectsProperties[effect] = {}
            if effect:IsA("ParticleEmitter") then
                cmErosOriginalEffectsProperties[effect].Color = effect.Color
                effect.Color = ColorSequence.new(CM_EROS_PINK_COLOR)
            elseif effect:IsA("Beam") then
                cmErosOriginalEffectsProperties[effect].Color = effect.Color
                effect.Color = ColorSequence.new(CM_EROS_PINK_COLOR)
            elseif effect:IsA("PointLight") then
                cmErosOriginalEffectsProperties[effect].Color = effect.Color
                effect.Color = CM_EROS_PINK_COLOR
            elseif effect:IsA("Sparkles") then
                cmErosOriginalEffectsProperties[effect].SparkleColor = effect.SparkleColor
                effect.SparkleColor = CM_EROS_PINK_COLOR
            elseif effect:IsA("Smoke") then
                cmErosOriginalEffectsProperties[effect].Color = effect.Color
                effect.Color = Color3.new(1, 0.7, 0.9)
            elseif effect:IsA("Fire") then
                cmErosOriginalEffectsProperties[effect].Color = effect.Color
                cmErosOriginalEffectsProperties[effect].SecondaryColor = effect.SecondaryColor
                effect.Color = CM_EROS_PINK_COLOR
                effect.SecondaryColor = CM_EROS_PINK_COLOR
            end
        end
    end
    for _, child in ipairs(muzzle:GetChildren()) do
        if (child:IsA("ParticleEmitter") or child:IsA("Beam") or child:IsA("PointLight") or child:IsA("Sparkles") or child:IsA("Smoke") or child:IsA("Fire")) and not cmErosOriginalEffectsProperties[child] then
            cmErosOriginalEffectsProperties[child] = {}
            if child:IsA("ParticleEmitter") then
                cmErosOriginalEffectsProperties[child].Color = child.Color
                child.Color = ColorSequence.new(CM_EROS_PINK_COLOR)
            elseif child:IsA("Beam") then
                cmErosOriginalEffectsProperties[child].Color = child.Color
                child.Color = ColorSequence.new(CM_EROS_PINK_COLOR)
            elseif child:IsA("PointLight") then
                cmErosOriginalEffectsProperties[child].Color = child.Color
                child.Color = CM_EROS_PINK_COLOR
            elseif child:IsA("Sparkles") then
                cmErosOriginalEffectsProperties[child].SparkleColor = child.SparkleColor
                child.SparkleColor = CM_EROS_PINK_COLOR
            elseif child:IsA("Smoke") then
                cmErosOriginalEffectsProperties[child].Color = child.Color
                child.Color = Color3.new(1, 0.7, 0.9)
            elseif child:IsA("Fire") then
                cmErosOriginalEffectsProperties[child].Color = child.Color
                cmErosOriginalEffectsProperties[child].SecondaryColor = child.SecondaryColor
                child.Color = CM_EROS_PINK_COLOR
                child.SecondaryColor = CM_EROS_PINK_COLOR
            end
        end
    end
end
--
local function restoreCMErosOriginalEffects()
    for effect, properties in pairs(cmErosOriginalEffectsProperties) do
        if effect and effect.Parent then
            pcall(function()
                if properties.Color then effect.Color = properties.Color end
                if properties.SparkleColor then effect.SparkleColor = properties.SparkleColor end
                if properties.SecondaryColor then effect.SecondaryColor = properties.SecondaryColor end
            end)
        end
    end
    cmErosOriginalEffectsProperties = {}
end
--
local function hideCMErosSpecificPartsInSkin(model)
    if not model then return end
    local partsToHide = {"GlowPart","WeaponHandle","HandlePart"}
    for _, partName in ipairs(partsToHide) do
        local part = model:FindFirstChild(partName, true)
        if part and (part:IsA("BasePart") or part:IsA("MeshPart")) then pcall(function() part.Transparency = 1; part.LocalTransparencyModifier = 1 end) end
    end
end
--
local function applyCMErosSkin(weapon)
    if not weapon or not cmErosModel or cmErosIsApplyingSkin then return false end
    cmErosIsApplyingSkin = true
    if cmErosCurrentSkinClone then pcall(function() cmErosCurrentSkinClone:Destroy() end); cmErosCurrentSkinClone = nil end
    hideCMErosOriginalParts(weapon)
    changeCMEffectsToPink(weapon)
    local success = pcall(function()
        local skinClone = cmErosModel:Clone()
        hideCMErosSpecificPartsInSkin(skinClone)
        local weaponHandle = weapon:FindFirstChild("Handle")
        if not weaponHandle then weaponHandle = weapon:FindFirstChildWhichIsA("BasePart") end
        if not weaponHandle then skinClone:Destroy(); cmErosIsApplyingSkin = false; return false end
        for _, part in ipairs(skinClone:GetDescendants()) do
            if part:IsA("BasePart") or part:IsA("MeshPart") then
                part.CanCollide = false; part.Anchored = false; part.Massless = true; part.CanTouch = false; part.CastShadow = false; part.CanQuery = false
                if part.Name == "GlowPart" or part.Name == "WeaponHandle" or part.Name == "HandlePart" then
                    part.Transparency = 1; part.LocalTransparencyModifier = 1
                else
                    if part.Transparency == 1 then part.LocalTransparencyModifier = 1 else part.Transparency = 0; part.LocalTransparencyModifier = 0 end
                end
                if part:IsA("MeshPart") then part.CollisionFidelity = Enum.CollisionFidelity.Box end
            end
        end
        local skinPrimary = nil
        if skinClone:IsA("BasePart") then skinPrimary = skinClone
        else
            if skinClone:IsA("Model") then
                skinPrimary = skinClone.PrimaryPart
                if not skinPrimary then for _, part in ipairs(skinClone:GetDescendants()) do if part:IsA("BasePart") or part:IsA("MeshPart") and part.Transparency < 1 then skinPrimary = part; break end end end
            else skinPrimary = skinClone:FindFirstChildWhichIsA("BasePart") end
        end
        if skinPrimary then
            skinPrimary.CFrame = weaponHandle.CFrame
            local weld = Instance.new("Weld"); weld.Name = "SawnoffErosSkinWeld"; weld.Part0 = weaponHandle; weld.Part1 = skinPrimary; weld.C0 = CFrame.new(); weld.C1 = CFrame.new(); weld.Parent = skinPrimary
            skinClone.Parent = weapon; cmErosCurrentSkinClone = skinClone; cmErosLastWeapon = weapon; cmErosIsApplyingSkin = false
            return true
        else skinClone:Destroy(); cmErosIsApplyingSkin = false; return false end
    end)
    if not success then cmErosIsApplyingSkin = false end
    return success
end
--
local function removeCMErosSkin()
    restoreCMErosOriginalEffects()
    if cmErosCurrentSkinClone then pcall(function() cmErosCurrentSkinClone:Destroy(); cmErosCurrentSkinClone = nil end) end
    restoreCMErosOriginalParts()
    cmErosLastWeapon = nil
end
--
Mare фyhkции (TrickShot & White)
local function loadCMMareModel()
    local success = pcall(function()
        local targetName = "mare_trickshot"
--
        local searchLocations = {
            game:GetService("ReplicatedStorage"),
            game:GetService("ServerStorage"),
            game:GetService("Workspace")
        }
--
        local storage = game:GetService("ReplicatedStorage"):FindFirstChild("Storage")
        if storage then
            for _, child in ipairs(storage:GetChildren()) do
                if string.lower(child.Name) == targetName then
                    cmMareModel = child:Clone()
                    return true
                end
            end
        end
--
        for _, location in ipairs(searchLocations) do
            if location then
                local function searchInContainer(container, depth)
                    if depth > 3 then return false end
--
                    for _, item in ipairs(container:GetChildren()) do
                        if string.lower(item.Name) == targetName then
                            if item:IsA("Model") or item:IsA("BasePart") or item:IsA("MeshPart") then
                                cmMareModel = item:Clone()
                                return true
                            end
                        end
--
                        if #item:GetChildren() > 0 then
                            if searchInContainer(item, depth + 1) then
                                return true
                            end
                        end
                    end
                    return false
                end
--
                if searchInContainer(location, 0) then
                    return true
                end
            end
        end
--
        return false
    end)
--
    if success and cmMareModel then
        for _, obj in ipairs(cmMareModel:GetDescendants()) do
            if obj:IsA("BasePart") or obj:IsA("MeshPart") then
                obj.CanCollide = false
                obj.Massless = true
                obj.CastShadow = false
                obj.CanQuery = false
--
                if obj:IsA("MeshPart") then
                    obj.CollisionFidelity = Enum.CollisionFidelity.Box
                end
            end
        end
        return true
    else
        return false
    end
end
--
local function getCMCurrentWeapon()
    local player = game.Players.LocalPlayer
    if not player or not player.Character then return nil end
--
    for _, child in ipairs(player.Character:GetChildren()) do
        if child:IsA("Tool") then
            return child
        end
    end
--
    local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
    if humanoid then
        return humanoid:GetEquippedTool()
    end
--
    return nil
end
--
local function isCMMareWeapon(weapon)
    if not weapon then return false end
--
    if weapon.Name == "Mare's Leg" then
        return true
    end
--
    local weaponName = weapon.Name:lower()
    local keywords = {
        "mare",
        "mares",
        "mare's",
        "mareleg",
        "mare leg",
        "mare's leg",
        "lever",
        "rifle",
        "cowboy",
        "western"
    }
--
    for _, keyword in ipairs(keywords) do
        if string.find(weaponName, keyword) then
            return true
        end
    end
--
    return false
end
--
local function hideCMMareOriginalParts(weapon)
    if not weapon then return end
--
    cmMareOriginalPartsTransparency = {}
    cmMareOriginalMaterials = {}
    cmMareOriginalColors = {}
--
    for _, part in ipairs(weapon:GetDescendants()) do
        if (part:IsA("BasePart") or part:IsA("MeshPart")) and part.Transparency < 1 then
            cmMareOriginalPartsTransparency[part] = part.Transparency
            cmMareOriginalMaterials[part] = part.Material
            cmMareOriginalColors[part] = part.Color
--
            part.Transparency = 1
            part.LocalTransparencyModifier = 1
        end
    end
end
--
local function restoreCMMareOriginalParts()
    for part, transparency in pairs(cmMareOriginalPartsTransparency) do
        if part and part.Parent then
            pcall(function()
                part.Transparency = transparency
                part.LocalTransparencyModifier = 0
--
                if cmMareOriginalMaterials[part] then
                    part.Material = cmMareOriginalMaterials[part]
                end
--
                if cmMareOriginalColors[part] then
                    part.Color = cmMareOriginalColors[part]
                end
            end)
        end
    end
    cmMareOriginalPartsTransparency = {}
    cmMareOriginalMaterials = {}
    cmMareOriginalColors = {}
end
--
local function addCMMareFFireSoundTWO(weapon)
    if not weapon then return nil end
--
    local handle = weapon:FindFirstChild("Handle")
    if not handle then
        handle = weapon:FindFirstChildWhichIsA("BasePart")
        if not handle then
            return nil
        end
    end
--
    local muzzle = handle:FindFirstChild("Muzzle")
    if not muzzle then
        muzzle = Instance.new("Part")
        muzzle.Name = "Muzzle"
        muzzle.Size = Vector3.new(0.2, 0.2, 0.2)
        muzzle.Transparency = 1
        muzzle.CanCollide = false
        muzzle.CanTouch = false
        muzzle.Anchored = false
        muzzle.Massless = true
        muzzle.Parent = handle
--
        local weld = Instance.new("Weld")
        weld.Part0 = handle
        weld.Part1 = muzzle
        weld.C0 = CFrame.new(0, 0, 1.5)
        weld.Parent = muzzle
    end
--
    local existingSound = muzzle:FindFirstChild("FFireSoundTWO")
    if existingSound then
        existingSound.SoundId = CM_MARE_FIRE_SOUND_ID
        cmMareCreatedFFireSoundTWO = existingSound
        return existingSound
    end
--
    local newFireSound = Instance.new("Sound")
    newFireSound.Name = "FFireSoundTWO"
    newFireSound.SoundId = CM_MARE_FIRE_SOUND_ID
    newFireSound.Volume = 1.0
    newFireSound.MaxDistance = 200
    newFireSound.RollOffMode = Enum.RollOffMode.Linear
    newFireSound.PlaybackSpeed = 1.0
    newFireSound.Looped = false
    newFireSound.Parent = muzzle
--
    cmMareCreatedFFireSoundTWO = newFireSound
    return newFireSound
end
--
local function removeCMMareFFireSoundTWO()
    if cmMareCreatedFFireSoundTWO and cmMareCreatedFFireSoundTWO.Parent then
        pcall(function()
            cmMareCreatedFFireSoundTWO:Destroy()
        end)
        cmMareCreatedFFireSoundTWO = nil
    end
--
    local player = game.Players.LocalPlayer
    if player and player.Character then
        for _, tool in ipairs(player.Character:GetChildren()) do
            if tool:IsA("Tool") then
                local handle = tool:FindFirstChild("Handle")
                if handle then
                    local muzzle = handle:FindFirstChild("Muzzle")
                    if muzzle then
                        local sound = muzzle:FindFirstChild("FFireSoundTWO")
                        if sound then
                            pcall(function()
                                sound:Destroy()
                            end)
                        end
                    end
                end
            end
        end
    end
end
--
local function makeCMMarePartsColored(weapon)
    if not weapon then return end
--
    cmMareOriginalEffectsProperties = {}
--
    local weaponHandle = weapon:FindFirstChild("Handle")
    if not weaponHandle then return end
--
    local muzzle = weaponHandle:FindFirstChild("Muzzle")
    if not muzzle then
        return
    end
--
    local skinData = cmMareSkins[currentMareSkin]
    if not skinData then return end
--
    local partsToColor = {
        "BarrelSmore",
        "FlashEmitter", 
        "Gas",
        "Gas2",
        "Lens flare",
        "Muzzle Flash 1", 
        "Smoke Emitter",
        "Sparkless"
    }
--
    for _, partName in ipairs(partsToColor) do
        local part = muzzle:FindFirstChild(partName)
        if part then
            pcall(function()
                if part:IsA("BasePart") or part:IsA("MeshPart") then
                    cmMareOriginalEffectsProperties[part] = {Color = part.Color}
                    part.Color = skinData.color
                    part.Material = Enum.Material.Neon
--
                elseif part:IsA("ParticleEmitter") then
                    if part.Color then
                        cmMareOriginalEffectsProperties[part] = {Color = part.Color}
                        part.Color = ColorSequence.new(skinData.effectColor)
                    end
--
                elseif part:IsA("PointLight") or part:IsA("SpotLight") then
                    cmMareOriginalEffectsProperties[part] = {
                        Color = part.Color,
                        Brightness = part.Brightness
                    }
                    part.Color = skinData.brightColor
                    part.Brightness = 10
                    part.Range = 20
--
                elseif part:IsA("LensFlare") then
                    cmMareOriginalEffectsProperties[part] = {Color = part.Color}
                    part.Color = skinData.color
                    part.Brightness = 5
--
                elseif part:IsA("Fire") then
                    cmMareOriginalEffectsProperties[part] = {
                        Color = part.Color,
                        Heat = part.Heat
                    }
                    part.Color = skinData.color
                    part.Heat = 15
                    part.Size = 5
--
                elseif part:IsA("Smoke") then
                    cmMareOriginalEffectsProperties[part] = {Color = part.Color}
                    part.Color = skinData.smokeColor
                    part.Opacity = 0.8
                    part.Size = 3
--
                elseif part:IsA("Sparkles") then
                    cmMareOriginalEffectsProperties[part] = {SparkleColor = part.SparkleColor}
                    part.SparkleColor = skinData.color
                end
            end)
        end
    end
--
    for _, child in ipairs(muzzle:GetChildren()) do
        if (child:IsA("ParticleEmitter") or child:IsA("Beam") or child:IsA("PointLight") or 
            child:IsA("Sparkles") or child:IsA("Smoke") or child:IsA("Fire")) and
            not cmMareOriginalEffectsProperties[child] then
--
            cmMareOriginalEffectsProperties[child] = {}
--
            if child:IsA("ParticleEmitter") then
                cmMareOriginalEffectsProperties[child].Color = child.Color
                child.Color = ColorSequence.new(skinData.effectColor)
--
            elseif child:IsA("Beam") then
                cmMareOriginalEffectsProperties[child].Color = child.Color
                child.Color = ColorSequence.new(skinData.effectColor)
--
            elseif child:IsA("PointLight") then
                cmMareOriginalEffectsProperties[child].Color = child.Color
                cmMareOriginalEffectsProperties[child].Brightness = child.Brightness
                child.Color = skinData.brightColor
                child.Brightness = 10
--
            elseif child:IsA("Sparkles") then
                cmMareOriginalEffectsProperties[child].SparkleColor = child.SparkleColor
                child.SparkleColor = skinData.color
--
            elseif child:IsA("Smoke") then
                cmMareOriginalEffectsProperties[child].Color = child.Color
                child.Color = skinData.smokeColor
--
            elseif child:IsA("Fire") then
                cmMareOriginalEffectsProperties[child].Color = child.Color
                cmMareOriginalEffectsProperties[child].SecondaryColor = child.SecondaryColor
                child.Color = skinData.color
                child.SecondaryColor = skinData.color
            end
        end
    end
end
--
local function restoreCMMareOriginalEffects()
    for effect, properties in pairs(cmMareOriginalEffectsProperties) do
        if effect and effect.Parent then
            pcall(function()
                if properties.Color then
                    effect.Color = properties.Color
                end
                if properties.Brightness then
                    effect.Brightness = properties.Brightness
                end
                if properties.Heat then
                    effect.Heat = properties.Heat
                end
                if properties.SparkleColor then
                    effect.SparkleColor = properties.SparkleColor
                end
                if properties.SecondaryColor then
                    effect.SecondaryColor = properties.SecondaryColor
                end
            end)
        end
    end
    cmMareOriginalEffectsProperties = {}
end
--
local function applyCMMareSkin(weapon)
    if not weapon or not cmMareModel or cmMareIsApplyingSkin then return false end
--
    cmMareIsApplyingSkin = true
--
    if cmMareCurrentSkinClone then
        pcall(function()
            cmMareCurrentSkinClone:Destroy()
        end)
        cmMareCurrentSkinClone = nil
    end
--
    hideCMMareOriginalParts(weapon)
--
    makeCMMarePartsColored(weapon)
--
    addCMMareFFireSoundTWO(weapon)
--
    local success = pcall(function()
        local skinClone = cmMareModel:Clone()
--
        local weaponHandle = weapon:FindFirstChild("Handle")
        if not weaponHandle then
            weaponHandle = weapon:FindFirstChildWhichIsA("BasePart")
        end
--
        if not weaponHandle then
            skinClone:Destroy()
            cmMareIsApplyingSkin = false
            return false
        end
--
        local skinData = cmMareSkins[currentMareSkin]
        if not skinData then
            skinClone:Destroy()
            cmMareIsApplyingSkin = false
            return false
        end
--
        for _, part in ipairs(skinClone:GetDescendants()) do
            if part:IsA("BasePart") or part:IsA("MeshPart") then
                part.CanCollide = false
                part.Anchored = false
                part.Massless = true
                part.CanTouch = false
                part.CastShadow = false
                part.CanQuery = false
--
                if part:IsA("MeshPart") then
                    part.CollisionFidelity = Enum.CollisionFidelity.Box
                    part.TextureID = skinData.texture
                end
            end
        end
--
        local partsFolder = skinClone:FindFirstChild("parts")
        if partsFolder then
            for _, meshPart in ipairs(partsFolder:GetDescendants()) do
                if meshPart:IsA("MeshPart") then
                    meshPart.TextureID = skinData.texture
                end
            end
        else
            for _, meshPart in ipairs(skinClone:GetDescendants()) do
                if meshPart:IsA("MeshPart") then
                    meshPart.TextureID = skinData.texture
                end
            end
        end
--
        local skinPrimary = nil
        if skinClone:IsA("BasePart") then
            skinPrimary = skinClone
        else
            if skinClone:IsA("Model") then
                skinPrimary = skinClone.PrimaryPart
                if not skinPrimary then
                    for _, part in ipairs(skinClone:GetDescendants()) do
                        if part:IsA("BasePart") or part:IsA("MeshPart") then
                            skinPrimary = part
                            break
                        end
                    end
                end
            else
                skinPrimary = skinClone:FindFirstChildWhichIsA("BasePart")
            end
        end
--
        if skinPrimary then
            skinPrimary.CFrame = weaponHandle.CFrame
--
            local weld = Instance.new("Weld")
            weld.Name = "MareSkinWeld"
            weld.Part0 = weaponHandle
            weld.Part1 = skinPrimary
            weld.C0 = CFrame.new()
            weld.C1 = CFrame.new()
            weld.Parent = skinPrimary
--
            skinClone.Parent = weapon
--
            cmMareCurrentSkinClone = skinClone
            cmMareLastWeapon = weapon
            cmMareIsApplyingSkin = false
            return true
        else
            skinClone:Destroy()
            cmMareIsApplyingSkin = false
            return false
        end
    end)
--
    if not success then
        cmMareIsApplyingSkin = false
    end
--
    return success
end
--
local function removeCMMareSkin()
    restoreCMMareOriginalEffects()
--
    removeCMMareFFireSoundTWO()
--
    if cmMareCurrentSkinClone then
        pcall(function()
            cmMareCurrentSkinClone:Destroy()
        end)
        cmMareCurrentSkinClone = nil
    end
--
    restoreCMMareOriginalParts()
--
    cmMareLastWeapon = nil
end
--
Common functions
local function isCMSubzeroWeapon(weapon)
    if not weapon then return false end
    local weaponName = weapon.Name:lower()
    local keywords = {"m4a1","m4","rifle","assault","ak47","ar15"}
    for _, keyword in ipairs(keywords) do if string.find(weaponName, keyword) then return true end end
    return false
end
--
local function isCMDragonWeapon(weapon)
    if not weapon then return false end
    local weaponName = weapon.Name:lower()
    local keywords = {"m4a1","m4","rifle","assault","ar15","ak47"}
    for _, keyword in ipairs(keywords) do if string.find(weaponName, keyword) then return true end end
    return false
end
--
local function isCMCryogenWeapon(weapon)
    if not weapon then return false end
    local weaponName = weapon.Name:lower()
    local keywords = {"mp7","smg","submachine","uzi","p90","vector"}
    for _, keyword in ipairs(keywords) do if string.find(weaponName, keyword) then return true end end
    return false
end
--
local function isCMHeritageWeapon(weapon)
    if not weapon then return false end
    local weaponName = weapon.Name:lower()
    local keywords = {"m4a1","m4","rifle","assault","ar15","ak47"}
    for _, keyword in ipairs(keywords) do if string.find(weaponName, keyword) then return true end end
    return false
end
--
local function isCMWogwWeapon(weapon)
    if not weapon then return false end
    local weaponName = weapon.Name:lower()
    local keywords = {"m4a1","m4","rifle","assault","ar15","ak47"}
    for _, keyword in ipairs(keywords) do if string.find(weaponName, keyword) then return true end end
    return false
end
--
local function isCMOpmWeapon(weapon)
    if not weapon then return false end
    local weaponName = weapon.Name:lower()
    local keywords = {"m4a1-1","m4a1","m4","rifle","assault","ar15"}
    for _, keyword in ipairs(keywords) do if string.find(weaponName, keyword) then return true end end
    return false
end
--
local function isCMShowdownWeapon(weapon)
    if not weapon then return false end
--
    local weaponName = weapon.Name:lower()
    local keywords = {
        "magnum",
        "revolver",
        "pistol",
        "handgun",
        "357",
        "44",
        "deagle",
        "desert eagle"
    }
--
    for _, keyword in ipairs(keywords) do
        if string.find(weaponName, keyword) then
            return true
        end
    end
--
    return false
end
--
local function isCMErosWeapon(weapon)
    if not weapon then return false end
    if weapon.Name == "Sawn-Off" then return true end
    local weaponName = weapon.Name:lower()
    local keywords = {"sawnoff","sawedoff","sawed-off","sawn-off","shotgun","double barrel","double-barrel","db"}
    for _, keyword in ipairs(keywords) do if string.find(weaponName, keyword) then return true end end
    return false
end
--
local function removeCMAllSkins()
    removeCMSubzeroSkin()
    removeCMDragonSkin()
    removeCMCryogenSkin()
    removeCMHeritageSkin()
    removeCMWogwSkin()
    removeCMOpmSkin()
    removeCMShowdownSkin()
    removeCMErosSkin()
    removeCMMareSkin()
end
--
local function checkCMWeapon()
    if not isCMEnabled then return end
--
    local weapon = getCMCurrentWeapon()
--
    if currentCMType == "M4:Subzero" then
        local currentTime = tick()
        if currentTime - cmSubzeroLastCheckTime < CM_SUBZERO_CHECK_INTERVAL then return end
        cmSubzeroLastCheckTime = currentTime
        if weapon and isCMSubzeroWeapon(weapon) then
            if weapon ~= cmSubzeroLastWeapon then
                removeCMSubzeroSkin()
                task.wait(0.1)
                applyCMSubzeroSkin(weapon)
            end
        else
            removeCMSubzeroSkin()
        end
    elseif currentCMType == "M4:Dragon" then
        local currentTime = tick()
        if currentTime - cmDragonLastCheckTime < CM_DRAGON_CHECK_INTERVAL then return end
        cmDragonLastCheckTime = currentTime
        if weapon and isCMDragonWeapon(weapon) then
            if weapon ~= cmDragonLastWeapon then
                removeCMDragonSkin()
                applyCMDragonSkin(weapon)
            end
        else
            removeCMDragonSkin()
        end
    elseif currentCMType == "MP7:Cryogen" then
        local currentTime = tick()
        if currentTime - cmCryogenLastCheckTime < CM_CRYOGEN_CHECK_INTERVAL then return end
        cmCryogenLastCheckTime = currentTime
        if weapon and isCMCryogenWeapon(weapon) then
            if weapon ~= cmCryogenLastWeapon then
                removeCMCryogenSkin()
                applyCMCryogenSkin(weapon)
            end
        else
            removeCMCryogenSkin()
        end
    elseif currentCMType == "M4:Heritage" then
        local currentTime = tick()
        if currentTime - cmHeritageLastCheckTime < CM_HERITAGE_CHECK_INTERVAL then return end
        cmHeritageLastCheckTime = currentTime
        if weapon and isCMHeritageWeapon(weapon) then
            if weapon ~= cmHeritageLastWeapon then
                removeCMHeritageSkin()
                task.wait(0.1)
                applyCMHeritageSkin(weapon)
            end
        else
            removeCMHeritageSkin()
        end
    elseif currentCMType == "M4:Heritage FullBlood" then
        local currentTime = tick()
        if currentTime - cmWogwLastCheckTime < CM_WOGW_CHECK_INTERVAL then return end
        cmWogwLastCheckTime = currentTime
        if weapon and isCMWogwWeapon(weapon) then
            if weapon ~= cmWogwLastWeapon then
                removeCMWogwSkin()
                task.wait(0.1)
                applyCMWogwSkin(weapon)
            end
        else
            removeCMWogwSkin()
        end
    elseif currentCMType == "M4:OPM" then
        local currentTime = tick()
        if currentTime - cmOpmLastCheckTime < CM_OPM_CHECK_INTERVAL then return end
        cmOpmLastCheckTime = currentTime
        if weapon and isCMOpmWeapon(weapon) then
            if weapon ~= cmOpmLastWeapon then
                removeCMOpmSkin()
                task.wait(0.1)
                applyCMOpmSkin(weapon)
            end
        else
            removeCMOpmSkin()
        end
    elseif currentCMType == "Magnum:Showdown" then
        local currentTime = tick()
        if currentTime - cmShowdownLastCheckTime < CM_SHOWDOWN_CHECK_INTERVAL then return end
        cmShowdownLastCheckTime = currentTime
        if weapon and isCMShowdownWeapon(weapon) then
            if weapon ~= cmShowdownLastWeapon then
                removeCMShowdownSkin()
                task.wait(0.1)
                applyCMShowdownSkin(weapon, false) -- false = he Steeldown
            end
        else
            removeCMShowdownSkin()
        end
    elseif currentCMType == "Magnum:Steeldown" then
        local currentTime = tick()
        if currentTime - cmShowdownLastCheckTime < CM_SHOWDOWN_CHECK_INTERVAL then return end
        cmShowdownLastCheckTime = currentTime
        if weapon and isCMShowdownWeapon(weapon) then
            if weapon ~= cmShowdownLastWeapon then
                removeCMShowdownSkin()
                task.wait(0.1)
                applyCMShowdownSkin(weapon, true) -- true = Steeldown
            end
        else
            removeCMShowdownSkin()
        end
    elseif currentCMType == "Sawn-Off:Eros" then
        local currentTime = tick()
        if currentTime - cmErosLastCheckTime < CM_EROS_CHECK_INTERVAL then return end
        cmErosLastCheckTime = currentTime
        if weapon and isCMErosWeapon(weapon) then
            if weapon ~= cmErosLastWeapon then
                removeCMErosSkin()
                task.wait(0.1)
                applyCMErosSkin(weapon)
            end
        else
            removeCMErosSkin()
        end
    elseif currentCMType == "Mare:TrickShot" or currentCMType == "Mare:White" then
        local currentTime = tick()
        if currentTime - cmMareLastCheckTime < CM_MARE_CHECK_INTERVAL then return end
        cmMareLastCheckTime = currentTime
--
        -- Oбhobляem tekyщий ckиh Mare b зabиcиmoctи ot bыбpahhoгo tипa
        if currentCMType == "Mare:TrickShot" then
            currentMareSkin = "TrickShot"
        elseif currentCMType == "Mare:White" then
            currentMareSkin = "White"
        end
--
        if weapon and isCMMareWeapon(weapon) then
            if weapon ~= cmMareLastWeapon then
                removeCMMareSkin()
                task.wait(0.1)
                applyCMMareSkin(weapon)
            end
        else
            removeCMMareSkin()
        end
    end
end
--
local function loadCMSelectedModel()
    if currentCMType == "M4:Subzero" then
        if not cmSubzeroModel then loadCMSubzeroModel() end
    elseif currentCMType == "M4:Dragon" then
        if not cmDragonModel then loadCMDragonModel() end
    elseif currentCMType == "MP7:Cryogen" then
        if not cmCryogenModel then loadCMCryogenModel() end
    elseif currentCMType == "M4:Heritage" then
        if not cmHeritageModel then findAndLoadCMHeritageModel() end
    elseif currentCMType == "M4:Heritage FullBlood" then
        if not cmWogwModel then findAndLoadCMWogwModel() end
    elseif currentCMType == "M4:OPM" then
        if not cmOpmModel then findAndLoadCMOpmModel() end
    elseif currentCMType == "Magnum:Showdown" or currentCMType == "Magnum:Steeldown" then
        if not cmShowdownModel then loadCMShowdownModel() end
    elseif currentCMType == "Sawn-Off:Eros" then
        if not cmErosModel then loadCMErosModel() end
    elseif currentCMType == "Mare:TrickShot" or currentCMType == "Mare:White" then
        if not cmMareModel then loadCMMareModel() end
    end
end
--
local function startCMSkinChecking()
    if cmHeartbeatConnection then
        cmHeartbeatConnection:Disconnect()
        cmHeartbeatConnection = nil
    end
--
    cmHeartbeatConnection = game:GetService("RunService").Heartbeat:Connect(function()
        pcall(checkCMWeapon)
    end)
--
    local player = game.Players.LocalPlayer
    if player then
        local charConn = player.CharacterAdded:Connect(function()
            task.wait(1.5)
            removeCMAllSkins()
            pcall(checkCMWeapon)
        end)
        table.insert(cmConnections, charConn)
    end
end
--
local function stopCMSkinChecking()
    if cmHeartbeatConnection then
        cmHeartbeatConnection:Disconnect()
        cmHeartbeatConnection = nil
    end
--
    removeCMAllSkins()
end
--
UI Elements
local CMDropdown = CustomModelsGroup:AddDropdown("CMType", {
    Text = "Select Model",
    Default = "M4:Subzero",
    Values = {
        "M4:Subzero",
        "M4:Dragon", 
        "M4:Heritage",
        "M4:Heritage FullBlood",
        "M4:OPM",
        "MP7:Cryogen",
        "Magnum:Showdown",
        "Magnum:Steeldown",
        "Sawn-Off:Eros",
        "Mare:TrickShot",
        "Mare:White"
    },
    Tooltip = "Choose which custom model to apply",
})
--
local CMToggle = CustomModelsGroup:AddToggle("CMEnable", {
    Text = "Enable Custom Model",
    Default = false,
    Tooltip = "Enable/disable custom model application",
})
--
CMDropdown:OnChanged(function(value)
    local skinMap = {
        ["M4:Subzero"] = "M4:Subzero",
        ["M4:Dragon"] = "M4:Dragon",
        ["M4:Heritage"] = "M4:Heritage",
        ["M4:Heritage FullBlood"] = "M4:Heritage FullBlood",
        ["M4:OPM"] = "M4:OPM",
        ["MP7:Cryogen"] = "MP7:Cryogen",
        ["Magnum:Showdown"] = "Magnum:Showdown",
        ["Magnum:Steeldown"] = "Magnum:Steeldown",
        ["Sawn-Off:Eros"] = "Sawn-Off:Eros",
        ["Mare:TrickShot"] = "Mare:TrickShot",
        ["Mare:White"] = "Mare:White"
    }
--
    local newCMType = skinMap[value]
    if newCMType == currentCMType then return end
--
    if isCMEnabled then
        stopCMSkinChecking()
    end
--
    currentCMType = newCMType
    loadCMSelectedModel()
--
    if isCMEnabled then
        startCMSkinChecking()
    end
end)
--
CMToggle:OnChanged(function(value)
    isCMEnabled = value
--
    for _, conn in ipairs(cmConnections) do
        if conn then
            pcall(function() conn:Disconnect() end)
        end
    end
    cmConnections = {}
--
    if value then
        loadCMSelectedModel()
--
        local modelLoaded = false
        if currentCMType == "M4:Subzero" and cmSubzeroModel then modelLoaded = true
        elseif currentCMType == "M4:Dragon" and cmDragonModel then modelLoaded = true
        elseif currentCMType == "MP7:Cryogen" and cmCryogenModel then modelLoaded = true
        elseif currentCMType == "M4:Heritage" and cmHeritageModel then modelLoaded = true
        elseif currentCMType == "M4:Heritage FullBlood" and cmWogwModel then modelLoaded = true
        elseif currentCMType == "M4:OPM" and cmOpmModel then modelLoaded = true
        elseif (currentCMType == "Magnum:Showdown" or currentCMType == "Magnum:Steeldown") and cmShowdownModel then modelLoaded = true
        elseif currentCMType == "Sawn-Off:Eros" and cmErosModel then modelLoaded = true
        elseif (currentCMType == "Mare:TrickShot" or currentCMType == "Mare:White") and cmMareModel then modelLoaded = true end
--
        if modelLoaded then
            startCMSkinChecking()
        else
            isCMEnabled = false
            CMToggle:SetValue(false)
        end
    else
        stopCMSkinChecking()
    end
end)
--
task.spawn(function()
    task.wait(2)
    loadCMSelectedModel()
end)
    local initWeps = getWepsInClass("Pistols"); local initSkins = {}; if #initWeps > 0 then initSkins = getSkinsForWep("Pistols", initWeps[1]) end
    local clsDrop, wepDrop, skinDrop
    SkinL:AddToggle("EnableSkinChanger", {Text="Enable SkinChanger", Default=false, Callback=function(s)
        SkinState.On = s; Lib:Notify(s and "SkinChanger on" or "SkinChanger off", 2)
        if s then if SkinState.Auto then setupAutoApply() end else for _, c in pairs(SkinState.Conns) do if c then c:Disconnect() end end; SkinState.Conns = {} end
    end})
    clsDrop = SkinL:AddDropdown("WeaponClass", {Text="Weapon Class", Values=SkinState.Classes, Default="Pistols", Multi=false, Callback=function(v)
        SkinState.Class = v; SkinState.Weapon = nil; SkinState.Skin = nil; local w = getWepsInClass(v)
        if wepDrop then
            wepDrop:SetValues(w)
            if #w > 0 then wepDrop:SetValue(w[1]); SkinState.Weapon = w[1]; local s = getSkinsForWep(v, w[1])
                if skinDrop then skinDrop:SetValues(s); if #s > 0 then skinDrop:SetValue(s[1]); SkinState.Skin = s[1] else skinDrop:SetValue(""); SkinState.Skin = nil end end
            else wepDrop:SetValue(""); if skinDrop then skinDrop:SetValues({}); skinDrop:SetValue("") end end
        end
        Lib:Notify("Class: "..v, 1)
    end})
    wepDrop = SkinL:AddDropdown("WeaponSelect", {Text="Weapon", Values=initWeps, Default=#initWeps>0 and initWeps[1] or "", Multi=false, Callback=function(v)
        if v == "" or not v then SkinState.Weapon = nil; SkinState.Skin = nil; if skinDrop then skinDrop:SetValues({}); skinDrop:SetValue("") end; return end
        SkinState.Weapon = v; if SkinState.Class then local s = getSkinsForWep(SkinState.Class, v)
            if skinDrop then skinDrop:SetValues(s); if #s > 0 then skinDrop:SetValue(s[1]); SkinState.Skin = s[1] else skinDrop:SetValue(""); SkinState.Skin = nil end end
        end
        Lib:Notify("Weapon: "..v, 1)
    end})
    skinDrop = SkinL:AddDropdown("SkinSelect", {Text="Skin", Values=initSkins, Default=#initSkins>0 and initSkins[1] or "", Multi=false, Callback=function(v)
        if v == "" or not v then SkinState.Skin = nil; return end
        SkinState.Skin = v; if SkinState.Class and SkinState.Weapon and v then
            local sInfo = SkinsDB[SkinState.Class][SkinState.Weapon][v]; if sInfo then
                SkinState.Equipped[SkinState.Weapon] = {class=SkinState.Class, name=v, id=sInfo.id, customApply=sInfo.customApply}
                if SkinState.Auto and SkinState.On then task.wait(0.5); applySkin() else Lib:Notify("Skin: "..v, 1) end
            end
        end
    end})
    SkinR:AddButton({Text="Apply Skin", Func=applySkin})
    SkinR:AddToggle("AutoApply", {Text="Auto Apply", Default=false, Callback=function(s)
        SkinState.Auto = s; setupAutoApply()
        if s and SkinState.On and SkinState.Weapon and SkinState.Skin then task.wait(0.5); applySkin() end
        Lib:Notify(s and "Auto on" or "Auto off", 2)
    end})
    SkinR:AddButton({Text="Save Skins", Func=saveSkins})
    SkinR:AddButton({Text="Load Skins", Func=loadSkins})
    SkinR:AddButton({Text="Clear All Skins", Func=function() SkinState.Equipped = {}; Lib:Notify("Skins cleared", 2) end})
    local status = SkinR:AddLabel("Status: Init...")
    if #initWeps > 0 then SkinState.Weapon = initWeps[1]; if #initSkins > 0 then SkinState.Skin = initSkins[1] end end
    loadSkins()
    task.spawn(function() task.wait(0.5); if clsDrop and clsDrop.Callback then clsDrop.Callback("Pistols") end end)
    SkinState.Loaded = true; status:SetText("Status: Ready"); Lib:Notify("SkinChanger loaded!", 2)
end)
--
-- END ORIGINAL SOURCE LINES 4079-7454
