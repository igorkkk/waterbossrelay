local e={}
e.adrtbl={}
e.pin=4
e.del=750
function e.getaddrs(a,o)
ow.setup(e.pin)
ow.reset_search(e.pin)
repeat
local t=ow.search(e.pin)
if(t~=nil)then
table.insert(e.adrtbl,t)
end
until(t==nil)
ow.reset_search(e.pin)
if#e.adrtbl~=0 then
e.askTemp(a,o)
else
print('No DS18b20!')
return
end
end
function e.askTemp(a,o)
ow.setup(e.pin)
for a,t in pairs(e.adrtbl)do
ow.reset(e.pin)
ow.select(e.pin,t)
ow.write(e.pin,68,1)
end
v=nil
tmr.create():alarm(e.del,tmr.ALARM_SINGLE,function(t)
t=nil
e.readResult(a,o)
end)
end
function e.readResult(s,n)
local a,i,t
for n,o in pairs(e.adrtbl)do
ow.reset(e.pin)
ow.select(e.pin,o)
ow.write(e.pin,190,1)
a=ow.read_bytes(e.pin,9)
i=ow.crc8(string.sub(a,1,8))
if(i==a:byte(9))then
t=(a:byte(1)+a:byte(2)*256)
if(t>32767)then t=t-65536 end
t=t*625/10000
local e=""
for t=1,#o do
local t=string.format("%02X",(string.byte(o,t)))
e=e..t
end
table.insert(s,{e,string.format("%.2f",t)})
end
end
a,i,t=nil,nil,nil
if n then n(s)end
end
function e.getTemp(t,a,i,o)
if#e.adrtbl==0 then
e.pin=i or e.pin
e.del=o or e.del
e.getaddrs(t,a)
else
e.askTemp(t,a)
end
end
return e