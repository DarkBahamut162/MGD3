local gc = Var("GameCommand")
return Def.ActorFrame{
	Def.ActorFrame{
		GainFocusCommand=THEME:GetMetric(Var "LoadingScreen","BGGainFocusCommand"),
		LoseFocusCommand=THEME:GetMetric(Var "LoadingScreen","BGLoseFocusCommand"),
		Def.Sprite {
			Texture = THEME:GetPathG("_SelectIcon",gc:GetName().." icon"),
			InitCommand=function(self) self:zoom(WideScreenDiff()) end,
			OnCommand=function(self) self:Center():diffusealpha(0):linear(0.5):diffusealpha(1) end,
			OffCommand=function(self) self:diffusealpha(1):linear(0.5):diffusealpha(0) end
		}
	},
	Def.ActorFrame{
		GainFocusCommand=THEME:GetMetric(Var "LoadingScreen","IconGainFocusCommand"),
		LoseFocusCommand=THEME:GetMetric(Var "LoadingScreen","IconLoseFocusCommand"),
		Def.Sprite {
			Texture = THEME:GetPathG("_SelectIcon",gc:GetName().." bg"),
			InitCommand=function(self) self:zoom(WideScreenDiff()) end,
			OnCommand=function(self) self:Center():diffusealpha(0):linear(0.5):diffusealpha(1) end,
			OffCommand=function(self) self:diffusealpha(1):linear(0.5):diffusealpha(0) end,
			GainFocusCommand=function(self) self:diffusealpha(0):linear(0.5):diffusealpha(1) end,
			LoseFocusCommand=function(self) self:stoptweening():diffusealpha(0) end
		}
	}
}