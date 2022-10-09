return Def.ActorFrame{
	LoadActor("ScreenMDCredits decorations/solong")..{
		InitCommand=function(self) self:Center():blend(Blend.Add):diffusealpha(0.5) end
	},
	LoadFont("MusicList titles")..{
		Text="GAME OVER",
		InitCommand=function(self) self:x(SCREEN_CENTER_X-130):y(SCREEN_CENTER_Y+70):diffusealpha(0):sleep(1):linear(2):diffusealpha(0.75) end
	}
}