--[[
a = dofile('_blink_patt.lua')(2)
dofile('_test_blink.lua')(20, a):start()
dofile('_test_blink.lua')(20, dofile('_blink_patt.lua')(2)):start()
]]

local pat ={
    {1,0},
    {1,0,1,0,0,0,0},
    {1,1,1,1,0,1,0,1,0,0}
}
return function (n)
    n = n or 1
    n = (n > #pat) and 1 or n
    return pat[n]
end