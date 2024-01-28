local mPlayer = GAMESTATE:GetMasterPlayerNumber()
local course,trail
local steps,stepsP1,stepsP2 = 0,0,0
local fakes,fakesP1,fakesP2 = 0,0,0
local jumps,jumpsP1,jumpsP2 = 0,0,0
local hands,handsP1,handsP2 = 0,0,0
local holds,holdsP1,holdsP2 = 0,0,0
local rolls,rollsP1,rollsP2 = 0,0,0
local lifts,liftsP1,liftsP2 = 0,0,0
local mines,minesP1,minesP2 = 0,0,0
local courseMode = GAMESTATE:IsCourseMode()

return Def.ActorFrame{
	Def.ActorFrame{
		InitCommand=function(self) c = self:GetChildren() end,
		LoadFont("MusicList titles")..{
			Name="Title",
			InitCommand=function(self) self:horizalign(left):zoom(0.82):x(-134):y(2) end
		},
		LoadFont("MusicList titles")..{
			Name="Artist",
			InitCommand=function(self) self:horizalign(left):zoom(0.82):x(-134):y(24) end
		},
		LoadFont("ScreenSelectMusic total time")..{
			Name="Time",
			InitCommand=function(self) self:horizalign(center):y(88):x(69) end
		},
		LoadFont("ScreenSelectMusic total time")..{
			Name="TrueTime",
			InitCommand=function(self) self:horizalign(center):y(88):x(69) end
		},
		SetCommand=function(self)
			trail = GAMESTATE:GetCurrentTrail(mPlayer)
			if trail then
				steps = trail:GetRadarValues(mPlayer):GetValue('RadarCategory_TapsAndHolds')
				fakes = trail:GetRadarValues(mPlayer):GetValue('RadarCategory_Fakes')
				jumps = trail:GetRadarValues(mPlayer):GetValue('RadarCategory_Jumps')
				hands = trail:GetRadarValues(mPlayer):GetValue('RadarCategory_Hands')
				holds = trail:GetRadarValues(mPlayer):GetValue('RadarCategory_Holds')
				rolls = trail:GetRadarValues(mPlayer):GetValue('RadarCategory_Rolls')
				lifts = trail:GetRadarValues(mPlayer):GetValue('RadarCategory_Lifts')
				mines = trail:GetRadarValues(mPlayer):GetValue('RadarCategory_Mines')

				course = GAMESTATE:GetCurrentCourse()
				local title = course:GetDisplayFullTitle()
				c.Title:maxwidth(325)
				c.Title:settext(title)

				local artist = course:GetScripter() ~= "" and course:GetScripter() or "??????????"
				c.Artist:maxwidth(325)
				c.Artist:settext("Programmed by "..artist)

				local seconds, trueseconds = 0, 0

				for entry in ivalues(course:GetCourseEntries()) do
					if entry:GetSong() then
						seconds = seconds + entry:GetSong():MusicLengthSeconds()
						local firstsecond = entry:GetSong():GetFirstSecond()
						local lastsecond = entry:GetSong():GetLastSecond()
						trueseconds = trueseconds + (lastsecond - firstsecond)
					end
				end

				c.Artist:diffusealpha(1)
				c.Time:maxwidth(128):diffusealpha(1):settext(SecondsToMMSSMsMs(seconds))
				c.Time:effectclock('timer'):diffuseshift():effectcolor1(color("#FFFFFFFF")):effectcolor2(color("#00000000")):effectperiod(4)
				c.TrueTime:maxwidth(128):diffusealpha(1):settext(SecondsToMMSSMsMs(trueseconds))
				c.TrueTime:effectclock('timer'):diffuseshift():effectcolor1(color("#00000000")):effectcolor2(color("#FFFFFFFF")):effectperiod(4)

				c.Artist:diffusealpha(1)
			else
				if #SONGMAN:GetAllCourses(PREFSMAN:GetPreference("AutogenGroupCourses")) == 0 and SONGMAN:GetNumAdditionalCourses() == 0 then
					c.Title:settext("No Courses Available")
				else
					c.Title:settext("No Course Selected")
				end
				c.Artist:diffusealpha(0)
				c.Time:diffusealpha(0)
				c.TrueTime:diffusealpha(0)
			end
		end,
		Def.BPMDisplay{
			File=THEME:GetPathF("BPM", "Display"),
			Name="BPMDisplay",
			InitCommand=function(self) self:x(5):y(133):horizalign(left):zoom(0.62):maxwidth(210) end,
			SetCommand=function(self) self:SetFromGameState() end
		},
		LoadFont("Panedisplay Blurred")..{
			InitCommand=function(self) self:zoom(0.35):horizalign(left):y(69):x(-132):maxwidth(160):diffusealpha(0.6):zoomx(0.37) end,
			SetCommand=function(self)
				local name = "STEPS"
				if trail then
					if fakes > 0 then name = name.."?" end
				end
				self:settext(name)
			end
		},
		LoadFont("Panedisplay Blurred")..{
			InitCommand=function(self) self:zoom(0.35):horizalign(left):y(90):x(-132):maxwidth(160):diffusealpha(0.6) end,
			SetCommand=function(self)
				self:settext("JUMPS")
			end
		},
		LoadFont("Panedisplay Blurred")..{
			InitCommand=function(self) self:zoom(0.35):horizalign(left):y(111):x(-132):maxwidth(160):diffusealpha(0.6) end,
			SetCommand=function(self)
				self:settext("HANDS")
			end
		},
		LoadFont("Panedisplay Blurred")..{
			InitCommand=function(self) self:zoom(0.35):horizalign(left):y(132):x(-132):maxwidth(160):diffusealpha(0.6) end,
			SetCommand=function(self)
				local name = ""
				if trail then
					if holds > 0 or (holds == 0 and rolls == 0 and lifts == 0) then name = "HOLDS" end
					if rolls > 0 then if name ~= "" then name = name.."+ROLLS" else name = "ROLLS" end end
					if lifts > 0 then if name ~= "" then name = name.."+LIFTS" else name = "LIFTS" end end
				else
					name = "HOLDS"
				end
				self:settext(name)
			end
		},
		LoadFont("Panedisplay Blurred")..{
			InitCommand=function(self) self:zoom(0.35):horizalign(left):y(70):x(10):diffusealpha(0.6):zoomx(0.33) end,
			SetCommand=function(self)
				self:settext("S O N G   L E N G T H"):maxwidth(360)
				self:effectclock('timer'):diffuseshift():effectcolor1(color("#FFFFFFFF")):effectcolor2(color("#00000000")):effectperiod(4)
			end
		},
		LoadFont("Panedisplay Blurred")..{
			InitCommand=function(self) self:zoom(0.35):horizalign(left):y(70):x(10):diffusealpha(0.6):zoomx(0.33) end,
			SetCommand=function(self)
				self:settext("T R U E   L E N G T H"):maxwidth(360)
				self:effectclock('timer'):diffuseshift():effectcolor1(color("#00000000")):effectcolor2(color("#FFFFFFFF")):effectperiod(4)
			end
		},
		LoadFont("Panedisplay Blurred")..{
			InitCommand=function(self) self:zoom(0.35):horizalign(left):y(115):x(10):diffusealpha(0.6):zoomx(0.34) end,
			SetCommand=function(self)
				self:settext("B P M")
			end
		},
		LoadFont("Panedisplay Text")..{
			InitCommand=function(self) self:zoom(0.36):horizalign(right):y(70):x(-11):maxwidth(170) end,
			SetCommand=function(self)
				local name = ""
				if trail then
					name = steps
				end
				self:settext(name)
			end
		},
		LoadFont("Panedisplay Text")..{
			InitCommand=function(self) self:zoom(0.36):horizalign(right):y(91):x(-11):maxwidth(170) end,
			SetCommand=function(self)
				local name = ""
				if trail then
					name = jumps
				end
				self:settext(name)
			end
		},
		LoadFont("Panedisplay Text")..{
			InitCommand=function(self) self:zoom(0.36):horizalign(right):y(112):x(-11):maxwidth(170) end,
			SetCommand=function(self)
				local name = ""
				if trail then
					name = hands
				end
				self:settext(name)
			end
		},
		LoadFont("Panedisplay Text")..{
			InitCommand=function(self) self:zoom(0.36):horizalign(right):y(133):x(-11):maxwidth(170) end,
			SetCommand=function(self)
				local name = ""
				if trail then
					if holds > 0 or (holds == 0 and rolls== 0 and lifts == 0) then name = holds end
					if rolls > 0 then if name ~= "" then name = name.."+"..rolls else name = rolls end end
					if lifts > 0 then if name ~= "" then name = name.."+"..lifts else name = lifts end end
				end
				self:settext(name)
			end
		},
		Def.Sprite{
			Texture='../mine',
			Frames = Sprite.LinearFrames( 8, 1 ),
			InitCommand=function(self) self:effectclock('beat'):addx(180):addy(12):visible(false) end,
			SetCommand=function(self)
				if trail and trails ~=nil then
					if mines > 0 then self:visible(true) else self:visible(false) end
				else
					self:visible(false)
				end
			end
		},
		CurrentCourseChangedMessageCommand=function(self) if courseMode then self:queuecommand("Set") end end
	}
}