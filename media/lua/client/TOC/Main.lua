local PlayerHandler = require("TOC/Handlers/PlayerHandler")
local CommonMethods = require("TOC/CommonMethods")
------------------


---@class Main
local Main = {}

---Setups the custom traits
function Main.SetupTraits()
    -- Perks.Left_Hand is defined in perks.txt

    local traitsTable = {}
    local trait1 = TraitFactory.addTrait("Amputee_Hand", getText("UI_trait_Amputee_Hand"), -8, getText("UI_trait_Amputee_Hand_desc"), false, false)
    traitsTable[1] = trait1

    local trait2 = TraitFactory.addTrait("Amputee_LowerArm", getText("UI_trait_Amputee_LowerArm"), -10, getText("UI_trait_Amputee_LowerArm_desc"), false, false)
    traitsTable[2] = trait2

    local trait3 = TraitFactory.addTrait("Amputee_UpperArm", getText("UI_trait_Amputee_UpperArm"), -20, getText("UI_trait_Amputee_UpperArm_desc"), false, false)
    traitsTable[2] = trait3

    for i=1, #traitsTable do
        local t = traitsTable[i]
        ---@diagnostic disable-next-line: undefined-field
        t:addXPBoost(Perks.Left_Hand, 4)
        t:addXPBoost(Perks.Fitness, -1)
        t:addXPBoost(Perks.Strength, -1)
    end

    TraitFactory.addTrait("Insensitive", getText("UI_trait_Insensitive"), 6, getText("UI_trait_Insensitive_desc"), false, false)

    TraitFactory.setMutualExclusive("Amputee_Hand", "Amputee_LowerArm")
    TraitFactory.setMutualExclusive("Amputee_Hand", "Amputee_UpperArm")
    TraitFactory.setMutualExclusive("Amputee_LowerArm", "Amputee_UpperArm")
end

function Main.Start()
    TOC_DEBUG.print("running Start method")
    Main.SetupTraits()
    Main.SetupEvents()
    -- Starts initialization for local client
    Events.OnGameStart.Add(Main.Initialize)

end

function Main.SetupEvents()
    --Triggered when a limb has been amputated
    LuaEventManager.AddEvent("OnAmputatedLimb")
end

function Main.Initialize()

    ---Looop until we've successfully initialized the mod
    local function TryToInitialize()
        local pl = getPlayer()
        TOC_DEBUG.print("Current username in TryToInitialize: " .. pl:getUsername())
        if pl:getUsername() == "Bob" then
            TOC_DEBUG.print("Username is still Bob, waiting")
            return
        end

        PlayerHandler.InitializePlayer(pl, false)
        Events.OnTick.Remove(TryToInitialize)
    end
    CommonMethods.SafeStartEvent("OnTick", TryToInitialize)
end


--* Events *--

Events.OnGameBoot.Add(Main.Start)