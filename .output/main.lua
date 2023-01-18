do
local e=0
local t=tmr.create()
t:alarm(1000,1,function(t)
e=e+1
local t=gpio.read(pins.pinread)
wth.open=t==1 and'On'or'Off'
do
if e<30 then
return
else
e=0
local e={}
function myWork()
prt("Got DS18b20: "..#e)
if e[1]and e[1][2]then
wth.garahetemp=e[1][2]
end
ds,e=nil,nil
package.loaded["_ds18b20"]=nil
if wth.relaytime=="On"and wth.secure=='Off'and wth.auto=='On'then dofile('timerelay.lua')end
node.task.post(function()dofile('mqttpub.lua')(wth)end)
end
ds=require('_ds18b20')
ds.getTemp(e,myWork,pins.ds18,750)
end
end
end)
end