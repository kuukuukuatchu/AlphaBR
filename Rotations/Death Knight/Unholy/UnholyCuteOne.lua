local addonName, br = ...
local rotationName = "CuteOne"
---------------
--- Toggles ---
---------------
local function createToggles() -- Define custom toggles
    local spell = br.player.spell
    -- Rotation Button
    RotationModes = {
        [1] = { mode = "Auto", value = 1 , overlay = "Automatic Rotation", tip = "Swaps between Single and Multiple based on number of enemies in range.", highlight = 1, icon = spell.scourgeStrike },
        [2] = { mode = "Mult", value = 2 , overlay = "Multiple Target Rotation", tip = "Multiple target rotation used.", highlight = 0, icon = spell.scourgeStrike },
        [3] = { mode = "Sing", value = 3 , overlay = "Single Target Rotation", tip = "Single target rotation used.", highlight = 0, icon = spell.deathAndDecay },
        [4] = { mode = "Off", value = 4 , overlay = "DPS Rotation Disabled", tip = "Disable DPS Rotation", highlight = 0, icon = spell.deathCoil }
    };
    CreateButton("Rotation",1,0)
    -- Cooldown Button
    CooldownModes = {
        [1] = { mode = "Auto", value = 1 , overlay = "Cooldowns Automated", tip = "Automatic Cooldowns - Boss Detection.", highlight = 1, icon = spell.armyOfTheDead },
        [2] = { mode = "On", value = 2 , overlay = "Cooldowns Enabled", tip = "Cooldowns used regardless of target.", highlight = 0, icon = spell.armyOfTheDead },
        [3] = { mode = "Off", value = 3 , overlay = "Cooldowns Disabled", tip = "No Cooldowns will be used.", highlight = 0, icon = spell.armyOfTheDead }
    };
    CreateButton("Cooldown",2,0)
    -- Defensive Button
    DefensiveModes = {
        [1] = { mode = "On", value = 1 , overlay = "Defensive Enabled", tip = "Includes Defensive Cooldowns.", highlight = 1, icon = spell.iceboundFortitude },
        [2] = { mode = "Off", value = 2 , overlay = "Defensive Disabled", tip = "No Defensives will be used.", highlight = 0, icon = spell.iceboundFortitude }
    };
    CreateButton("Defensive",3,0)
    -- Interrupt Button
    InterruptModes = {
        [1] = { mode = "On", value = 1 , overlay = "Interrupts Enabled", tip = "Includes Basic Interrupts.", highlight = 1, icon = spell.mindFreeze },
        [2] = { mode = "Off", value = 2 , overlay = "Interrupts Disabled", tip = "No Interrupts will be used.", highlight = 0, icon = spell.mindFreeze }
    };
    CreateButton("Interrupt",4,0)
    -- Death And Decay Button
    DndModes = {
        [1] = { mode = "On", value = 1 , overlay = "DnD Enabled", tip = "Will use DnD.", highlight = 1, icon = spell.deathAndDecay },
        [2] = { mode = "Off", value = 2 , overlay = "DnD Disabled", tip = "will NOT use DnD.", highlight = 0, icon = spell.deathAndDecay }
    };
    CreateButton("Dnd",5,0)
end

---------------
--- OPTIONS ---
---------------
local function createOptions()
    local optionTable
    local function rotationOptions()
        -----------------------
        --- GENERAL OPTIONS ---
        -----------------------
        local section
        local alwaysCdNever = {"|cff00FF00Always","|cffFFFF00Cooldowns","|cffFF0000Never"}
        section = br.ui:createSection(br.ui.window.profile,  "General")
            -- APL
            br.ui:createDropdownWithout(section, "APL Mode", {"|cffFFFFFFSimC"}, 1, "|cffFFFFFFSet APL Mode to use.")
            -- Dummy DPS Test
            br.ui:createSpinner(section, "DPS Testing",  5,  5,  60,  5,  "|cffFFFFFFSet to desired time for test in minuts. Min: 5 / Max: 60 / Interval: 5")
            -- Chains of Ice
            br.ui:createCheckbox(section, "Chains of Ice")
            -- Control Undead
            br.ui:createCheckbox(section, "Control Undead")
            -- Dark Command
            br.ui:createCheckbox(section, "Dark Command","|cffFFFFFFWill taunt selected target to begin combat.")
            -- Death Grip
            br.ui:createCheckbox(section, "Death Grip","|cffFFFFFFWill grip units out that are >8yrds away from you while in combat.")
            br.ui:createCheckbox(section, "Death Grip - Pre-Combat","|cffFFFFFFWill grip selected target to begin combat.")
            -- Pre-Pull Timer
            br.ui:createSpinner(section, "Pre-Pull Timer",  5,  1,  10,  1,  "|cffFFFFFFSet to desired time to start Pre-Pull (DBM Required). Min: 1 / Max: 10 / Interval: 1")
            -- Path of Frost
            br.ui:createCheckbox(section, "Path of Frost")
        br.ui:checkSectionState(section)
        -------------------
        --- PET OPTIONS ---
        -------------------
        section = br.ui:createSection(br.ui.window.profile, "Pet Management")
            -- Raise Dead
            br.ui:createCheckbox(section, "Raise Dead")
            -- Pet Target
            br.ui:createDropdownWithout(section, "Pet Target", {"Dynamic Unit", "Only Target", "Any Unit"},1,"Select how you want pet to acquire targets.")
            -- Auto Attack/Passive
            br.ui:createCheckbox(section, "Auto Attack/Passive")
            -- Claw
            br.ui:createCheckbox(section, "Claw")
            -- Gnaw
            br.ui:createCheckbox(section, "Gnaw")
            -- Huddle
            br.ui:createSpinner(section, "Huddle", 30, 0, 100, 5, "|cffFFFFFFPet Health Percent to Cast At")
            -- Leap
            br.ui:createCheckbox(section, "Leap")
        br.ui:checkSectionState(section)
        ------------------------
        --- COOLDOWN OPTIONS ---
        ------------------------
        section = br.ui:createSection(br.ui.window.profile,  "Cooldowns")
            -- Cooldowns Time To Die Limit
            br.ui:createSpinnerWithout(section,  "Cooldowns Time To Die Limit",  30,  0,  40,  1,  "|cffFFFFFFTarget Time to die limit for using cooldowns (in sec).")        
            -- Augment Rune
            br.ui:createCheckbox(section, "Augment Rune")
            -- Potion
            br.ui:createCheckbox(section, "Potion")
            -- Elixir
            br.player.module.FlaskUp("Strength",section)
            -- Racial
            br.ui:createCheckbox(section, "Racial")
            -- Trinkets
            br.player.module.BasicTrinkets(nil,section)
            -- Covenant Ability
            br.ui:createDropdownWithout(section, "Covenant Ability", alwaysCdNever, 1, "{cffFFFFFFWhen to use Covenant Ability.")
            -- Apocalypse
            br.ui:createDropdownWithout(section, "Apocalypse", alwaysCdNever, 1, "|cffFFFFFFWhen to use Apocalypse.")
            -- Army of the Dead
            br.ui:createDropdownWithout(section, "Army of the Dead", alwaysCdNever, 1, "|cffFFFFFFWhen to use Army of the Dead.")
            -- Dark Transformation
            br.ui:createDropdownWithout(section, "Dark Transformation", alwaysCdNever, 1, "|cffFFFFFFWhen to use Dark Transformation.")
            -- Soul Reaper
            br.ui:createDropdownWithout(section, "Soul Reaper", alwaysCdNever, 1, "|cffFFFFFFWhen to use Soul Reaper.")
            -- Summon Gargoyle
            br.ui:createDropdownWithout(section, "Summon Gargoyle", alwaysCdNever, 1, "|cffFFFFFFWhen to use Summon Gargoyle.")
            -- Unholy BLight
            br.ui:createDropdownWithout(section, "Unholy Blight", alwaysCdNever, 1, "|cffFFFFFFWhen to use Unholy Blight.")
            -- Unholy Assault
            br.ui:createDropdownWithout(section, "Unholy Assault", alwaysCdNever, 1, "|cffFFFFFFWhen to use Unholy Assault.")
            br.ui:checkSectionState(section)
        -------------------------
        --- DEFENSIVE OPTIONS ---
        -------------------------
        section = br.ui:createSection(br.ui.window.profile, "Defensive")
            -- Basic Healing Module
            br.player.module.BasicHealing(section)
            -- Anti-Magic Shell
            br.ui:createSpinner(section, "Anti-Magic Shell", 50, 0, 100, 5, "|cffFFFFFFHealth Percent to use at.")
            -- Death Strike
            br.ui:createSpinner(section, "Death Strike", 50, 0, 100, 5, "|cffFFFFFFHealth Percent to use at.")
            -- Death Pact
            br.ui:createSpinner(section, "Death Pact", 50, 0, 100, 5, "|cffFFFFFFHealth Percent to use at.")
            -- Icebound Fortitude
            br.ui:createSpinner(section, "Icebound Fortitude", 50, 0, 100, 5, "|cffFFFFFFHealth Percent to use at.")
			-- Sacraficial Pact
            br.ui:createSpinner(section, "Sacraficial Pact", 50, 0, 100, 5, "|cffFFFFFFHealth Percent to use at.")
            -- Raise Ally
            br.ui:createDropdown(section, "Raise Ally", {"|cff00FF00Target","|cffFF0000Mouseover"}, 1, "|cffFFFFFFTarget to cast on")
        br.ui:checkSectionState(section)
        -------------------------
        --- INTERRUPT OPTIONS ---
        -------------------------
        section = br.ui:createSection(br.ui.window.profile, "Interrupts")
            -- Mind Freeze
            br.ui:createCheckbox(section, "Mind Freeze")
            -- Death Grip
            br.ui:createCheckbox(section, "Death Grip (Interrupt)")
            -- Asphyxiate
            br.ui:createCheckbox(section, "Asphyxiate")
            -- Asphyxiate Logic
            br.ui:createCheckbox(section, "Asphyxiate Logic")
            -- Interrupt Percentage
            br.ui:createSpinnerWithout(section, "Interrupt At",  0,  0,  95,  5,  "|cffFFFFFFCast Percent to Cast At (0 is random)")
        br.ui:checkSectionState(section)
        ----------------------
        --- TOGGLE OPTIONS ---
        ----------------------
        section = br.ui:createSection(br.ui.window.profile,  "Toggle Keys")
            -- Single/Multi Toggle
            br.ui:createDropdownWithout(section,  "Rotation Mode", br.dropOptions.Toggle,  4)
            --Cooldown Key Toggle
            br.ui:createDropdownWithout(section,  "Cooldown Mode", br.dropOptions.Toggle,  3)
            --Defensive Key Toggle
            br.ui:createDropdownWithout(section,  "Defensive Mode", br.dropOptions.Toggle,  6)
            -- Interrupts Key Toggle
            br.ui:createDropdownWithout(section,  "Interrupt Mode", br.dropOptions.Toggle,  6)
            -- Pause Toggle
            br.ui:createDropdown(section,  "Pause Mode", br.dropOptions.Toggle,  6)
        br.ui:checkSectionState(section)
    end
    optionTable = {{
        [1] = "Rotation Options",
        [2] = rotationOptions,
    }}
    return optionTable
