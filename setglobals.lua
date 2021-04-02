dat = {}
if not wth then wth = {} end
dofile'_setuser.lua'

wth.secure = "Off"
wth.isboss = "On"
wth.relay = 'Off'
wth.auto = 'On'

--[[
	Sonoff:
	BUTTON = 3
	RELAY = 6
	LED1 = 7
--]]

pins = {
	relay = 6,
}
gpio.mode(pins.relay, gpio.OUTPUT)

l = require('_blink')
l.set(7)
--l.on(1)
dat.pinread = 3
prt('Client :', dat.clnt)
dat.boot = true
dofile'mqttset.lua'
dofile'main.lua'

function switch(run)
	wth.relay = run == 1 and 'On' or 'Off'
	prt('Relay is '.. wth.relay)
	gpio.write(pins.relay, run)
	l.on(run)
	dofile('mqttpub.lua')(wth)
end
switch(1)
