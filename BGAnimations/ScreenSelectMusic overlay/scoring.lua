local courseMode = GAMESTATE:IsCourseMode()
local af = Def.ActorFrame{
	PlayerJoinedMessageCommand=function(self, params) self:queuecommand("Init") end,
	PlayerUnjoinedMessageCommand=function(self, params) self:queuecommand("Init") end,
	CurrentSongChangedMessageCommand=function(self) if not courseMode then self:playcommand("Set") end end,
	CurrentCourseChangedMessageCommand=function(self) if courseMode then self:playcommand("Set") end end
}

for player in ivalues({PLAYER_1, PLAYER_2}) do
	af[#af+1] = Def.BitmapText{
		Name="Actual",
		Font="Combo numbers",
		InitCommand=function(self)
			self:visible( GAMESTATE:IsHumanPlayer(player) )
				:zoom(0.38)
				:x( (#GAMESTATE:GetHumanPlayers()==2 and (player==PLAYER_1 and -30 or 30)) or 0  )
				:y(-15)
				:maxwidth((#GAMESTATE:GetHumanPlayers()==2 and 140) or 300)
		end,
		PlayerJoinedMessageCommand=function(self, params) self:queuecommand("Init") end,
		PlayerUnjoinedMessageCommand=function(self, params) self:queuecommand("Init") end,
		["CurrentSteps"..ToEnumShortString(player).."ChangedMessageCommand"]=function(self) if not courseMode then self:playcommand("Set") end end,
		["CurrentTrail"..ToEnumShortString(player).."ChangedMessageCommand"]=function(self) if courseMode then self:playcommand("Set") end end,
		SetMessageCommand=function(self)
			self:settext("")
			local song = (GAMESTATE:IsCourseMode() and GAMESTATE:GetCurrentCourse()) or GAMESTATE:GetCurrentSong()
			local steps = (GAMESTATE:IsCourseMode() and GAMESTATE:GetCurrentTrail(player)) or GAMESTATE:GetCurrentSteps(player)
			local profile = (PROFILEMAN:IsPersistentProfile(player) and PROFILEMAN:GetProfile(player)) or PROFILEMAN:GetMachineProfile()
			if song and steps and profile then
				local score_list = profile:GetHighScoreList(song,steps)
				local scores = score_list:GetHighScores()
				local top_score = scores[1]
				if top_score then
					local taps = top_score:GetRadarValues(player):GetValue("RadarCategory_TapsAndHolds")
					self:settext(taps)
				else
					self:settext("0")
				end
			end
		end
	}

	af[#af+1] = Def.BitmapText{
		Name="Possible",
		Font="Combo numbers",
		InitCommand=function(self)
			self:visible( GAMESTATE:IsHumanPlayer(player) )
				:zoom(0.38)
				:x( (#GAMESTATE:GetHumanPlayers()==2 and (player==PLAYER_1 and -30 or 30)) or 0  )
				:y(13)
				:maxwidth((#GAMESTATE:GetHumanPlayers()==2 and 140) or 300)
		end,
		PlayerJoinedMessageCommand=function(self, params) self:queuecommand("Init") end,
		PlayerUnjoinedMessageCommand=function(self, params) self:queuecommand("Init") end,
		["CurrentSteps"..ToEnumShortString(player).."ChangedMessageCommand"]=function(self) if not courseMode then self:playcommand("Set") end end,
		["CurrentTrail"..ToEnumShortString(player).."ChangedMessageCommand"]=function(self) if courseMode then self:playcommand("Set") end end,
		SetMessageCommand=function(self)
			self:settext("")
			local song = (GAMESTATE:IsCourseMode() and GAMESTATE:GetCurrentCourse()) or GAMESTATE:GetCurrentSong()
			local steps = (GAMESTATE:IsCourseMode() and GAMESTATE:GetCurrentTrail(player)) or GAMESTATE:GetCurrentSteps(player)
			if song and steps then
				local taps = 0
				if GAMESTATE:IsCourseMode() then
					for entry in ivalues(steps:GetTrailEntries()) do
						taps = taps + entry:GetSteps():GetRadarValues(mPlayer):GetValue('RadarCategory_TapsAndHolds')
					end
				else
					taps = steps:GetRadarValues(player):GetValue("RadarCategory_TapsAndHolds")
				end
				self:settext(taps)
			end
		end
	}
end

return af