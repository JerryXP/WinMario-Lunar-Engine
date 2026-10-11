function onCreate()
    for i = 0, getProperty('unspawnNotes.length')-1 do
        if (getPropertyFromGroup('unspawnNotes', i, 'noteType') == '17') then
            setPropertyFromGroup('unspawnNotes', i, 'extraData.realData', 16, true) --always make sure to do one less than it will be visually, as noteData for left is actually 0!
        end
    end
end