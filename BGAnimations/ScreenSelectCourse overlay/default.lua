local courseMode = GAMESTATE:IsCourseMode()
local sideWidth = 208*WideScreenDiff()
local bgWidth = (SCREEN_WIDTH-sideWidth)

return Def.ActorFrame{
	Def.ActorFrame{
		InitCommand=function(self) cc = self:GetChildren() end,
		loadfile(THEME:GetPathB("ScreenSelectCourse","overlay/tile"))()..{
			OnCommand=function(self) self:blend(Blend.Add):diffusealpha(0.2) end
		},
		Def.Sprite {
			Texture = THEME:GetPathB("ScreenSelectCourse","overlay/side"),
			Name="Side",
			InitCommand=function(self) self:halign(0):valign(0):zoomtowidth(sideWidth) end
		},
		Def.Sprite {
			Texture = THEME:GetPathB("ScreenSelectCourse","overlay/background"),
			Name="Background",
			InitCommand=function(self) self:x(sideWidth):halign(0):valign(0):zoomtowidth(SCREEN_WIDTH-sideWidth) end
		},
		Def.Sprite {
			Texture = THEME:GetPathB("ScreenSelectCourse","overlay/border"),
			Name="Left",
			InitCommand=function(self) self:x(sideWidth):halign(0):valign(0) end
		},
		Def.Sprite {
			Texture = THEME:GetPathB("ScreenSelectCourse","overlay/border"),
			Name="right",
			InitCommand=function(self) self:x(SCREEN_RIGHT):halign(0):valign(0):zoomx(-1) end
		},
		Def.Sprite {
			Texture = THEME:GetPathB("ScreenSelectCourse","overlay/course"),
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
		loadfile(THEME:GetPathB("ScreenSelectCourse","overlay/data"))()..{
			InitCommand=function(self) self:Center():addx(106*WideScreenDiff()):addy(-12) end
		},
		loadfile(THEME:GetPathB("ScreenSelectCourse","overlay/accel"))(),
		Def.BitmapText {
			File = "Panedisplay Blurred",
			InitCommand=function(self) self:x(SCREEN_CENTER_X+100*WideScreenDiff()):y(SCREEN_BOTTOM-69):settext("ACCELERATION"):diffuse(color('#808080')):zoom(1/4) end,
		},
		SetBGCommand=function(self)
			local course = GAMESTATE:GetCurrentCourse()
			if course then
				cc.BG1:diffusealpha(1)
				cc.BG2:diffusealpha(0)
			else
				cc.BG1:diffusealpha(0)
				cc.BG2:diffusealpha(1)
			end
		end,
		CurrentCourseChangedMessageCommand=function(self) if courseMode then self:queuecommand("SetBG") end end
	}
}