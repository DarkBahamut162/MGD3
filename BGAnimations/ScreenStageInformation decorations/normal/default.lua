local Song = GAMESTATE:GetCurrentSong();
local SongTit = Song:GetDisplayMainTitle();
local dir = Song:GetSongDir();
local t = Def.ActorFrame {};
if string.find(dir,"Mungyodance") then
	t[#t+1] = Def.ActorFrame {
		Def.Sprite{
			BeginCommand=cmd(scale_or_crop_background);
			InitCommand=function(self)
				if Song then
					if Song:HasBackground() then
							self:LoadBackground(Song:GetBackgroundPath());
						else
							self:Load(THEME:GetPathG("Common fallback", "background"));
					end;
				end;
			end;
			OnCommand=cmd(zoom,3;diffusealpha,0;decelerate,2;scale_or_crop_background;diffusealpha,1);
		};
	};
else
	t[#t+1] = Def.ActorFrame {
		Def.Sprite{
			BeginCommand=cmd(scale_or_crop_background);
			InitCommand=function(self)
				if Song then
					if Song:HasBackground() then
							self:LoadBackground(Song:GetBackgroundPath());
						else
							self:Load(THEME:GetPathG("Common fallback", "background"));
					end;
				end;
			end;
			OnCommand=cmd(diffusealpha,0;decelerate,2;diffusealpha,1);
		};
	};
end
t[#t+1] = Def.ActorFrame {
	Def.Quad{
		OnCommand=cmd(FullScreen;diffusecolor,Color.White;zoomy,6.5;decelerate,0.34;zoomy,0.013;sleep,0.1;accelerate,0.35;diffusealpha,0;zoomx,0);
	};
	LoadActor( "../../select" )..{
		BeginCommand=cmd(Center);
		OnCommand=cmd(sleep,0.5;linear,0.4;diffusealpha,0);
	};
	LoadActor( "../../spin" )..{
		BeginCommand=cmd(scale_or_crop_background);
		OnCommand=cmd(diffusealpha,0.6;zoom,0.2;accelerate,0.6;zoom,1;diffusealpha,0;rotationz,250);
	};
	LoadActor( "../../spin" )..{
		BeginCommand=cmd(scale_or_crop_background);
		OnCommand=cmd(diffusealpha,0.6;zoom,0.2;accelerate,0.8;zoom,1;diffusealpha,0;rotationz,-250);
	};
	LoadActor( "../../spin" )..{
		BeginCommand=cmd(scale_or_crop_background);
		OnCommand=cmd(diffusealpha,0.6;zoom,0.2;accelerate,1;zoom,1;diffusealpha,0;rotationz,250);
	};
};
return t;