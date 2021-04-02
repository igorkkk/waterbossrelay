pintmr = tmr.create()
worktmr = tmr.create()

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

function switch(run)
	print('Light is '..run)
	dat.isswitch = run
	gpio.write(pins.relay, run)
	if run == 0 then sntp.sync() end
	return dofile'mqttpub.lua'
end


startpin = function()
	gpio.trig(dat.pinread, 'down', analizepin)
end

pintmr:register(2000, tmr.ALARM_SEMI, startpin)
pintmr:start()

worktmr:alarm(30000, 1, function(t)  dofile('mqttpub.lua')   end)