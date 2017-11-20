local SpeedMods = {"0.5x", "1x", "1.5x", "2x", "2.5x", "3x", "3.5x", "4x", "4.5x", "5x", "5.5x", "6x"};
local sIdx = 2;
local sMax = #SpeedMods;
local t = Def.ActorFrame {};

t[#t+1] = Def.ActorFrame {
	CodeMessageCommand = function(self, params)
		if params.Name == 'SpeedUp' then
			sIdx = sIdx - 1;
			if sIdx < 1 then
				sIdx = sMax;
			end
			GAMESTATE:ApplyGameCommand('mod,'..SpeedMods[sIdx]);
			--SCREENMAN:SystemMessage("Index "..sIdx.." - Mod:"..SpeedMods[sIdx]);
			self:playcommand("Speed");
		elseif params.Name == 'SpeedDown' then
			sIdx = sIdx + 1;
			if sIdx > sMax then
				sIdx = 1;
			end
			GAMESTATE:ApplyGameCommand('mod,'..SpeedMods[sIdx]);
			--SCREENMAN:SystemMessage("Index "..sIdx.." - Mod:"..SpeedMods[sIdx]);
			self:playcommand("Speed");
		end;
	end;
	LoadActor(THEME:GetPathS("ScreenSelectMusic","options"))..{
		OnCommand=cmd(stop);
		SpeedCommand=cmd(play);
	};
	LoadFont("OptionIcon")..{
		OnCommand=cmd(x,SCREEN_CENTER_X+100;y,SCREEN_BOTTOM-50;diffuse,color('#BEC1C6');zoom,.76);
		SpeedCommand=function(self)
			self:settext(string.upper(SpeedMods[sIdx]));
		end;
	}
};

return t;