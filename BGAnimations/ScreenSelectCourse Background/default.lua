return Def.ActorFrame{
	Def.Sprite {
		Texture = THEME:GetPathB("ScreenSelectCourse","Background/bg"),
		InitCommand=function(self) self:FullScreen() end,
		OnCommand=function(self) self:rainbow():effectclock('bgm'):effectperiod(24) end
	},
	Def.Model{
		Materials=THEME:GetPathB("","ball2mod"),
		Meshes=THEME:GetPathB("","ball2mod"),
		Bones=THEME:GetPathB("","ball2mod"),
		OnCommand=function(self) self:x(SCREEN_CENTER_X+110):CenterY():blend(Blend.Add):zoom(6):spin():effectmagnitude(44,67,37) end
	},
	Def.Model{
		Materials=THEME:GetPathB("","ball2mod"),
		Meshes=THEME:GetPathB("","ball2mod"),
		Bones=THEME:GetPathB("","ball2mod"),
		OnCommand=function(self) self:Center():z(30):blend(Blend.Add):zoom(18):spin():effectmagnitude(0,44,0) end
	},
	Def.Model{
		Materials=THEME:GetPathB("","sphere_back"),
		Meshes=THEME:GetPathB("","sphere_back"),
		Bones=THEME:GetPathB("","sphere_back"),
		OnCommand=function(self) self:Center():zoom(7):spin():effectmagnitude(0,124,0) end
	}
}