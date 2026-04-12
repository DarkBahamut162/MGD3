return Def.ActorFrame{
	loadfile(THEME:GetPathB("","Logo"))()..{
		OnCommand=function(self) self:Center() end
	},
	loadfile(THEME:GetPathB("","Title_deco"))()
}