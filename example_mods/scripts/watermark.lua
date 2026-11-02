function onCreatePost()
    makeLuaText("engineText", "WinMario Engine - Alpha 1", 500, 30, 30)
    setTextAlignment("engineText", "left")
    addLuaText("engineText")

    if getPropertyFromClass('ClientPrefs', 'downScroll') == false then
        setProperty('engineText.y', 660)
    end
end