return Def.ActorFrame{
	Def.Sprite {
		Texture = THEME:GetPathB("","_tiledbg/1"),
		InitCommand=function(self) self:FullScreen() end,
		OnCommand=function(self)
			local w = DISPLAY:GetDisplayWidth() / self:GetWidth()
			local h = DISPLAY:GetDisplayHeight() / self:GetHeight()
			self:customtexturerect(0,0,w,h)
			self:texcoordvelocity(-.2,0)
			self:diffusealpha(0.95)
		end
	}
}