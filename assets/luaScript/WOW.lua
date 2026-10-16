function onUpdatePost()
    --local upscrollTime = -30
    local downscrollTime = 683
    -- Bool Options
    if hideHud then
        setProperty('watermark.visible', false)
        setProperty('healthText.visible', false)
        setProperty('offsetText.visible', false)
        setProperty('timeTxt.visible', false)
        setProperty('timeBarBG.visible', false);
        setProperty('kalanZaman.visible', false);
        setProperty('arasBar.visible', false);
        setProperty('percentDerece.visible', false);
        setProperty('timeBar.visible', false);
        setProperty('difficult.visible', false);
        removeLuaScript('luaScript/noteCombo')
    end

    if not timerBreak then
        setProperty('kalanZaman.visible', false);
        setProperty('arasBar.visible', false);
        setProperty('percentDerece.visible', false);
    end

    if not popupMS then
        setProperty('offsetText.visible', false)
    end

    if not healTxt then
        setProperty('healthText.visible', false)

        if downscroll then
            setProperty('timeText.y', downscrollTime)
        end
    end

    if not comboNotehx then
        removeLuaScript('luaScript/noteCombo')
    end

    -- Water Mark Titles

    -- Disabled
    if watermarkSong0 then
        setProperty('watermark.visible', false)
        setProperty('difficult.visible', false);
        if not downscroll then
            setProperty('watermark.y', 690)
        end
    end

    -- From WinMario Engine July 29 2025 Alpha Version
    if watermarkSong2 then
        setTextString('watermark', songName .. " - Lunar Engine")
        setProperty('difficult.visible', false);
        if not downscroll then
            setProperty('watermark.y', 690)
        end
    end

    -- Usual (yeah idk wtf do I mean by that. :/)
    if watermarkSong3 then
        setTextString('watermark', songName .. " - " .. difficultyName .. "")
        setProperty('difficult.visible', false);
        if not downscroll then
            setProperty('watermark.y', 690)
        end
    end

    -- Kade
    if watermarkSong4 then
        setTextString('watermark', songName .. " " .. difficultyName .. " - LE 1.2")
        setProperty('difficult.visible', false);
        if not downscroll then
            setProperty('watermark.y', 690)
        end
    end

    -- Song Name Only (this is like Vs. WinMario 1.0 to 2.0 or Dave and Bambi)
    if watermarkSong5 then
        setProperty('difficult.visible', false);
        if not downscroll then
            setProperty('watermark.y', 690)
        end
    end

    -- Difficulty Name Only (this is like Modding Plus)
    if watermarkSong6 then
        if not downscroll then
            setProperty('difficult.y', 690)
        else
            setProperty('difficult.y', 10)
        end
        setProperty('watermark.visible', false)
    end

    -- for Upscroll People
    if not downscroll then
        setProperty('watermark.y', 670)
        setProperty('difficult.y', 690)
        setProperty('healthText.y', 10)
        setProperty('offsetText.y', 10)
        if healTxt then
            setProperty('timeText.y', 30)
        else
            setProperty('timeText.y', 10)
        end
    end

    -- if Colored Note Strum is disabled
    if not iconColoredstrum then
        removeLuaScript('luaScript/coloredStrums')
    end

end