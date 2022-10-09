local player = Var "Player"
local curLives = 0
local moved = (GAMESTATE:GetNumPlayersEnabled() == 1) and true or false
local centered = (GAMESTATE:GetNumPlayersEnabled() == 1) and true or false

return Def.ActorFrame{
	LoadFont("Combo numbers")..{
		BeginCommand=function(self)
			local screen = SCREENMAN:GetTopScreen()
			local glifemeter = screen:GetLifeMeter(player)
			if glifemeter:GetTotalLives() <= 5 then
				self:diffuseshift()
				self:effectcolor1(1,1,1,1)
				self:effectcolor2(1,0,0,1)
			end
			curLives = glifemeter:GetTotalLives()
			self:settext(glifemeter:GetTotalLives())
			self:zoom(0.6)
			self:horizalign(center)
		end,
		LifeChangedMessageCommand=function(self,params)
			if params.Player == player then
				if curLives ~= params.LivesLeft then
					curLives = params.LivesLeft
					self:finishtweening()
					self:settext(params.LivesLeft)
					if params.LivesLeft <= 5 then
						self:diffuseshift()
						self:effectcolor1(1,1,1,1)
						self:effectcolor2(1,0,0,1)
					else
						self:stopeffect()
					end
					self:zoom(0.75)
					self:linear(0.1)
					self:zoom(0.6)
				end
			end
		end,
		HealthStateChangedMessageCommand=function(self, param)
			if param.HealthState == Health.Dead then --If player dies
				if param.PlayerNumber == PLAYER_1 and player == PLAYER_1 and not moved then --Move P1's filter if P1 dies
					--self:linear(0.1):zoom(0)
					moved = true
				elseif param.PlayerNumber == PLAYER_2 and player == PLAYER_2 and not moved then --Move P2's filter if P2 dies
					--self:linear(0.1):zoom(0)
					moved = true
				end
				if param.PlayerNumber == PLAYER_1 and player == PLAYER_2 and not centered then --Move P1's filter to center if P2 dies
					--self:linear(0.5):x(-SCREEN_WIDTH*0.21)
					centered = true
				elseif param.PlayerNumber == PLAYER_2 and player == PLAYER_1 and not centered then --Move P2's filter to center if P1 dies
					--self:linear(0.5):x(SCREEN_WIDTH*0.21)
					centered = true
				end
			end
		end
	}
}