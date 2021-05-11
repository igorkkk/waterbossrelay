local tm = rtctime.epoch2cal(rtctime.get()+3*60*60)
local timetb = {}
timetb[1] = {11, 18}
timetb[2] = {11, 20}
local mm = (tm.min > 9) and tm.min or ('0'..tm.min)
print('\n\nNow '.. tm.hour..':'..mm)
if wth.auto == 'On' and wth.secure == 'Off' then
    if tm.hour == timetb[1][1] and tm.min >= timetb[1][2] and wth.relay == 'On' then
        switch(0)
        prt('\n\t\tRelay off by time')
    end
    if tm.hour == timetb[2][1] and tm.min >= timetb[2][2] and wth.relay == 'Off' then
        switch(1)
        prt('\n\t\tRelay on by time')
    end
end