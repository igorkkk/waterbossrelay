dat = {}
wth = {}
dofile'_setuser.lua'

wth.secure = "Off"
wth.relay = 'Off'
wth.auto = 'On'

-- ####### Sonoff Pins ######## --
-- BUTTON = 3
-- RELAY = 6
-- LED1 = 7

pins = { relay = 6 }
gpio.mode(pins.relay, gpio.OUTPUT)
pins.pinread = 3

l = require('_blink')
l.setpin(7)
--l.on(1)

prt('Client :', dat.clnt)
dat.boot = true

function switch(run)
	wth.relay = run == 1 and 'On' or 'Off'
	prt('Relay is '.. wth.relay)
	gpio.write(pins.relay, run)
	l.on(run)
	dofile('mqttpub.lua')(wth)
end
switch(1)

dofile'pinmake.lua'
dofile'mqttset.lua'
dofile'main.lua'