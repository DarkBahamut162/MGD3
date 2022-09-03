return Def.ActorFrame {
	LoadActor("logo_deco")..{
		OnCommand=function(self) self:y(-85) end;
	};
	LoadFont("Panedisplay Blurred")..{
		OnCommand=function(self) self:y(200):horizalign(center):maxwidth(573):zoomx(0.3):zoomy(0.2):diffusealpha(0.5):playcommand("Refresh") end;
		RefreshCommand=function(self)
			self:settext(ProductFamily() .. " " .. ProductVersion() .. " (" .. VersionDate() .. ")")
		end;
	};
	LoadActor("copy")..{
		OnCommand=function(self) self:y(222) end;
	};
	LoadActor( "effect" )..{
        OnCommand=function(self) self:queuecommand("Animate") end,
		AnimateCommand=function(self) self:diffusealpha(0):y(-35):sleep(0.349):blend('BlendMode_Add'):diffusealpha(0.4):zoom(0.88):decelerate(1.08):diffusealpha(0):zoom(1):queuecommand("Repeat") end;
		RepeatCommand=function(self) self:sleep(0.4):queuecommand("On") end;
	};
	LoadActor( "effect" )..{
        OnCommand=function(self) self:queuecommand("Animate") end,
		AnimateCommand=function(self) self:diffusealpha(0):y(-35):sleep(0.449):blend('BlendMode_Add'):diffusealpha(0.2):zoom(0.88):decelerate(0.98):diffusealpha(0):zoom(1):queuecommand("Repeat") end;
		RepeatCommand=function(self) self:sleep(0.4):queuecommand("On") end;
	};
	LoadActor( "effect" )..{
        OnCommand=function(self) self:queuecommand("Animate") end,
		AnimateCommand=function(self) self:diffusealpha(0):y(-35):sleep(0.549):blend('BlendMode_Add'):diffusealpha(0.1):zoom(0.88):decelerate(0.88):diffusealpha(0):zoom(1):queuecommand("Repeat") end;
		RepeatCommand=function(self) self:sleep(0.4):queuecommand("On") end;
	};
	LoadActor( "mgdlogo" )..{
		OnCommand=function(self) self:y(-35):zoom(0.88) end;
	};
}
