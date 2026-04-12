return Def.ActorFrame{
	Def.Sprite {
		Texture = THEME:GetPathG("Common fallback", "background"),
		BeginCommand=function(self) self:Center() end,
		OnCommand=function(self) self:diffusecolor(1,0.3,0.3,1) end
	},
	Def.Quad{
		OnCommand=function(self) self:FullScreen():diffusecolor(Color.White):diffusealpha(1):linear(1):diffusealpha(0) end
	},
	Def.Sprite {
		Texture = THEME:GetPathB("","exborder"),
		BeginCommand=function(self) self:Center() end,
		OnCommand=function(self) self:diffusealpha(0.8):zoomy(2.4):decelerate(0.8):zoomy(1) end
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