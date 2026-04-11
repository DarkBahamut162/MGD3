-- VERSION CHECKS
function isEtterna()
	return ProductFamily() == "Etterna"
end

function isStepMania()
	return ProductFamily() == "StepMania"
end

function isOldStepMania()
	return ProductFamily() == "StepMania" and not VersionDateCheck(20180000)
end

function isOutFox(version)
	local productCheck = ProductFamily() == "OutFox" or (isStepMania() and tonumber(split("-",ProductVersion())[1]) == 5.3)
	if version then return productCheck and VersionDateCheck(version) else return productCheck end
end

function isOutFoxV(version)
	local versionSplit = tonumber(split("-",ProductVersion())[1])
	local productCheck = isOutFox() and versionSplit >= 0.5 and versionSplit < 5
	if version then return productCheck and VersionDateCheck(version) else return productCheck end
end

function isOutFoxV043(version)
	if version then return isOutFoxV(20240000) and VersionDateCheck(version) else return isOutFoxV(20240000) end
end

function VersionDateCheck(version)
	return tonumber(VersionDate()) > version
end

-- SCREEN CHECKS
function WideScreenDiff()
	return math.min(1,GetScreenAspectRatio() / (4/3))
end

function WideScreenDiff_(aspect)
	return math.min(1,GetScreenAspectRatio() / aspect)
end

function WideScreenSemiDiff()
	return 1-(1-WideScreenDiff())*0.5
end

function WideScreenSemiDiff_(aspect)
	return 1-(1-WideScreenDiff_(aspect))*0.5
end

-- ADDITIONAL FUNCTIONS
function FindInTable(needle, haystack)
	for i = 1, #haystack do
		if needle == haystack[i] then
			return i
		end
	end
	return nil
end

-- BUTTON CHECKS
local GameAndMenuButtons = {
	dance		= { "Left", "Down", "Up", "Right" },
	groove		= { "Left", "Down", "Up", "Right" },
	pump		= { "DownLeft", "UpLeft", "Center", "UpRight", "DownRight" },
	smx			= { "Left", "Down", "Up", "Right" },
	["be-mu"]	= { "Key1", "Key7", "Scratch up", "Scratch down" },
	techno		= { "Left", "Down", "Up", "Right" },
	["po-mu"]	= { "Left Yellow", "Left Blue", "Red", "Right Blue", "Right Yellow" },
}

local LocalizedGameButtons = {}

local DelocalizeGameButton = function(localized_btn)
	local game = GAMESTATE:GetCurrentGame():GetName()
	if not GameAndMenuButtons[game] then return false end

	local language = THEME:GetCurLanguage()
	if not LocalizedGameButtons[language] then
		local t = {}
		for gb in ivalues(GameAndMenuButtons[game]) do
			t[THEME:GetString("GameButton", gb)] = gb
		end
		LocalizedGameButtons[language] = t
	end

	return LocalizedGameButtons[language][localized_btn]
end

function IsGameAndMenuButton(localized_btn)
	if PREFSMAN:GetPreference("OnlyDedicatedMenuButtons") then return false end

	local btn = DelocalizeGameButton(localized_btn)
	if not btn then return false end

	return FindInTable(btn, GameAndMenuButtons[GAMESTATE:GetCurrentGame():GetName()])
end