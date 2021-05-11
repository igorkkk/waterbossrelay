worktmr = tmr.create()

worktmr:alarm(30000, 1, function(t)
    if wth.relaytime == "On" and wth.secure == 'Off' then dofile('timerelay.lua') end
    dofile('mqttpub.lua')(wth)
end)