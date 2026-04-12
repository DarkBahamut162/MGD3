return Def.ActorFrame{
	Def.Sprite {
		Texture = THEME:GetPathB("","Title_deco/menu_bg"),
		OnCommand=function(self) self:Center():addy(126*WideScreenDiff()):zoom(WideScreenDiff()):zoomx(SCREEN_WIDTH/854) end
	},
	Def.Sprite {
		Texture = THEME:GetPathB("","Title_deco/monakai"),
		OnCommand=function(self) self:x(SCREEN_RIGHT-72*WideScreenDiff()):y(SCREEN_BOTTOM-25*WideScreenDiff()):zoom(WideScreenDiff()) end
	},
	Def.Sprite {
		Texture = THEME:GetPathB("","Title_deco/vulp_logo"),
		OnCommand=function(self) self:x(SCREEN_LEFT+69*WideScreenDiff()):y(SCREEN_BOTTOM-18*WideScreenDiff()):zoom(WideScreenDiff()) end
	}
}