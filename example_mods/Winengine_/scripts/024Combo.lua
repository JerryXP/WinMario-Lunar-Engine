-- This script was made by MinerGuyBr. This is poorly optimized and may be updated in the future. 
-- Credits to the Hotline 024 team for making the original thing that was recreated here.
-- Some parts of this are slightly inaccurate so please don't think of this as a 100% recreation.

local hotlineFont = true --Toglles the Hotline 024 font for the rest of the hud.
local hotlineBlink = true --Toggles the Hotline 024 blink style (continues blinking for a bit if another combo is started within 1.25 seconds of the first.) Can be distracting if on.
local middleSupport = true --Toggles the visibility of it for middlescroll palyers. Can be distracting if on.
local includeLongNotes = false --Toggles if long notes should keep the combo going or not. Keep it false if you want the true 024 experience.
local instantGlow = false --Toggles if the glow must complete a tween cycle to get back to full opacity. Keep it false if you want the true 024 experience.

---- Coding Stuff. Feel free to optimize it if you want. ----

local recentRating = 'pussy'
local recentScore = 0
local recentCombo = 0
local recentMisses = 0
local endRating = 'coochie'
local endScore = 0
local recentSick = 0
local recentGood = 0
local recentBad = 0
local recentShit = 0
local sick = 0
local good = 0
local bad = 0
local shit = 0
local dummyScore = 0
local blink = false
local noteWasHit = false
local glowEnded = false
local mustBeVisible = false

function onCreatePost()

    makeLuaText('comboTxt', 'cock', 1000, 0, 75)
    setTextSize('comboTxt', 38)
    setTextBorder('comboTxt', 2, '000000')
    screenCenter('comboTxt', 'X')
    setTextFont('comboTxt', 'cool.ttf')
    addLuaText('comboTxt')
    setObjectCamera('comboTxt', 'hud')
    setProperty('comboTxt.alpha', 0)

    makeLuaText('addedScoreTxt', 'and', 1000, 0, 105)
    setTextSize('addedScoreTxt', 21)
    setTextBorder('addedScoreTxt', 2, '000000')
    screenCenter('addedScoreTxt', 'X')
    setTextFont('addedScoreTxt', 'cool.ttf')
    addLuaText('addedScoreTxt')
    setObjectCamera('addedScoreTxt', 'hud')
    setProperty('addedScoreTxt.alpha', 0)

    makeLuaText('comboScoreTxt', 'balls', 1000, 0, 122)
    setTextSize('comboScoreTxt', 38)
    setTextBorder('comboScoreTxt', 2, '000000')
    screenCenter('comboScoreTxt', 'X')
    setTextFont('comboScoreTxt', 'cool.ttf')
    addLuaText('comboScoreTxt')
    setObjectCamera('comboScoreTxt', 'hud')
    setProperty('comboScoreTxt.alpha', 0)

    makeLuaSprite('glow', 'comboGlow', 545, 50)
    setObjectCamera('glow', 'hud')
    addLuaSprite('glow', false)
    setProperty('glow.alpha', 0)
end

function onUpdate(elapsed)

    if downscroll and not middlescroll then
        setProperty('comboTxt.y', 575)
        setProperty('addedScoreTxt.y', 605)
        setProperty('comboScoreTxt.y', 622)
        setProperty('glow.y', 550)
    elseif middlescroll and downscroll then
        setProperty('comboTxt.y', 145)
        setProperty('addedScoreTxt.y', 175)
        setProperty('comboScoreTxt.y', 192)
        setProperty('glow.y', 120)
    elseif middlescroll and not downscroll then
        setProperty('comboTxt.y', 500)
        setProperty('addedScoreTxt.y', 530)
        setProperty('comboScoreTxt.y', 547)
        setProperty('glow.y', 475)
    elseif not middlescroll and not downscroll then
        setProperty('comboTxt.y', 75)
        setProperty('addedScoreTxt.y', 105)
        setProperty('comboScoreTxt.y', 122)
        setProperty('glow.y', 50)
    end

    if recentCombo > 0 then
        setTextString('comboTxt', recentRating.. ' X'.. recentCombo)
        setTextString('addedScoreTxt', '+'..recentScore)
        setTextString('comboScoreTxt', endScore)

        if glowEnded == true then
            setProperty('glow.alpha', 0.33)
            glowEnded = false
        end

        if mustBeVisible == true then
            setProperty('comboTxt.visible', true)
            mustBeVisible = false
        end

        if recentShit > 0 then
            endRating = 'Whoops...'
        elseif recentBad > 0 then 
            endRating = 'NICE!'
        elseif recentGood > 0 then
            endRating = 'GREAT!'
        elseif recentSick > 0 then 
            endRating = 'PERFECT!!'
        end
        dummyScore = dummyScore
    else
        setTextString('comboScoreTxt', endScore)
        dummyScore = score - endScore
    end

    if endScore < 0 then
        endScore = 0
    end

    if hits < 1 and misses < 1 then
        setTextString('scoreTxt', 'Goal: 0 | Oops: 0 | Results: ?')
    else
        setTextString('scoreTxt', 'Goal: ' .. dummyScore .. ' | Oops: ' .. misses .. ' | Results: ' .. ratingName.. ' ('..round(rating * 100, 2).. '%) - ' .. ratingFC)
    end

    local rng = (1 + math.random(5,25)/100)
    if decreaseScore == true then
        endScore = round(endScore/rng, 0);
        if endScore <= 100 then
            endScore = 0 
        end
    end
    if endScore <= 0 then
        decreaseScore = false
        endScore = 0
    end
