return Def.ActorFrame{
	LoadActor("shared_main")..{
		OnCommand=function(self) self:zoom(1.3):addx(-20*WideScreenDiff()):addy(-70):diffusealpha(0.7) end
	}
}