return Def.ActorFrame{
	LoadActor("menu_bg")..{
		OnCommand=function(self) self:Center():addy(126*WideScreenDiff()):zoom(WideScreenDiff()):zoomx(SCREEN_WIDTH/854) end
	},
	LoadActor("monakai")..{
		OnCommand=function(self) self:x(SCREEN_RIGHT-72*WideScreenDiff()):y(SCREEN_BOTTOM-25*WideScreenDiff()):zoom(WideScreenDiff()) end
	},
	LoadActor("vulp_logo")..{
		OnCommand=function(self) self:x(SCREEN_LEFT+69*WideScreenDiff()):y(SCREEN_BOTTOM-18*WideScreenDiff()):zoom(WideScreenDiff()) end
	}
}