local tm = rtctime.epoch2cal(rtctime.get()+3*60*60)
if tm.year == 1970 then return (function() print('Wrong time') end)() end
local a, b = node.bootreason()
do
if a == 1 then a = 'power-on'
elseif a == 2 then a = 'reset'
elseif a == 3 then a = 'reset pin'
elseif a == 4 then a = 'WDT reset'
end

if b == 0 then b = 'power-on'
elseif 	b == 1 then b = 'hardware watchdog'
elseif 	b == 2 then b = 'exception reset'
elseif 	b == 3 then b = 'software watchdog'
elseif 	b == 4 then b = 'software restart'
elseif 	b == 5 then b = 'wake from deep sleep'
elseif 	b == 6 then b = 'external reset'
end

local tx = string.format("%04d.%02d.%02d %02d:%02d", tm.year, tm.mon, tm.day, tm.hour, tm.min)
m:publish(dat.clnt..'/boot', a..' : '..b..' at '..tx,0,1)
print(dat.clnt..'/boot', a..' : '..b..' at '..tx)
dat.boot,tm,a,b,tx = nil,nil,nil,nil,nil
end