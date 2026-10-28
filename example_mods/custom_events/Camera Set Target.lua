function onEvent(name, value1, value2)
	if name == 'Camera Set Target' then
		camTarget = value1;
        cameraSetTarget(camTarget)
	end
end