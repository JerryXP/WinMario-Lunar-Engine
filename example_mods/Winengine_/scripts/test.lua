Int=10 function onBeatHit() bopIcon(curBeat) end
function onCountdownTick(c) bopIcon(c) end
function onSongStart() bopIcon('') end
function bopIcon(t) t=t or curBeat for i=1,2 do ang('iconP'..i,t%2==0 and Int or -Int) end end
function ang(n,a) setProperty(n..'.angle',a) end