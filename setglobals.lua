dat = {}
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
-- RELAY01 = 0
-- RELAY02 = 5
-- RELAY03 = 6
-- RELAY04 = 7

-- LED1 = 1

-- ########################### --



pins = {
	relaySec = 5,
	relayOpen = 6 
}

gpio.mode(pins.relaySec, gpio.OUTPUT)
gpio.mode(pins.relayOpen, gpio.OUTPUT)
-- pins.pinread = 3
pins.blink = 1
pins.ds18 = 4

l = require('_blink')
l.setpin(pins.blink)

prt('Client :', dat.clnt)
dat.boot = true

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