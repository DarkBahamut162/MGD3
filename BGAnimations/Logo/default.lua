return Def.ActorFrame{
	Def.Sprite {
		Texture = THEME:GetPathB("","Logo/logo_deco"),
		OnCommand=function(self) self:y(-85*WideScreenDiff()):zoom(WideScreenDiff()) end
	},
	Def.BitmapText {
		File = "Panedisplay Blurred",
		OnCommand=function(self) self:y(200):horizalign(center):maxwidth(573):zoomx(0.3*WideScreenDiff()):zoomy(0.2*WideScreenDiff()):diffusealpha(0.5):playcommand("Refresh") end,
		RefreshCommand=function(self)
			self:settext(ProductFamily().." "..ProductVersion().." ("..VersionDate()..")")
		end
	},
	Def.Sprite {
		Texture = THEME:GetPathB("","Logo/copy"),
		OnCommand=function(self) self:y(222):zoom(WideScreenDiff()) end
	},
	Def.Sprite {
		Texture = THEME:GetPathB("","Logo/effect"),
        OnCommand=function(self) self:queuecommand("Animate") end,
		AnimateCommand=function(self) self:diffusealpha(0):y(-35*WideScreenDiff()):sleep(0.349):blend(Blend.Add):diffusealpha(0.4):zoom(0.88*WideScreenDiff()):decelerate(1.08):diffusealpha(0):zoom(WideScreenDiff()):queuecommand("Repeat") end,
		RepeatCommand=function(self) self:sleep(0.4):queuecommand("On") end
	},
	Def.Sprite {
		Texture = THEME:GetPathB("","Logo/effect"),
        OnCommand=function(self) self:queuecommand("Animate") end,
		AnimateCommand=function(self) self:diffusealpha(0):y(-35*WideScreenDiff()):sleep(0.449):blend(Blend.Add):diffusealpha(0.2):zoom(0.88*WideScreenDiff()):decelerate(0.98):diffusealpha(0):zoom(WideScreenDiff()):queuecommand("Repeat") end,
		RepeatCommand=function(self) self:sleep(0.4):queuecommand("On") end
	},
	Def.Sprite {
		Texture = THEME:GetPathB("","Logo/effect"),
        OnCommand=function(self) self:queuecommand("Animate") end,
		AnimateCommand=function(self) self:diffusealpha(0):y(-35*WideScreenDiff()):sleep(0.549):blend(Blend.Add):diffusealpha(0.1):zoom(0.88*WideScreenDiff()):decelerate(0.88):diffusealpha(0):zoom(WideScreenDiff()):queuecommand("Repeat") end,
		RepeatCommand=function(self) self:sleep(0.4):queuecommand("On") end
	},
	Def.Sprite {
		Texture = THEME:GetPathB("","Logo/mgdlogo"),
		OnCommand=function(self) self:y(-35*WideScreenDiff()):zoom(0.88*WideScreenDiff()) end
	}
}
