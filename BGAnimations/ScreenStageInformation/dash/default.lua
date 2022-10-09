return Def.ActorFrame{
	LoadActor("../../shared_main")..{
		OnCommand=function(self) self:diffusealpha(0):sleep(1.437):rainbow():diffusealpha(1):linear(2):diffusealpha(0) end
	},
	Def.Quad{
		OnCommand=function(self) self:FullScreen():diffusecolor(Color.Black):diffusealpha(1):sleep(1.437):diffusealpha(0) end
	},
	LoadActor("../../dash-bg")..{
		BeginCommand=function(self) self:Center() end,
		OnCommand=function(self) self:diffusealpha(0):sleep(1.437):blend(Blend.Add):zoom(3):diffusealpha(0):decelerate(2):zoom(1):diffusealpha(1) end
	},
	Def.Quad{
		OnCommand=function(self) self:FullScreen():diffusecolor(Color.White):diffusealpha(0):sleep(1.437):diffusealpha(1):rainbow():diffusealpha(1):linear(1):diffusealpha(0) end
	},
	Def.Quad{
		OnCommand=function(self) self:FullScreen():diffusecolor(Color.White):diffusealpha(1):linear(0.4):diffusealpha(0) end
	},
	Def.Quad{
		OnCommand=function(self) self:FullScreen():diffusecolor(Color.White):zoomy(SCREEN_HEIGHT):decelerate(0.34):zoomy(0.013):sleep(0.1):accelerate(0.35):diffusealpha(0):zoomx(0) end
	},
	LoadActor("../../select")..{
		BeginCommand=function(self) self:Center() end,
		OnCommand=function(self) self:sleep(0.5):linear(0.4):diffusealpha(0) end
	},
	LoadActor("../../spin")..{
		BeginCommand=function(self) self:scale_or_crop_background() end,
		OnCommand=function(self) self:diffusealpha(0.6):zoom(0.2):accelerate(0.6):zoom(1):diffusealpha(0):rotationz(250) end
	},
	LoadActor("../../spin")..{
		BeginCommand=function(self) self:scale_or_crop_background() end,
		OnCommand=function(self) self:diffusealpha(0.6):zoom(0.2):accelerate(0.8):zoom(1):diffusealpha(0):rotationz(-250) end
	},
	LoadActor("../../spin")..{
		BeginCommand=function(self) self:scale_or_crop_background() end,
		OnCommand=function(self) self:diffusealpha(0.6):zoom(0.2):accelerate(1):zoom(1):diffusealpha(0):rotationz(250) end
	}
}