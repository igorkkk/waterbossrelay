local e=rtctime.epoch2cal(rtctime.get()+3*60*60)
local t={}
t[1]={23,0}
t[2]={8,30}
local a=(e.min>9)and e.min or('0'..e.min)
prt('\n\nNow '..e.hour..':'..a)
if wth.auto=='On'and wth.secure=='Off'then
if e.hour==t[1][1]and e.min>=t[1][2]and wth.relaySec=='On'then
switch(pins.relaySec,0)
prt('\n\t\tGarage Blocked By Time')
return
end
if e.hour==t[2][1]and e.min>=t[2][2]and wth.relaySec=='Off'then
switch(pins.relaySec,1)
prt('\n\t\tGarage Unblocked By Time')
end
end