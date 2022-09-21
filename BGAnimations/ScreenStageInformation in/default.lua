for pn in ivalues(GAMESTATE:GetEnabledPlayers()) do
	local batLives = ThemePrefs.Get("DefLives")
	if batLives == -1 then
		batLives = GetLives(pn)
	end
	if GAMESTATE:IsCourseMode() then
		if GAMESTATE:GetPlayMode() ~= "PlayMode_Oni" then
			GAMESTATE:GetPlayerState(pn):GetPlayerOptions('ModsLevel_Stage'):BatteryLives(batLives)
		end
		GAMESTATE:GetPlayerState(pn):GetPlayerOptions('ModsLevel_Stage'):AttackMines(true)
		GAMESTATE:GetPlayerState(pn):GetPlayerOptions('ModsLevel_Stage'):FailSetting('FailType_Immediate')
	else
		GAMESTATE:GetPlayerState(pn):GetPlayerOptions('ModsLevel_Preferred'):LifeSetting('LifeType_Battery')
		GAMESTATE:GetPlayerState(pn):GetPlayerOptions('ModsLevel_Preferred'):BatteryLives(batLives)
		GAMESTATE:GetPlayerState(pn):GetPlayerOptions('ModsLevel_Preferred'):AttackMines(true)
		GAMESTATE:GetPlayerState(pn):GetPlayerOptions('ModsLevel_Preferred'):FailSetting('FailType_Immediate')
	end
end

GAMESTATE:SetFailTypeExplicitlySet(true)

local t = Def.ActorFrame{}

if GAMESTATE:IsCourseMode() then
	t[#t+1] = Def.ActorFrame{
		LoadActor("boss")..{ OnCommand=function(self) self:play() end },
		LoadActor(THEME:GetPathB("","ScreenStageInformation/course"))
	}
else
	local Song = GAMESTATE:GetCurrentSong()
	local SongTit = Song:GetDisplayMainTitle()
	if SongTit == "I'm an Idiot" then
		t[#t+1] = Def.ActorFrame{
			LoadActor("windeu")..{ OnCommand=function(self) self:play() end },
			LoadActor(THEME:GetPathB("","ScreenStageInformation/windeu"))
		}
	elseif SongTit == "What Do You Really Want" or SongTit == "What Do You Really Want EX" then
		t[#t+1] = Def.ActorFrame{
			LoadActor("crash")..{ OnCommand=function(self) self:play() end },
			LoadActor(THEME:GetPathB("","ScreenStageInformation/crash"))
		}
	elseif IsSongBoss(SongTit) then
		t[#t+1] = Def.ActorFrame{
			LoadActor("boss")..{ OnCommand=function(self) self:play() end },
			LoadActor(THEME:GetPathB("","ScreenStageInformation/boss"))
		}
	elseif IsSongEx(SongTit) then
		t[#t+1] = Def.ActorFrame{
			LoadActor("ex")..{ OnCommand=function(self) self:play() end },
			LoadActor(THEME:GetPathB("","ScreenStageInformation/ex"))
		}
	elseif IsSongDash(SongTit) then
		t[#t+1] = Def.ActorFrame{
			LoadActor("dash")..{ OnCommand=function(self) self:play() end },
			LoadActor(THEME:GetPathB("","ScreenStageInformation/dash"))
		}
	elseif IsSongNonstop(SongTit) then
		t[#t+1] = Def.ActorFrame{
			LoadActor("nonstop")..{ OnCommand=function(self) self:play() end },
			LoadActor(THEME:GetPathB("","ScreenStageInformation/nonstop"))
		}
	elseif IsSongRemix(SongTit) then
		t[#t+1] = Def.ActorFrame{
			LoadActor("remix")..{ OnCommand=function(self) self:play() end },
			LoadActor(THEME:GetPathB("","ScreenStageInformation/remix"))
		}
	else
		t[#t+1] = Def.ActorFrame{
			LoadActor("normal")..{ OnCommand=function(self) self:play() end },
			LoadActor(THEME:GetPathB("","ScreenStageInformation/normal"))
		}
	end
end

return t