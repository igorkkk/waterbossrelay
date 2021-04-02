dat = {}
if not wth then wth = {} end
dofile'_setuser.lua'

wth.secure = "Off"
wth.isboss = "Off"


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

function switch(run)
	wth.isboss = run == 1 and 'On' or 'Off'
	prt('Relay is '.. wth.isboss)
	gpio.write(pins.relay, run)
	dofile('mqttpub.lua')(wth)
	--return (dofile('mqttpub.lua')(wth))
end
switch(1)

l = require('_blink')
l.set(7)
l.on(1)
dat.pinread = 3
prt('Client :', dat.clnt)
dat.boot = true
dofile'mqttset.lua'
dofile'main.lua'