end

--------------
--- Locals ---
--------------
-- BR API Locals
local buff
local cast
local cd
local conduit
local covenant
local debuff
local enemies
local equiped
local essence
local module
local pet
local runeforge
local runes
local runeDeficit
local runesTTM
local runicPower
local runicPowerDeficit
local spell
local talent
local ui
local unit
local units
local use
local var

-- General Locals
local actionList = {}
local waitForPetToAppear

--------------------
--- Action Lists ---
--------------------
-- Action List - Pet Management
actionList.PetManagement = function()
    local function getCurrentPetMode()
        local slots = _G["NUM_PET_ACTION_SLOTS"]
        local petMode = "None"
        for i = 1, slots do
            local name, _, _,isActive = GetPetActionInfo(i)
            if isActive then
                if name == "PET_MODE_ASSIST" then petMode = "Assist" end
                if name == "PET_MODE_DEFENSIVE" then petMode = "Defensive" end
                if name == "PET_MODE_PASSIVE" then petMode = "Passive" end
            end
        end
        return petMode
    end

    local petCombat = unit.inCombat("pet")
    local petExists = br.player.pet.active.exists()
    local petMode = getCurrentPetMode()
    local validTarget = unit.exists("pettarget") or (not unit.exists("pettarget") and unit.valid("target")) or unit.br.isDummy("target")
    if petExists and br.deadPet then br.deadPet = false end
    if waitForPetToAppear == nil or IsMounted() or IsFlying() or UnitHasVehicleUI("player") or CanExitVehicle("player") then
        waitForPetToAppear = GetTime()
    elseif ui.checked("Raise Dead") then
        if waitForPetToAppear ~= nil and GetTime() - waitForPetToAppear > 2 then
            if cast.able.raiseDead() and (br.deadPet or (not br.deadPet and not petExists)
                or (talent.allWillServe and not pet.risenSkulker.exists()))
            then
                if cast.raiseDead("player") then waitForPetToAppear = GetTime(); ui.debug("Casting Raise Dead") return true end
            end
        end
    end
    if ui.checked("Auto Attack/Passive") then
        -- Set Pet Mode Out of Comat / Set Mode Passive In Combat
        if unit.exists("target") and ((not unit.inCombat() and petMode == "Passive") or (unit.inCombat() and (petMode == "Defensive" or petMode == "Passive"))) then
            PetAssistMode()
            ui.debug("Setting Pet to Assist")
        elseif not unit.inCombat() and petMode == "Assist" and #enemies.yards40nc > 0 then
            PetDefensiveAssistMode()
            ui.debug("Setting Pet to Defensive")
        elseif unit.inCombat() and petMode ~= "Passive" and #enemies.yards40 == 0 then
            PetPassiveMode()
            ui.debug("Setting Pet to Passive")
        end
        -- Pet Attack / retreat
        if (not UnitExists("pettarget") or not validTarget) and (unit.inCombat() or petCombat) then
            if ui.value("Pet Target") == 1 and unit.valid(units.dyn40) then
                PetAttack(units.dyn40)
            elseif ui.value("Pet Target") == 2 and validTarget then
                PetAttack("target")
            elseif ui.value("Pet Target") == 3 then
                for i=1, #enemies.yards40 do
                    local thisUnit = enemies.yards40[i]
                    if (unit.valid(thisUnit) or unit.br.isDummy(thisUnit)) then PetAttack(thisUnit); break end
                end
            end
        elseif (not unit.inCombat() or (unit.inCombat() and not validTarget and not unit.valid("target") and not unit.br.isDummy("target"))) and IsPetAttackActive() then
            PetStopAttack()
            PetFollow()
        end
    end
    -- Huddle
    if ui.checked("Huddle") and cast.able.huddle() and (unit.inCombat() or petCombat) and unit.hp("pet") <= ui.value("Huddle") then
        if cast.huddle() then ui.debug("Casting Huddle [Pet]") return true end
    end
    if unit.valid("pettarget") then
        -- Claw
        if ui.checked("Claw") and cast.able.claw("pettarget") and not buff.huddle.exists("pet") and validTarget and unit.distance("pettarget","pet") < 5 then
            if cast.claw("pettarget") then ui.debug("Casting Claw [Pet]") return true end
        end
        -- Leap
        if ui.checked("Leap") and cast.able.leap("pettarget") and not buff.huddle.exists("pet") and validTarget and unit.distance("pettarget","pet") > 8 then
            if cast.leap("pettarget") then ui.debug("Casting Leap [Pet]") return true end
        end
    end
    -- Gnaw
    if ui.checked("Gnaw") and cast.able.gnaw() and not buff.huddle.exists("pet") then
        for i=1, #enemies.yards5 do
            local thisUnit = enemies.yards5[i]
            if canInterrupt(thisUnit,ui.value("Interrupt At")) then
                if cast.gnaw(thisUnit) then ui.debug("Casting Gnaw [Pet]") return true end
            end
        end
    end
end -- End Action List - Pet Management

