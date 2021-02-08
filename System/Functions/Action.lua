local addonName, br = ...
function canFly()
	return IsOutdoors() and IsFlyableArea()
end

-- if canHeal("target") then
function canHeal(Unit)
	if
		br.GetUnitExists(Unit) and UnitInRange(Unit) == true and UnitCanCooperate("player", Unit) and not UnitIsEnemy("player", Unit) and not UnitIsCharmed(Unit) and
			not UnitIsDeadOrGhost(Unit) and
			br.getLineOfSight(Unit) == true and
			not br.UnitDebuffID(Unit, 33786)
	 then
		return true
	end
	return false
end

-- if canRun() then
function canRun()
	if br.getOptionCheck("Pause") ~= 1 then
		if br.isAlive("player") then
			if
				SpellIsTargeting() or --or UnitInVehicle("Player")
					(IsMounted() and not br.UnitBuffID("player", 164222) and not br.UnitBuffID("player", 165803) and not br.UnitBuffID("player", 157059) and not br.UnitBuffID("player", 157060)) or
					br.UnitBuffID("player", 11392) ~= nil or
					br.UnitBuffID("player", 80169) ~= nil or
					br.UnitBuffID("player", 87959) ~= nil or
					br.UnitBuffID("player", 104934) ~= nil or
					br.UnitBuffID("player", 9265) ~= nil
			 then -- Deep Sleep(SM)
				return nil
			else
				if br.GetObjectExists("target") then
					if br.GetObjectID("target") ~= 5687 then
						return nil
					end
				end
				return true
			end
		end
	else
		br.ChatOverlay("|cffFF0000-BadRotations Paused-")
		return false
	end
end
