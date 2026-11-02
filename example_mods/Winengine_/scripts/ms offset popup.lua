function onCreate()
    makeLuaText('offsetText', '', 200, 950, 690)
    setTextSize('offsetText', 24)
    addLuaText('offsetText')
    setProperty('offsetText.alpha', 0)
    setTextBorder('offsetText', 0.5, '000000')
	setTextAlignment('offsetText', 'left')
end

function goodNoteHit(id, direction, noteType, isSustainNote)

    if isSustainNote then
        return
    end

    cancelTween('fadeOut')

    local offset = getPropertyFromGroup('notes', id, 'strumTime') - getSongPosition()

    local formattedOffset = string.format('%.3f', offset):gsub('%.?0+$', '')

    setTextString('offsetText', formattedOffset .. 'ms')

    if offset > 100 then
        setTextColor('offsetText', '870000') -- Red for over 100ms
    elseif offset > 50 then
        setTextColor('offsetText', '008700') -- Green for over 50ms
    else
        setTextColor('offsetText', '00FFFF') -- Cyan for under 50ms
    end

    setProperty('offsetText.alpha', 1)
    runTimer('fadeOffsetText', 0.25)
end

function onTimerCompleted(tag, loops, loopsLeft)
    if tag == 'fadeOffsetText' then
        doTweenAlpha('fadeOut', 'offsetText', 0, 0.1, 'linear')
    end
end