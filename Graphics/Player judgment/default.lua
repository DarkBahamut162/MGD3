local c
local player = Var "Player"
local TNSFrames = {
	HoldNoteScore_Held = 0,
	HoldNoteScore_LetGo = 1
}

local arrows = GAMESTATE:GetCurrentStyle():ColumnsPerPlayer()
local arrowPos = {}
local space = IsGame("Pump") and 50 or 64
local startFromZero = arrows % 2 == 0 and false or true
local centerPosition = math.round(arrows / 2)

local addToI = arrows % 2 == 0 and 0 or 1
local subToArrows = arrows % 2 == 0 and 1 or 0

for i=addToI,arrows-subToArrows do
	if i < centerPosition then
		arrowPos[i-addToI] = (centerPosition-i)*-space
	else
		arrowPos[i-addToI] = (i-centerPosition)*space
	end
	if arrows % 2 == 0 then arrowPos[i-addToI] = arrowPos[i-addToI] + space/2 end
end

return Def.ActorFrame{
	LoadActor("../HoldJudgment label 1x2")..{
		Condition=arrows>=1,
		Name="Judgment1",
		InitCommand=function(self) self:pause():visible(false) end,
		ResetCommand=function(self) self:finishtweening():x(arrowPos[0]):y(-146):stopeffect():visible(false) end
	},
	LoadActor("../HoldJudgment label 1x2")..{
		Condition=arrows>=2,
		Name="Judgment2",
		InitCommand=function(self) self:pause():visible(false) end,
		ResetCommand=function(self) self:finishtweening():x(arrowPos[1]):y(-146):stopeffect():visible(false) end
	},
	LoadActor("../HoldJudgment label 1x2")..{
		Condition=arrows>=3,
		Name="Judgment3",
		InitCommand=function(self) self:pause():visible(false) end,
		ResetCommand=function(self) self:finishtweening():x(arrowPos[2]):y(-146):stopeffect():visible(false) end
	},
	LoadActor("../HoldJudgment label 1x2")..{
		Condition=arrows>=4,
		Name="Judgment4",
		InitCommand=function(self) self:pause():visible(false) end,
		ResetCommand=function(self) self:finishtweening():x(arrowPos[3]):y(-146):stopeffect():visible(false) end
	},
	LoadActor("../HoldJudgment label 1x2")..{
		Condition=arrows>=5,
		Name="Judgment5",
		InitCommand=function(self) self:pause():visible(false) end,
		ResetCommand=function(self) self:finishtweening():x(arrowPos[4]):y(-146):stopeffect():visible(false) end
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