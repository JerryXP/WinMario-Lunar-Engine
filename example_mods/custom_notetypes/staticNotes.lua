function onCreate()
	--Iterate over all notes
	for i = 0, getProperty('unspawnNotes.length')-1 do
		if getPropertyFromGroup('unspawnNotes', i, 'noteType') == 'staticNotes' then 
			setPropertyFromGroup('unspawnNotes', i, 'texture', 'staticNotes');

			if getPropertyFromGroup('unspawnNotes', i, 'mustPress') then --Doesn't let Dad/Opponent notes get ignored
				setPropertyFromGroup('unspawnNotes', i, 'ignoreNote', false); --Miss has penalties
			end
		end
	end
end


function onCreatePost()
    precacheImage('hitStatic')
	makeAnimatedLuaSprite('brzt','hitStatic',0,0)
    addAnimationByPrefix('brzt','static','staticANIMATION',24,false)
    setObjectCamera('brzt','other')
	addLuaSprite('brzt', true)
	setProperty('brzt.alpha', 0)
end

function noteMiss(id,data,noteType,sus)
    if noteType == 'Static Note' and flashingLights then
       setProperty('brzt.alpha', 1)
        objectPlayAnimation('brzt','static',true)
        playSound('hitStatic1')
        runTimer('staticFallOff', 0.466, 1)
    end
end
function onTimerCompleted(tag, loopsleft)
	if tag == 'staticFallOff' then
	setProperty('brzt.alpha', 0)
	end
end

--function noteMiss(id, direction, noteType, isSustainNote)
	--if noteType == 'staticNotes' then
       --playSound('hitStatic1', 1);
	   --triggerEvent('YOU MISSED THE STATIC NOTE NOW GET FUCKED');
	--end
--end

