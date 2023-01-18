local a=rtctime.epoch2cal(rtctime.get()+3*60*60)
if a.year==1970 then return(function()print('Wrong time')end)()end
local t,e=node.bootreason()
do
if t==1 then t='power-on'
elseif t==2 then t='reset'
elseif t==3 then t='reset pin'
elseif t==4 then t='WDT reset'
else t=" "
end
if e==0 then e='power-on'
elseif e==1 then e='hardware watchdog'
elseif e==2 then e='exception reset'
elseif e==3 then e='software watchdog'
elseif e==4 then e='software restart'
elseif e==5 then e='wake from deep sleep'
elseif e==6 then e='external reset'
else e=" "
end
local o=string.format("%04d.%02d.%02d %02d:%02d",a.year,a.mon,a.day,a.hour,a.min)
m:publish(dat.clnt..'/boot',t..' : '..e..' at '..o,0,1)
print(dat.clnt..'/boot',t..' : '..e..' at '..o)
dat.boot,a,t,e,o=nil,nil,nil,nil,nil
end