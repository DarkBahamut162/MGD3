return Def.ActorFrame{
	LoadActor("header")..{
		InitCommand=function(self) self:Center():zoom(WideScreenDiff()) end
	}
}