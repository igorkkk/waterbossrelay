dat = {}
dat.boot = true
wth = {}
dbug = true
prt = function(...)
	if dbug then print(...) end
end

dofile'_setuser.lua'

wth.secure = "On"
wth.relaySec = 'Off'
wth.relayOpen = 'Off'
wth.auto = 'On'

-- ####### Relay Pins ######## --

-- BUTTON = 
-- RELAY01 = 0	-- GPIO16
-- RELAY02 = 5  -- GPIO14
-- RELAY03 = 6  -- GPIO12
-- RELAY04 = 7 	-- GPIO13
-- LED = 1		-- GPIO5

-- ########################### --

pins = {
	relaySec = 5,	-- GPIO14
	relayOpen = 6,	-- GPIO12
	pinread = 8,	-- GPIO15
	blink = 1,  	-- GPIO5
	ds18 = 4		-- GPIO2
}

gpio.mode(pins.relaySec, gpio.OUTPUT)
gpio.mode(pins.relayOpen, gpio.OUTPUT)
gpio.mode(pins.relaySec, gpio.INPUT)

l = require('_blink')
l.setpin(pins.blink)

-- Функция переключения любого реле
function switch(rel, run)
	prt('\n\n\t\t\tGot Relay:', rel, 'Set to:', run, '\n\n')
	if rel == pins.relaySec then
		wth.relaySec = run == 1 and 'On' or 'Off'
		prt('\n\t\t\tRelaySec Set At '.. wth.relaySec..'\n\n')
		l.on(run)
	end
	if rel == pins.relayOpen then
		wth.relayOpen = run == 1 and 'On' or 'Off'
		if run == 1 then 
			tmr.create():alarm(1500, tmr.ALARM_SINGLE, function(t) t = nil; switch(pins.relayOpen, 0)  end)
		end
		prt('\n\t\t\tRelayOpen Set At '.. wth.relayOpen..'\n\n')
	end
	gpio.write(rel, run)
	if m then node.task.post(function() dofile('mqttpub.lua')(wth) end) end

end

-- Разомкнуто при старте модуля 
switch(pins.relaySec, 0)

-- dofile'pinmake.lua'

dofile'mqttset.lua'
dofile'main.lua'