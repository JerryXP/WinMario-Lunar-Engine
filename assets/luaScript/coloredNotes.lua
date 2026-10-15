--This is a mod made by BloonyFox
--Colours
dadCols = {150, 150, 150}
dadColsDark = {50, 50, 50}

bfCols = {150, 150, 150}
bfColsDark = {50, 50, 50}

--Colours Kapi style
dadColsKap = {150, 150, 150}
dadColsDarkKap = {50, 50, 50}

bfColsKap = {150, 150, 150}
bfColsDarkKap = {50, 50, 50}

kapSt = true		--Some notes are darker!
kapStVal = -100

--Notes pos:  0 Left, 1 DOWN, 2 UP, 3 Right
kapStNote1 = 1
kapStNote2 = 3

function onCreatePost()
	--Colorize notes
	if notedColored then
		colorizeNotes()
	end
end

function onCountdownTick()
	--Colorize notes
	if notedColored then
		colorizeNotes()
	end
end

function onEvent(name, val1, val2)
	--Change character fixes
	if name == "Change Character" then
		if notedColored then
			colorizeNotes()
		end
	end
end

function colorizeNotes()
	--Set cols
	for i = 1, 3 do
		--Prepare change colours!
		--Do the cols
		bfCols[i] = getProperty('boyfriend.healthColorArray')[i]
		dadCols[i] = getProperty('dad.healthColorArray')[i]
		
		--Do the cols (DARK)
		bfColsDark[i] = getProperty('boyfriend.healthColorArray')[i]-125
		dadColsDark[i] = getProperty('dad.healthColorArray')[i]-125

		--DARKER! (Kapi style)
		--Do the cols
		bfColsKap[i] = bfCols[i]+kapStVal
		dadColsKap[i] = dadCols[i]+kapStVal
		
		--Do the cols (DARK)
		bfColsDarkKap[i] = bfColsDark[i]+kapStVal
		dadColsDarkKap[i] = dadColsDark[i]+kapStVal
		
		--Fix the cols
		if bfCols[i] < 0 then
			bfCols[i] = 0
		end
		if bfCols[i] > 255 then
			bfCols[i] = 255
		end
		if dadCols[i] < 0 then
			dadCols[i] = 0
		end
		if dadCols[i] > 255 then
			dadCols[i] = 255
		end
		
		--Fix the cols (DARK)
		if bfColsDark[i] < 0 then
			bfColsDark[i] = 0
		end
		if bfColsDark[i] > 255 then
			bfColsDark[i] = 255
		end
		if dadColsDark[i] < 0 then
			dadColsDark[i] = 0
		end
		if dadColsDark[i] > 255 then
			dadColsDark[i] = 255
		end
		
		--Fix the cols (KAP)
		if bfColsKap[i] < 0 then
			bfColsKap[i] = 0
		end
		if bfColsKap[i] > 255 then
			bfColsKap[i] = 255
		end
		if dadColsKap[i] < 0 then
			dadColsKap[i] = 0
		end
		if dadColsKap[i] > 255 then
			dadColsKap[i] = 255
		end
		
		--Fix the cols (KAP) (DARK)
		if bfColsDarkKap[i] < 0 then
			bfColsDarkKap[i] = 0
		end
		if bfColsDarkKap[i] > 255 then
			bfColsDarkKap[i] = 255
		end
		if dadColsDarkKap[i] < 0 then
			dadColsDarkKap[i] = 0
		end
		if dadColsDarkKap[i] > 255 then
			dadColsDarkKap[i] = 255
		end
    end

	--Colorize notes
	--Player 1
	noteColFix(bfCols, bfColsDark, bfColsKap, bfColsDarkKap, true)
	
	--Opponent
	noteColFix(dadCols, dadColsDark, dadColsKap, dadColsDarkKap, false)
end

function noteColFix(stCol, stColDark, stColKap, stColDarkKap, stHit)
	--Final result
	--Normal
	stCol = getColorFromHex(rgbToHex(stCol))
	stColDark = getColorFromHex(rgbToHex(stColDark))
	
	--Kap
	stColKap = getColorFromHex(rgbToHex(stColKap))
	stColDarkKap = getColorFromHex(rgbToHex(stColDarkKap))

	--Check notes (Not spawned)
	for i = 0, getProperty('unspawnNotes.length') - 1 do
		local tmpNoteData = getPropertyFromGroup('unspawnNotes', i, 'noteData')
	
        --Change note colours!
		if getPropertyFromGroup('unspawnNotes', i, 'mustPress') == stHit and getPropertyFromGroup('unspawnNotes', i, 'rgbShader.enabled', true) then
			--Check kapi style
			if (kapSt == true and tmpNoteData ~= kapStNote1 and tmpNoteData ~= kapStNote2) or kapSt == false then
				--Do the cols!
				setPropertyFromGroup('unspawnNotes', i, 'rgbShader.r', stCol)
				setPropertyFromGroup('unspawnNotes', i, 'rgbShader.b', stColDark)
				
				--Splashes
				setPropertyFromGroup('unspawnNotes', i, 'noteSplashData.r', stCol)
				setPropertyFromGroup('unspawnNotes', i, 'noteSplashData.b', stColDark)
			else
				--Do the cols! (DARK)
				setPropertyFromGroup('unspawnNotes', i, 'rgbShader.r', stColKap)
				setPropertyFromGroup('unspawnNotes', i, 'rgbShader.b', stColDarkKap)
				
				--Splashes
				setPropertyFromGroup('unspawnNotes', i, 'noteSplashData.r', stColKap)
				setPropertyFromGroup('unspawnNotes', i, 'noteSplashData.b', stColDarkKap)
			end
		end
    end
	
	--Check notes
	for i = 0, getProperty('notes.length') - 1 do
		local tmpNoteData = getPropertyFromGroup('notes', i, 'noteData')
	
        --Change note colours!
		if getPropertyFromGroup('notes', i, 'mustPress') == stHit and getPropertyFromGroup('notes', i, 'rgbShader.enabled', true) then
			--Check kapi style
			if (kapSt == true and tmpNoteData ~= kapStNote1 and tmpNoteData ~= kapStNote2) or kapSt == false then
				--Do the cols!
				setPropertyFromGroup('notes', i, 'rgbShader.r', stCol)
				setPropertyFromGroup('notes', i, 'rgbShader.b', stColDark)
				
				--Splashes
				setPropertyFromGroup('notes', i, 'noteSplashData.r', stCol)
				setPropertyFromGroup('notes', i, 'noteSplashData.b', stColDark)
			else
				--Do the cols! (DARK)
				setPropertyFromGroup('notes', i, 'rgbShader.r', stColKap)
				setPropertyFromGroup('notes', i, 'rgbShader.b', stColDarkKap)
				
				--Splashes
				setPropertyFromGroup('notes', i, 'noteSplashData.r', stColKap)
				setPropertyFromGroup('notes', i, 'noteSplashData.b', stColDarkKap)
			end
		end
    end
end

function rgbToHex(array)
	return string.format('%.2x%.2x%.2x', array[1], array[2], array[3])
end