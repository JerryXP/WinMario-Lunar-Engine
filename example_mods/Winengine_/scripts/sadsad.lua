function onCreate() for i=1,3 do precacheSound('missnote'..i) end end
function noteMiss(I,D,nT,S) if nT=='' and not S then missSound() end end
function noteMissPress() missSound() end
function missSound() playSound('missnote'..getRandomInt(1,3),.65,'Miss') end