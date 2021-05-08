
pintmr = tmr.create()
function analizepin( )
	gpio.trig(pins.pinread)
	prt('trig!')
	if wth.relay == "Off" then
		switch(1)
	else
		switch(0)
	end
	pintmr:start()
	dofile("mqttpub.lua")(wth)
end

startpin = function()
	gpio.trig(pins.pinread, 'down', analizepin)
end

pintmr:register(2000, tmr.ALARM_SEMI, startpin)
pintmr:start()
l.on(0)