end

function goodNoteHit(id, direction, noteType, isSustainNote)

    if not middlescroll or middlescroll and middleSupport then
        if not isSustainNote then
            
            setProperty('comboTxt.alpha', 1)
            setProperty('addedScoreTxt.alpha', 1)
            setProperty('comboScoreTxt.alpha', 1)
            if instantGlow or noteWasHit == false then
                setProperty('glow.alpha', 0.33)
                cancelTween('glowFade')
                noteWasHit = true
            end

            setProperty('comboTxt.scale.x', 1.075)
            setProperty('comboTxt.scale.y', 1.075)
            setProperty('addedScoreTxt.scale.x', 1.075)
            setProperty('addedScoreTxt.scale.y', 1.075)
            setProperty('comboScoreTxt.scale.x', 1.075)
            setProperty('comboScoreTxt.scale.y', 1.075)

            doTweenX('comboX', 'comboTxt.scale', 1, 0.2, 'cubeInOut')
            doTweenY('comboY', 'comboTxt.scale', 1, 0.2, 'cubeInOut')
            doTweenX('scoringX', 'addedScoreTxt.scale', 1, 0.2, 'cubeInOut')
            doTweenY('scoringY', 'addedScoreTxt.scale', 1, 0.2, 'cubeInOut')
            doTweenX('ratingX', 'comboScoreTxt.scale', 1, 0.2, 'cubeInOut')
            doTweenY('ratingY', 'comboScoreTxt.scale', 1, 0.2, 'cubeInOut')

            recentCombo = recentCombo + 1

            if recentCombo > 0 then
                if sick < getProperty('ratingsData[0].hits') then
                    sick = sick + 1
                    recentRating = 'COOL!'
                    recentScore = 350
                    recentSick = recentSick + 1
                    endScore = endScore + 350
                elseif good < getProperty('ratingsData[1].hits') then
                    good = good + 1
                    recentRating = 'GOOD!'
                    recentScore = 200
                    recentGood = recentGood + 1   
                    endScore = endScore + 200
                elseif bad < getProperty('ratingsData[2].hits') then
                    bad = bad + 1
                    recentRating = 'BAD!'
                    recentScore = 100
                    recentBad = recentBad + 1
                    endScore = endScore + 100
                elseif shit < getProperty('ratingsData[3].hits') then
                    shit = shit + 1
                    recentRating = 'AWFUL!'
                    recentScore = 50
                    recentShit = recentShit + 1
                    endScore = endScore + 50
                end
            end
        end

        if not isSustainNote or includeLongNotes == false and not isSustainNote or includeLongNotes == true and isSustainNote then
            decreaseScore = false
            if hotlineBlink == false then
                cancelTimer('flashingCombo')
                cancelTimer('failsafeTimer')
                setProperty('comboTxt.visible', true)
                blink = false
            end

            cancelTimer('scoreFading')   
            cancelTween('comboFade')
            cancelTween('ratingFade')
            runTimer('scoreFading', 2.05)
        end
    end
end

function onTimerCompleted(tag, loops, loopsLeft)

    if tag == 'scoreFading' then
        --[[local random = math.random (4)

        if recentShit > 0 or recentBad > 0 then
            if random == 1 then
                playAnim('boyfriend', 'singLEFTmiss')
            elseif random == 2 then
                playAnim('boyfriend', 'singDOWNmiss')                
            elseif random == 3 then
                playAnim('boyfriend', 'singUPmiss')
            elseif random == 4 then
                playAnim('boyfriend', 'singRIGHTmiss')
            end
        elseif recentGood > 0 or recentSick > 0 then
            playAnim('boyfriend', 'hey')
            setProperty('boyfriend.specialAnim', true)
        end]]
        -- Remove the comment stuff if you want bf to do miss poses on bad combos and the hey pose on good combos.

        blink = true
        recentCombo = 0
        recentMisses = 0
        recentSick = 0
        recentGood = 0
        recentBad = 0
        recentShit = 0
        decreaseScore = true
        setProperty('glow.alpha', 0.66)
        setTextString('comboTxt', endRating)
        doTweenAlpha('comboFade', 'comboTxt', 0, 1.05, 'linear')
        doTweenAlpha('scoringFade', 'addedScoreTxt', 0, 0.001, 'linear')
        doTweenAlpha('ratingFade', 'comboScoreTxt', 0, 1.05, 'linear')
        doTweenAlpha('glowFade', 'glow', 0, 1.05, 'linear')
        runTimer('failsafeTimer', 1.11)
        runTimer('flashingCombo', 0.05, 22)
    end
    if tag == 'flashingCombo' then
        if blink == true then
            setProperty('comboTxt.visible', false)
            blink = false
        elseif blink == false then
            setProperty('comboTxt.visible', true)
            blink = true
        end
    end
    if tag == 'failsafeTimer' then
        if mustBeVisible == false then
            mustBeVisible = true
        end
    end
end

function onTweenCompleted(tag)
    if tag == 'glowFade' then
        if instantGlow == false then
            glowEnded = true
        end
    end
end

function round(num, dp) -- I stole this code lol
    local mult = 10^(dp or 0);
    return math.floor(num * mult + 0.5)/mult;
end