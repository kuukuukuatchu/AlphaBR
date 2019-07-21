local rotationName = "Laksmackt" -- Change to name of profile listed in options drop down

---------------
--- Toggles ---
---------------
local function createToggles()
    -- Define custom toggles
    -- Rotation Button
    RotationModes = {
        [1] = { mode = "Auto", value = 1, overlay = "Automatic Rotation", tip = "Swaps between Single and Multiple based on number of enemies in range.", highlight = 1, icon = br.player.spell.moonfire },
        [2] = { mode = "Mult", value = 2, overlay = "Multi Target rotation", tip = "Multi Target rotation", highlight = 1, icon = br.player.spell.starfall },
        [3] = { mode = "Sing", value = 3, overlay = "Force single target", tip = "Force single target", highlight = 0, icon = br.player.spell.solarWrath },
        [4] = { mode = "Off", value = 4, overlay = "DPS Rotation Disabled", tip = "Disable DPS Rotation", highlight = 0, icon = br.player.spell.soothe }
    };

    CreateButton("Rotation", 1, 0)
    -- Cooldown Button
    CooldownModes = {
        [1] = { mode = "Auto", value = 1, overlay = "Cooldowns Automated", tip = "Automatic Cooldowns - Boss Detection.", highlight = 1, icon = br.player.spell.celestialAlignment },
        [2] = { mode = "On", value = 2, overlay = "Cooldowns Enabled", tip = "Cooldowns used regardless of target.", highlight = 1, icon = br.player.spell.celestialAlignment },
        [3] = { mode = "Off", value = 3, overlay = "Cooldowns Disabled", tip = "No Cooldowns will be used.", highlight = 0, icon = br.player.spell.celestialAlignment }
    };
    CreateButton("Cooldown", 2, 0)
    -- Defensive Button
    DefensiveModes = {
        [1] = { mode = "On", value = 1, overlay = "Defensive Enabled", tip = "Includes Defensive Cooldowns.", highlight = 1, icon = br.player.spell.barkskin },
        [2] = { mode = "Off", value = 2, overlay = "Defensive Disabled", tip = "No Defensives will be used.", highlight = 0, icon = br.player.spell.barkskin }
    };
    CreateButton("Defensive", 3, 0)
    -- Interrupt Button
    InterruptModes = {
        [1] = { mode = "On", value = 1, overlay = "Interrupts Enabled", tip = "Includes Basic Interrupts.", highlight = 1, icon = br.player.spell.solarBeam },
        [2] = { mode = "Off", value = 2, overlay = "Interrupts Disabled", tip = "No Interrupts will be used.", highlight = 0, icon = br.player.spell.solarBeam }
    };
    CreateButton("Interrupt", 4, 0)
    -- FoN Button
    ForceofNatureModes = {
        [1] = { mode = "On", value = 1, overlay = "Force of Nature Enabled", tip = "Will Use Force of Nature", highlight = 0, icon = br.player.spell.forceOfNature },
        [2] = { mode = "Key", value = 2, overlay = "Force of Nature hotkey", tip = "Key triggers Force of Nature", highlight = 0, icon = br.player.spell.forceOfNature },
        [3] = { mode = "Off", value = 2, overlay = "Force of Nature Disabled", tip = "Will Not Use Force of Nature", highlight = 0, icon = br.player.spell.forceOfNature }
    };
    CreateButton("ForceofNature", 5, 0)

    FormsModes = {
        [1] = { mode = "On", value = 1, overlay = "Auto Forms Enabled", tip = "Will change forms", highlight = 0, icon = br.player.spell.travelForm },
        [2] = { mode = "Off", value = 2, overlay = "Auto Forms hotkey", tip = "Key triggers Auto Forms", highlight = 0, icon = br.player.spell.travelForm },
    };
    CreateButton("Forms", 6, 0)

