return Def.ActorFrame{
	Def.Sprite{
		SetCommand=function(self,param)
			local Course = param.Course
			if Course and Course:HasBackground() then
				self:LoadBackground(Course:GetBackgroundPath())
			elseif Course and Course:HasBanner() then
				self:LoadBackground(Course:GetBannerPath())
			else
				self:Load(THEME:GetPathG("Common fallback", "banner"))
			end
			self:setsize(170*WideScreenDiff(),128*WideScreenDiff())
		end
	}
}