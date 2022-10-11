local player = Var "Player"
local TNSFrames = {
	HoldNoteScore_Held = 0,
	HoldNoteScore_LetGo = 1
}

local reverse = GAMESTATE:GetIsFieldReversed(player)
local yPos = reverse and THEME:GetMetric('Player', 'HoldJudgmentYReverse') or THEME:GetMetric('Player', 'HoldJudgmentYStandard')
local HoldJudgments = Def.ActorFrame { InitCommand = function(self) self:y(yPos) end }

local screen
local isSurvival = GAMESTATE:GetPlayMode() == "PlayMode_Oni" and GAMESTATE:GetCurrentCourse(player):GetCourseEntry(0):GetGainSeconds() > 0
local glifemeter = 100
local isAutoPlay = GAMESTATE:GetPlayerState(player):GetPlayerController() == "PlayerController_Autoplay"

for i = 1, GAMESTATE:GetCurrentStyle():ColumnsPerPlayer() do
	local xPos = GAMESTATE:GetCurrentStyle():GetColumnInfo(player, i).XOffset
	HoldJudgments[#HoldJudgments + 1] = LoadActor("../HoldJudgment label 1x2")..{
		Name="Judgment"..i,
		InitCommand = function(self) self:x(xPos):diffusealpha(0):pause() end,
		OnCommand=function(self) screen = SCREENMAN:GetTopScreen() end,
		HeldCommand = function(self)
			glifemeter = screen:GetLifeMeter(player):GetLivesLeft()
			if glifemeter < 100 then
				self:stoptweening():setstate(0):diffusealpha(0):zoom(0.3):decelerate(0.2):zoom(0.6):diffusealpha(1):sleep(0.3):decelerate(0.2):diffusealpha(0):zoomx(1.2)
				screen:GetLifeMeter(player):ChangeLives(1)
			end
		end,
		LetGoCommand = function(self)
			self:stoptweening():setstate(1):diffusealpha(0):zoom(0.3):decelerate(0.2):zoom(0.6):diffusealpha(1):sleep(0.3):decelerate(0.2):diffusealpha(0):zoomx(1.2)
			screen:GetLifeMeter(player):ChangeLives(-2)
		end,
		JudgmentMessageCommand = function(self, params)
			if params.Player ~= player then return end
			if params.FirstTrack ~= i - 1 then return end
			isAutoPlay = GAMESTATE:GetPlayerState(player):GetPlayerController() == "PlayerController_Autoplay"
			if TNSFrames[params.HoldNoteScore] and not isSurvival and not isAutoPlay then
				self:playcommand(ToEnumShortString(params.HoldNoteScore))
			end
		end
	}
end

return Def.ActorFrame{ HoldJudgments }