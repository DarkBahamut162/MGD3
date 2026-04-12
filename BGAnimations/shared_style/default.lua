return Def.ActorFrame{
	Def.Sprite {
		Texture = THEME:GetPathB("","shshared_styleared_main/shared_style"),
		InitCommand=function(self) self:FullScreen() end
	}
}