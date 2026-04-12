return Def.ActorFrame{
	Def.Sound {
		File = THEME:GetPathB("ScreenEvaluationNormal","in/evaluation.ogg"),
		OnCommand=function(self) self:play() end
	},
	Def.Quad{
		OnCommand=function(self) self:FullScreen():diffusecolor(Color.Black):diffusealpha(1):sleep(1.2):diffusealpha(0) end
	},
	Def.Quad{
		OnCommand=function(self) self:FullScreen():diffusecolor(Color.White):diffusealpha(0):sleep(1.2):diffusealpha(1):decelerate(1.0):diffusealpha(0) end
	},
	Def.Quad{
		OnCommand=function(self) self:FullScreen():diffusecolor(Color.White):diffusealpha(1):decelerate(0.8):diffusealpha(0) end
	},
	Def.Quad{
		OnCommand=function(self) self:FullScreen():diffusecolor(Color.White):zoomy(6.5):decelerate(0.34):zoomy(0.013):sleep(0.1):accelerate(0.35):diffusealpha(0):zoomx(0) end
	},
	Def.Sprite {
		Texture = THEME:GetPathB("","select"),
		BeginCommand=function(self) self:Center() end,
		OnCommand=function(self) self:sleep(0.5):linear(0.4):diffusealpha(0) end
	}
}