function SMOnlineScreen()
	for pn in ivalues(GAMESTATE:GetHumanPlayers()) do
		if not IsSMOnlineLoggedIn(pn) then
			return "ScreenSMOnlineLogin"
		end
	end
	return "ScreenNetRoom"
end

function SelectMusicOrCourse()
	if IsNetSMOnline() then
		return "ScreenNetSelectMusic"
	elseif GAMESTATE:IsCourseMode() then
		return "ScreenSelectCourse"
	else
		return "ScreenSelectMusic"
	end
end

function GameOverOrContinue()
	if THEME:GetMetric("ScreenContinue", "ContinueEnabled") then
		return "ScreenContinue"
	else
		return "ScreenGameOver"
	end
end

Branch = {
	Init = function() return "ScreenInit" end,
	AfterInit = function()
		return Branch.TitleMenu()
	end,
	TitleMenu = function()
		if GAMESTATE:GetCoinMode() == "CoinMode_Home" then
			return "ScreenTitleMenu"
		end
		if GAMESTATE:GetCoinsNeededToJoin() > GAMESTATE:GetCoins() then
			return "ScreenTitleJoin"
		else
			return "ScreenTitleJoin"
		end
	end,
	AfterTitleMenu = function()
		return Branch.StartGame()
	end,
	StartGame = function()
		return "ScreenSelectStyle"
	end,
	AfterProfileSave = function()
		if GAMESTATE:IsEventMode() then
			return SelectMusicOrCourse()
		elseif STATSMAN:GetCurStageStats():AllFailed() then
			return GameOverOrContinue()
		elseif GAMESTATE:GetSmallestNumStagesLeftForAnyHumanPlayer() == 0 then
			if not GAMESTATE:IsCourseMode() then
				return "ScreenEvaluationSummary"
			else
				return GameOverOrContinue()
			end
		else
			return SelectMusicOrCourse()
		end
	end,
	AfterSMOLogin = SMOnlineScreen(),
	BackOutOfPlayerOptions = function()
		return SelectMusicOrCourse()
	end,
	BackOutOfStageInformation = function()
		return SelectMusicOrCourse()
	end,
	AfterSelectMusic = function()
		if SCREENMAN:GetTopScreen():GetGoToOptions() then
			return SelectFirstOptionsScreen()
		else
			return "ScreenStageInformation"
		end
	end,
	PlayerOptions = function()
		local pm = GAMESTATE:GetPlayMode()
		local restricted = { PlayMode_Oni= true, PlayMode_Rave= true }
		local optionsScreen = "ScreenPlayerOptions"
		if restricted[pm] then
			optionsScreen = "ScreenPlayerOptionsRestricted"
		end
		if SCREENMAN:GetTopScreen():GetGoToOptions() and ThemePrefs.Get("SongOpt") then
			return optionsScreen
		else
			return "ScreenStageInformation"
		end
	end,
	SongOptions = function()
		if SCREENMAN:GetTopScreen():GetGoToOptions() then
			return "ScreenSongOptions"
		else
			return "ScreenStageInformation"
		end
	end,
	GameplayScreen = function()
		return IsRoutine() and "ScreenGameplayShared" or "ScreenGameplay"
	end,
	EvaluationScreen= function()
		if IsNetSMOnline() then
			return "ScreenNetEvaluation"
		else
			-- todo: account for courses etc?
			return "ScreenEvaluationNormal"
		end
	end,
	AfterGameplay = function()
		return Branch.EvaluationScreen()
	end,
	AfterEvaluation = function()
		if GAMESTATE:IsCourseMode() then
			return "ScreenProfileSave"
		else
			local maxStages = PREFSMAN:GetPreference("SongsPerPlay")
			local stagesLeft = GAMESTATE:GetSmallestNumStagesLeftForAnyHumanPlayer()
			local allFailed = STATSMAN:GetCurStageStats():AllFailed()
			local song = GAMESTATE:GetCurrentSong()

			if GAMESTATE:IsEventMode() or stagesLeft >= 1 then
				return "ScreenProfileSave"
			elseif song:IsLong() and maxStages <= 2 and stagesLeft < 1 and allFailed then
				return "ScreenProfileSaveSummary"
			elseif song:IsMarathon() and maxStages <= 3 and stagesLeft < 1 and allFailed then
				return "ScreenProfileSaveSummary"
			elseif maxStages >= 2 and stagesLeft < 1 and allFailed then
				return "ScreenProfileSaveSummary"
			elseif allFailed then
				return "ScreenProfileSaveSummary"
			else
				return "ScreenProfileSave"
			end
		end
	end,
	AfterSummary = function()
		return "ScreenProfileSaveSummary"
	end,
	Network = function()
		return IsNetConnected() and "ScreenTitleMenu" or "ScreenTitleMenu"
	end,
	AfterSaveSummary = function()
		return GameOverOrContinue()
--		[[ Enable when Finished ]]
-- 		return GAMESTATE:AnyPlayerHasRankingFeats() and "ScreenNameEntryTraditional" or "ScreenGameOver"
	end,
	AfterContinue = function()
		if GAMESTATE:GetNumPlayersEnabled() == 0 then
			return "ScreenGameOver"
		end

		if STATSMAN:GetStagesPlayed() == 0 then
			return "ScreenSelectStyle"
		end

		return "ScreenProfileLoad"
	end
}
