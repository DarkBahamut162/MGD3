local courseMode = GAMESTATE:IsCourseMode()
local sideWidth = 208*WideScreenDiff()
local bgWidth = (SCREEN_WIDTH-sideWidth)

return Def.ActorFrame{
	Def.ActorFrame{
		InitCommand=function(self) c = self:GetChildren() end,
		Def.Sprite {
			Texture = THEME:GetPathB("ScreenSelectMusic","overlay/side"),
			Name="Side",
			InitCommand=function(self) self:halign(0):valign(0):zoomtowidth(sideWidth) end
		},
		Def.Sprite {
			Texture = THEME:GetPathB("ScreenSelectMusic","overlay/background"),
			Name="Background",
			InitCommand=function(self) self:x(sideWidth):halign(0):valign(0):zoomtowidth(SCREEN_WIDTH-sideWidth) end
		},
		Def.Sprite {
			Texture = THEME:GetPathB("ScreenSelectMusic","overlay/border"),
			Name="Left",
			InitCommand=function(self) self:x(sideWidth):halign(0):valign(0) end
		},
		Def.Sprite {
			Texture = THEME:GetPathB("ScreenSelectMusic","overlay/border"),
			Name="right",
			InitCommand=function(self) self:x(SCREEN_RIGHT):halign(0):valign(0):zoomx(-1) end
		},
		Def.Sprite {
			Texture = THEME:GetPathB("ScreenSelectMusic","overlay/song"),
			Name="BG1",
			InitCommand=function(self) self:x(sideWidth+bgWidth/2):zoomx(WideScreenDiff()):valign(0) end
		},
		Def.Sprite {
			Texture = THEME:GetPathB("ScreenSelectMusic","overlay/folder"),
			Name="BG2",
			InitCommand=function(self) self:x(sideWidth+bgWidth/2):zoomx(WideScreenDiff()):valign(0) end
		},
		loadfile(THEME:GetPathB("ScreenSelectMusic","overlay/difflist"))()..{
			InitCommand=function(self) self:Center():addx(40*WideScreenDiff()):addy(-140) end
		},
		loadfile(THEME:GetPathB("ScreenSelectMusic","overlay/scoring"))()..{
			InitCommand=function(self) self:Center():addx(180*WideScreenDiff()):addy(-117) end
		},
		loadfile(THEME:GetPathB("ScreenSelectMusic","overlay/data"))()..{
			InitCommand=function(self) self:Center():addx(106*WideScreenDiff()):addy(-12) end
		},
		loadfile(THEME:GetPathB("ScreenSelectMusic","overlay/accel"))(),
		Def.BitmapText {
			File = "Panedisplay Blurred",
			InitCommand=function(self) self:x(SCREEN_CENTER_X+100*WideScreenDiff()):y(SCREEN_BOTTOM-69):settext("ACCELERATION"):diffuse(color('#808080')):zoom(1/4) end,
		},
		SetCommand=function(self)
			local song = GAMESTATE:GetCurrentSong()
			if song then
				c.BG1:diffusealpha(1)
				c.BG2:diffusealpha(0)
			else
				c.BG1:diffusealpha(0)
				c.BG2:diffusealpha(1)
			end
		end,
		CurrentSongChangedMessageCommand=function(self) if not courseMode then self:playcommand("Set") end end
	}
}