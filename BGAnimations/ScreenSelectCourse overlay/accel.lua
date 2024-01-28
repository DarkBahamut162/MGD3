local SpeedMods = {"0.5X", "1X", "1.5X", "2X", "2.5X", "3X", "3.5X", "4X", "4.5X", "5X", "5.5X", "6X"}
local sIdx = {PlayerNumber_P1=2,PlayerNumber_P2=2}
local sMax = #SpeedMods
local invert = ThemePrefs.Get("InvertAccel") and -1 or 1
local questionMark = ""
local courseMode = GAMESTATE:IsCourseMode()

function DoesCourseHasX()
	local course = GAMESTATE:GetCurrentCourse()
	if course then
		local filePath = course:GetCourseDir()
		local file = RageFileUtil.CreateRageFile()
		file:Open(filePath,1)
		file:Seek(0)
		local gLine = ""
		local line
		while true do
			line=file:GetLine()
			if string.find(line,"#NOTES:.*") or file:AtEOF() then break
			elseif (string.find(line,"^.*#MOD:.*") and (not string.find(line,"^%/%/.*"))) or gLine~="" then
				gLine=gLine..""..split("//",line)[1]
			end
		end
		if string.find(gLine,"[0-9]?[.]*[0-9]*[0-9]x") then questionMark = "?" else questionMark = "" end
		file:Close()
		file:destroy()
	else
		questionMark = ""
	end
end

return Def.ActorFrame{
	OnCommand=function()
		for pn in ivalues(GAMESTATE:GetEnabledPlayers()) do
			GAMESTATE:ApplyGameCommand('mod,'..SpeedMods[sIdx[pn]],pn)
			GAMESTATE:ApplyGameCommand('mod,'..GAMESTATE:GetPlayerState(pn):GetPlayerOptions("ModsLevel_Preferred"):NoteSkin(),pn)
			if GAMESTATE:GetPlayerState(pn):GetPlayerOptions("ModsLevel_Preferred"):ScrollSpeed() then
				sIdx[pn] = GAMESTATE:GetPlayerState(pn):GetPlayerOptions("ModsLevel_Preferred"):ScrollSpeed() * 2
			end
		end
	end,
	PlayerJoinedMessageCommand=function(self)
		self:playcommand("On")
	end,
	PlayerUnjoinedMessageCommand=function(self)
		self:playcommand("On")
	end,
	Def.ActorFrame{
		CodeMessageCommand = function(self, params)
			if params.Name == 'SpeedUp' or params.Name == 'SpeedUpCab' then
				sIdx[params.PlayerNumber] = sIdx[params.PlayerNumber] - (1 * invert)
				if sIdx[params.PlayerNumber] < 1 then sIdx[params.PlayerNumber] = sMax elseif sIdx[params.PlayerNumber] > sMax then sIdx[params.PlayerNumber] = 1 end
				GAMESTATE:ApplyGameCommand('mod,'..SpeedMods[sIdx[params.PlayerNumber]],params.PlayerNumber)
				self:playcommand("Speed"):playcommand("Speed"..ToEnumShortString(params.PlayerNumber))
			elseif params.Name == 'SpeedDown' or params.Name == 'SpeedDownCab' then
				sIdx[params.PlayerNumber] = sIdx[params.PlayerNumber] + (1 * invert)
				if sIdx[params.PlayerNumber] > sMax then sIdx[params.PlayerNumber] = 1 elseif sIdx[params.PlayerNumber] < 1 then sIdx[params.PlayerNumber] = sMax end
				GAMESTATE:ApplyGameCommand('mod,'..SpeedMods[sIdx[params.PlayerNumber]],params.PlayerNumber)
				self:playcommand("Speed"):playcommand("Speed"..ToEnumShortString(params.PlayerNumber))
			end
		end,
		LoadActor(THEME:GetPathS("ScreenSelectMusic","options"))..{
			OnCommand=function(self) self:stop() end,
			SupportPan=true,
			SpeedCommand=function(self)
				if GAMESTATE:GetNumPlayersEnabled() == 1 then self:play() end
			end,
			SpeedP1Command=function(self)
				if GAMESTATE:GetNumPlayersEnabled() == 2 then self:playforplayer(PLAYER_1) end
			end,
			SpeedP2Command=function(self)
				if GAMESTATE:GetNumPlayersEnabled() == 2 then self:playforplayer(PLAYER_2) end
			end
		},
		LoadFont("OptionIcon")..{
			OnCommand=function(self)
				if GAMESTATE:GetNumPlayersEnabled() == 1 then
					self:x(SCREEN_CENTER_X+100)
				else
					self:x(SCREEN_CENTER_X+50)
				end
				if GAMESTATE:IsPlayerEnabled(PLAYER_1) then
					self:y(SCREEN_BOTTOM-50):settext(SpeedMods[sIdx[PLAYER_1]]):diffuse(color('#BEC1C6')):zoom(0.76)
				end
			end,
			SpeedP1Command=function(self)
				self:settext(SpeedMods[sIdx[PLAYER_1]]..questionMark)
			end,
			CurrentCourseChangedMessageCommand=function(self)
				if courseMode then
					DoesCourseHasX()
					if GAMESTATE:IsPlayerEnabled(PLAYER_1) then
						self:settext(SpeedMods[sIdx[PLAYER_1]]..questionMark)
					end
				end
			end
		},
		LoadFont("OptionIcon")..{
			OnCommand=function(self)
				if GAMESTATE:GetNumPlayersEnabled() == 1 then
					self:x(SCREEN_CENTER_X+100)
				else
					self:x(SCREEN_CENTER_X+150)
				end
				if GAMESTATE:IsPlayerEnabled(PLAYER_2) then
					self:y(SCREEN_BOTTOM-50):settext(SpeedMods[sIdx[PLAYER_2]]):diffuse(color('#BEC1C6')):zoom(0.76)
				end
			end,
			SpeedP2Command=function(self)
				self:settext(SpeedMods[sIdx[PLAYER_2]]..questionMark)
			end,
			CurrentCourseChangedMessageCommand=function(self)
				if courseMode then
					DoesCourseHasX()
					if GAMESTATE:IsPlayerEnabled(PLAYER_2) then
						self:settext(SpeedMods[sIdx[PLAYER_2]]..questionMark)
					end
				end
			end
		}
	}
}