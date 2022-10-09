return Def.ActorFrame{
	OnCommand=function(self) self:Center() end,
	Def.Quad{
		OnCommand=function(self) self:FullScreen():x(0):y(0):diffusecolor(Color.Black):draworder(1):diffusealpha(0):linear(1):diffusealpha(1) end
	},
	LoadActor("x")..{
		OnCommand=function(self) self:blend(Blend.Add):zoom(5):rotationz(290):diffusealpha(0):sleep(0.1):decelerate(0.6):zoom(1):rotationz(0):diffusealpha(1):sleep(0.1):linear(0.8):diffusealpha(0) end
	},
	LoadActor("failed_shadow")..{
		OnCommand=function(self) self:diffusealpha(0):zoom(4):sleep(0.6):diffusealpha(1):decelerate(0.25):zoom(1):sleep(0.1):linear(0.8):zoom(1.5):diffusealpha(0) end
	},
	LoadActor("failed_over")..{
		OnCommand=function(self) self:diffusealpha(0):sleep(0.7):decelerate(0.12):diffusealpha(1):sleep(1):linear(0.9):diffusealpha(0) end
	},
	LoadActor("failed_sound")..{
		StartTransitioningCommand=function(self) self:play() end
	}
}