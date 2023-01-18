prt('\nmqtt pub:')
local a
local t={}
local i=0
a=function(e,o)
e,o=next(t,e)
if e then prt(e,o)end
if e and dat.broker then
m:publish(dat.clnt..'/'..e,o,2,0,function()if a then a(e)end end)
else
if dat.boot then dofile('sendboot.lua')end
end
end
return function(e)
if not dat.broker or not m then prt('Lost Broker')return end
if e then t=e end
for e in pairs(debug.getregistry())do i=i+1 end
t.reg=i
t.heap=node.heap()
a()
end