-- notesturnyellow v2 baybeeeeee

pastNoteID = 0
pastNoteStTi = 0

function onEvent(name, v1, v2)
    if name == 'Change Character' then
        if notedColoredLEGACY then
            fixTimeBar()
        end
    end
end
function opponentNoteHit()
    if notedColoredLEGACY then
        local dadColR = getProperty('dad.healthColorArray[0]')
        local dadColG = getProperty('dad.healthColorArray[1]')
        local dadColB = getProperty('dad.healthColorArray[2]')

        local dadColFinal = string.format('%02x%02x%02x', dadColR, dadColG, dadColB)
		    for i = 0, getProperty('opponentStrums.length')-1 do
	            setPropertyFromGroup('opponentStrums', i, 'rgbShader.r', getColorFromHex(dadColFinal))
	            setPropertyFromGroup('opponentStrums', i, 'rgbShader.g', getColorFromHex('FFFFFF'))
	            setPropertyFromGroup('opponentStrums', i, 'rgbShader.b', getColorFromHex(dadColFinal))
            end
    end
end

function fixTimeBar()    
    local dadColR = getProperty('dad.healthColorArray[0]')
    local dadColG = getProperty('dad.healthColorArray[1]')
    local dadColB = getProperty('dad.healthColorArray[2]')

    local dadColFinal = string.format('%02x%02x%02x', dadColR, dadColG, dadColB)

		for i = 0, getProperty('unspawnNotes.length')-1 do
			if getPropertyFromGroup('unspawnNotes', i, 'mustPress') == false then
	setPropertyFromGroup('unspawnNotes', i, 'rgbShader.r', getColorFromHex(dadColFinal))
	setPropertyFromGroup('unspawnNotes', i, 'rgbShader.g', getColorFromHex('FFFFFF'))
	setPropertyFromGroup('unspawnNotes', i, 'rgbShader.b', getColorFromHex(dadColFinal))
			end
        end
end

function onSongStart()
    if notedColoredLEGACY then
        fixTimeBar()
    end
end

function onCountdownTick(counter)
if counter == 0 then
    if notedColoredLEGACY then
        fixTimeBar()
    end
  end
end