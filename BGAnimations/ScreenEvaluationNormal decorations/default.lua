local t = Def.ActorFrame{}
local Song = GAMESTATE:GetCurrentSong()
local SongTit = Song:GetDisplayMainTitle()

if not ThemePrefs.Get("AltResult") then
	t[#t+1] = Def.ActorFrame{
		LoadActor("../ball3")..{
			InitCommand=function(self) self:Center():zoom(14):z(-100):spin():effectmagnitude(44,44,44):diffusealpha(0.5) end
		}
	}
end

t[#t+1] = Def.ActorFrame{
	LoadActor("../_tiledbg"),
	Def.Sprite{
		InitCommand=function(self)
			if Song then
				if Song:HasBackground() then
						self:LoadBackground(Song:GetBackgroundPath())
					else
						self:Load(THEME:GetPathG("Common fallback", "background"))
				end
			end
		end,
		OnCommand=function(self) self:scale_or_crop_background():diffusealpha(0.2) end
	},
	LoadActor("../Shared_style")..{
		InitCommand=function(self) self:diffusealpha(0.15) end
	}
}

if ThemePrefs.Get("AltResult") then
	t[#t+1] = Def.ActorFrame{
		LoadActor("../ball3")..{
			InitCommand=function(self) self:Center():zoom(14):z(-100):spin():effectmagnitude(44,44,44):diffusealpha(1) end
		},
		LoadActor("../Shared_style")..{
			InitCommand=function(self) self:z(-100):ztestmode("WriteOnFail"):diffusealpha(0.1) end
		}
	}
end

t[#t+1] = Def.ActorFrame{
	Def.Sprite{
		InitCommand=function(self)
			if Song then
				if Song:HasBackground() then
						self:LoadBackground(Song:GetBackgroundPath())
					else
						self:Load(THEME:GetPathG("Common fallback", "background"))
				end
				self:setsize(200*(SCREEN_WIDTH/640),150*(SCREEN_WIDTH/640))
			end
		end,
		OnCommand=function(self) self:x(SCREEN_CENTER_X-160*(SCREEN_WIDTH/640)):y(SCREEN_CENTER_Y+8*(SCREEN_WIDTH/640)) end
	},
	LoadActor("rankbg")..{
		InitCommand=function(self) self:Center():zoom(SCREEN_WIDTH/640) end
	},
	LoadActor("left")..{
		InitCommand=function(self) self:x(SCREEN_LEFT+64):CenterY() end
	},
	LoadActor("right")..{
		InitCommand=function(self) self:x(SCREEN_RIGHT-64):CenterY() end
	},
	LoadFont("MusicList titles")..{
		Name="Title",
		InitCommand=function(self) self:zoom(1):Center():queuecommand("Set"):addy(137):maxwidth(SCREEN_WIDTH) end,
		SetCommand=function(self)
			if Song then
				self:settext(Song:GetDisplayFullTitle())
			end
		end
	}
}

for player in ivalues(GAMESTATE:GetEnabledPlayers()) do
	t[#t+1] = Def.ActorFrame{
		LoadFont("Combo numbers")..{
			InitCommand=function(self)
				if Song then
					local TotalStep=STATSMAN:GetCurStageStats():GetPlayerStageStats(player):GetTapNoteScores("TapNoteScore_W1") + STATSMAN:GetCurStageStats():GetPlayerStageStats(player):GetTapNoteScores("TapNoteScore_W2") + STATSMAN:GetCurStageStats():GetPlayerStageStats(player):GetTapNoteScores("TapNoteScore_W3") + STATSMAN:GetCurStageStats():GetPlayerStageStats(player):GetTapNoteScores("TapNoteScore_W4")
					self:settext(TotalStep)
					self:horizalign(right)
					self:maxwidth(230*(SCREEN_WIDTH/640))
					self:zoom(0.7*(SCREEN_WIDTH/640))
					self:zoomy((#GAMESTATE:GetHumanPlayers()==2 and 0.35 or 0.7)*(SCREEN_WIDTH/640))
					if player == PLAYER_1 then
					self:y(SCREEN_CENTER_Y+(#GAMESTATE:GetHumanPlayers()==2 and 11 or 20)*(SCREEN_WIDTH/640))
						self:x(SCREEN_CENTER_X+107*(SCREEN_WIDTH/640))
					else
						self:y(SCREEN_CENTER_Y+(#GAMESTATE:GetHumanPlayers()==2 and 29 or 20)*(SCREEN_WIDTH/640))
						self:x(SCREEN_CENTER_X+107*(SCREEN_WIDTH/640))
					end
				end
			end
		},
		LoadFont("Combo numbers")..{
			InitCommand=function(self)
				if GAMESTATE:IsCourseMode() then
					local trail = GAMESTATE:GetCurrentTrail(player)
					local TotalStep = 0
					for entry in ivalues(trail:GetTrailEntries()) do
						TotalStep = TotalStep + entry:GetSteps():GetRadarValues(player):GetValue('RadarCategory_TapsAndHolds')
					end
					self:settext(TotalStep)
				else
					self:settext(GAMESTATE:GetCurrentSteps(player):GetRadarValues(player):GetValue('RadarCategory_TapsAndHolds'))
				end
				self:horizalign(left)
				self:maxwidth(230*(SCREEN_WIDTH/640))
				self:zoom(0.7*(SCREEN_WIDTH/640))
				self:zoomy((#GAMESTATE:GetHumanPlayers()==2 and 0.35 or 0.7)*(SCREEN_WIDTH/640))
				if player == PLAYER_1 then
					self:y(SCREEN_CENTER_Y+(#GAMESTATE:GetHumanPlayers()==2 and 11 or 20)*(SCREEN_WIDTH/640))
					self:x(SCREEN_CENTER_X+138*(SCREEN_WIDTH/640))
				else
					self:y(SCREEN_CENTER_Y+(#GAMESTATE:GetHumanPlayers()==2 and 29 or 20)*(SCREEN_WIDTH/640))
					self:x(SCREEN_CENTER_X+138*(SCREEN_WIDTH/640))
				end
			end
		}
	}
end

return t