return Def.ActorFrame{
	Def.ActorFrame{
		SystemMessageMessageCommand=function(self, params)
			SystemMessageText:settext( params.Message )
			self:playcommand("On")
			if params.NoAnimate then
				self:finishtweening()
			end
			self:playcommand("Off")
		end,
		HideSystemMessageMessageCommand=function(self) self:finishtweening() end,
		Def.Quad{
			InitCommand=function(self)
				self:zoomto(_screen.w, 30):horizalign(left):vertalign(top)
					:diffuse(Color.Black):diffusealpha(0)
			end,
			OnCommand=function(self)
				self:finishtweening():diffusealpha(0.85)
					:zoomto(_screen.w, (SystemMessageText:GetHeight() + 16) * 0.8 )
			end,
			OffCommand=function(self) self:sleep(3):linear(0.5):diffusealpha(0) end
		},
		Def.BitmapText {
			File = "Common normal",
			Name="Text",
			InitCommand=function(self)
				self:maxwidth(750):horizalign(left):vertalign(top)
					:xy(SCREEN_LEFT+10, 10):diffusealpha(0):zoom(0.5)
				SystemMessageText = self
			end,
			OnCommand=function(self) self:finishtweening():diffusealpha(1) end,
			OffCommand=function(self) self:sleep(3):linear(0.5):diffusealpha(0) end
		}
	}
}