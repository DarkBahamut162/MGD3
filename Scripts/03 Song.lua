function IsSongLife(songtit)
	local SongTable = {
		["The Seven Gates"] = true,
		["Cubed"] = true,
		["Happiness"] = true,
		["Relation"] = true,
		["Another Run"] = true,
		["Floridian Love Scene"] = true,
		["Freak Empire"] = true,
		["Rotterdom Nation 94.5"] = true,
		["Something Dreamy"] = true,
		["The Moon Breaks My Day"] = true
	}

	local SongVal = SongTable[songtit] or false
	return SongVal
end

function IsSongEx(songtit)
	local SongTable = {
		["1995 EX"] = true,
		["I Love You Baby EX"] = true,
		["Killing Fields EX"] = true,
		["More Like You EX"] = true,
		["Rapture EX"] = true,
		["Infinite Blue EX"] = true,
		["All or Something EX"] = true,
		["Empire of the Sun EX"] = true,
		["Taito No Suika EX"] = true,
		["Mermaid EX"] = true,
		["Feel the Soul EX"] = true,
		["Machucando EX"] = true,
		["Freak on a Leash EX"] = true,
		["Lockjaw EX"] = true,
		["Love is More EX"] = true,
		["Concept of Love (Concept of Passion Mix) EX"] = true,
		["Amber Starlight EX"] = true
	}

	local SongVal = SongTable[songtit] or false
	return SongVal
end

function IsSongBoss(songtit)
	local SongTable = {
		["Chaos Theory"] = true,
		["V^3"] = true,
		["Inkey$"] = true,
		["Lawn Wake IV"] = true,
		["Passage d"] = true,
		["Destination Helios"] = true,
		["Dis"] = true,
		["Due In One Hour"] = true,
		["Killing Fields"] = true,
		["Please EX."] = true,
		["Speak Sins"] = true,
		["The Daeva Suite"] = true,
		["Under Angel Wings"] = true,
		["Lune Noir"] = true,
		["Lune Noir EX"] = true,
		["Stratosphere"] = true,
		["Midnight Runner"] = true,
		["Pwnage U N00bs EX"] = true,
		["Contact"] = true,
		["Destination Unknown"] = true,
		["Destination of the Heart"] = true,
		["The Daeva Suite"] = true,
		["Boss Rush"] = true,
		["Speed Strike"] = true,
		["Reasons to Live"] = true
	}

	local SongVal = SongTable[songtit] or false
	return SongVal
end

function IsSongDash(songtit)
	local SongTable = {
		["Dash Hopes II"] = true,
		["Bag"] = true
	}

	local SongVal = SongTable[songtit] or false
	return SongVal
end

function IsSongNonstop(songtit)
	local SongTable = {
		["The Seven Gates"] = true,
		["Cubed"] = true,
		["Happiness"] = true,
		["Relation"] = true,
	}

	local SongVal = SongTable[songtit] or false
	return SongVal
end

function IsSongRemix(songtit)
	local SongTable = {
		["Another Run"] = true,
		["Floridian Love Scene"] = true,
		["Freak Empire"] = true,
		["Rotterdom Nation 94.5"] = true,
		["Something Dreamy"] = true,
		["The Moon Breaks My Day"] = true
	}

	local SongVal = SongTable[songtit] or false
	return SongVal
end

function CalcDifficulty(StepsOrTrail)
	if StepsOrTrail then
		local stepCounter = 0
		local jumpCounter = 0
		local handCounter = 0
		local songInSeconds = 0

		if not GAMESTATE:IsCourseMode() then
			stepCounter = StepsOrTrail:GetRadarValues(GAMESTATE:GetMasterPlayerNumber()):GetValue('RadarCategory_TapsAndHolds')
			jumpCounter = StepsOrTrail:GetRadarValues(GAMESTATE:GetMasterPlayerNumber()):GetValue('RadarCategory_Jumps')
			handCounter = StepsOrTrail:GetRadarValues(GAMESTATE:GetMasterPlayerNumber()):GetValue('RadarCategory_Hands') * 2
			songInSeconds = GAMESTATE:GetCurrentSong():GetLastSecond() - GAMESTATE:GetCurrentSong():GetFirstSecond()
		else
			stepCounter = StepsOrTrail:GetRadarValues(GAMESTATE:GetMasterPlayerNumber()):GetValue('RadarCategory_TapsAndHolds')
			jumpCounter = StepsOrTrail:GetRadarValues(GAMESTATE:GetMasterPlayerNumber()):GetValue('RadarCategory_Jumps')
			handCounter = (StepsOrTrail:GetRadarValues(GAMESTATE:GetMasterPlayerNumber()):GetValue('RadarCategory_Hands') * 2)
			for entry in ivalues(StepsOrTrail:GetTrailEntries()) do
				songInSeconds = songInSeconds + (entry:GetSong():GetLastSecond() - entry:GetSong():GetFirstSecond())
			end
		end

		local sum = ( (stepCounter + jumpCounter + handCounter) / songInSeconds ) * 20

		if sum < 0 then return "???" else return math.round(sum) end
	end

	return "???"
end