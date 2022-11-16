local M = {}
M.pin = 1
M.lt = 0
-- M.shem = {
-- 	{1,0,1,0,1,0,0,0,0}
-- }
M.setpin = function(pin)
	M.pin = pin or M.pin
	gpio.mode(M.pin, gpio.OUTPUT)
	gpio.write(M.pin, gpio.LOW)
end
M.kill = function()
	if M.tmr then
		M.tmr:stop()
		M.tmr:unregister()
		M.tmr = nil
	end
end

M.on = function(on)
	M.kill()
	on = on or 1
	on = on == 0 and 1 or 0
	gpio.write(M.pin, on)
end
M.flash = function(fl)
	fl = fl or false
	if fl then 
		if not M.tmr then
			M.tmr = tmr.create()
			M.tmr:alarm(fl*100, 1, function()
				M.lt = M.lt==0 and 1 or 0
				gpio.write(M.pin, M.lt)
			end)
		else
			M.tmr:interval(fl*100)
		end
	else
		M.kill()
	end
end
return M
