local cool = false
function onUpdate()
    if cool then
        if keyJustPressed('accept') then
            endSong()
        end
    end
end


function onEndSong()
    if isStoryMode then
        if not cool then
            playMusic('', 1)
            makeLuaSprite('end', 'spaghetti/fake-sserafim_end', 0, 0);
            setObjectCamera('end', 'camOther');
            addLuaSprite('end', true);
            cool = true
            return Function_Stop;
        end
        return Function_Continue;
    end
end