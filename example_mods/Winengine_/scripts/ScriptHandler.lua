---@diagnostic disable: lowercase-global, undefined-global

function onCreate()
    require("mods/" .. modFolder .. "/scripts/utility/ClientData")
    require("mods/" .. modFolder .. "/scripts/utility/Misc")

    setVar("debugMode", false)
    setVar("disableSaves", false) -- so you can view the results screen early (ENDING THE SONG EARLY WITH THIS SET TO "FALSE" WILL MESS UP UR SAVES)

    luaDebugMode = getVar("debugMode")

    ClientData.load()

    if ClientData.data.openOptions then
       addLuaScript("scripts/options/Main.lua")
    else
        addLuaScript("scripts/game/HUD.lua")
        if ClientData.data.quantNotes then
            addHScript("scripts/game/QuantizedNotes.hx")
        end
        if ClientData.data.skipIntroToggle then
            addLuaScript("scripts/game/SkipIntro.lua")
        end
        if ClientData.data.opponentSide then
            addHScript("scripts/game/OpponentSide.hx")
        end
        if botPlay or getPropertyFromClass("states.PlayState", "chartingMode") or practice then
            debugPrint("The results screen will not be shown because of BOTPLAY, CHARTING MODE, or PRACTICE MODE.")
        else
            if ClientData.data.showResults then
                if ClientData.data.resultsPresence == "ALL" or (ClientData.data.resultsPresence == "STORY MODE" and isStoryMode) or (ClientData.data.resultsPresence == "FREEPLAY" and not isStoryMode) then
                    addLuaScript("scripts/game/Results.lua")
                end
            end
        end
    end
end

function onCreatePost()
    if not botPlay and not getPropertyFromClass("states.PlayState", "chartingMode") and not practice then
        setVar("totalNotes", getProperty("unspawnNotes.length"))
        if not ClientData.data.openOptions then
            addLuaScript("scripts/game/SongDataHandler.lua")
        end
    end
end

function onUpdate(elapsed)
    if keyboardJustPressed("F1") and not ClientData.data.openOptions then
        ClientData.data.openOptions = true
        ClientData.save()
        debugPrint("The options menu will appear upon the next loaded song.")
    end
    if getVar("debugMode") then
        if keyboardJustPressed("F2") then
            restartSong(true)
        elseif keyboardJustPressed("F3") then
            endSong()
        elseif keyboardJustPressed("F4") then
            exitSong(true)
        elseif keyboardJustPressed("TAB") then
            for i in pairs(getRunningScripts()) do
                if stringStartsWith(getRunningScripts()[i], "mods/" .. modFolder) then
                    debugPrint(getRunningScripts()[i])
                end
            end
        elseif keyboardJustPressed("SHIFT") then
            ClientData.load()
            for key, value in pairs(ClientData.data) do
                debugPrint(tostring(key) .. " = " .. tostring(ClientData.data[key]))
            end
        elseif keyboardJustPressed("F11") then
            setPropertyFromClass("flixel.FlxG", "fullscreen", not getPropertyFromClass("flixel.FlxG", "fullscreen"))
        end
    end
end