return Def.ActorFrame{
	Def.Sprite {
		Texture = THEME:GetPathB("ScreenLawsuit","background/logo"),
		InitCommand=function(self) self:FullScreen() end
	},
	Def.Sprite {
		Texture = THEME:GetPathB("ScreenLawsuit","background/rating"),
		InitCommand=function(self) self:Center() end,
		OnCommand=function(self) self:diffusealpha(0):sleep(5):linear(1):diffusealpha(1) end
	}
}