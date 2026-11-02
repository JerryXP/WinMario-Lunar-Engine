--script by daBlowBoi

local sickHit = 0
local goodHit = 0
local badHit = 0
local shitHit = 0

function onCreate()
   makeLuaText('sickCounter', 'Cool!: ', 0, 2, 300)
   setTextSize('sickCounter', 22)
   setTextBorder('sickCounter', 2, '000000')
   addLuaText('sickCounter')
   
   makeLuaText('goodCounter', 'Good: ', 0, 2, 325)
   setTextSize('goodCounter', 22)
   setTextBorder('goodCounter', 2, '000000')
   addLuaText('goodCounter')
   
   makeLuaText('badCounter', 'Bad: ', 0, 2, 350)
   setTextSize('badCounter', 22)
   setTextBorder('badCounter', 2, '000000')
   addLuaText('badCounter')
   
   makeLuaText('shitCounter', 'Awful: ', 0, 2, 375)
   setTextSize('shitCounter', 22)
   setTextBorder('shitCounter', 2, '000000')
   addLuaText('shitCounter')
end

function goodNoteHit(id, direction, noteType, isSustainNote)

if not isSustainNote then
   local rating = getPropertyFromGroup('notes', id, 'rating')
   if rating == 'sick' then
   sickHit = sickHit + 1
   elseif rating == 'good' then
   goodHit = goodHit + 1
   elseif rating == 'bad' then
   badHit = badHit + 1
   elseif rating == 'shit' then
   shitHit = shitHit + 1
end
end
end
function onUpdate(elapsed)
   setTextString('sickCounter', 'Cool!: ' .. sickHit)
   setTextString('goodCounter', 'Good: ' .. goodHit)
   setTextString('badCounter', 'Bad: ' .. badHit)
   setTextString('shitCounter', 'Awful: ' .. shitHit)
end