-- Action List - Extras
actionList.Extras = function()
    -- Dummy Test
    if ui.checked("DPS Testing") then
        if unit.exists("target") then
            if getCombatTime() >= (tonumber(ui.value("DPS Testing"))*60) and unit.br.isDummy() then
                StopAttack()
                ClearTarget()
                ui.print(tonumber(ui.value("DPS Testing")) .." Minute Dummy Test Concluded - Profile Stopped")
                var.profileStop = true
            end
        end
    end -- End Dummy Test
    -- Chains of Ice
    if ui.checked("Chains of Ice") and cast.able.chainsOfIce() then
        for i = 1, #enemies.yards30 do
            local thisUnit = enemies.yards30[i]
            if not debuff.chainsOfIce.exists(thisUnit) and not unit.facing(thisUnit,"player") and unit.facing("player",thisUnit)
                and unit.moving(thisUnit) and unit.distance(thisUnit) > 8 and unit.inCombat()
            then
                if cast.chainsOfIce(thisUnit) then ui.debug("Casting Chains of Ice") return true end
            end
        end
    end
    -- Control Undead
    if ui.checked("Control Undead") and cast.able.controlUndead() then
        for i = 1, #enemies.yards30 do
            local thisUnit = enemies.yards30[i]
            if isUndead(thisUnit) and not unit.br.isDummy(thisUnit) and not unit.br.isBoss(thisUnit) and unit.level(thisUnit) <= unit.level() + 1 then
                if cast.controlUndead(thisUnit) then ui.debug("Casting Control Undead") return true end
            end
        end
    end
    -- Death Grip
    if ui.checked("Death Grip") and cast.able.deathGrip() then
        local thisUnit = talent.deathsReach and units.dyn40 or units.dyn30
        if unit.inCombat() and unit.distance(thisUnit) > 10 and ((talent.deathsReach and unit.distance(thisUnit) < 40) or unit.distance(thisUnit) < 30) and not unit.br.isDummy(thisUnit) then
            if cast.deathGrip() then ui.debug("Casting Death Grip") return true end
        end
    end
    -- Path of Frost
    if ui.checked("Path of Frost") and cast.able.pathOfFrost() then
        if not unit.inCombat() and unit.swimming() and not buff.pathOfFrost.exists() then
            if cast.pathOfFrost() then ui.debug("Casting Path of Frost") return true end
        end
    end
end -- End Action List - Extras

-- Action List - Defensive
actionList.Defensive = function()
    -- Basic Healing Module
    module.BasicHealing()
    -- Anti-Magic Shell
    if ui.checked("Anti-Magic Shell") and cast.able.antiMagicShell() and unit.hp() < ui.value("Anti-Magic Shell") then
        if cast.antiMagicShell() then ui.debug("Casting Anti-Magic Shell") return true end
    end
    -- Death Strike
    if ui.checked("Death Strike") and cast.able.deathStrike() and (unit.hp() < ui.value("Death Strike") or buff.darkSuccor.exists()) then
        if cast.deathStrike() then ui.debug("Casting Death Strike") return true end
    end
    -- Death Pact
    if ui.checked("Death Pact") and cast.able.deathPact() and unit.hp() < ui.value("Death Pact") then
        if cast.deathPact() then ui.debug("Casting Death Pact") return true end
    end
    -- Icebound Fortitude
    if ui.checked("Icebound Fortitude") and cast.able.iceboundFortitude() and unit.hp() < ui.value("Icebound Fortitude") then
        if cast.iceboundFortitude() then ui.debug("Casting Icebound Fortitude") return true end
    end
	-- Sacraficial Pact
    if ui.checked("Sacraficial Pact") and cast.able.sacraficialPact() and unit.hp() < ui.value("Sacraficial Pact") then
        if cast.sacraficialPact() then ui.debug("Casting Sacraficial Pact") return true end
    end
    -- Raise Ally
    if ui.checked("Raise Ally") then
        if ui.value("Raise Ally")==1 and cast.able.raiseAlly("target","dead")
            and unit.player("target") and unit.deadOrGhost("target") and unit.friend("target","player")
        then
            if cast.raiseAlly("target","dead") then ui.debug("Casting Raise Ally on Target") return true end
        end
        if ui.value("Raise Ally")==2 and cast.able.raiseAlly("mouseover","dead")
            and unit.player("mouseover") and unit.deadOrGhost("mouseover") and unit.friend("mouseover","player")
        then
            if cast.raiseAlly("mouseover","dead") then ui.debug("Casting Raise Ally on Mouseover") return true end
        end
    end
end -- End Action List - Defensive

-- Action List - Interrupts
actionList.Interrupts = function()
    if ui.useInterrupt() then
        -- Mind Freeze
        if ui.checked("Mind Freeze") and cast.able.mindFreeze() then
            for i=1, #enemies.yards15 do
                local thisUnit = enemies.yards15[i]
                if canInterrupt(thisUnit,ui.value("Interrupt At")) then
                    if cast.mindFreeze(thisUnit) then ui.debug("Casting Mind Freeze") return true end
                end
            end
        end
        --Asphyxiate
        if ui.checked("Asphyxiate") and cast.able.asphyxiate() and cd.mindFreeze.remain() > unit.gcd(true) then
            for i=1, #enemies.yards20 do
                local thisUnit = enemies.yards20[i]
                if canInterrupt(thisUnit,ui.value("Interrupt At")) then
                    if cast.asphyxiate(thisUnit) then ui.debug("Casting Asphyxiate") return true end
                end
            end
        end
        --Death Grip
        if ui.checked("Death Grip (Interrupt)") and cast.able.deathGrip() then
            local theseEnemies = talent.deathsReach and enemies.yards40 or enemies.yards30
            for i = 1,  #theseEnemies do
                local thisUnit = theseEnemies[i]
                if canInterrupt(thisUnit,ui.value("Interrupt At")) and unit.distance(thisUnit) > 10 then
                    if cast.deathGrip(thisUnit) then ui.debug("Casting Death Grip [Int]") return true end
                end
            end
        end
    end
end-- End Action List - Interrupts

