local addonName, br = ...
local CurrentTable,OldTable
local function copyTable(datatable)
	local tblRes={}
	if type(datatable)=="table" then
		for k,v in pairs(datatable) do
			tblRes[copyTable(k)] = copyTable(v)
		end
	else
		tblRes=datatable
	end
	return tblRes
end

local TagHandlerList = {
	"IsSpellInRange","IsItemInRange","UnitInRange","isCritter","UnitAura",
	"UnitPlayerControlled",
	"UnitIsVisible",
	"GetUnitSpeed",
	"UnitClass",
	"UnitIsTappedByPlayer",
	"UnitThreatSituation",
	"UnitCanAttack",
	"UnitCreatureType",
	"UnitIsDeadOrGhost",
	"UnitDetailedThreatSituation",
	"UnitIsUnit",
	"UnitHealthMax",
	"UnitAffectingCombat",
	"UnitIsPlayer",
	"UnitIsDead",
	"UnitInParty",
	"UnitInRaid",
	"UnitHealth",
	"UnitCastingInfo",
	"UnitChannelInfo",
	"UnitName",
	"UnitBuff",
	"UnitDebuff",
	-- "CanLootUnit",
	"UnitInPhase",
	"UnitIsFriend",
	"UnitClassification",
	"UnitReaction",
	"UnitGroupRolesAssigned",
	-- "SetPortraitTexture",
	"UnitXPMax",
	"UnitXP",
	-- "UnitUsingVehicle",
	"UnitStat",
	-- "UnitSex",
	-- "UnitSelectionColor",
	"UnitPhaseReason",
	"UnitResistance",
	"UnitRangedDamage",
	"UnitRangedAttackPower",
	"UnitRangedAttack",
	"UnitRace",
	"UnitPowerType",
	"UnitPowerMax",
	"UnitPower",
	"UnitPVPName",
	"UnitPlayerOrPetInRaid",
	"UnitPlayerOrPetInParty",
	"UnitManaMax",
	"UnitMana",
	"UnitLevel",
	"UnitIsTrivial",
	"UnitIsTapped",
	"UnitIsSameServer",
	"UnitIsPossessed",
	-- "UnitIsPVPSanctuary",
	-- "UnitIsPVPFreeForAll",
	"UnitIsPVP",
	"UnitIsGhost",
	"UnitIsFeignDeath",
	"UnitIsEnemy",
	"UnitIsDND",
	"UnitIsCorpse",
	"UnitIsConnected",
	"UnitIsCharmed",
	-- "UnitIsAFK",
	-- "UnitIsInMyGuild",
	"UnitInBattleground",
	-- "GetPlayerInfoByGUID",
	-- "UnitDefense",
	"UnitDamage",
	"UnitCreatureFamily",
	"UnitCanCooperate",
	"UnitCanAssist",
	"UnitAttackSpeed",
	"UnitAttackPower",
	"UnitAttackBothHands",
	"UnitArmor",
	-- "InviteUnit",
	"GetUnitPitch",
	-- "GetUnitName",
	"FollowUnit",
	"CheckInteractDistance",
	"InitiateTrade",
	"UnitOnTaxi",
	"AssistUnit",
	"SpellTargetUnit",
	"CopyToClipboard",
	"SpellTargetItem",
	"SpellCanTargetUnit",
	-- "CombatTextSetActiveUnit",
	-- "SummonFriend",
	-- "CanSummonFriend",
	-- "GrantLevel",
	-- "CanGrantLevel",
	"SetRaidTarget",
	-- "GetReadyCheckStatus",
	"GetRaidTargetIndex",
	-- "GetPartyAssignment",
	-- "DemoteAssistant",
	-- "PromoteToAssistant",
	"IsUnitOnQuest",
	"DropItemOnUnit",
	"GetDefaultLanguage",
	"GetCritChanceFromAgility",
	"GetSpellCritChanceFromIntellect",
	"UnitGetTotalHealAbsorbs",
	"UnitGetIncomingHeals",
	"CastSpellByName",
	"CastSpellByID",
	"UseItemByName",
	"SpellIsTargeting",
	"InteractUnit",
	-- "CancelUnitBuff",
	"TargetUnit",
	"UnitGUID",
	"C_NamePlate.SetTargetClampingInsets",
	"AuraUtil.FindAuraBySpellId",
	"AuraUtil.FindAuraByName",
	"AuraUtil.FindAura",
}
local UnlockList = {
	"ToggleGameMenu",
	"RunMacroText",
	"UseInventoryItem",
	"SpellStopCasting",
	"CameraOrSelectOrMoveStart",
	"CameraOrSelectOrMoveStop",
	"CancelShapeshiftForm",
	"PetAssistMode",
	"PetPassiveMode",
	"SpellStopTargeting",
	"AscendStop",
	"JumpOrAscendStart",
	"JumpOrAscendStop",
	"MoveBackwardStart",
	"MoveBackwardStop",
	"MoveForwardStart",
	"StrafeLeftStart",
	"StrafeLeftStop",
	"StrafeRightStart",
	"StrafeRightStop",
	"TurnLeftStart",
	"TurnLeftStop",
	"TurnRightStart",
	"TurnRightStop",
	"PitchUpStart",
	"PitchDownStart",
	"PitchDownStop",
	"ClearTarget",
	"AcceptProposal",
	"CastPetAction",
	"CastShapeshiftForm",
	"CastSpell",
	"ChangeActionBarPage",
	"ClearOverrideBindings",
	"CreateMacro",
	"DeleteCursorItem",
	"DeleteMacro",
	"DescendStop",
	"DestroyTotem",
	"FocusUnit",
	"ForceQuit",
	"GetUnscaledFrameRect",
	"GuildControlSetRank",
	"GuildControlSetRankFlag",
	"GuildDemote",
	"GuildPromote",
	"GuildUninvite",
	"JoinBattlefield",
	"Logout",
	"PetAttack",
	"PetDefensiveAssistMode",
	"PetDefensiveMode",
	"PetFollow",
	"PetStopAttack",
	"PetWait",
	"PickupAction",
	"PickupCompanion",
	"PickupMacro",
	"PickupPetAction",
	"PickupSpell",
	"PickupSpellBookItem",
	"Quit",
	"Region_GetBottom",
	"Region_GetCenter",
	"Region_GetPoint",
	"Region_GetRect",
	"Region_Hide",
	"Region_SetPoint",
	"Region_Show",
	"RegisterForSave",
	"ReplaceEnchant",
	"ReplaceTradeEnchant",
	"RunMacro",
	"SendChatMessage",
	"SetBinding",
	"SetBindingClick",
	"SetBindingItem",
	"SetBindingMacro",
	"SetBindingSpell",
	"SetCurrentTitle",
	"SetMoveEnabled",
	"SetOverrideBinding",
	"SetOverrideBindingClick",
	"SetOverrideBindingItem",
	"SetOverrideBindingMacro",
	"SetOverrideBindingSpell",
	"SetTurnEnabled",
	"ShowUIPanel",
	"SitStandOrDescendStart",
	-- "Stuck",
	-- "SwapRaidSubgroup",
	"TargetLastEnemy",
	"TargetLastTarget",
	"TargetNearestEnemy",
	"TargetNearestFriend",
	-- "ToggleAutoRun",
	-- "ToggleRun",
	"TurnOrActionStart",
	"TurnOrActionStop",
	-- "UIObject_SetForbidden",
	-- "UninviteUnit",
	"UseAction",
	-- "UseContainerItem",
	"UseToy",
	"UseToyByName",
	-- "AcceptBattlefieldPort",
	"AcceptTrade",
	"AttackTarget",
	-- "CancelItemTempEnchantment",
	"CancelLogout",
	"StartAttack", "MainMenuBar.ClearAllPoints", "UIParent.SetAttribute","MainMenuBar.SetPoint"
}
local function BrUnlock()
	print("huy")
	for i,val in ipairs(TagHandlerList) do
		for k,rot in ipairs(UnlockList) do
			if val == rot then
				print(rot)
			end
		end
	end
	local function lbUnlock(method)
		lb.RunString(method.."Old = "..method.."; "..method.." = function (...) return lb.Unlock(_G."..method.."Old, ...); end")
	end
	local function lbUnitTagHandler(method)
		lb.RunString(method.."Old = "..method.."; "..method.." = function (...) return lb.UnitTagHandler(_G."..method.."Old, ...); end")
	end
	for _, method in ipairs(TagHandlerList) do
		lbUnitTagHandler(method)
	end
	for _, method in ipairs(UnlockList) do
		lbUnlock(method)
	end

	ObjectPointer = UnitGUID
	ObjectPosition = function (...) return lb.ObjectPosition(...) end
	ObjectGUID = UnitGUID
	ObjectIsUnit = function(...) local ObjType = lb.ObjectType(...); return ObjType == 5 or ObjType == 6 or ObjType == 7 end
	ObjectIsGameObject = function(...) local ObjType = lb.ObjectType(...); return ObjType == 8 or ObjType == 11 end
	ObjectID = function (...) return lb.ObjectId(...) end
	UnitMovementFlags = function(...) return lb.UnitMovementFlags(...) end
	TraceLine = function(...)
		lb.Raycast(...)
	end
	UnitTarget = lb.UnitTarget
	IsQuestObject = function(obj)
		return false, false
	end
	-- UnitCastingInfo = lb.UnitCastingInfo
	-- UnitChannelInfo = lb.UnitChannelInfo
	UnitCastID = function(...)
		local CastSpellID, CastTargetGUID, timeLeft, NotInterruptible = lb.UnitCastingInfo(...)
		local ChannelSpellID, ChannelTargetGUID, timeLeft, NotInterruptible = lb.UnitChannelInfo(...)
		return CastSpellID,ChannelSpellID,CastTargetGUID,ChannelTargetGUID
	end
	GetWoWDirectory = lb.GetGameDirectory
	CreateDirectory = lb.CreateDirectory
	GetDirectoryFiles = lb.GetFiles
	GetKeyState = lb.GetKeyState
	WorldToScreen = function (wX, wY, wZ)
		local ResolutionCoef = _G.WorldFrame:GetWidth() / lb.GetWindowSize()
		local sX, sY = lb.WorldToScreen(wX, wY, wZ)
		if sX and sY then
			return sX * ResolutionCoef, -sY * ResolutionCoef
		else
			return sX, sY
		end
	end
	ScreenToWorld = function()
		return 0,0
	end
	GetDistanceBetweenPositions = function(X1, Y1, Z1, X2, Y2, Z2)
		return math.sqrt(math.pow(X2 - X1, 2) + math.pow(Y2 - Y1, 2) +  math.pow(Z2 - Z1, 2))
	end

	GetAnglesBetweenObjects = function(Object1,Object2)
		local X1,Y1,Z1 = ObjectPosition(Object1)
		local X2,Y2,Z2 = ObjectPosition(Object2)
		-- print(Unit1,X1,Y1,Z1,unit2,X2,Y2,Z2)
		return math.atan2(Y2 - Y1, X2 - X1) % (math.pi * 2),
			math.atan((Z1 - Z2) / math.sqrt(math.pow(X1 - X2, 2) + math.pow(Y1 - Y2, 2))) % math.pi
	end

	GetAnglesBetweenPositions = function(X1, Y1, Z1, X2, Y2, Z2)
		return math.atan2(Y2 - Y1, X2 - X1) % (math.pi * 2),
			math.atan((Z1 - Z2) / math.sqrt(math.pow(X1 - X2, 2) + math.pow(Y1 - Y2, 2))) % math.pi
	end

	GetPositionFromPosition = function(X, Y, Z, Distance, AngleXY, AngleXYZ)
		return math.cos(AngleXY) * Distance + X, math.sin(AngleXY) * Distance + Y, math.sin(AngleXYZ) * Distance + Z
	end

	GetPositionBetweenPositions = function(X1, Y1, Z1, X2, Y2, Z2, DistanceFromPosition1)
		local AngleXY, AngleXYZ = GetAnglesBetweenPositions(X1, Y1, Z1, X2, Y2, Z2)
		return GetPositionFromPosition(X1, Y1, Z1, DistanceFromPosition1, AngleXY, AngleXYZ)
	end

	GetPositionBetweenObjects = function(unit1,unit2,DistanceFromPosition1)
		local X1,Y1,Z1 = ObjectPosition(unit1)

		local X2,Y2,Z2 = ObjectPosition(unit2)
		local AngleXY, AngleXYZ = GetAnglesBetweenPositions(X1, Y1, Z1, X2, Y2, Z2)
		return GetPositionFromPosition(X1, Y1, Z1, DistanceFromPosition1, AngleXY, AngleXYZ)
	end
	ObjectFacing = lb.ObjectFacing
	FaceDirection = function(arg)
		if type(arg) == "number" then
			lb.SetPlayerAngles (arg)
		else
			arg = GetAnglesBetweenObjects("player",arg)
			lb.SetPlayerAngles (arg)
		end
	end
	function ObjectFacingObject(obj1,obj2, degrees)
		local Facing = lb.ObjectFacing(obj1)
		local AngleToUnit = GetAnglesBetweenObjects(obj1,obj2)
		local AngleDifference = Facing > AngleToUnit and Facing - AngleToUnit or AngleToUnit - Facing
		local ShortestAngle = AngleDifference < math.pi and AngleDifference or math.pi * 2 - AngleDifference
		degrees = degrees and rad(degrees)/2 or math.pi/2
		return ShortestAngle < degrees
	end
	-- getFacing = ObjectFacingObject
	UnitCreator = lb.ObjectCreator
	ObjectName = lb.ObjectName
	GetDistanceBetweenPositions = lb.GetDistance3D
	GetMapId = lb.GetMapId
	UnitIsMounted = function (...)
		return lb.UnitHasFlag(...,lb.EUnitFlags.Mount)
	end
	SendMovementUpdate = lb.UpdatePlayerMovement

	ObjectDynamicFlags = lb.ObjectDynamicFlags

	IsHackEnabled = function (...)
		print(...)
		return false

	end
	UnitCombatReach = lb.UnitCombatReach
	ReadFile = lb.ReadFile
	DirectoryExists = lb.DirectoryExists
	WriteFile = function(file,string,boolean)
		-- print(file,string,boolean)
		lb.WriteFile(file,string,boolean)
	end
	-- local addedOM,removedOM = {}, {}
	function GetObjectCountBR()
		if not OldTable and not CurrentTable then
			CurrentTable = lb.GetObjects()
			return #CurrentTable, true, CurrentTable, {}
		else
			OldTable = CurrentTable
			CurrentTable = lb.GetObjects()
			local TempTable = copyTable(CurrentTable)
			local TempTableOld = copyTable(OldTable)
			for i = #TempTableOld, 1, -1 do
				for k = #TempTable, 1, -1 do
					if TempTableOld[i] == TempTable[k] then
						table.remove(TempTable, k)
						table.remove(TempTableOld, i)
						break
					end
				end
			end
			return #CurrentTable, true, TempTable, TempTableOld
		end
	end
	function GetObjectWithIndex(n)
		return CurrentTable[n]
	end
	function GetObjectWithGUID(n)
		return n
	end
	ObjectIsVisible = lb.ObjectExists
	ObjectExists = lb.ObjectExists
	-- GetUnitIsVisible = lb.ObjectExists
	IsAoEPending = lb.IsAoEPending
	ClickPosition = lb.ClickPosition
	UnitBoundingRadius = lb.UnitBoundingRadius
	GetUnitIsUnit = function(...)
		local unit1, unit2 = ...
		local guid1 = UnitGUID(unit1)
		local guid2 = UnitGUID(unit2)
		return guid1 == guid2 and true or nil
	end
	-- UnitIsUnitOld = UnitIsUnit
	-- UnitIsUnit = function(...) return lb.UnitTagHandler(UnitIsUnitOld,...) end
	-- CanLootUnit = lb.UnitIsLootable
	-- function getGUID(unit)
	-- 	local nShortHand, targetGUID = "", ""
	-- 	if GetObjectExists(unit) then
	-- 		if UnitIsPlayer(unit) then
	-- 			targetGUID = unit
	-- 			nShortHand = string.sub(unit,-5)
	-- 		else
	-- 			targetGUID = string.match(unit,"-(%d+)-%x+$")
	-- 			nShortHand = string.sub(unit,-5)
	-- 		end
	-- 	end
	-- 	return targetGUID,nShortHand
	-- end
	-- function getHP(Unit)
	-- 	if GetObjectExists(Unit) then
	-- 		if UnitIsEnemy("player", Unit) then
	-- 			return 100*UnitHealth(Unit)/UnitHealthMax(Unit)
	-- 		else
	-- 			if not UnitIsDeadOrGhost(Unit) and GetUnitIsVisible(Unit) then
	-- 				for i = 1,#br.friend do
	-- 					if br.friend[i] then
	-- 						if br.friend[i].guidsh == string.sub(Unit,-5) then
	-- 							return br.friend[i].hp
	-- 						end
	-- 					end
	-- 				end
	-- 				if getOptionCheck("Incoming Heals") == true and UnitGetIncomingHeals(Unit,"player") ~= nil then
	-- 					return 100*(UnitHealth(Unit)+UnitGetIncomingHeals(Unit,"player"))/UnitHealthMax(Unit)
	-- 				else
	-- 					return 100*UnitHealth(Unit)/UnitHealthMax(Unit)
	-- 				end
	-- 			end
	-- 		end
	-- 	end
	-- 	return 0
	-- end
	br.unlocked = true
end
local f = CreateFrame("Frame", "BrUnlock")
f:SetScript(
	"OnUpdate",
	function()
		if not br.unlocked and lb then
			-- print("123")
			BrUnlock()
		end
	end
)
