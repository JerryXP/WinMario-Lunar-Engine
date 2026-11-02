function onCreatePost()
    -- This function is called after the stage is created and all default objects are loaded.
    -- It's the ideal place to modify existing objects like the score text.

    -- Change the X position of the score text
    setProperty('scoreTxt.x', 0) -- Moves the score text to X position 100

    -- Change the Y position of the score text
    setProperty('scoreTxt.y', 0)  -- Moves the score text to Y position 50

    -- You can also adjust other properties like scale, alpha, etc.
    -- setProperty('scoreTxt.scale.x', 1.5) -- Makes the score text 1.5 times larger horizontally
    -- setProperty('scoreTxt.alpha', 0.8)   -- Makes the score text slightly transparent
end