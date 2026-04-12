return Def.ActorFrame{
	Def.Sprite {
		Texture = THEME:GetPathB("","shared_main/shared_main"),
		InitCommand=function(self) self:FullScreen() end
	}
}