local courseMode = GAMESTATE:IsCourseMode()

return Def.ActorFrame{
	Def.StepsDisplayList{
		Name="StepsDisplayListRow",
		CurrentSongChangedMessageCommand=function(self)
			self:stoptweening()
			if not courseMode then if GAMESTATE:GetCurrentSong() then self:visible(true) else self:visible(false) end end
		end,
		CurrentCourseChangedMessageCommand=function(self)
			self:stoptweening()
			if courseMode then if GAMESTATE:GetCurrentCourse() then self:visible(true) else self:visible(false) end end
		end,
		CursorP1 = Def.ActorFrame{
			InitCommand=function(self) self:x(0):player(PLAYER_1) end,
			PlayerJoinedMessageCommand=function(self, params) if params.Player == PLAYER_1 then self:visible(true) end end,
			PlayerUnjoinedMessageCommand=function(self, params) if params.Player == PLAYER_1 then self:visible(false) end end,
			LoadActor(THEME:GetPathG("","CursorP1"))..{
				CurrentStepsP1ChangedMessageCommand=function(self) if not courseMode then self:playcommand("PositionCheck") end end,
				CurrentStepsP2ChangedMessageCommand=function(self) if not courseMode then self:playcommand("PositionCheck") end end,
				PositionCheckCommand=function(self)
					self:stoptweening()
					if getenv("wheelstop") == 1 then
						if #GAMESTATE:GetHumanPlayers() > 1 then
							local p1Steps = ""
							local p2Steps = ""
							if GAMESTATE:GetCurrentSong() then
								p1Steps = GAMESTATE:GetCurrentSteps(PLAYER_1)
								p2Steps = GAMESTATE:GetCurrentSteps(PLAYER_2)
							elseif GAMESTATE:GetCurrentCourse() then
								p1Steps = GAMESTATE:GetCurrentTrail(PLAYER_1)
								p2Steps = GAMESTATE:GetCurrentTrail(PLAYER_2)
							end
							if p1Steps and p2Steps then
								if p1Steps:GetDifficulty() == 'Difficulty_Edit' and p2Steps:GetDifficulty() == 'Difficulty_Edit' then
									if p1Steps:GetDescription() == p2Steps:GetDescription() then self:y(11) else self:y(0) end
								else
									if p1Steps:GetDifficulty() == p2Steps:GetDifficulty() then self:y(11) else self:y(0) end
								end
							end
						end
					else self:y(0)
					end
				end
			}
		},
		CursorP2 = Def.ActorFrame{
			InitCommand=function(self) self:x(52):player(PLAYER_2) end,
			PlayerJoinedMessageCommand=function(self, params) if params.Player == PLAYER_2 then self:visible(true) end end,
			PlayerUnjoinedMessageCommand=function(self, params) if params.Player == PLAYER_2 then self:visible(false) end end,
			LoadActor(THEME:GetPathG("","CursorP1"))..{
				InitCommand=function(self) self:zoomx(-1) end,
				CurrentStepsP1ChangedMessageCommand=function(self) if not courseMode then self:playcommand("PositionCheck") end end,
				CurrentStepsP2ChangedMessageCommand=function(self) if not courseMode then self:playcommand("PositionCheck") end end,
				PositionCheckCommand=function(self)
					self:stoptweening()
					if getenv("wheelstop") == 1 then
						if #GAMESTATE:GetHumanPlayers() > 1 then
							local p1Steps = ""
							local p2Steps = ""
							if GAMESTATE:GetCurrentSong() then
								p1Steps = GAMESTATE:GetCurrentSteps(PLAYER_1)
								p2Steps = GAMESTATE:GetCurrentSteps(PLAYER_2)
							elseif GAMESTATE:GetCurrentCourse() then
								p1Steps = GAMESTATE:GetCurrentTrail(PLAYER_1)
								p2Steps = GAMESTATE:GetCurrentTrail(PLAYER_2)
							end
							if p1Steps and p2Steps then
								if p1Steps:GetDifficulty() == 'Difficulty_Edit' and p2Steps:GetDifficulty() == 'Difficulty_Edit' then
									if p1Steps:GetDescription() == p2Steps:GetDescription() then self:y(11) else self:y(0) end
								else
									if p1Steps:GetDifficulty() == p2Steps:GetDifficulty() then self:y(11) else self:y(0) end
								end
							end
						end
					else self:y(0)
					end
				end
			}
		},
		CursorP1Frame = Def.Actor{
			ChangeCommand=function(self) self:stoptweening():linear(0.05) end
		},
		CursorP2Frame = Def.Actor{
			ChangeCommand=function(self) self:stoptweening():linear(0.05) end
		}
	}
}