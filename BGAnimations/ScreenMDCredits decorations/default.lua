return Def.ActorFrame{
	LoadActor("bg")..{
		OnCommand=function(self) self:x(SCREEN_CENTER_X+1680):CenterY():blend(Blend.Add):linear(120):x(SCREEN_CENTER_X-2920) end
	},
	Def.Quad{
		OnCommand=function(self) self:FullScreen():diffusecolor(Color.Black):diffusealpha(0.5) end
	},
	LoadActor("credits")..{
		OnCommand=function(self) self:diffuse(color("0,0,0,0.5")):y(SCREEN_CENTER_Y+8):x(SCREEN_CENTER_X+2290):linear(60):x(SCREEN_CENTER_X-2930) end
	},
	LoadActor("credits")..{
		OnCommand=function(self) self:x(SCREEN_CENTER_X+2280):y(SCREEN_CENTER_Y+8):linear(60):x(SCREEN_CENTER_X-2920) end
	},
	Def.Quad{
		OnCommand=function(self) self:FullScreen():diffusecolor(Color.Black):diffusealpha(0):sleep(50):linear(2):diffusealpha(1) end
	},
	LoadActor("solong")..{
		OnCommand=function(self) self:Center():diffusealpha(0):sleep(52):linear(2.5):diffusealpha(1):sleep(2):linear(2.5):diffusealpha(0) end
	}
}