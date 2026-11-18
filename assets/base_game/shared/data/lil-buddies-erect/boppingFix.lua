local inv = 1
function onBeatHit()
   inv = inv * -1
   setProperty('camHUD.angle', 3 * inv)
   doTweenAngle('camHUDAngleBack', 'camHUD', 0, crochet*.0025, 'quartOut')
end