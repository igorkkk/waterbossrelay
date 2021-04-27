worktmr = tmr.create()

worktmr:alarm(30000, 1, function(t) 
    dofile('mqttpub.lua')(wth)   
end)