end
---------------
--- OPTIONS ---
---------------
local function createOptions()
    local optionTable

    local function rotationOptions()
        -----------------------
        --- GENERAL OPTIONS --- -- Define General Options
        -----------------------
        section = br.ui:createSection(br.ui.window.profile, "General")
        br.ui:createSpinner(section, "Pre-Pull Timer", 2.5, 0, 10, 0.5, "|cffFFFFFFSet to desired time to start Pre-Pull (DBM Required). Min: 1 / Max: 10 / Interval: 1")
        if br.player.talent.restorationAffinity then
            br.ui:createSpinner(section, "OOC Regrowth", 50, 1, 100, 5, "Set health to heal while out of combat. Min: 1 / Max: 100 / Interval: 5")
            br.ui:createSpinner(section, "OOC Wild Growth", 50, 1, 100, 5, "Set health to heal while out of combat. Min: 1 / Max: 100 / Interval: 5")
        end
        br.ui:createCheckbox(section, "Auto Shapeshifts")
        br.ui:createCheckbox(section, "Auto Soothe")
        br.ui:createCheckbox(section, "Auto Engage On Target", "Check this to cast sunfire on target OOC to engage combat")
        br.ui:checkSectionState(section)
        section = br.ui:createSection(br.ui.window.profile, "Healing")
        br.ui:createDropdown(section, "Rebirth", { "|cff00FF00Tanks", "|cffFFFF00Healers", "|cffFFFFFFTanks and Healers", "|cffFF0000Mouseover Target", "|cffFFFFFFAny" }, 3, "", "|ccfFFFFFFTarget to Cast On")
        br.ui:createCheckbox(section, "Revive target")
        br.ui:createDropdown(section, "Remove Corruption", { "|cff00FF00Player Only", "|cffFFFF00Selected Target", "|cffFFFFFFPlayer and Target", "|cffFF0000Mouseover Target", "|cffFFFFFFAny" }, 3, "", "|ccfFFFFFFTarget to Cast On")
        br.ui:createDropdown(section, "Off-healing", { "Nope", "always", "No-Healer" }, 1, "", "offheal")

        br.ui:checkSectionState(section)

        ------------------------
        --- COOLDOWN OPTIONS --- -- Define Cooldown Options
        ------------------------
        section = br.ui:createSection(br.ui.window.profile, "M+")
        br.ui:createCheckbox(section, "Freehold - pig")
        br.ui:createCheckbox(section, "Freehold - root grenadier")
        br.ui:createCheckbox(section, "Atal - root Spirit of Gold")
        br.ui:checkSectionState(section)

        ------------------------
        --- COOLDOWN OPTIONS --- -- Define Cooldown Options
        ------------------------
        section = br.ui:createSection(br.ui.window.profile, "Cooldowns")
        br.ui:createCheckbox(section, "Auto Innervate", "Use Innervate if you have Lively Spirit traits for DPS buff")
        br.ui:createDropdown(section, "Pots", { "None", "Battle", "RisingDeath", "Draenic", "Prolonged" }, 1, "", "Use Pot when Incarnation/Celestial Alignment is up")
        br.ui:createCheckbox(section, "Racial")
        br.ui:createCheckbox(section, "Use Trinkets")
        br.ui:createCheckbox(section, "Warrior Of Elune")
        br.ui:createCheckbox(section, "Fury Of Elune")
        br.ui:createSpinnerWithout(section, "Fury of Elune Targets", 3, 1, 10, 1, "How many baddies before using Fury?")
        br.ui:createCheckbox(section, "Group Fury with CD")
        br.ui:createCheckbox(section, "Incarnation/Celestial Alignment")
        br.ui:createSpinnerWithout(section, "Treant Targets", 3, 1, 10, 1, "How many baddies before using Treant?")
        br.ui:createCheckbox(section, "Group treants with CD")
        br.ui:createDropdown(section, "Treants Key", br.dropOptions.Toggle, 6, "", "|cffFFFFFFTreant Key")
        br.ui:createSpinner(section, "ConcentratedFlame - Heal", 5, 0, 100, 5, "", "health to heal at")
        br.ui:createCheckbox(section, "ConcentratedFlame - DPS")
        br.ui:createSpinner(section, "Focused Azerite Beam", 3, 1, 10, 1, "|cffFFFFFF Min. units hit to use Focused Azerite Beam")

        br.ui:createCheckbox(section, "Opener")
        br.ui:checkSectionState(section)
        -------------------------
        ---  TARGET OPTIONS   ---  -- Define Target Options
        -------------------------
        section = br.ui:createSection(br.ui.window.profile, "Targets")
        br.ui:createSpinnerWithout(section, "Max Stellar Flare Targets", 2, 1, 10, 1, "|cff0070deSet to maximum number of targets to dot with Stellar Flare. Min: 1 / Max: 10 / Interval: 1")
        br.ui:createSpinnerWithout(section, "Max Moonfire Targets", 2, 1, 10, 1, "|cff0070deSet to maximum number of targets to dot with Moonfire. Min: 1 / Max: 10 / Interval: 1")
        br.ui:createSpinnerWithout(section, "Max Sunfire Targets", 2, 1, 10, 1, "|cff0070deSet to maximum number of targets to dot with Sunfire. Min: 1 / Max: 10 / Interval: 1")
        br.ui:createCheckbox(section, "Safe Dots")
        br.ui:createSpinnerWithout(section, "Starfall Targets (0 for auto)", 0, 0, 10, 1, "|cff0070deSet to minimum number of targets to use Starfall. 0 to calculate")
        br.ui:createSpinnerWithout(section, "Fury of Elune Targets", 2, 1, 10, 1, "|cff0070deSet to minimum number of targets to use Fury of Elune. Min: 1 / Max: 10 / Interval: 1")
        br.ui:createCheckbox(section, "Ignore dots during pewbuff")
        br.ui:checkSectionState(section)
        -------------------------
        --- DEFENSIVE OPTIONS --- -- Define Defensive Options
        -------------------------
        section = br.ui:createSection(br.ui.window.profile, "Defensive")
        br.ui:createSpinner(section, "Potion/Healthstone", 20, 0, 100, 5, "Health Percent to Cast At")
        br.ui:createSpinner(section, "Renewal", 25, 0, 100, 5, "Health Percent to Cast At")
        br.ui:createSpinner(section, "Barkskin", 60, 0, 100, 5, "Health Percent to Cast At")
        br.ui:createSpinner(section, "Regrowth", 30, 0, 100, 5, "Health Percent to Cast At")
        br.ui:createSpinner(section, "Swiftmend", 15, 0, 100, 5, "Health Percent to Cast At")
        br.ui:createDropdown(section, "Bear Form Key", br.dropOptions.Toggle, 6, "", "|cffFFFFFFGO BEAR GO!")
        br.ui:checkSectionState(section)
        -------------------------
        --- INTERRUPT OPTIONS --- -- Define Interrupt Options
        -------------------------
        section = br.ui:createSection(br.ui.window.profile, "Interrupts")
        br.ui:createCheckbox(section, "Solar Beam")
        br.ui:createCheckbox(section, "Mighty Bash")
        br.ui:createCheckbox(section, "Typhoon")
        -- Interrupt Percentage
        br.ui:createSpinner(section, "InterruptAt", 0, 0, 95, 5, "|cffFFBB00Cast Percentage to use at.")
        br.ui:checkSectionState(section)
        ----------------------
        --- TOGGLE OPTIONS --- -- Define Toggle Options
        ----------------------
        section = br.ui:createSection(br.ui.window.profile, "Toggle Keys")
        -- Single/Multi Toggle
        br.ui:createDropdown(section, "Rotation Mode", br.dropOptions.Toggle, 4)
        --Cooldown Key Toggle
        br.ui:createDropdown(section, "Cooldown Mode", br.dropOptions.Toggle, 3)
        --Defensive Key Toggle
        br.ui:createDropdown(section, "Defensive Mode", br.dropOptions.Toggle, 6)
        -- Interrupts Key Toggle
        br.ui:createDropdown(section, "Interrupt Mode", br.dropOptions.Toggle, 6)
        -- Pause Toggle
        br.ui:createDropdown(section, "Pause Mode", br.dropOptions.Toggle, 6)
        br.ui:checkSectionState(section)
    end
    optionTable = { {
                        [1] = "Rotation Options",
                        [2] = rotationOptions,
                    } }
    return optionTable
end

local opener

