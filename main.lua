do
    local counter = 0
    local worktmr = tmr.create()
    worktmr:alarm(1000, 1, function(t)
        counter = counter + 1
        local dt = gpio.read(pins.pinread)
        wth.open = dt == 1 and 'On' or 'Off'
        do
            if counter < 30 then 
                return
            else
                counter = 0
                local temp = {}
                function myWork() 
                    prt("Got DS18b20: "..#temp)
                    if temp[1] and temp[1][2] then
                        wth.garahetemp = temp[1][2]
                    end
                    ds, temp = nil, nil
                    package.loaded["_ds18b20"]=nil
                    if wth.relaytime == "On" and wth.secure == 'Off' and wth.auto == 'On' then dofile('timerelay.lua') end
                    node.task.post(function() dofile('mqttpub.lua')(wth) end)
                end
                ds = require('_ds18b20')
                ds.getTemp(temp, myWork, pins.ds18, 750 )
        
            end
        end
    end)

end