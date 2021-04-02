worktmr = tmr.create()
bosstmr = tmr.create()
--------------------

workrelay = function(t)
    t:stop()
    if wth.relay == 'Off' then
        t:interval(dat.shorttime * 1000)
        switch(1)
    elseif wth.relay == 'On' then
        t:interval(dat.longtime * 1000)
        switch(0)
    end
    t:start()
end
bosstmr:register(dat.longtime * 1000, tmr.ALARM_SEMI, workrelay)

runboss  = function(set)
    if set == 'Off' then
        bosstmr:stop()
        switch(1)
    end
    if set == "On" then
        bosstmr:interval(dat.longtime * 1000)
        switch(0)
        bosstmr:start()
    end
end

whattodo = function ()
    if wth.auto == 'Off' then
        bosstmr:stop()
        switch(1)
        return
    end
    
    if wth.isboss == "On" and wth.secure == "On" then
        wth.isboss = "Off"
        runboss("On")
    end
    if wth.isboss == "Off" and wth.secure == "Off" then
        wth.isboss = "On"
        runboss("Off")
    end
end

worktmr:alarm(30000, 1, function(t) whattodo(); dofile('mqttpub.lua')(wth)   end)