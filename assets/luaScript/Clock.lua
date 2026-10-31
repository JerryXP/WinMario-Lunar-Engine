function onCreate()
    -- Create a text object to display the time
    makeLuaText('timeText', '', 2350, 55, 663)
    setTextSize('timeText', 26)
    setTextFont('timeText', 'time.ttf');
    addLuaText('timeText')
end

function onUpdate()
    -- Get the current time from the computer
    local twelve = os.date('%I:%M:%S %p')
    local twentyFour = os.date('%H:%M:%S')
    
    -- Update the text object with the current time
    if hour12 then
        setTextString('timeText', twelve)
    elseif hour24 then
        setTextString('timeText', twentyFour)
    end
end
