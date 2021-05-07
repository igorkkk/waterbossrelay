dat = {}
wth = {}
dofile'_setuser.lua'

wth.relay = 'Off'

-- ####### Sonoff Pins ######## --
-- BUTTON = 3
-- RELAY = 6
-- LED1 = 7

pins = { relay = 6 }
gpio.mode(pins.relay, gpio.OUTPUT)
pins.pinread = 3
pins.blink = 7

l = require('_blink')
l.setpin(pins.blink)

prt('Client :', dat.clnt)
dat.boot = true

function switch(run)
	wth.relay = run == 1 and 'On' or 'Off'
	prt('Relay is '.. wth.relay)
	gpio.write(pins.relay, run)
	l.on(run)
	dofile('mqttpub.lua')(wth)
end
switch(0)

dofile'pinmake.lua'
dofile'mqttset.lua'
dofile'main.lua'