local t = Def.ActorFrame{}

if GAMESTATE:IsCourseMode() then
	t[#t+1] = Def.ActorFrame{
		Def.Sprite{
			BeginCommand=function(self) self:scale_or_crop_background() end,
			InitCommand=function(self)
				self:Load(THEME:GetPathG("Common fallback", "background"))
			end,
			OnCommand=function(self) self:diffusecolor(1,0.3,0.3,1):diffusealpha(1):sleep(0.2):decelerate(0.88):diffusealpha(0) end
		},
		Def.Sprite {
			Texture = THEME:GetPathB("","exborder"),
			BeginCommand=function(self) self:Center() end,
			OnCommand=function(self) self:diffusealpha(0.8):zoomy(1):accelerate(0.8):zoomy(2.4) end
		}
	}
else
	local Song = GAMESTATE:GetCurrentSong()
	local SongTit = Song:GetDisplayMainTitle()

	t[#t+1] = Def.ActorFrame{
		InitCommand=function(self) self:sleep(4) end,
		Def.Sprite{
			BeginCommand=function(self) self:scale_or_crop_background() end,
			InitCommand=function(self)
				if Song then
					if Song:HasBackground() then
							self:LoadBackground(Song:GetBackgroundPath())
						else
							self:Load(THEME:GetPathG("Common fallback", "background"))
					end
				end
			end,
			OnCommand=function(self) self:diffusealpha(1):sleep(0.2):decelerate(0.88):diffusealpha(0) end
		}
	}

	if IsSongBoss(SongTit) then
		t[#t+1] = Def.ActorFrame{
			Def.Sprite{
				BeginCommand=function(self) self:scale_or_crop_background() end,
				InitCommand=function(self)
					if Song then
						if Song:HasBackground() then
								self:LoadBackground(Song:GetBackgroundPath())
							else
								self:Load(THEME:GetPathG("Common fallback", "background"))
						end
					end
				end,
				OnCommand=function(self) self:diffusecolor(1,0.3,0.3,1):diffusealpha(1):sleep(0.2):decelerate(0.88):diffusealpha(0) end
			}
		}
	end
	if IsSongDash(SongTit) then
		t[#t+1] = Def.ActorFrame{
			Def.Sprite {
				Texture = THEME:GetPathB("","dash-bg"),
				BeginCommand=function(self) self:scale_or_crop_background() end,
				OnCommand=function(self) self:diffusealpha(1):sleep(0.2):decelerate(0.88):diffusealpha(0) end
			}
		}
	end
	if IsSongLife(SongTit) then
		t[#t+1] = Def.ActorFrame{
			Def.Sprite{
				BeginCommand=function(self) self:scale_or_crop_background() end,
				InitCommand=function(self)
					if Song then
						if Song:HasBackground() then
								self:LoadBackground(Song:GetBackgroundPath())
							else
								self:Load(THEME:GetPathG("Common fallback", "background"))
						end
					end
				end,
				OnCommand=function(self) self:diffusealpha(1):sleep(0.2):decelerate(0.88):diffusealpha(0) end
			}
		}
	end
	if IsSongBoss(SongTit) then
		t[#t+1] = Def.ActorFrame{
			Def.Sprite {
				Texture = THEME:GetPathB("","border"),
				BeginCommand=function(self) self:Center() end,
				OnCommand=function(self) self:diffusealpha(0.8):zoomy(1):accelerate(0.8):zoomy(2.4) end
			}
		}
	end
	if IsSongEx(SongTit) then
		t[#t+1] = Def.ActorFrame{
			Def.Sprite {
				Texture = THEME:GetPathB("","exborder"),
				BeginCommand=function(self) self:Center() end,
				OnCommand=function(self) self:diffusealpha(0.8):zoomy(1):accelerate(0.8):zoomy(2.4) end
			}
		}
	end
	if IsSongLife(SongTit) then
		t[#t+1] = Def.ActorFrame{
			Def.Sprite {
				Texture = THEME:GetPathB("","lifeborder"),
				BeginCommand=function(self) self:Center() end,
				OnCommand=function(self) self:diffusealpha(0.8):zoomy(1):accelerate(0.8):zoomy(2.4) end
			}
		}
	end
end

return t