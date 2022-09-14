return Def.ActorFrame{
	LoadActor("shared_main")..{
		InitCommand=function(self) self:FullScreen() end
	}
}