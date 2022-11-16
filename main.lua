worktmr = tmr.create()

worktmr:alarm(30000, 1, function(t)
    do
        local temp = {}
        local pin = pins.ds18
        local del = 750

        function myWork() 
            prt("Got DS18b20: "..#temp)
            -- table.foreach(temp, 
            --     function(k,v)
            --         print("no", k)
            --         table.foreach(v, print)
            --     end)
            if temp[1] and temp[1][2] then
                wth.garahetemp = temp[1][2]
            end
            ds. temp = nil, nil
            package.loaded["_ds18b20"]=nil
            if wth.relaytime == "On" and wth.secure == 'Off' then dofile('timerelay.lua') end
            node.task.post(function() dofile('mqttpub.lua')(wth) end)
        end
        ds = require('_ds18b20')
        ds.getTemp(temp, myWork, pin, del )
    end

end)