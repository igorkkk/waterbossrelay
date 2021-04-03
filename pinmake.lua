
pintmr = tmr.create()
function analizepin( )
	gpio.trig(dat.pinread)
	print('trig!')
	if wth.relay == "Off" then
		switch(1)
		wth.auto = 'Off'
	else
		--switch(0)
		wth.auto = 'On'
		wth.isboss = "On"
	end
	pintmr:start()
	dofile("mqttpub.lua")(wth)
end

startpin = function()
	gpio.trig(dat.pinread, 'down', analizepin)
end

pintmr:register(2000, tmr.ALARM_SEMI, startpin)
pintmr:start()