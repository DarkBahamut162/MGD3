local t = Def.ActorFrame{}
local Center1Player = PREFSMAN:GetPreference('Center1Player')
local NumPlayers = GAMESTATE:GetNumPlayersEnabled()
local NumSides = GAMESTATE:GetNumSidesJoined()
local st = GAMESTATE:GetCurrentStyle():GetStepsType()

local function GetPosition(pn)
	if st == "StepsType_Dance_Solo" then
		if Center1Player then
			return SCREEN_WIDTH/2
		elseif pn == PLAYER_1 then
			return SCREEN_WIDTH/4
		elseif pn == PLAYER_2 then
			return SCREEN_WIDTH/4*3
		end
	elseif st == "StepsType_Dance_Double" then
		if pn == PLAYER_1 then
			return SCREEN_WIDTH/4
		elseif pn == PLAYER_2 then
			return SCREEN_WIDTH/4*3
		end
	else
		local strPlayer = (NumPlayers == 1) and "OnePlayer" or "TwoPlayers"
		local strSide = (NumSides == 1) and "OneSide" or "TwoSides"
		return THEME:GetMetric("ScreenGameplay","Player"..ToEnumShortString(pn)..strPlayer..strSide.."X")
	end
end

local moved = (GAMESTATE:GetNumPlayersEnabled() == 1) and true or false
local centered = (GAMESTATE:GetNumPlayersEnabled() == 1) and true or false

for player in ivalues(GAMESTATE:GetHumanPlayers()) do
	t[#t+1] = LoadActor("playerfilter")..{
		InitCommand=function(self)
			self:x(GetPosition(player))
			self:CenterY()
		end,
		HealthStateChangedMessageCommand=function(self, param)
			if param.HealthState == Health.Dead then --If player dies
				if param.PlayerNumber == PLAYER_1 and player == PLAYER_1 and not moved then --Move P1's filter if P1 dies
					--self:linear(0.5):x(SCREEN_LEFT-SCREEN_WIDTH)
					moved = true
				elseif param.PlayerNumber == PLAYER_2 and player == PLAYER_2 and not moved then --Move P2's filter if P2 dies
					--self:linear(0.5):x(SCREEN_RIGHT+SCREEN_WIDTH)
					moved = true
				end
				if param.PlayerNumber == PLAYER_1 and player == PLAYER_2 and not centered then --Move P1's filter to center if P2 dies
					--self:linear(0.5):CenterX()
					centered = true
				elseif param.PlayerNumber == PLAYER_2 and player == PLAYER_1 and not centered then --Move P2's filter to center if P1 dies
					--self:linear(0.5):CenterX()
					centered = true
				end
			end
		end
	}
	if GAMESTATE:IsCourseMode() then
		local course = GAMESTATE:GetCurrentCourse()
		local entries = course:GetCourseEntries()
		local isSurvival = false

		for entry in ivalues(course:GetCourseEntries()) do
			if entry:GetGainSeconds() > 0 then
				isSurvival = true
			end
		end

		if isSurvival then
			t[#t+1] = LoadActor("RemainingTime", player)..{
				Condition=GAMESTATE:GetPlayMode() == "PlayMode_Oni"
			}
		end
	end
end

return t