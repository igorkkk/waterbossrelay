if not killtop then
dat.analiz=nil
return
end
dat.analiz=true
local e=table.remove(killtop)
if not e[1]or not e[2]then
e,killtop=nil,nil
return
end
print('\n\n\t\tGot From Broker:',e[1],e[2],'\n\n')
if e[1]=="ide"then
if e[2]=="On"then
prt("Restart Now")
node.task.post(function()dofile('restart.lua')end)
return
end
elseif e[1]=="auto"then
if e[2]=="On"then
wth.auto='On'
if wth.secure=="Off"then
switch(pins.relaySec,1)
else
switch(pins.relaySec,0)
end
elseif e[2]=="Off"then
wth.auto='Off'
switch(pins.relaySec,0)
end
elseif e[1]=="relaySec"then
if e[2]=="On"and wth.secure=='Off'then
switch(pins.relaySec,1)
prt('Secure Manual Off ')
elseif e[2]=="Off"then
switch(pins.relaySec,0)
prt('Secure Manual On')
end
elseif e[1]=="relaytime"then
if e[2]=="On"then
wth.relaytime='On'
prt("Time Works Set On")
elseif e[2]=="Off"then
wth.relaytime='Off'
prt("Time Works Set Off")
end
elseif e[1]=="garageOpen"and wth.secure=="Off"then
if e[2]=="On"then
switch(pins.relayOpen,1)
prt("\nOpen Garage!")
end
elseif e[1]=="ajaxsecure"then
if e[2]=="On"and wth.secure=="Off"then
wth.secure="On"
prt("Garage Secure To On")
switch(pins.relaySec,0)
elseif e[2]=="Off"and wth.secure=="On"and wth.auto=='On'then
wth.secure="Off"
prt("Garage Secure To Off")
switch(pins.relaySec,1)
end
end
e=nil
if killtop and killtop[1]then
node.task.post(function()dofile('mqttanalize.lua')end)
else
killtop=nil
dat.analiz=nil
node.task.post(function()dofile('mqttpub.lua')(wth)end)
end