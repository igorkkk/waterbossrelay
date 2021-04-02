dat = {}
if not wth then wth = {} end
dofile'_setuser.lua'

--[[
GPIO00 - BUTTON = 3
GPIO12 - RELAY = 6
GPIO13 - LED1 = 7
--]]

pins = {
	relay = 6, 
}
gpio.mode(pins.relay, gpio.OUTPUT)
gpio.write(pins.relay, gpio.LOW)
l = require('_blink')
l.set(7)
l.on(1)
dat.pinread = 3
print('Client :', dat.clnt)
dat.boot = true
dofile'mqttset.lua'
dofile'main.lua'