local function runRotation()

    ---------------
    --- Toggles --- -- List toggles here in order to update when pressed
    ---------------
    UpdateToggle("Rotation", 0.25)
    UpdateToggle("Cooldown", 0.25)
    UpdateToggle("Defensive", 0.25)
    UpdateToggle("Interrupt", 0.25)
    UpdateToggle("ForceofNature", 0.25)
    UpdateToggle("Forms", 0.25)

    br.player.mode.forceOfNature = br.data.settings[br.selectedSpec].toggles["ForceofNature"]
    br.player.mode.DPS = br.data.settings[br.selectedSpec].toggles["Rotation"]
    br.player.mode.forms = br.data.settings[br.selectedSpec].toggles["Forms"]


    --------------
    --- Locals ---
    --------------
    -- local artifact                                      = br.player.artifact
    -- local combatTime                                    = getCombatTime()
    -- local cd                                            = br.player.cd
    -- local falling, swimming, flying, moving             = getFallTime(), IsSwimming(), IsFlying(), GetUnitSpeed("player")>0
    -- local healPot                                       = getHealthPot()
    -- local level                                         = br.player.level
    local lowestHP = br.friend[1].unit
    local lowest = br.friend[1]
    local mana = getMana("player")
    -- local perk                                          = br.player.perk

    local power, powmax, powgen = br.player.power.astralPower.amount(), br.player.powerMax, br.player.powerRegen
    -- local ttm                                           = br.player.power.mana.ttm()
    --------------
    -- Player
    --------------
    local buff = br.player.buff
    local cast = br.player.cast
    local php = br.player.health
    local spell = br.player.spell
    local talent = br.player.talent
    local cd = br.player.cd
    local gcd = br.player.gcdMax
    local charges = br.player.charges
    local debuff = br.player.debuff
    local drinking = getBuffRemain("player", 192002) ~= 0 or getBuffRemain("player", 167152) ~= 0 or getBuffRemain("player", 192001) ~= 0
    local resable = UnitIsPlayer("target") and UnitIsDeadOrGhost("target") and GetUnitIsFriend("target", "player") and UnitInRange("target")
    local inCombat = isInCombat("player")
    local inInstance = br.player.instance == "party" or br.player.instance == "scenario"
    local inRaid = br.player.instance == "raid"
    local solo = #br.friend == 1
    local race = br.player.race
    local racial = br.player.getRacial()
    local traits = br.player.traits
    local moving = isMoving("player")
    local swimming = IsSwimming()
    local ttd = getTTD
    local astralPowerDeficit = br.player.power.astralPower.deficit()
    local travel, flight, cat = br.player.buff.travelForm.exists(), br.player.buff.flightForm.exists(), br.player.buff.catForm.exists()
    local catspeed = br.player.buff.dash.exists() or br.player.buff.tigerDash.exists()
    local norepeat = nil
    local hasteAmount = GetHaste() / 100
    local thisUnit = nil
    local aoeTarget = 0
    -------------
    -- Raid
    ------------

    local tanks = getTanksTable()
    local lowest = br.friend[1]
    local friends = friends or {}
    local gcd = br.player.gcdMax
    -- Enemies
    -------------
    local enemies = br.player.enemies
    local lastSpell = lastSpellCast
    local mode = br.player.mode
    local pullTimer = br.DBM:getPulltimer()
    local units = br.player.units
    local pewbuff = buff.incarnationChoseOfElune.exists() or buff.celestialAlignment.exists()
    local starfallRadius = nil

    if #tanks > 0 and inInstance then
        for i = 1, #tanks do
            tank = tanks[i].unit
        end
    else
        tank = "Player"
    end

    enemies.get(45)
    enemies.get(40)
    enemies.get(15)
    enemies.get(8, "target") -- enemies.yards8t
    enemies.get(10, "target", true)
    enemies.get(15, "target") -- enemies.yards15t
    enemies.get(12, "target") -- enemies.yards12t


    --Print(tostring(mode.DPS))

    -- Opener Reset
    local opener = br.player.opener

    if (not inCombat and not GetObjectExists("target")) or opener.complete == nil then
        opener.count = 0
        opener.WRA1 = false
        opener.WRA2 = false
        opener.DOT1 = false
        opener.DOT2 = false
        opener.DOT3 = false
        opener.PWR = false
        opener.PEW = false
        opener.complete = false

        --Clear last cast table ooc to avoid strange casts
        if #br.lastCast.tracker > 0 then
            wipe(br.lastCast.tracker)
        end
    end

    --[134388] = "A Knot of Snakes",


    -- track dispells in group
    --[[ for i = 1, #br.friend do
       if UnitGroupRolesAssigned(br.friend[i].unit) == "HEALER" and inInstance then
         local healerClass = UnitClassification(br.friend[i].unit)
         if healerClass == druid then
           dispell_healer_list = curse, magic, poison
         elseif healerClass == monk then
           dispell_healer_list = disease, magic, poison
         elseif healerClass == priest then
           dispell_healer_list = disease, magic
         elseif healerClass == shaman then
           dispell_healer_list = curse, magic
         elseif healerClass == paladin then
           dispell_healer_list = disease, magic, poison
         end
       end
   ]]

    ABOpener = ABOpener or false
    SW1 = SW1 or false
    SW2 = SW2 or false
    MF = MF or false
    SF = SF or false
    StF = StF or false
    CA = CA or false

    if (not inCombat and not GetObjectExists("target")) and ABopener
    then
        br.addonDebug("Opener Reset")
        ABOpener = false
        SW1 = false
        SW2 = false
        MF = false
        SF = false
        StF = false
        CA = false
        if #br.lastCast.tracker > 0 then
            wipe(br.lastCast.tracker)
        end

    end

    local opener_complete
    local open_count = 0
    local open1, open2, open3, open3, open4, open5, open6
    local function openerACT()
        -- if isChecked("opener") and not opener.complete and isValidUnit("target") and getDistance("target") < 45
        --       and getFacing("player", "target") and getSpellCD(61304) == 0 and isBoss("target") then
        if isChecked("oxxxpener") and getSpellCD(61304) == 0 and opener_complete == nil then

            if not br.player.buff.moonkinForm.exists() and not buff.prowl.exists() and not cast.last.moonkinForm(1) then
                if cast.moonkinForm() then
                    return true
                end
            end

            -- 2 x wrath
            Print("count: " .. open_count)

            if not open1 and cast.last.solarWrath(1) then
                open_count = open_count + 1
                open1 = true
                return true
            elseif not open1 then
                if cast.solarWrath("target") then
                    open_count = open_count + 1
                    open1 = true
                    return true
                end
            end
            if open1 and not open2 then
                Print("Open1:  " .. open_count)
            end


        end
    end

    local function castBeam(minUnits, safe, minttd)
        if not isKnown(spell.focusedAzeriteBeam) or getSpellCD(spell.focusedAzeriteBeam) ~= 0 then
            return false
        end

        local x, y, z = ObjectPosition("player")
        local length = 30
        local width = 6
        ttd = ttd or 0
        safe = safe or true
        local function getRectUnit(facing)
            local halfWidth = width / 2
            local nlX, nlY, nlZ = GetPositionFromPosition(x, y, z, halfWidth, facing + math.rad(90), 0)
            local nrX, nrY, nrZ = GetPositionFromPosition(x, y, z, halfWidth, facing + math.rad(270), 0)
            local frX, frY, frZ = GetPositionFromPosition(nrX, nrY, nrZ, length, facing, 0)
            return nlX, nlY, nrX, nrY, frX, frY
        end
        local enemiesTable = getEnemies("player", length, true)
        local facing = ObjectFacing("player")
        local unitsInRect = 0
        local nlX, nlY, nrX, nrY, frX, frY = getRectUnit(facing)
        local thisUnit
        for i = 1, #enemiesTable do
            thisUnit = enemiesTable[i]
            local uX, uY, uZ = ObjectPosition(thisUnit)
            if isInside(uX, uY, nlX, nlY, nrX, nrY, frX, frY) and not TraceLine(x, y, z + 2, uX, uY, uZ + 2, 0x100010) then
                if safe and not UnitAffectingCombat(thisUnit) and not isDummy(thisUnit) then
                    unitsInRect = 0
                    break
                end
                if ttd(thisUnit) >= minttd then
                    unitsInRect = unitsInRect + 1
                end
            end
        end
        if unitsInRect >= minUnits then
            CastSpellByName(GetSpellInfo(spell.focusedAzeriteBeam))
            return true
        else
            return false
        end
    end


    --aoe_count
    local aoe_count = 0
    for i = 1, #enemies.yards10tnc do
        local thisUnit = enemies.yards10tnc[i]
        if ttd(thisUnit) > 4 then
            aoe_count = aoe_count + 1
        end
    end

    local standingTime = 0
    if DontMoveStartTime then
        standingTime = GetTime() - DontMoveStartTime
    end

    local function dps()

        --setting norepeat
        norepeat = false
        if (traits.streakingStars.active and pewbuff) or UnitDebuffID("player", 304409) then
            norepeat = true
        end

        if not br.player.buff.moonkinForm.exists() and not buff.prowl.exists() and not cast.last.moonkinForm(1) then
            if cast.moonkinForm() then
                return true
            end
        end

        --Essence Support
        if isChecked("ConcentratedFlame - DPS") then
            if cast.concentratedFlame("target") then
                return true
            end
        end
        if standingTime > 1 and isChecked("Focused Azerite Beam") and aoe_count > 3 then
            if castBeam(getOptionValue("Focused Azerite Beam"), true, 3) then
                return true
            end
        end

        if getValue("Starfall Targets (0 for auto)") == 0 then
            aoeTarget = 4
            if traits.arcanicPulsar.active then
                aoeTarget = aoeTarget + 1
            end
            if talent.starlord then
                aoeTarget = aoeTarget + 1
            end
            if talent.twinMoons then
                aoeTarget = aoeTarget + 1
            end
            if traits.arcanicPulsar.active and br.player.traits.streakingStars.rank >= 2 then
                aoeTarget = aoeTarget + 1
            end

            if talent.stellarDrift then
                starfallRadius = 15
            else
                starfallRadius = 12
            end

            if (race == "Troll") and isChecked("Racial") and useCDs() and pewbuff and ttd("target") >= 12 then
                cast.racial("player")
            end
        elseif getValue("Starfall Targets (0 for auto)") ~= 0 then
            aoeTarget = getValue("Starfall Targets (0 for auto)")
        end

        --trinkets
        -- pewbuff.
        if isChecked("Use Trinkets") and (pewbuff or (cd.celestialAlignment.remain() > 30 or cd.incarnationChoseOfElune.remain() > 30)) then
            if canUseItem(13) then
                useItem(13)
            end
            if canUseItem(14) then
                useItem(14)
            end
        end

        --Pots
        --{ "None", "Battle", "RisingDeath", "Draenic", "Prolonged" }, 1, "", "Use Pot when Incarnation/Celestial Alignment is up")

        if isChecked("Pots") and not getOptionValue("Pots") == 1 and not solo and (buff.incarnationChoseOfElune.exists() and buff.incarnationChoseOfElune.remain() > 10) or (buff.celestialAlignment.exists() and buff.celestialAlignment.remain() > 10) then
            if getOptionValue("Pots") == 2 and canUseItem(163222) then
                useItem(163222)
            elseif getOptionValue("Pots") == 3 and canUseItem(152559) then
                useItem(152559)
            elseif getOptionValue("Pots") == 4 and canUseItem(109218) then
                useItem(109218)
            elseif getOptionValue("Pots") == 5 and canUseItem(142117) then
                useItem(142117)
            end
        end

        -- Warrior of Elune
        if useCDs() and isChecked("Warrior Of Elune") and talent.warriorOfElune and not buff.warriorOfElune.exists() then
            if cast.warriorOfElune() then
                return true
            end
        end

        -- Innverate
        --Print("Innervate Check: "..tostring(isChecked("Auto Innervate")) .." castable: " .. tostring(cast.able.innervate()).." TTD: " ..getTTD("target"))

        if isChecked("Auto Innervate") and cast.able.innervate() and getTTD(UnitTarget(tank)) >= 12 then
            for i = 1, #br.friend do
                if UnitGroupRolesAssigned(br.friend[i].unit) == "HEALER" and getDistance(br.friend[i].unit) < 45 and inInstance or inRaid and not UnitIsDeadOrGhost(br.friend[i].unit) and getLineOfSight(br.friend[i].unit) then
                    --Print("Healer is: " .. br.friend[i].unit)
                    if cast.innervate(br.friend[i].unit) then
                        return true
                    end
                end
            end
        end


        --quickdots
        if not isChecked("Ignore dots during pewbuff") then
            if (buff.incarnationChoseOfElune.exists() and buff.incarnationChoseOfElune.remain() < gcd + 1)
                    or (buff.celestialAlignment.exists() and buff.celestialAlignment.remain() < gcd + 1) then
                if norepeat and not cast.last.moonfire(1) then
                    if cast.moonfire(units.dyn45) then
                        return true
                    end
                elseif norepeat and not cast.last.sunfire(1) then
                    if cast.sunfire(units.dyn45) then
                        return true
                    end
                end
            end
        end

        --if streaking stars, rotate with solar_wrath
        if (norepeat and not cast.last.solarWrath(1)) then
            if mode.DPS == 1 or mode.DPS == 2 then
                if cast.solarWrath(units.dyn45) then
                    return true
                end
            end
            if mode.DPS == 3 then
                if cast.solarWrath("target") then
                    return true
                end
            end
        end

        -- Incarnation  ap_check&!buff.ca_inc.up
        if talent.incarnationChoseOfElune and useCDs() and isChecked("Incarnation/Celestial Alignment") and
                debuff.sunfire.remain("target") > 8 and debuff.moonfire.remain("target") > 12 and not pewbuff and
                (debuff.stellarFlare.remain("target") > 6 or not talent.stellarFlare) and power >= 40 and getTTD("target") >= 30 or hasBloodLust() then
            if cast.incarnationChoseOfElune("player") then
                return true
            end
        end

        if not talent.incarnationChoseOfElune and useCDs() and isChecked("Incarnation/Celestial Alignment") and
                power >= 40 and getTTD("target") >= 20 and not pewbuff and
                (not traits.livelySpirit.active or buff.livelySpirit.exists() or solo or (traits.livelySpirit.active and cd.innervate.remain() >= 30)) and
                debuff.sunfire.remain("target") > 2 and debuff.moonfire.remain("target") > 2 and
                (debuff.stellarFlare.remain("target") > 1 or not talent.stellarFlare) or
                hasBloodLust()
        then
            if cast.celestialAlignment("player") then
                return true
            end
        end

        --	fury_of_elune
        if talent.furyOfElune and isChecked("Fury Of Elune") and (#enemies.yards8t >= getValue("Fury of Elune Targets") or isBoss()) and getTTD("target") >= 8
                and (isChecked("Group Fury with CD") and (pewbuff or cd.celestialAlignment.remain() > 30 or cd.incarnationChoseOfElune.remain() > 30) or not isChecked("Group Fury with CD")) then
            if cast.furyOfElune(getBiggestUnitCluster(45, 1.25)) then
                return true
            end
        end


        -- Force Of Nature / treants
        if talent.forceOfNature and cast.able.forceOfNature() and br.player.power.astralPower.deficit() > 20 then
            if br.player.mode.forceOfNature == 1 and getTTD("target") >= 10
                    and (isChecked("Group treants with CD") and (pewbuff or cd.celestialAlignment.remain() > 30 or cd.incarnationChoseOfElune.remain() > 30) or not isChecked("Group treants with CD"))
                    and (#enemies.yards12t >= getValue("Treant Targets") or isBoss())
            then
                if cast.forceOfNature("best", nil, 1, 15, true) then
                    return true
                end
            elseif br.player.mode.forceOfNature == 2 and isChecked("Treants Key") and SpecificToggle("Treants Key") and not GetCurrentKeyBoardFocus() then
                if cast.forceOfNature("best", nil, 1, 15, true) then
                    return true
                end
            end
        end

        --starLord cancellation
        if talent.starlord and power >= 87 and buff.starLord.exists() and buff.starLord.remain() < 8 then
            cancelBuff(279709)
            --Print("Cancelling starLord at" .. buff.starLord.remain())
            --RunMacroText("/cancelAura starlord")
            return true
        end

        if (talent.stellarDrift and #enemies.yards15t >= aoeTarget) or #enemies.yards12t >= aoeTarget then
            --Starfall
            if power >= 50 or talent.soulOfTheForest and power >= 40 then
                if #enemies.yards12t >= aoeTarget
                        and (talent.starlord and (buff.starLord.remain() >= 8 or buff.starLord.stack() == 3) or not talent.starlord)
                then
                    if cast.starfall("best", false, aoeTarget, starfallRadius) then
                        return true
                    end
                end
            end
        else
            --starsurge
            if (traits.streakingStars.active and pewbuff and not cast.last.starsurge(1)) or not traits.streakingStars.active or not pewbuff then
                if talent.starlord and power >= 40 and cast.able.starsurge
                        and (buff.starLord.stack() < 3 and (buff.starLord.remain() >= 8) or not buff.starLord.exists()) then
                    if traits.arcanicPulsar.active and (buff.arcanicPulsar.stack() < 8 or (power >= 75 and buff.arcanicPulsar.stack() == 8)) or not traits.arcanicPulsar.active then
                        if cast.starsurge(units.dyn45) then
                            --Print("Stacks: " .. buff.starLord.stack() .. " Remain: " .. buff.starLord.remain() .. " pulsar: " .. buff.arcanicPulsar.stack())
                            return true
                        end
                    end
                elseif not talent.starlord and power >= 40 and cast.able.starsurge then
                    if (buff.arcanicPulsar.stack() < 8 or pewbuff) or
                            buff.lunarEmpowerment.stack() + buff.solarEmpowerment.stack() < 4 and buff.solarEmpowerment.stack() < 3 and buff.lunarEmpowerment.stack() < 3 then
                        if cast.starsurge(units.dyn45) then
                            return
                        end
                    end
                end
            end
        end


        --dots and roots

        local root_UnitList = {}
        if isChecked("Freehold - root grenadier") then
            root_UnitList[129758] = "Irontide Grenadier"
        end
        if isChecked("Atal - root Spirit of Gold") then
            root_UnitList[131009] = "Spirit of Gold"
        end

        if mode.DPS < 4 then
            for i = 1, #enemies.yards45 do
                if mode.DPS < 3 then
                    thisUnit = enemies.yards45[i]
                elseif mode.DPS == 3 then
                    thisUnit = "target"
                end

                if cast.able.entanglingRoots() then
                    if (root_UnitList[GetObjectID(thisUnit)] ~= nil and getBuffRemain(thisUnit, 226510) == 0) then
                        if cast.entanglingRoots(thisUnit) then
                            return true
                        end
                    end
                end

                if (buff.incarnationChoseOfElune.exists() or buff.celestialAlignment.exists()) and not isChecked("Ignore dots during pewbuff")
                        or not (buff.incarnationChoseOfElune.exists() or buff.celestialAlignment.exists()) then

                    --[[
                    actions+=/sunfire,target_if=refreshable,if=ap_check&floor(target.time_to_die%(2*spell_haste))*spell_targets>=ceil(floor(2%spell_targets)*1.5)+2*spell_targets
                    &(spell_targets>1+talent.twin_moons.enabled|dot.moonfire.ticking)&(!variable.az_ss|!buff.ca_inc.up|!prev.sunfire)&(buff.ca_inc.remains>remains|!buff.ca_inc.up)
                    (ttd(thisUnit)/(2*hasteAmount))*#enemies.yards12t >ceiling(floor(2/#enemies.yards12t)*1.5) + 2 * #enemies.yards12t and (#enemies.yards12t
                    ]]

                    if isChecked("Safe Dots") and
                            (
                                    (inInstance and #tanks > 0 and getDistance(thisUnit, tanks[1].unit) <= 10)
                                            or (inInstance and #tanks == 0)
                                            or solo
                                            or (inInstance and #tanks > 0 and getDistance(tanks[1].unit) >= 90)
                            ) or not isChecked("Safe Dots") then
                        if debuff.sunfire.count() < getOptionValue("Max Sunfire Targets") then
                            if astralPowerDeficit >= 7 and not debuff.sunfire.exists(thisUnit) and ttd(thisUnit) > 5.4 and ((norepeat and lastSpellCast ~= spell.sunfire) or not norepeat) then
                                if castSpell(thisUnit, spell.sunfire, true, false, false, true, false, true, true, false) then
                                    return true
                                end
                            end
                        end
                        --[[
                        Print(GetHaste())
                        Print(hasteAmount)
                        Print("TTD: ".. ttd(thisUnit))
                        Print(floor(ttd(thisUnit) / (2 * hasteAmount)))
              ]]
                        if debuff.moonfire.count() < getOptionValue("Max Moonfire Targets") then
                            if astralPowerDeficit >= 7 and not debuff.moonfire.exists(thisUnit) and ttd(thisUnit) > 6.6 and ((norepeat and lastSpellCast ~= spell.moonfire) or not norepeat) then
                                if castSpell(thisUnit, spell.moonfire, true, false, false, true, false, true, true, false) then
                                    return true
                                end
                            end
                        end
                        if debuff.stellarFlare.count() < getOptionValue("Max Stellar Flare Targets") and not isMoving("player") then
                            if talent.stellarFlare and astralPowerDeficit >= 12 and not debuff.stellarFlare.exists(thisUnit) and ttd(thisUnit) > 7 and not cast.last.stellarFlare() then
                                if castSpell(thisUnit, spell.stellarFlare, true, false, false, true, false, true, true, false) then
                                    return true
                                end
                            end
                        end
                    end
                end
                --refresh dots

                if astralPowerDeficit >= 7 and debuff.moonfire.exists(thisUnit) and debuff.moonfire.remain(thisUnit) < 6.6
                        and floor(ttd(thisUnit) / (2 * hasteAmount)) >= 6 and ((norepeat and lastSpellCast ~= spell.moonfire) or not norepeat) then
                    if castSpell(thisUnit, spell.moonfire, true, false, false, true, false, true, true, false) then
                        return true
                    end
                end
                if astralPowerDeficit >= 7 and debuff.sunfire.exists(thisUnit) and debuff.sunfire.remain(thisUnit) < 5.4 and ttd(thisUnit) > 5.4 and ((norepeat and lastSpellCast ~= spell.sunfire) or not pewbuff) then
                    if castSpell(thisUnit, spell.sunfire, true, false, false, true, false, true, true, false) then
                        return true
                    end
                end
                if talent.stellarFlare and astralPowerDeficit >= 12 and debuff.stellarFlare.exists(thisUnit) and debuff.stellarFlare.remain(thisUnit) < 7.2 and floor(ttd(thisUnit) / (2 * hasteAmount)) >= 5 and not cast.last.stellarFlare() then
                    if castSpell(thisUnit, spell.stellarFlare, true, false, false, true, false, true, true, false) then
                        return true
                    end
                end
            end
        end



        --lunar_strike
        if buff.solarEmpowerment.stack() < 3 and
                (astralPowerDeficit >= 12 or buff.lunarEmpowerment.stack() == 3) and
                ((buff.warriorOfElune.exists() or buff.lunarEmpowerment.exists() or #enemies.yards8t >= 2 and
                        not buff.solarEmpowerment.exists()) and
                        (not norepeat or norepeat and cast.last.solarWrath(1))) then
            if cast.lunarStrike(getBiggestUnitCluster(45, 8)) then
                return true
            end
        end
        --[[if buff.owlkinFrenzy.exists()
                or buff.solarEmpowerment.stack() < 3 and (buff.lunarEmpowerment.stack() == 3 or astralPowerDeficit >= 12 )
                and ((buff.warriorOfElune.exists() or buff.lunarEmpowerment.stack() > 0 or (#enemies.yards8t >= 2 and not buff.solarEmpowerment.exists()))
                and (norepeat and cast.last.solarWrath(1)) then
          --if cast.lunarStrike(units.dyn45) then
          if cast.lunarStrike(getBiggestUnitCluster(45, 8)) then
            return true
          end
          --end
        ]]
        --solar_wrath,if=variable.az_ss<3|!buff.ca_inc.up|!prev.solar_wrath
        if ((norepeat and not cast.last.solarWrath(1)) or not pewbuff or not traits.streakingStars.active) then
            if cast.solarWrath(units.dyn45) then
            end
        end

        if not norepeat or norepeat and cast.last.sunfire(1) then
            if cast.sunfire(units.dyn45) then
            end
        end

        if cast.moonfire(units.dyn45)
        then
            return true
        end
    end

    local function defensive()

        --Bear Form Key-br.player.buff.bearForm.exists()
        if isChecked("Bear Form Key") and not buff.bearForm.exists("player") and SpecificToggle("Bear Form Key") and not GetCurrentKeyBoardFocus() then
            if cast.bearForm("player") then
                return true
            end
        elseif isChecked("Bear Form Key") and buff.bearForm.exists("player") and SpecificToggle("Bear Form Key") and not GetCurrentKeyBoardFocus() then
            return
        elseif isChecked("Bear Form Key") and buff.bearForm.exists("player") and not SpecificToggle("Bear Form Key") and not GetCurrentKeyBoardFocus() then
            if cast.moonkinForm() then
                return true
            end
        end


        --Potion or Stone
        if isChecked("Potion/Healthstone") and php <= getValue("Potion/Healthstone") then
            if canUseItem(5512) then
                useItem(5512)
            elseif canUseItem(getHealthPot()) then
                useItem(getHealthPot())
            end
        end
        -- Renewal
        if isChecked("Renewal") and talent.renewal and php <= getValue("Renewal") then
            if cast.renewal("player") then
                return
            end
        end
        -- Barkskin
        if isChecked("Barkskin") and php <= getValue("Barkskin") then
            if cast.barkskin() then
                return
            end
        end
        -- Swiftmend
        if talent.restorationAffinity and isChecked("Swiftmend") and php <= getValue("Swiftmend") and charges.swiftmend.count() >= 1 then
            if cast.swiftmend("player") then
                return true
            end
        end
        -- Regrowth
        if isChecked("Regrowth") and not moving and php <= getValue("Regrowth") then
            if cast.regrowth("player") then
                return true
            end
        end
        -- Rebirth
        if isChecked("Rebirth") and cd.rebirth.remains() <= gcd and not isMoving("player") then
            if getOptionValue("Rebirth") == 1 then
                local tanks = getTanksTable()
                for i = 1, #tanks do
                    local thisUnit = tanks[i].unit
                    if UnitIsDeadOrGhost(thisUnit) and UnitIsPlayer(thisUnit) then
                        if cast.rebirth(thisUnit, "dead") then
                            return true
                        end
                    end
                end
            elseif getOptionValue("Rebirth") == 2 then
                for i = 1, #br.friend do
                    local thisUnit = br.friend[i].unit
                    if UnitIsDeadOrGhost(thisUnit) and UnitGroupRolesAssigned(thisUnit) == "HEALER" and UnitIsPlayer(thisUnit) then
                        if cast.rebirth(thisUnit, "dead") then
                            return true
                        end
                    end
                end
            elseif getOptionValue("Rebirth") == 3 then
                for i = 1, #br.friend do
                    local thisUnit = br.friend[i].unit
                    if UnitIsDeadOrGhost(thisUnit) and (UnitGroupRolesAssigned(thisUnit) == "TANK" or UnitGroupRolesAssigned(thisUnit) == "HEALER") and UnitIsPlayer(thisUnit) then
                        if cast.rebirth(thisUnit, "dead") then
                            return true
                        end
                    end
                end
            elseif getOptionValue("Rebirth") == 4 then
                if GetUnitExists("mouseover") and UnitIsDeadOrGhost("mouseover") and GetUnitIsFriend("mouseover", "player") then
                    if cast.rebirth("mouseover", "dead") then
                        return true
                    end
                end
            elseif getOptionValue("Rebirth") == 5 then
                for i = 1, #br.friend do
                    local thisUnit = br.friend[i].unit
                    if UnitIsDeadOrGhost(thisUnit) and UnitIsPlayer(thisUnit) then
                        if cast.rebirth(thisUnit, "dead") then
                            return true
                        end
                    end
                end
            end
        end

        -- offheal

        local offheal = false
        if getOptionValue("offheal") == 2 then
            offheal = true
        elseif getOptionValue("offheal") == 3 then
            for i = 1, #br.friend do
                local thisUnit = br.friend[i].unit
                if UnitIsDeadOrGhost(thisUnit) and UnitGroupRolesAssigned(thisUnit) == "HEALER" and UnitIsPlayer(thisUnit) then
                    offheal = true
                end
            end
        end

        -- Remove Corruption
        if isChecked("Remove Corruption") then
            if getOptionValue("Remove Corruption") == 1 then
                if canDispel("player", spell.removeCorruption) then
                    if cast.removeCorruption("player") then
                        return true
                    end
                end
            elseif getOptionValue("Remove Corruption") == 2 then
                if canDispel("target", spell.removeCorruption) then
                    if cast.removeCorruption("target") then
                        return true
                    end
                end
            elseif getOptionValue("Remove Corruption") == 3 then
                if canDispel("player", spell.removeCorruption) then
                    if cast.removeCorruption("player") then
                        return true
                    end
                elseif canDispel("target", spell.removeCorruption) then
                    if cast.removeCorruption("target") then
                        return true
                    end
                end
            elseif getOptionValue("Remove Corruption") == 4 then
                if canDispel("mouseover", spell.removeCorruption) then
                    if cast.removeCorruption("mouseover") then
                        return true
                    end
                end
            elseif (getOptionValue("Remove Corruption") == 5 or offheal == true) then
                for i = 1, #br.friend do
                    if canDispel(br.friend[i].unit, spell.removeCorruption) then
                        if cast.removeCorruption(br.friend[i].unit) then
                            return true
                        end
                    end
                end
            end
        end
    end

    local function interrupts()
        if useInterrupts() then
            for i = 1, #enemies.yards45 do
                local thisUnit = enemies.yards45[i]
                if canInterrupt(thisUnit, getValue("InterruptAt")) then
                    -- Solar Beam
                    if isChecked("Solar Beam") then
                        if cast.solarBeam(thisUnit) then
                            return
                        end
                    end
                    -- Typhoon
                    if isChecked("Typhoon") and talent.typhoon and getDistance(thisUnit) <= 15 then
                        if cast.typhoon() then
                            return
                        end
                    end
                    -- Mighty Bash
                    if isChecked("Mighty Bash") and talent.mightyBash and getDistance(thisUnit) <= 10 then
                        if cast.mightyBash(thisUnit) then
                            return true
                        end
                    end
                end
            end
        end

        if isChecked("Auto Soothe") then
            for i = 1, #enemies.yards45 do
                local thisUnit = enemies.yards45[i]
                if canDispel(thisUnit, spell.soothe) then
                    if cast.soothe(thisUnit) then
                        return true
                    end
                end
            end
        end
    end

    local function PreCombat()
        -- Pre-Pull Timer
        if isChecked("Pre-Pull Timer") and GetObjectExists("target") and not UnitIsDeadOrGhost("target") and UnitCanAttack("target", "player") then
            if PullTimerRemain() <= getOptionValue("Pre-Pull Timer") then
                if not br.player.buff.moonkinForm.exists() and not cast.last.moonkinForm(1) and not isMoving("player") then
                    if cast.moonkinForm() then
                        return true
                    end
                end
                if cast.solarWrath() then
                    return true
                end
            end
        end
        if isChecked("Auto Engage On Target") then
            if cast.sunfire() then
                return true
            end
        end
        if isChecked("Freehold - pig") and GetMinimapZoneText() == "Ring of Booty" then
            bossHelper()
        end
    end
    local function extras()
        --Resurrection
        if isChecked("Revive target") and not inCombat and not isMoving("player") then
            if UnitIsPlayer("target") and UnitIsDeadOrGhost("target") and GetUnitIsFriend("target", "player") then
                if cast.revive("target", "dead") then
                    return true
                end
            end
        end
        -- Wild Growth
        if isChecked("OOC Wild Growth") and not isMoving("player") and php <= getValue("OOC Wild Growth") then
            if cast.wildGrowth() then
                return true
            end
        end
        -- Regrowth
        if isChecked("OOC Regrowth") and not isMoving("player") and php <= getValue("OOC Regrowth") then
            if cast.regrowth("player") then
                return true
            end
        end
        -- Shapeshift Form Management
        local standingTime = 0
        if DontMoveStartTime then
            standingTime = GetTime() - DontMoveStartTime
        end

        if mode.forms == 1 then
            if (travel or buff.catForm.exists()) and not buff.prowl.exists() and standingTime > 1 then
                if cast.moonkinForm("player") then
                    return true
                end
            end

            -- Flight Form
            if not inCombat and canFly() and not swimming and br.fallDist > 90 --[[falling > getOptionValue("Fall Timer")]] and level >= 58 and not buff.prowl.exists() then
                if GetShapeshiftForm() ~= 0 and not cast.last.travelForm() then
                    -- CancelShapeshiftForm()
                    RunMacroText("/CancelForm")
                    CastSpellByID(783, "player")
                    return true
                else
                    CastSpellByID(783, "player")
                    return true
                end
            end
            -- Aquatic Form
            if (not inCombat --[[or getDistance("target") >= 10--]]) and swimming and not travel and not buff.prowl.exists() and isMoving("player") then
                if GetShapeshiftForm() ~= 0 and not cast.last.travelForm() then
                    -- CancelShapeshiftForm()
                    RunMacroText("/CancelForm")
                    CastSpellByID(783, "player")
                    return true
                else
                    CastSpellByID(783, "player")
                    return true
                end
            end
            -- Travel Form
            if not inCombat and not swimming and br.player.level >= 58 and not buff.prowl.exists() and not catspeed and not travel and not IsIndoors() and IsMovingTime(1) then
                if GetShapeshiftForm() ~= 0 and not cast.last.travelForm() then
                    RunMacroText("/CancelForm")
                    CastSpellByID(783, "player")
                    return true
                else
                    CastSpellByID(783, "player")
                    return true
                end
            end
            -- Cat Form
            if not cat and not IsMounted() and not flying and IsIndoors() then
                -- Cat Form when not swimming or flying or stag and not in combat
                if moving and IsMovingTime(3) and not swimming and not flying and not travel then
                    if cast.catForm("player") then
                        return true
                    end
                end
                -- Cat Form - Less Fall Damage
                if (not canFly() or inCombat or br.player.level < 58) and (not swimming or (not moving and swimming and #enemies.yards5 > 0)) and br.fallDist > 90 then
                    --falling > getOptionValue("Fall Timer") then
                    if cast.catForm("player") then
                        return true
                    end
                end
            end
        end -- End Shapeshift Form Management
    end
    local function actionList_Opener()
        if ABOpener == false then
            if not SW1 then
                if cast.solarWrath() then
                    -- or last cast
                    SW1 = true
                    br.addonDebug("Opener: Solar Wrath 1 cast")
                    return
                end
            elseif SW1 and not SW2 then
                if cast.solarWrath() then
                    SW2 = true
                    br.addonDebug("Opener: Solar Wrath 2 cast")
                    return
                end
            elseif MF and not SF then
                if cast.sunfire() then
                    SF = true
                    br.addonDebug("Opener: Sunfire cast")
                    return
                end
            elseif SW2 and not MF then
                if cast.moonfire() then
                    MF = true
                    br.addonDebug("Opener: Moonfire cast")
                    return
                end
            elseif SF and not StF then
                if talent.stellarFlare then
                    if cast.stellarFlare() then
                        StF = true
                        br.addonDebug("Opener: Stellar Flare cast")
                        return
                    end
                else
                    StF = true
                    br.addonDebug("Opener: Stellar Flare not talented, bypassing")
                    return
                end
            elseif StF and not CA and power < 40 then
                if cast.solarWrath() then
                    br.addonDebug("Opener: Building Up AP")
                    return
                end
            elseif StF and not CA and power >= 40 then
                if talent.incarnationChoseOfElune and cd.incarnationChoseOfElune.remains() <= 3 then
                    if cast.incarnationChoseOfElune("player") then
                        br.addonDebug("Opener: Inc cast")
                        CA = true
                    end
                elseif not talent.incarnationChoseOfElune and cd.celestialAlignment.remains() <= 3 then
                    if cast.celestialAlignment("player") then
                        br.addonDebug("Opener: CA cast")
                        CA = true
                    end
                else
                    br.addonDebug("Opener: CA/Inc On CD, Bypassing")
                    CA = true
                end
                return
            elseif CA then
                ABOpener = true
                br.addonDebug("Opener Complete")
            end
        end
    end
    -----------------
    --- Rotations ---
    -----------------
    -- Pause
    if not (IsMounted() or br.player.buff.travelForm.exists() or br.player.buff.flightForm.exists()) or mode.rotation == 4 then
        if pause() or drinking or mode.rotation == 4 or cast.current.focusedAzeriteBeam() then
            return true
        else

            ---------------------------------
            --- Out Of Combat - Rotations ---
            ---------------------------------````````````````````````````````````````````
            if not inCombat and not UnitBuffID("player", 115834) then
                if extras() then
                    return true
                end
                if useDefensive() then
                    if defensive() then
                        return true
                    end
                end
                if PreCombat() then
                    return true
                end
            end
        end -- End Out of Combat Rotation
        -----------------------------
        --- In Combat - Rotations ---
        -----------------------------
        if inCombat and not UnitBuffID("player", 115834) then
            -----------------------
            --- Opener Rotation ---
            -----------------------
            if openerACT() then
                return true
            end
            if useInterrupts() then
                if interrupts() then
                    return true
                end
            end
            if useDefensive() then
                if defensive() then
                    return true
                end
            end
            if ABOpener == false and isChecked("Opener") and (GetObjectExists("target") and isBoss("target")) then
                actionList_Opener()
            end
            if mode.rotation ~= 4 then
                if dps() then
                    return true
                end
            end
        end -- End In Combat Rotation
    end -- Pause
end -- End runRotation

local id = 102
if br.rotations[id] == nil then
    br.rotations[id] = {}
end

tinsert(br.rotations[id], {
    name = rotationName,
    toggles = createToggles,
    options = createOptions,
    run = runRotation,
})