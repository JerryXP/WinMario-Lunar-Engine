---------------------------------------------------------
-- LISTAS DE SPRITES
---------------------------------------------------------
local stageSprites = {'bg','back-tables','floor','back-stools','front-stools','truck','door'}
local shaderStage = {}
local backLight = 'backLight'
local backLight2 = 'backLight2'        
local truckLight1 = 'truck-light1'      
local truckLight2 = 'truck-light2'      

---------------------------------------------------------
-- VARIÁVEIS DO EFEITO
---------------------------------------------------------
local lightEnabled = false
local flashStrength = 0.5

local presetColors = {
    getColorFromHex('6F00FF'),
    getColorFromHex('FF00AC')
}
local colorIndex = 1

---------------------------------------------------------
-- EVENTO CUSTOM
---------------------------------------------------------
function onEvent(name, value1, value2)
    if name ~= 'sserafimShow' then return end
    if not shadersEnabled then return end

    local stageBrightness = tonumber(value2) or 0

    -------------------------------------
    -- CRIAÇÃO DE LIGHTS (Mantido igual)
    -------------------------------------
    if not luaSpriteExists(backLight) then
        makeLuaSprite(backLight, 'spaghetti/lights/back-light-color', -2000, -950)
        setScrollFactor(backLight, 1, 1)
        scaleLuaSprite(backLight, 1.3, 1.3)
        setProperty(backLight..'.alpha', 0)
        addLuaSprite(backLight)
        setObjectOrder(backLight, getObjectOrder('truck') - 1)
    end
    
    if not luaSpriteExists(backLight2) then
        makeLuaSprite(backLight2, 'spaghetti/lights/back-light-color', -1000, -700)
        setScrollFactor(backLight2, 1, 1)
        scaleLuaSprite(backLight2, 0.9, 0.9)
        setProperty(backLight2..'.alpha', 0)
        addLuaSprite(backLight2)
        setObjectOrder(backLight2, getObjectOrder('backLight') + 1)
    end

    if not luaSpriteExists(truckLight1) then
        makeLuaSprite(truckLight1, 'spaghetti/lights/truck-light1', -962, -607)
        setScrollFactor(truckLight1, 1, 1)
        scaleLuaSprite(truckLight1, 1, 1)
        setProperty(truckLight1..'.alpha', 0)
        addLuaSprite(truckLight1)
        setObjectOrder(truckLight1, getObjectOrder('truck') + 1)
    end

    if not luaSpriteExists(truckLight2) then
        makeLuaSprite(truckLight2, 'spaghetti/lights/truck-light2', -781, -464)
        setScrollFactor(truckLight2, 1, 1)
        scaleLuaSprite(truckLight2, 1, 1)
        setProperty(truckLight2..'.alpha', 0)
        addLuaSprite(truckLight2)
        setObjectOrder(truckLight2, getObjectOrder('truck') + 2)
    end

    initLuaShader('adjustColor')

    -----------------------------------------------------
    -- CENÁRIO (APENAS BRILHO)
    -----------------------------------------------------
    for _, spr in ipairs(stageSprites) do
        if luaSpriteExists(spr) then
            setSpriteShader(spr, 'adjustColor')

            if value1 == 'dark' then
                lightEnabled = false
                setShaderFloat(spr, 'brightness', stageBrightness)

            elseif value1 == 'light' then
                lightEnabled = true
                local brightness = tonumber(value2) or -80
                setShaderFloat(spr, 'brightness', brightness)
                setProperty(backLight..'.alpha', 0)
            end

            -- Removidas as linhas de hue, contrast e saturation para não resetarem os valores
            updateFrameInfo(spr)
            table.insert(shaderStage, spr)
        end
    end

    -----------------------------------------------------
    -- PERSONAGENS (APENAS BRILHO)
    -----------------------------------------------------
    for _, char in ipairs(charSprites) do
        setSpriteShader(char, 'adjustColor')

        if value1 == 'light' then
            setShaderFloat(char, 'brightness', -30)
            -- Removidos saturation e contrast extras que estavam aqui
        else
            setShaderFloat(char, 'brightness', 0)
        end

        -- Removidas as linhas de hue, contrast e saturation daqui também
        updateFrameInfo(char)
        table.insert(shaderStage, char)
    end
end

---------------------------------------------------------
-- BEAT (PISCAR + TROCAR COR) - Sem alterações
---------------------------------------------------------
function onBeatHit()
    if not lightEnabled then return end
    if not luaSpriteExists(backLight) then return end

    cancelTween('backLightFlash')

    setProperty(backLight..'.alpha', flashStrength)
    doTweenAlpha('backLightFlash', backLight, 0, 0.4, 'quadIn')
    setProperty(backLight..'.color', presetColors[colorIndex])

    setProperty(backLight2..'.alpha', flashStrength)
    doTweenAlpha('backLight2Flash', backLight2, 0, 0.4, 'quadIn')

    setProperty(truckLight1..'.alpha', 1)
    doTweenAlpha('truckLight1Flash', truckLight1, 0, 0.4, 'quadIn')

    setProperty(truckLight2..'.alpha', flashStrength)
    doTweenAlpha('truckLight2Flash', truckLight2, 0, 0.4, 'quadIn')

    colorIndex = colorIndex + 1
    if colorIndex > #presetColors then
        colorIndex = 1
    end
end

---------------------------------------------------------
-- UPDATE
---------------------------------------------------------
function onUpdatePost()
    if not shadersEnabled then return end
    for _, spr in ipairs(shaderStage) do
        updateFrameInfo(spr)
    end
end

function updateFrameInfo(s)
    setShaderFloatArray(s, 'uFrameBounds', {
        getProperty(s..'.frame.uv.x'),
        getProperty(s..'.frame.uv.y'),
        getProperty(s..'.frame.uv.width'),
        getProperty(s..'.frame.uv.height')
    })
end