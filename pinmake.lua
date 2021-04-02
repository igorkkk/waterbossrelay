---------------
if not dat then dat = {}; dat.pinread = 3 end
---------------

pintmr = tmr.create()
function analizepin( )
	gpio.trig(dat.pinread)
	print('trig!')
	if dat.isswitch == 0 then
		switch(1)
	else
		switch(0)
	end
	pintmr:start()
end

startpin = function()
	gpio.trig(dat.pinread, 'down', analizepin)
end

pintmr:register(2000, tmr.ALARM_SEMI, startpin)
pintmr:start()