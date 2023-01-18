do
local n,o,a,i
function n(e)
dat.broker=true
e:subscribe(dat.clnt.."/com/#",0)
e:subscribe("ajaxstate/ajaxsecure",0)
e:publish(dat.clnt..'/state',"On",0,1)
print("\n\nSubscribed to "..dat.clnt.."/com/# \najaxstate/ajaxsecure \nHeap: "..node.heap())
end
function o(e,t)
dat.broker=false
print('\nMQTT Error now. Lock Garage.\n')
switch(pins.relaySec,0)
if e then e:close()end
if m then m:close()end
do local e=0;for t,t in pairs(debug.getregistry())do e=e+1 end;print('Length = '..e,'Heap = '..node.heap())end
e,t,m,ct=nil,nil,nil,nil
if not getmqtt then
getmqtt=tmr.create()
getmqtt:alarm(20000,tmr.ALARM_SINGLE,a)
return collectgarbage()
end
end
function i(a,e,t)
if not killtop then killtop={}end
e=string.match(e,"/(%w+)$")
print('Got',e,t)
if e and t then
table.insert(killtop,{e,t})
if not dat.analiz then
dofile("mqttanalize.lua")
end
end
end
function a(e)
getmqtt=nil
e=nil
if(wifi.sta.getip())then
return dofile('mqttmake.lua')(n,o,i)
else
return o()
end
end
a()
end