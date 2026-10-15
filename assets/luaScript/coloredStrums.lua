--This is a port made by BloonyFox
--Original idea by Ethan_DOORSnFNFFan
-- VSLICE/FNF MOBILE EDITION: https://gamebanana.com/mods/701086

function onCountdownTick()
	--Colorize strums
	colorizeStrums()
end

function onEvent(name, val1, val2)
	--Change character fixes
	if name == "Change Character" then
		colorizeStrums()
	end
end

function colorizeStrums()
	--Colorize strums
	--Player 1
	strumColFix(4, 7, getProperty('boyfriend.healthColorArray'))
	
	--Opponent
	strumColFix(0, 3, getProperty('dad.healthColorArray'))
end

function strumColFix(stFrom, stTo, stCol)
	--Final result
	stCol = getColorFromHex(rgbToHex(stCol))

	--Strum icon colored
	for i = 0, 7 do
		--Colorize
		if i >= stFrom and i <= stTo then
			--YAY
			setPropertyFromGroup('strumLineNotes', i, 'color', stCol)
		end
	end
end

function rgbToHex(array)
	return string.format('%.2x%.2x%.2x', array[1], array[2], array[3])
end