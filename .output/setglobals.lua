dat={}
dat.boot=true
wth={}
dbug=true
prt=function(...)
if dbug then print(...)end
end
dofile'_setuser.lua'
wth.secure="On"
wth.relaySec='Off'
wth.relayOpen='Off'
wth.auto='On'
pins={
relaySec=5,
relayOpen=6,
pinread=8,
blink=1,
ds18=4
}
gpio.mode(pins.relaySec,gpio.OUTPUT)
gpio.mode(pins.relayOpen,gpio.OUTPUT)
gpio.mode(pins.relaySec,gpio.INPUT)
l=require('_blink')
l.setpin(pins.blink)
function switch(t,e)
prt('\n\n\t\t\tGot Relay:',t,'Set to:',e,'\n\n')
if t==pins.relaySec then
wth.relaySec=e==1 and'On'or'Off'
prt('\n\t\t\tRelaySec Set At '..wth.relaySec..'\n\n')
l.on(e)
end
if t==pins.relayOpen then
wth.relayOpen=e==1 and'On'or'Off'
if e==1 then
tmr.create():alarm(1500,tmr.ALARM_SINGLE,function(e)e=nil;switch(pins.relayOpen,0)end)
end
prt('\n\t\t\tRelayOpen Set At '..wth.relayOpen..'\n\n')
end
gpio.write(t,e)
if m then node.task.post(function()dofile('mqttpub.lua')(wth)end)end
end
switch(pins.relaySec,0)
dofile'mqttset.lua'
dofile'main.lua'