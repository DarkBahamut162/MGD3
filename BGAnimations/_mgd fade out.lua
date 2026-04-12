return Def.ActorFrame{
	Def.Quad{
		OnCommand=function(self) self:FullScreen():diffusecolor(Color.Black) end
	},
	Def.Quad{
		OnCommand=function(self) self:FullScreen():diffusecolor(Color.White):zoomy(SCREEN_HEIGHT):decelerate(0.34):zoomy(0.013):sleep(0.1):accelerate(0.35):diffusealpha(0):zoomx(0) end
	},
	Def.Sprite {
		Texture = THEME:GetPathB("","select"),
		BeginCommand=function(self) self:Center() end,
		OnCommand=function(self) self:sleep(0.5):linear(0.4):diffusealpha(0) end
	},
	Def.Sprite {
		Texture = THEME:GetPathB("","spin"),
		BeginCommand=function(self) self:scale_or_crop_background() end,
		OnCommand=function(self) self:diffusealpha(0.6):zoom(0.2):accelerate(0.6):zoom(1):diffusealpha(0):rotationz(250) end
	},
	Def.Sprite {
		Texture = THEME:GetPathB("","spin"),
		BeginCommand=function(self) self:scale_or_crop_background() end,
		OnCommand=function(self) self:diffusealpha(0.6):zoom(0.2):accelerate(0.8):zoom(1):diffusealpha(0):rotationz(-250) end
	},
	Def.Sprite {
		Texture = THEME:GetPathB("","spin"),
		BeginCommand=function(self) self:scale_or_crop_background() end,
		OnCommand=function(self) self:diffusealpha(0.6):zoom(0.2):accelerate(1):zoom(1):diffusealpha(0):rotationz(250) end
	}
}