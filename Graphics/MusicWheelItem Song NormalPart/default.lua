return Def.ActorFrame{
	Def.Sprite{
		SetMessageCommand=function(self,params)
			local Song = params.Song
			if Song and Song:HasJacket() then
				self:LoadBanner(Song:GetJacketPath())
			elseif Song and Song:HasBackground() then
				self:LoadBackground(Song:GetBackgroundPath())
			else
				self:Load(THEME:GetPathG("Common fallback", "banner"))
			end
			self:setsize(170,128)
		end
	}
}