-- Action List - Cooldowns
actionList.Cooldowns = function()
    -- Trinkets
    -- use_items
    module.BasicTrinkets()
    -- Potion
    -- potion,if=pet.gargoyle.active|buff.unholy_assault.up|talent.army_of_the_damned&(pet.army_ghoul.active|pet.apoc_ghoul.active|cooldown.army_of_the_dead.remains>target.time_to_die)
    -- Army of the Dead
    -- army_of_the_dead,if=cooldown.unholy_blight.remains<3&cooldown.dark_transformation.remains<3&talent.unholy_blight|!talent.unholy_blight|fight_remains<35
    if ui.alwaysCdNever("Army of the Dead") and (unit.ttdGroup(40) >= ui.value("Cooldowns Time To Die Limit") or unit.br.isDummy()) and cast.able.armyOfTheDead()
        and ((cd.unholyBlight.remains() < 3 and cd.darkTransformation.remains() < 3 and talent.unholyBlight) or not talent.unholyBlight or not ui.alwaysCdNever("Unholy Blight"))
    then
        if cast.armyOfTheDead() then ui.debug("Casting Army of the Dead") return true end
    end
    -- Soul Reaper
    -- soul_reaper,target_if=target.time_to_pct_35<5&target.time_to_die>5
    if ui.alwaysCdNever("Soul Reaper") and cast.able.soulReaper() and unit.ttd(units.dyn5,35) < 5 and unit.ttd(units.dyn5) > 5 then
        if cast.soulReaper() then ui.debug("Casting Soul Reaper") return true end
    end
    -- Unholy Blight
    if ui.alwaysCdNever("Unholy Blight") and cast.able.unholyBlight() and (cd.darkTransformation.remain() < unit.gcd(true) or buff.darkTransformation.exists()) then
        if var.stPlanning then
            -- unholy_blight,if=variable.st_planning&(cooldown.dark_transformation.remains<gcd|buff.dark_transformation.up)&(!runeforge.deadliest_coil|!talent.army_of_the_damned|conduit.convocation_of_the_dead.rank<5)
            if (not runeforge.deadliestCoil.equiped or not talent.armyOfTheDamned or conduit.convocationOfTheDead.rank < 5) then
                if cast.unholyBlight("player","aoe",1,10) then ui.debug("Casting Unholy Blight [ST]") return true end
            end
            -- unholy_blight,if=variable.st_planning&runeforge.deadliest_coil&talent.army_of_the_damned&conduit.convocation_of_the_dead.rank>=5&cooldown.apocalypse.remains<=5&(cooldown.dark_transformation.remains<gcd|buff.dark_transformation.up)
            if runeforge.deadliestCoil.equiped and talent.armyOfTheDamned and conduit.convocationOfTheDead.rank >= 5 and cd.apocalypse.remain() <= 5 then
                if cast.unholyBlight("player","aoe",1,10) then ui.debug("Casting Unholy Blight [ST - Deadliest Coil]") return true end
            end
        end
        -- unholy_blight,if=active_enemies>=2|fight_remains<21
        if ui.useAOE(8,2) and unit.ttdGroup(8) >= 21 then
            if cast.unholyBlight("player","aoe",1,10) then ui.debug("Casting Unholy Blight [AOE]") return true end
        end
    end
    -- Dark Transformation
    if ui.alwaysCdNever("Dark Transformation") and cast.able.darkTransformation() and pet.active.exists() then
        -- dark_transformation,if=variable.st_planning&(debuff.unholy_blight_debuff.up|!talent.unholy_blight)
        if var.stPlanning and (debuff.unholyBlight.exists(units.dyn5) or not talent.unholyBlight or not ui.alwaysCdNever("UnholyBlight")) then
            if cast.darkTransformation() then ui.debug("Casting Dark Transformation [ST]") return true end
        end
        -- dark_transformation,if=active_enemies>=2|fight_remains<21
        if ui.useAOE(8,2) and unit.ttdGroup(8) >= 21 then
            if cast.darkTransformation() then ui.debug("Casting Dark Transformation [AOE]") return true end
        end
    end
    -- Apocalypse
    if ui.alwaysCdNever("Apocalypse") and cast.able.apocalypse() then
        if ui.useST(8,2) and debuff.festeringWound.stack(units.dyn5) >= 4 then
            if talent.unholyBlight then
                -- apocalypse,if=active_enemies=1&debuff.festering_wound.stack>=4&talent.unholy_blight&talent.army_of_the_damned&runeforge.deadliest_coil&conduit.convocation_of_the_dead.rank>=5&dot.unholy_blight_dot.remains
                if talent.armyOfTheDamned and runeforge.deadliestCoil.equiped and conduit.convocationOfTheDead.rank >= 5 and debuff.unholyBlight.exists(units.dyn5) then
                    if cast.apocalypse() then ui.debug("Casting Apocalypse [Deadliest Coil]") return true end
                end
                -- apocalypse,if=active_enemies=1&debuff.festering_wound.stack>=4&talent.unholy_blight&dot.unholy_blight_dot.remains>10&!talent.army_of_the_damned&conduit.convocation_of_the_dead.rank<5
                if debuff.unholyBlight.remains() > 10 and not talent.armyOfTheDamned and conduit.convocationOfTheDead.rank < 5 then
                    if cast.apocalypse() then ui.debug("Casting Apocalyse [Unholy Blight]") return true end
                end
            end
            -- apocalypse,if=active_enemies=1&debuff.festering_wound.stack>=4&(!talent.unholy_blight|talent.army_of_the_damned&(!runeforge.deadliest_coil|conduit.convocation_of_the_dead.rank<5)|!talent.army_of_the_damned&conduit.convocation_of_the_dead.rank>=5|fight_remains<16)
            if (not talent.unholyBlight or (talent.armyOfTheDamned and (not runeforge.deadliestCoil.equiped or conduit.convocationOfTheDead.rank < 5)) or (not talent.armyOfTheDamned and conduit.convocationOfTheDead.rank >= 5)) then
                if cast.apocalypse() then ui.debug("Casting Apocalypse [ST]") return true end
            end
        end
        -- apocalypse,target_if=max:debuff.festering_wound.stack,if=active_enemies>=2&debuff.festering_wound.stack>=4&!death_and_decay.ticking
        if ui.useAOE(8,2) and var.fwoundHighest >= 4 and not buff.deathAndDecay.exists() then
            if cast.apocalypse(var.fwoundHighUnit) then ui.debug("Casting Apocalypse [AOE]") return true end
        end
    end
    -- Summon Gargoyle
    -- summon_gargoyle,if=runic_power.deficit<14&(cooldown.unholy_blight.remains<10|dot.unholy_blight_dot.remains)
    if ui.alwaysCdNever("Summon Gargoyle") and cast.able.summonGargoyle() and runicPowerDeficit < 14 and (unit.ttdGroup(40) >= ui.value("Cooldowns Time To Die Limit") or unit.br.isDummy())
        and (cd.unholyBlight.remains() < 10 or debuff.unholyBlight.exists(units.dyn5))
    then
        if cast.summonGargoyle() then ui.debug("Casting Summon Gargoyle") return true end
    end
    -- Unholy Assault
    if ui.alwaysCdNever("Unholy Assault") and cast.able.unholyAssault() and (unit.ttdGroup(40) >= ui.value("Cooldowns Time To Die Limit") or unit.br.isDummy()) then
        -- unholy_assault,if=variable.st_planning&debuff.festering_wound.stack<2&(pet.apoc_ghoul.active|conduit.convocation_of_the_dead&buff.dark_transformation.up&!pet.army_ghoul.active)
        if var.stPlanning and debuff.festeringWound.stack(units.dyn5) < 2
            and (pet.apocalypseGhoul.active() or conduit.convocationOfTheDead.enabled and buff.darkTransformation.exists() and not pet.armyOfTheDead.active)
        then
            if cast.unholyAssault() then ui.debug("Casting Unholy Assault [ST]") return true end
        end
        -- unholy_assault,target_if=min:debuff.festering_wound.stack,if=active_enemies>=2&debuff.festering_wound.stack<2
        if ui.useAOE(8,2) and var.fwoundLowest < 2 then
            if cast.unholyAssault(var.fwoundLowUnit) then ui.debug("Casting Unholy Assault [AOE]") return true end
        end
    end
end -- End Action List - Cooldowns

-- Action List - Covenants
actionList.Covenants = function()
    -- Swarming Mist
    -- swarming_mist,if=variable.st_planning&runic_power.deficit>16&(cooldown.apocalypse.remains|!talent.army_of_the_damned&cooldown.dark_transformation.remains)|fight_remains<11
    if cast.able.swarmingMist() and ui.useST(8,2) and runicPowerDeficit > 16 and (cd.apocalypse.exists() or not talent.armyOfTheDamned and cd.darkTransformation.exists()) then
        if cast.swarmingMist("player","aoe",1,8) then ui.debug("Casting Swarming Mist") return true end
    end
    -- swarming_mist,if=cooldown.apocalypse.remains&(active_enemies>=2&active_enemies<=5&runic_power.deficit>10+(active_enemies*6)|active_enemies>5&runic_power.deficit>40)
    if cast.able.swarmingMist() and cd.apocalypse.exists() and #enemies.yards8 >= 2 and ((#enemies.yards8 <= 5 and runicPowerDeficit > 10 + (#enemies.yards8 * 6)) or (#enemies.yards8 > 5 and runicPowerDeficit > 40)) then
        if cast.swarmingMist("player","aoe",2,8) then ui.debug("Casting Swarming Mist [AOE]") return true end
    end
    -- Abomination Limb
    -- abomination_limb,if=variable.st_planning&!soulbind.lead_by_example&(cooldown.apocalypse.remains|!talent.army_of_the_damned&cooldown.dark_transformation.remains)&rune.time_to_4>(3+buff.runic_corruption.remains)|fight_remains<21
    if cast.able.abominationLimb() and var.stPlanning and (cd.apocalypse.exists() or not talent.armyOfTheDamned and cd.darkTransformation.exists()) and runesTTM(4) > (3 + buff.runicCorruption.remains()) then
        if cast.abominationLimb("player","aoe",1,20) then ui.debug("Casting Abomination Limb") return true end
    end
    -- abomination_limb,if=variable.st_planning&soulbind.lead_by_example&(dot.unholy_blight_dot.remains>11|!talent.unholy_blight&cooldown.dark_transformation.remains)
    --
    -- abomination_limb,if=active_enemies>=2&rune.time_to_4>(3+buff.runic_corruption.remains)
    if cast.able.abominationLimb() and ui.useAOE(20,2) and runesTTM(4) > (3 + buff.runicCorruption.remains()) then
        if cast.abominationLimb("player","aoe",1,20) then ui.debug("Casting Abomination Limb [AOE]") return true end
    end
    -- Shackle the Unworthy
    -- shackle_the_unworthy,if=variable.st_planning&(cooldown.apocalypse.remains|!talent.army_of_the_damned&cooldown.dark_transformation.remains)|fight_remains<15
    if cast.able.shackleTheUnworthy() and var.stPlanning and (cd.apocalypse.exists() or not talent.armyOfTheDamned and cd.darkTransformation.exists()) then
        if cast.shackleTheUnworthy() then ui.debug("Casting Shackle the Unworthy") return true end
    end
    -- shackle_the_unworthy,if=active_enemies>=2&(death_and_decay.ticking|raid_event.adds.remains<=14)
    if cast.able.shackleTheUnworthy() and ui.useAOE(30,2) and buff.deathAndDecay.exists() then
        if cast.shackleTheUnworthy() then ui.debug("Casting Shackle the Unworthy [AOE]") return true end
    end
