--==================================================
--  STAGE + PERSONAGENS + NOTAS PERSONALIZADAS
--==================================================

function onCreate()
    -- STAGE / BACKGROUND
    makeLuaSprite('bg', 'spaghetti/bg', -1888, -660)
    addLuaSprite('bg')

    makeLuaSprite('back-tables', 'spaghetti/back-tables', -1908, 267)
    addLuaSprite('back-tables')

    makeLuaSprite('floor', 'spaghetti/floor', -2232, 631)
    addLuaSprite('floor')

    makeLuaSprite('back-stools', 'spaghetti/back-stools', -1551, 431)
    addLuaSprite('back-stools')

    makeLuaSprite('front-stools', 'spaghetti/front-stools', -1551, 431)
    addLuaSprite('front-stools')

    makeLuaSprite('truck', 'spaghetti/truck-stuff', -983, -707)
    addLuaSprite('truck')

    makeLuaSprite('door', 'spaghetti/truck-door', -980, -173)
    addLuaSprite('door')
end