local c
local player = Var "Player"
local TNSFrames = {
	HoldNoteScore_Held = 0,
	HoldNoteScore_LetGo = 1
}

return Def.ActorFrame{
	LoadActor("../HoldJudgment label 1x2")..{
		Name="Judgment1",
		InitCommand=function(self) self:pause():visible(false) end,
		ResetCommand=function(self) self:finishtweening():x(-96):y(-146):stopeffect():visible(false) end
	},
	LoadActor("../HoldJudgment label 1x2")..{
		Name="Judgment2",
		InitCommand=function(self) self:pause():visible(false) end,
		ResetCommand=function(self) self:finishtweening():x(-32):y(-146):stopeffect():visible(false) end
	},
	LoadActor("../HoldJudgment label 1x2")..{
		Name="Judgment3",
		InitCommand=function(self) self:pause():visible(false) end,
		ResetCommand=function(self) self:finishtweening():x(32):y(-146):stopeffect():visible(false) end
	},
	LoadActor("../HoldJudgment label 1x2")..{
		Name="Judgment4",
		InitCommand=function(self) self:pause():visible(false) end,
		ResetCommand=function(self) self:finishtweening():x(96):y(-146):stopeffect():visible(false) end
	},
	InitCommand = function(self)
		c = self:GetChildren()
	end,
	JudgmentMessageCommand=function(self, param)
		if param.Player ~= player then return end
		if not param.TapNoteScore then return end
		if not param.HoldNoteScore then return end
		local tns = param.HoldNoteScore
		local iFrame = TNSFrames[tns]
		local screen = SCREENMAN:GetTopScreen()
		local isSurvival = GAMESTATE:GetPlayMode() == "PlayMode_Oni" and GAMESTATE:GetCurrentCourse(player):GetCourseEntry(0):GetGainSeconds() > 0
		local glifemeter = 100
		local isAutoPlay = GAMESTATE:GetPlayerState(player):GetPlayerController() == "PlayerController_Autoplay"
		if not isSurvival then glifemeter = screen:GetLifeMeter(param.Player):GetLivesLeft() end
		if (iFrame and glifemeter < 100 and not isSurvival and not isAutoPlay) or param.HoldNoteScore == "HoldNoteScore_LetGo" then
			if param.HoldNoteScore == "HoldNoteScore_Held" then
				screen:GetLifeMeter(player):ChangeLives(1)
			elseif param.HoldNoteScore == "HoldNoteScore_LetGo" then
				screen:GetLifeMeter(player):ChangeLives(-2)
			end
			c["Judgment"..(param.FirstTrack+1)]:playcommand("Reset"):diffusealpha(0):zoom(0.3):decelerate(0.2):zoom(0.6):diffusealpha(1):sleep(0.3):decelerate(0.2):diffusealpha(0):zoomx(1.2)
			c["Judgment"..(param.FirstTrack+1)]:setstate( iFrame )
			c["Judgment"..(param.FirstTrack+1)]:visible( true )
		end
	end
}