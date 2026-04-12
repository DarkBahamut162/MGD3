local c
local player = Var "Player"
local ShowComboAt = THEME:GetMetric("Combo", "ShowComboAt")
local Pulse = THEME:GetMetric("Combo", "PulseCommand")

local NumberMinZoom = THEME:GetMetric("Combo", "NumberMinZoom")
local NumberMaxZoom = THEME:GetMetric("Combo", "NumberMaxZoom")
local NumberMaxZoomAt = THEME:GetMetric("Combo", "NumberMaxZoomAt")

local ComboW1 = THEME:GetMetric("Combo","FullComboW1Command")
local ComboW2 = THEME:GetMetric("Combo","FullComboW2Command")
local ComboW3 = THEME:GetMetric("Combo","FullComboW3Command")
local ComboNormal = THEME:GetMetric("Combo","FullComboBrokenCommand")

local course = nil
local isSurvival = false

return Def.ActorFrame{
	Def.BitmapText {
		File = "Combo numbers",
		Name="Number",
		OnCommand = THEME:GetMetric("Combo", "NumberOnCommand")
	},
	Def.Sprite {
		Texture = THEME:GetPathG("Player","combo/_combo"),
		Name="ComboLabel",
		OnCommand = THEME:GetMetric("Combo", "LabelOnCommand")
	},
	Def.Sprite {
		Texture = THEME:GetPathG("Player","combo/_misses"),
		Name="MissesLabel",
		OnCommand = THEME:GetMetric("Combo", "LabelOnCommand")
	},
	InitCommand = function(self)
		c = self:GetChildren()
		c.Number:visible(false)
		c.ComboLabel:visible(false)
		c.MissesLabel:visible(false)
	end,
	OnCommand=function(self)
		if GAMESTATE:IsCourseMode() then
			course = GAMESTATE:GetCurrentCourse()
			local entries = course:GetCourseEntries()
			for entry in ivalues(course:GetCourseEntries()) do
				if entry:GetGainSeconds() > 0 then
					isSurvival = true
				end
			end
		end
	end,
	OffCommand=function(self)
		if GAMESTATE:IsCourseMode() then
			course = nil
			isSurvival = false
		end
	end,
	ComboCommand=function(self, param)
		local iCombo = param.Misses or param.Combo
		if not iCombo or iCombo < ShowComboAt then
			c.Number:visible(false)
			c.ComboLabel:visible(false)
			c.MissesLabel:visible(false)
			return
		end

		local Label
		if param.Combo then
			Label = c.ComboLabel
			c.MissesLabel:visible(false)
		else
			Label = c.MissesLabel
			c.ComboLabel:visible(false)
		end

		if iCombo%50 == 0 and not (GAMESTATE:IsCourseMode() and isSurvival) then
			local Screen = SCREENMAN:GetTopScreen()
			Screen:GetLifeMeter(player):ChangeLives(1)
		end

		param.Zoom = scale( iCombo, 0, NumberMaxZoomAt, NumberMinZoom, NumberMaxZoom )
		param.Zoom = clamp( param.Zoom, NumberMinZoom, NumberMaxZoom )
		c.Number:visible(true)
		Label:visible(true)
		c.Number:settext( string.format("%i", iCombo) )

		if param.FullComboW1 then ComboW1(c.Number) ComboW1(Label)
		elseif param.FullComboW2 then ComboW2(c.Number) ComboW2(Label)
		elseif param.FullComboW3 then ComboW3(c.Number) ComboW3(Label)
		elseif param.Combo then ComboNormal(c.Number) ComboNormal(Label)
		else ComboNormal(c.Number) ComboNormal(Label)
		end

		Pulse( c.Number, param )
		Pulse( Label, param )
	end
}