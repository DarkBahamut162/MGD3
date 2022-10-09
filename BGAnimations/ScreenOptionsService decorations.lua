return Def.ActorFrame{
	LoadActor("Logo/mgdlogo")..{
		InitCommand=function(self) self:Center():blend(Blend.Add):diffusealpha(0.25) end
	},
	Def.Quad{
		OnCommand=function(self) self:FullScreen():diffusecolor(Color.Black):diffusealpha(0.7) end
	},
	LoadActor("ScreenEvaluationNormal decorations/left")..{
		InitCommand=function(self) self:x(SCREEN_LEFT+64):CenterY() end
	},
	LoadActor("ScreenEvaluationNormal decorations/right")..{
		InitCommand=function(self) self:x(SCREEN_RIGHT-64):CenterY() end
	}
}