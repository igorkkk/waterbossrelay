do
local subscribe, merror, mconnect, msg
function subscribe(con)
    l.on()
    dat.broker = true
    con:subscribe(dat.clnt.."/com/#", 0)
    --con:subscribe("ajaxstate/ajaxsecure", 0)
    con:publish(dat.clnt..'/state', "On", 0, 1)
    print("\n\nSubscribed to "..dat.clnt.."/com/# \najaxstate/ajaxsecure \nHeap: "..node.heap())    
end

function merror(con, reason)
    l.on(1)
    dat.broker = false
    print('MQTT Error now!')
    if con then con:close() end
    if m then m:close() end
    do local ct = 0; for k,v in pairs(debug.getregistry()) do ct = ct + 1 end; print('Length = '..ct, 'Heap = '..node.heap()) end
    con, reason, m, ct = nil,nil,nil,nil
    tmr.create():alarm(20000, tmr.ALARM_SINGLE, mconnect)
    return collectgarbage()
end
function msg(con, top, dt)
	if not killtop then killtop = {} end
    top = string.match(top, "/(%w+)$")
    print('Got', top, dt)
    if top and dt then
        table.insert(killtop, {top, dt})
        if not dat.analiz then
            dofile("mqttanalize.lua")
        end
    end
end
function mconnect(t)
    t = nil 
    if (wifi.sta.getip()) then   
        return dofile('mqttmake.lua')(subscribe, merror, msg)
    else
        return merror()
    end
end
mconnect()
end