end -- End Action List - Covenants

-- Action List - AOE Setup
actionList.AOE_Setup = function()
    -- Death and Decal / Defile
    if ui.mode.dnd == 1 then
        -- any_dnd,if=death_knight.fwounded_targets=active_enemies|raid_event.adds.exists&raid_event.adds.remains<=11
        if var.fwoundTargets == #enemies.yards5 or (ui.mode.rotation == 2 and #enemies.yards5 <= 11) then
            if cast.able.defile() and talent.defile then
                if cast.defile("best",nil,2,8) then ui.debug("Casting Defile [AOE Setup]") return true end
            end
            if cast.able.deathAndDecay() and not talent.defile then
                if cast.deathAndDecay("best",nil,2,8) then ui.debug("Casting Death and Decay [AOE Setup]") return true end
            end
        end
        -- any_dnd,if=death_knight.fwounded_targets>=5
        if var.fwoundTargets >= 5 then
            if cast.able.defile() and talent.defile then
                if cast.defile("best",nil,2,8) then ui.debug("Casting Defile [AOE Setup - 5+]") return true end
            end
            if cast.able.deathAndDecay() and not talent.defile then
                if cast.deathAndDecay("best",nil,2,8) then ui.debug("Casting Death and Decay [AOE Setup - 5+]") return true end
            end
        end
    end
    -- Death Coil
    -- death_coil,if=!variable.pooling_runic_power&(buff.dark_transformation.up&runeforge.deadliest_coil&active_enemies<=3|active_enemies=2)
    if cast.able.deathCoil() and not var.poolingRunicPower and ((buff.darkTransformation.exists() and runeforge.deadliestCoil.equiped and ui.useST(30,4)) or #enemies.yards30 == 2) then
        if cast.deathCoil() then ui.debug("Casting Death Coil [AOE Setup - Deadliest Coil]") return true end
    end
    -- Epidemic
    -- epidemic,if=!variable.pooling_runic_power
    if cast.able.epidemic() and not var.poolingRunicPower and debuff.virulentPlague.exists(units.dyn30) then
        if cast.epidemic() then ui.debug("Casting Epidemic [AOE Setup - Low Runic or Sudden Doom]") return true end
    end
    -- Festering Strike
    if cast.able.festeringStrike() then
        -- festering_strike,target_if=max:debuff.festering_wound.stack,if=debuff.festering_wound.stack<=3&cooldown.apocalypse.remains<3
        if debuff.festeringWound.stack(var.fwoundHighUnit) <= 3 and cd.apocalypse.remain() < 3 then
            if cast.festeringStrike(var.fwoundHighUnit) then ui.debug("Casting Festering Strike [AOE Setup - Highest Stacks]") return true end
        end
        -- festering_strike,target_if=debuff.festering_wound.stack<1
        for i = 1, #enemies.yards5 do
            local thisUnit = enemies.yards5[i]
            if debuff.festeringWound.stack(thisUnit) < 1 then
                if cast.festeringStrike(thisUnit) then ui.debug("Casting Festering Strike [AOE Setup - No Stacks") return true end
            end
        end
        -- festering_strike,target_if=min:debuff.festering_wound.stack,if=rune.time_to_4<(cooldown.death_and_decay.remains&!talent.defile|cooldown.defile.remains&talent.defile)
        if runesTTM(4) < var.deathAndDefileRemain then
            if cast.festeringStrike(var.fwoundLowUnit) then ui.debug("Casting Festering Strike [AOE Setup - 4 Runes before DnD") return true end
        end
    end
    -- Epidemic
    -- epidemic,if=!variable.pooling_for_gargoyle
    if cast.able.epidemic() and not var.poolForGargoyle and debuff.virulentPlague.exists(units.dyn30) then
        if cast.epidemic() then ui.debug("Casting Epidemic [AOE Setup]") return true end
    end
end -- End Action List - AOE Setup

-- Action List - AOE Burst
actionList.AOE_Burst = function()
    -- Death Coil
    -- death_coil,if=(buff.sudden_doom.react|!variable.pooling_runic_power)&(buff.dark_transformation.up&runeforge.deadliest_coil&active_enemies<=3|active_enemies=2)
    if cast.able.deathCoil() and (buff.suddenDoom.exists() or not var.poolingRunicPower) and ((buff.darkTransformation.exists() and runeforge.deadliestCoil.equiped and ui.useST(30,4)) or #enemies.yards30 == 2) then
        if cast.deathCoil() then ui.debug("Casting Death Coil [AOE Burst - Deadliest Coil]") return true end
    end
    -- Epidemic
    if cast.able.epidemic() and debuff.virulentPlague.exists(units.dyn30) then
        -- epidemic,if=runic_power.deficit<(10+death_knight.fwounded_targets*3)&death_knight.fwounded_targets<6&!variable.pooling_runic_power|buff.swarming_mist.up
        if runicPowerDeficit < (10 + var.fwoundTargets * 3) and var.fwoundTargets < 6 and (not var.poolingRunicPower or buff.swarmingMist.exists()) then
            if cast.epidemic() then ui.debug("Casting Epidemic [AOE Burst - Low Wounded]") return true end
        end
        -- epidemic,if=runic_power.deficit<25&death_knight.fwounded_targets>5&!variable.pooling_runic_power
        if runicPowerDeficit < 25 and var.fwoundTargets > 5 and not var.poolingRunicPower then
            if cast.epidemic() then ui.debug("Casting Epidemic [AOE Burst - High Wounded]") return true end
        end
        -- epidemic,if=!death_knight.fwounded_targets&!variable.pooling_runic_power|fight_remains<5|raid_event.adds.exists&raid_event.adds.remains<5
        if var.fwoundTargets == 0 and (not var.poolingRunicPower or unit.ttdGroup(5) < 5 or ui.useAOE(8,2)) then
            if cast.epidemic() then ui.debug("Casting Epidemic [AOE Burst - No Wounded]") return true end
        end
    end
    -- Scourge Strike
    -- wound_spender
    if cast.able.scourgeStrike() then
        if cast.scourgeStrike() then ui.debug("Casting Scourge Strike [AOE Burst]") return true end
    end
    -- Epidemic
    -- epidemic,if=!variable.pooling_runic_power
    if cast.able.epidemic() and not var.poolingRunicPower and debuff.virulentPlague.exists(units.dyn30) then
        if cast.epidemic() then ui.debug("Casting Epidemic [AOE Burst]") return true end
    end
end -- End Action List - AOE Burst

-- Action List - AOE
actionList.AOE = function()
    -- Wait for Cooldown - Soul Reaper
    -- wait_for_cooldown,name=soul_reaper,if=talent.soul_reaper&target.time_to_pct_35<5&fight_remains>5&cooldown.soul_reaper.remains<(gcd*0.75)&active_enemies<=3
    if talent.soulReaper and unit.ttd(units.dyn5,35) < 5 and unit.ttdGroup(5) > 5 and cd.soulReaper.remains() < (unit.gcd(true) * 0.75) and #enemies.yards8 <= 3 then
        ui.debug("Waiting for Soul Reaper [AOE]")
        return true
    end
    -- Death Coil
    -- death_coil,if=(!variable.pooling_runic_power|buff.sudden_doom.react)&(buff.dark_transformation.up&runeforge.deadliest_coil&active_enemies<=3|active_enemies=2)
    if cast.able.deathCoil() and (not var.poolingRunicPower or buff.suddenDoom.exists()) and ((buff.darkTransformation.exists() and runeforge.deadliestCoil.equiped and ui.useST(30,4)) or #enemies.yards30 == 2) then
        if cast.deathCoil() then ui.debug("Casting Death Coil [AOE - Deadliest Coil]") return true end
    end
    -- Epidemic
    -- epidemic,if=buff.sudden_doom.react|!variable.pooling_for_gargoyle
    if cast.able.epidemic() and debuff.virulentPlague.exists(units.dyn30) and (buff.suddenDoom.exists() or not var.poolForGargoyle) then
        if cast.epidemic() then ui.debug("Casting Epidemic [AOE]") return true end
    end
    -- Scourge Strike
    -- wound_spender,target_if=max:debuff.festering_wound.stack,if=(cooldown.apocalypse.remains>5&debuff.festering_wound.up|debuff.festering_wound.stack>4)&(fight_remains<cooldown.death_and_decay.remains+10|fight_remains>cooldown.apocalypse.remains)
    if cast.able.scourgeStrike() and ((cd.apocalypse.remain() > 5 or var.apocBypass) and debuff.festeringWound.exists(var.fwoundHighUnit) or var.fwoundHighest > 4)
        and (unit.ttdGroup(40) < cd.deathAndDecay.remains() + 10 or unit.ttdGroup(40) > cd.apocalypse.remains())
    then
        if cast.scourgeStrike(var.fwoundHighUnit) then ui.debug("Casting Scourge Strike [AOE]") return true end
    end
    -- Festering Strike
    if cast.able.festeringStrike() then
        -- festering_strike,target_if=max:debuff.festering_wound.stack,if=debuff.festering_wound.stack<=3&cooldown.apocalypse.remains<3|debuff.festering_wound.stack<1
        if var.fwoundHighest <= 3 and cd.apocalypse.remains() < 3 or var.fwoundHighest < 1 then
            if cast.festeringStrike(var.fwoundHighUnit) then ui.debug("Casting Festering Strike [AOE - Max Stack Low") return true end
        end 
        -- festering_strike,target_if=min:debuff.festering_wound.stack,if=cooldown.apocalypse.remains>5&debuff.festering_wound.stack<1
        if (cd.apocalypse.remains() > 5 or var.apocBypass) and var.fwoundLowest < 1 then
            if cast.festeringStrike(var.fwoundLowUnit) then ui.debug("Casting Festering Strike [AOE - Low Stack") return true end
        end
    end
end -- End Action List - AOE

-- Action List - Generic
actionList.Single = function()
    -- Death Coil
    if cast.able.deathCoil() then
        -- death_coil,if=buff.sudden_doom.react&!variable.pooling_runic_power|pet.gargoyle.active
        if cast.able.deathCoil() and buff.suddenDoom.exists() and (not var.poolingRunicPower or pet.gargoyle.exists()) then
            if cast.deathCoil() then ui.debug("Casting Death Coil [ST Sudden Doom]") return true end
        end
        -- death_coil,if=runic_power.deficit<13&
        if cast.able.deathCoil() and runicPowerDeficit < 13 then
            if cast.deathCoil() then ui.debug("Casting Death Coil [ST High Runic Power]") return true end
        end
    end
    -- Any DnD
    -- any_dnd,if=cooldown.apocalypse.remains&(talent.defile.enabled|covenant.night_fae|runeforge.phearomones)&(!variable.pooling_runes|fight_remains<5)
    if ui.mode.dnd == 1 and ((cd.apocalypse.exists() or var.apocBypass) and (talent.defile or covenant.nightFae.active or runeforge.phearomones.equiped) and not var.poolingRunes) then
        if cast.able.defile() and talent.defile then
            if cast.defile("best",nil,1,8) then ui.debug("Casting Defile [ST]") return true end
        end
        if cast.able.deathAndDecay() and not talent.defile then
            if cast.deathAndDecay("best",nil,1,8) then ui.debug("Casting Death and Decay [ST]") return true end
        end
    end 
    -- Scourge Strike
    if cast.able.scourgeStrike() then
        -- wound_spender,if=debuff.festering_wound.stack>4&!variable.pooling_runes
        if debuff.festeringWound.stack(units.dyn5) > 4 and not var.poolingRunes then
            if cast.scourgeStrike() then ui.debug("Casting Scourge Strike [ST - High Wound Stack]") return true end
        end
        -- wound_spender,if=debuff.festering_wound.up&cooldown.apocalypse.remains>5&!variable.pooling_runes&(!talent.unholy_blight|talent.army_of_the_damned&conduit.convocation_of_the_dead.rank<5|!talent.army_of_the_damned&conduit.convocation_of_the_dead.rank>=5|!conduit.convocation_of_the_dead)
        if debuff.festeringWound.exists(unit.dyn5) and (cd.apocalypse.remains() > 5 or var.apocBypass) and not var.poolingRunes
            and (not talent.unholyBlight or (talent.armyOfTheDamned and conduit.convocationOfTheDead.rank < 5)
                or (not talent.armyOfTheDamned and conduit.convocationOfTheDead.rank >= 5) or not conduit.convocationOfTheDead.active)
        then
            if cast.scourgeStrike() then ui.debug("Casting Scourge Strike [No Apocalypse Soon]") return true end
        end
        -- wound_spender,if=debuff.festering_wound.up&talent.unholy_blight&!variable.pooling_runes&(!talent.army_of_the_damned&conduit.convocation_of_the_dead.rank<5|talent.army_of_the_damned&conduit.convocation_of_the_dead.rank>=5)&(cooldown.unholy_blight.remains>10&!dot.unholy_blight_dot.remains|cooldown.apocalypse.remains>10)
        if debuff.festeringWound.exists(unit.dyn5) and talent.unholyBlight and not var.poolingRunes
            and (not talent.armyOfTheDamned and conduit.convocationOfTheDead.rank < 5 or talent.armyOfTheDamned and conduit.convocationOfTheDead.rank >= 5)
            and (cd.unholyBlight.remains() > 10 and not debuff.unholyBlight.exists(units.dyn5) or cd.apocalypse.remains() > 10)
        then
            if cast.scourgeStrike() then ui.debug("Casting Scourge Strike [ST - Unholy Blight]") return true end
        end
    end
    -- Death Coil
    -- death_coil,if=runic_power.deficit<20&!variable.pooling_runic_power
    if cast.able.deathCoil() and runicPowerDeficit < 20 and not var.poolingRunicPower then
        if cast.deathCoil() then ui.debug("Casting Death Coil [ST High Runic Power]") return true end
    end
    -- Festering Strike
    if cast.able.festeringStrike() then
        -- festering_strike,if=debuff.festering_wound.stack<1&!variable.pooling_runes
        if debuff.festeringWound.stack(units.dyn5) < 1 and not var.poolingRunes then
            if cast.festeringStrike() then ui.debug("Casting Festering Strike [ST - No Wounds / No Apocalypse]") return true end
        end
        -- festering_strike,if=debuff.festering_wound.stack<4&cooldown.apocalypse.remains<5&!variable.pooling_runes&(!talent.unholy_blight|talent.army_of_the_damned&conduit.convocation_of_the_dead.rank<5|!talent.army_of_the_damned&conduit.convocation_of_the_dead.rank>=5|!conduit.convocation_of_the_dead)
        if debuff.festeringWound.stack(units.dyn5) < 4 and (cd.apocalypse.remains() < 5 or var.apocBypass) and not var.poolingRunes
            and (not talent.unholyBlight or (talent.armyOfTheDamned and conduit.convocationOfTheDead.rank < 5)
                or (not talent.armyOfTheDamned and conduit.convocationOfTheDead.rank >= 5) or not conduit.convocationOfTheDead.active)
        then
            if cast.festeringStrike() then ui.debug("Casting Festering Strike [ST - Apoc Soon]") return true end
        end
        -- festering_strike,if=debuff.festering_wound.stack<4&talent.unholy_blight&!variable.pooling_runes&(!talent.army_of_the_damned&conduit.convocation_of_the_dead.rank<5|talent.army_of_the_damned&conduit.convocation_of_the_dead.rank>=5)&(cooldown.unholy_blight.remains<10|cooldown.apocalypse.remains<10&dot.unholy_blight_dot.remains)
        if debuff.festeringWound.stack(unit.dyn5) < 4 and talent.unholyBlight and not var.poolingRunes
            and (not talent.armyOfTheDamned and conduit.convocationOfTheDead.rank < 5 or talent.armyOfTheDamned and conduit.convocationOfTheDead.rank >= 5)
            and (cd.unholyBlight.remains() < 10 or cd.apocalypse.remains() < 10 and debuff.unholyBlight.exists(units.dyn5))
        then
            if cast.festeringStrike() then ui.debug("Casting Festering Strike [ST - Unholy Blight]") return true end
        end
    end
    -- Death Coil
    -- death_coil,if=!variable.pooling_runic_power
    if cast.able.deathCoil() and not var.poolingRunicPower then
        if cast.deathCoil() then ui.debug("Casting Death Coil [ST Dump]") return true end
    end
end -- End Action List - Single

-- Action List - PreCombat
actionList.PreCombat = function()
    -- Flask Module
    module.FlaskUp("Strength")
    -- Pre-pull
    if ui.checked("Pre-Pull Timer") and ui.pullTimer() <= ui.value("Pre-Pull Timer") then
        -- Potion
        if ui.checked("Potion") and use.able.battlePotionOfStrength() and ui.useCDs() and var.inRaid then
            use.battlePotionOfStrength()
            ui.debug("Using Battle Potion of Strength")
        end
        -- Army of the Dead
        if ui.alwaysCdNeer("Army of the Dead") and ui.pullTimer() <= 2 then
            if cast.armyOfTheDead() then ui.debug("Casting Army of the Dead [Pre-Pull]") return true end
        end
        -- Azshara's Font of Power
        if (ui.value("Trinkets") == 1 or (ui.value("Trinkets") == 2 and ui.useCDs())) and equiped.azsharasFontOfPower() 
            and use.able.azsharasFontOfPower() and not unit.moving("player") and not unit.inCombat() and ui.pullTimer()<= ui.value("Pre-Pull Timer")
        then
            if use.azsharasFontOfPower() then ui.debug("Using Azshara's Font of Power [Pre-Pull]") return true end
        end               
    end 
    -- Pull
    if unit.valid("target") and not unit.inCombat() then
        -- Death Grip
        if ui.checked("Death Grip - Pre-Combat") and cast.able.deathGrip("target") and not unit.br.isDummy("target")
            and unit.distance("target") > 10 and ((talent.deathsReach and unit.distance("target") < 40) or unit.distance("target") < 30)
        then
            if cast.deathGrip("target") then ui.debug("Casting Death Grip [Pull]") return true end
        end
        -- Dark Command
        if ui.checked("Dark Command") and cast.able.darkCommand("target") and not (ui.checked("Death Grip") or cast.able.deathGrip("target")) then
            if cast.darkCommand("target") then ui.debug("Casting Dark Command [Pull]") return true end
        end
        -- Start Attack
        unit.startAttack("target")
    end
end -- End Action List - PreCombat

----------------
--- ROTATION ---
----------------
local function runRotation()
--------------
--- Locals ---
--------------
    -- BR Player API
    buff                                          = br.player.buff
    cast                                          = br.player.cast
    cd                                            = br.player.cd
    conduit                                       = br.player.conduit
    covenant                                      = br.player.covenant
    debuff                                        = br.player.debuff
    enemies                                       = br.player.enemies
    equiped                                       = br.player.equiped
    essence                                       = br.player.essence
    module                                        = br.player.module
    pet                                           = br.player.pet
    runeforge                                     = br.player.runeforge
    runes                                         = br.player.power.runes.amount()
    runeDeficit                                   = br.player.power.runes.deficit()
    runesTTM                                      = br.player.power.runes.ttm
    runicPower                                    = br.player.power.runicPower.amount()
    runicPowerDeficit                             = br.player.power.runicPower.deficit()
    spell                                         = br.player.spell
    talent                                        = br.player.talent
    ui                                            = br.player.ui
    unit                                          = br.player.unit
    units                                         = br.player.units
    use                                           = br.player.use
    var                                           = br.player.variables

    -- Units Declaration
    units.get(5)
    units.get(25)
    units.get(30)
    units.get(30,true)
    units.get(40)
    -- Enemies Declaration
    enemies.get(5)
    enemies.get(8)
    enemies.get(8,"target")
    enemies.get(8,"player",false,true) -- makes enemies.yards8f
    enemies.get(15)
    enemies.get(20)
    enemies.get(30)
    enemies.get(40)
    enemies.get(45)
    enemies.get(40,"player",true)
    enemies.yards8r = getEnemiesInRect(10,20,false) or 0

    -- Nil Checks
    if var.profileStop == nil then var.profileStop = false end

    -- Variables
    -- variable,name=pooling_runic_power,value=cooldown.summon_gargoyle.remains<5&talent.summon_gargoyle
    var.poolingRunicPower =  ui.alwaysCdNever("Summon Gargoyle") and cd.summonGargoyle.remain() < 5 and talent.summonGargoyle
    -- variable,name=pooling_runes,value=talent.soul_reaper&rune<2&target.time_to_pct_35<5&fight_remains>5
    var.poolingRunes = talent.soulReaper and runes < 2 and unit.ttd(units.dyn5,30) < 5 and unit.ttdGroup(5) > 5
    -- variable,name=st_planning,value=active_enemies=1&(!raid_event.adds.exists|raid_event.adds.in>15)
    var.stPlanning = ui.useST(8,2)
    -- variable,name=major_cooldowns_active,value=pet.gargoyle.active|buff.unholy_assault.up|talent.army_of_the_damned&pet.apoc_ghoul.active|buff.dark_transformation.up
    var.majorCooldownsActive = pet.gargoyle.active or buff.unholyAssault.exists() or (talent.armyOfTheDamned and pet.apocGhoul.active) or buff.darkTransformation.exists()
    var.deathAndDecayRemain = (cd.deathAndDecay.remain() - 10) > 0 and (cd.deathAndDecay.remain() - 10) or 0
    var.deathAndDefileRemain = talent.defile and cd.defile.remain() or cd.deathAndDecay.remain()
    var.apocBypass = not ui.alwaysCdNever("Apocalypse") or not spell.known.apocalypse() or unit.level() < 19
    var.aotdBypass = not ui.alwaysCdNever("Army of the Dead") or not spell.known.armyOfTheDead() or unit.level() < 44
    var.fwoundTargets = 0
    var.fwoundHighest = 0
    var.fwoundHighUnit = "target"
    var.fwoundLowest = 99
    var.fwoundLowUnit = "target"
    for i = 1, #enemies.yards5 do
        local thisUnit = enemies.yards5[i]
        local fwoundStacks = debuff.festeringWound.stack(thisUnit)
        if fwoundStacks > 0 then
            var.fwoundTargets = var.fwoundTargets + 1
            if fwoundStacks >= var.fwoundHighest then
                var.fwoundHighest = fwoundStacks
                var.fwoundHighUnit = thisUnit
            end
            if fwoundStacks <= var.fwoundLowest then
                var.fwoundLowest = fwoundStacks
                var.fwoundLowUnit = thisUnit
            end
        end
    end

-----------------
--- Rotations ---
-----------------
    -- Profile Stop | Pause
    if not unit.inCombat() and not unit.exists("target") and var.profileStop then
        var.profileStop = false
    elseif (unit.inCombat() and var.profileStop) or ui.pause() or ui.mode.rotation == 4 then
        if ui.checked("Auto Attack/Passive") and ui.pause(true) and IsPetAttackActive() then
            PetStopAttack()
            PetFollow()
        end
        return true
    else
--------------------
--- Pet Rotation ---
--------------------
        if actionList.PetManagement() then return true end
-----------------------
--- Extras Rotation ---
-----------------------
        if actionList.Extras() then return true end
--------------------------
--- Defensive Rotation ---
--------------------------
        if actionList.Defensive() then return true end
------------------------------
--- Out of Combat Rotation ---
------------------------------
        if actionList.PreCombat() then return true end
--------------------------
--- In Combat Rotation ---
--------------------------
        if unit.inCombat() and not var.profileStop and unit.exists("target") then
            -- auto_attack
            unit.startAttack("target")
    ------------------------------
    --- In Combat - Interrupts ---
    ------------------------------
            if actionList.Interrupts() then return true end
    ---------------------------
    --- SimulationCraft APL ---
    ---------------------------
            if ui.value("APL Mode") == 1 then
                -- Racial                    
                if ui.checked("Racial") and cast.able.racial()
                    -- arcane_torrent,if=runic_power.deficit>65&(pet.gargoyle.active|!talent.summon_gargoyle)&rune.deficit>=5
                    and ((unit.race() == "BloodElf" and runicPowerDeficit > 65 and (pet.gargoyle.exists() or not talent.summonGargoyle) and runeDeficit >= 5)
                    -- blood_fury,if=variable.major_cooldowns_active|target.time_to_die<=buff.blood_fury.duration
                    or (unit.race() == "Orc" and (var.majorCooldownsActive or unit.ttd(units.dyn5) <= cd.racial.duration()))
                    -- berserking,if=variable.major_cooldowns_active|target.time_to_die<=buff.berserking.duration
                    or (unit.race() == "Troll" and (var.majorCooldownsActive or unit.ttd(units.dyn5) <= cd.racial.duration()))
                    -- lights_judgment,if=buff.unholy_strength.up
                    or (unit.race() == "LightforgedDraenei" and buff.unholyStrength)
                    -- ancestral_call,if=variable.major_cooldowns_active|target.time_to_die<=15
                    or (unit.race() == "MagharOrc" and (var.majorCooldownsActive or unit.ttd(units.dyn5) <= 15))
                    -- arcane_pulse,if=active_enemies>=2|(rune.deficit>=5&runic_power.deficit>=60)
                    or (unit.race() == "Nightborne" and (ui.useAOE(8,2) or (runeDeficit >= 5 and runicPowerDeficit >= 60)))
                    -- fireblood,if=variable.major_cooldowns_active|target.time_to_die<=buff.fireblood.duration
                    or (unit.race() == "DarkIronDwarf" and (var.majorCooldownsActive or unit.ttd(units.dyn5) <= cd.racial.duration()))
                    -- bag_of_tricks,if=buff.unholy_strength.up&active_enemies=1
                    )
                then
                    if cast.racial("player") then ui.debug("Casting Racial") return true end
                end
                -- Augment Rune
                if ui.checked("Augment Rune") and use.able.battleScarredAugmentRune() and var.inRaid then
                    use.battleScarredAugmentRune()
                    ui.debug("Using Augment Rune")
                end
                -- -- Trinkets
                -- if (ui.value("Trinkets") == 1 or (ui.value("Trinkets") == 2 and ui.useCDs())) and unit.exists(units.dyn5) and unit.distance(units.dyn5) < 5 then
                --     for i = 13, 14 do
                --         if use.able.slot(i) then
                --             -- All Others
                --             -- use_items,if=time>20|!equipped.ramping_amplitude_gigavolt_engine|!equipped.vision_of_demise
                --             if unit.combatTime > 20 or not (equiped.azsharasFontOfPower(i) or equiped.ashvanesRazorCoral(i) or equiped.visionOfDemise(i)
                --                 or equiped.rampingAmplitudeGigavoltEngine(i) or equiped.bygoneBeeAlmanac(i)
                --                 or equiped.jesHowler(i) or equiped.galecallersBeak(i) or equiped.grongsPrimalRage(i))
                --             then
                --                 use.slot(i)
                --                 ui.debug("Using Trinket [Slot "..i.."]")
                --             end
                --         end
                --     end
                -- end
                -- Potion
                -- potion,if=cooldown.army_of_the_dead.ready|pet.gargoyle.exists|buff.unholy_frenzy.up
                if ui.checked("Potion") and var.inRaid and ui.useCDs() and use.able.battlePotionOfStrength()
                    and (cd.armyOfTheDead.remain() == 0 or pet.gargoyle.exists() or buff.unholyAssault.exists())
                then
                    use.battlePotionOfStrength()
                    ui.debug("Using Battle Potion of Strength")
                end
                -- Outbreak
                -- outbreak,if=dot.virulent_plague.refreshable&!talent.unholy_blight&!raid_event.adds.exists
                if cast.able.outbreak(units.dyn25) and debuff.virulentPlague.refresh(units.dyn25)
                    and (not talent.unholyBlight) and ui.useST(25,2)
                then
                    if cast.outbreak(units.dyn25) then ui.debug("Casting Outbreak [ST]") return true end
                end
                -- outbreak,if=dot.virulent_plague.refreshable&active_enemies>=2&(!talent.unholy_blight|talent.unholy_blight&cooldown.unholy_blight.remains)
                if cast.able.outbreak(units.dyn25) and debuff.virulentPlague.refresh(units.dyn25) and ui.useAOE(25,2)
                    and (not talent.unholyBlight or (talent.unholyBlight and cd.unholyBlight.exists()))
                then
                    if cast.outbreak(units.dyn25) then ui.debug("Casting Outbreak [AOE]") return true end
                end
                -- outbreak,if=runeforge.superstrain.equipped&(dot.frost_fever.refreshable|dot.blood_plague.refreshable)
                if cast.able.outbreak(units.dyn25) and runeforge.superstrain.equiped and (debuff.frostFever.refresh(units.dyn25) or debuff.bloodPlague.refresh()) then
                    if cast.outbreak(units.dyn25) then ui.debug("Casting Outbreak [Superstrain]") return true end
                end
                -- wait_for_cooldown,name=soul_reaper,if=talent.soul_reaper&target.time_to_pct_35<5&fight_remains>5&cooldown.soul_reaper.remains<(gcd*0.75)&active_enemies=1
                if talent.soulReaper and unit.ttd(units.dyn5,35) < 5 and unit.ttdGroup(5) > 5 and cd.soulReaper.remains() < (unit.gcd(true) * 0.75) and #enemies.yards5 == 1 then
                    ui.debug("Waiting for Soul Reaper")
                    return true
                end
                -- Call Action List - Covenants
                if ui.alwaysCdNever("Covenant Ability") then
                    if actionList.Covenants() then return true end
                end
                -- Call Action List - Cooldowns
                -- call_action_list,name=cooldowns
                if actionList.Cooldowns() then return true end
                -- Run Action List - AOE
                -- run_action_list,name=aoe_setup,if=active_enemies>=2&(cooldown.death_and_decay.remains<10&!talent.defile|cooldown.defile.remains<10&talent.defile)&!death_and_decay.ticking
                if ui.useAOE(8,2)
                    and ((cd.deathAndDecay.remain() < 10 and not talent.defile) or (cd.defile.remains() < 10 and talent.defile))
                    and not buff.deathAndDecay.exists()
                then
                    if actionList.AOE_Setup() then return true end
                end
                -- run_action_list,name=aoe_burst,if=active_enemies>=2&death_and_decay.ticking
                if ui.useAOE(8,2) and buff.deathAndDecay.exists() then
                    if actionList.AOE_Burst() then return true end
                end
                -- run_action_list,name=generic_aoe,if=active_enemies>=2&(!death_and_decay.ticking&(cooldown.death_and_decay.remains>10&!talent.defile|cooldown.defile.remains>10&talent.defile))
                if ui.useAOE(8,2)
                    and not buff.deathAndDecay.exists() and ((cd.deathAndDecay.remains() > 10 and not talent.defile) or (cd.defile.remain() > 10 and talent.defile))
                then
                    if actionList.AOE_Burst() then return true end
                end
                -- Call Action List - Single
                -- call_action_list,name=generic
                if ui.useST(8,2) then
                    if actionList.Single() then return true end
                end
            end -- End SimC APL
        end -- End Rotation
    end -- End Pause Check
end -- End runRotation

-- Add To Rotation List
local id = 252
if br.rotations[id] == nil then br.rotations[id] = {} end
tinsert(br.rotations[id],{
    name = rotationName,
    toggles = createToggles,
    options = createOptions,
    run = runRotation,
})
