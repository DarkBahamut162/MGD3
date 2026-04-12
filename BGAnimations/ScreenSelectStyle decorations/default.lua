return Def.ActorFrame{
	Def.Sprite {
		Texture = THEME:GetPathB("ScreenSelectStyle","decorations/header"),
		InitCommand=function(self) self:Center():zoom(WideScreenDiff()) end
	}
}