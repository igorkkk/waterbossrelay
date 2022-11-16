-- Проверяем время и блокируем гараж на ночь
local tm = rtctime.epoch2cal(rtctime.get()+3*60*60)
local timetb = {}
timetb[1] = {23, 0}
timetb[2] = {8, 30}
local mm = (tm.min > 9) and tm.min or ('0'..tm.min)
prt('\n\nNow '.. tm.hour..':'..mm)
if wth.auto == 'On' and wth.secure == 'Off' then
    if tm.hour == timetb[1][1] and tm.min >= timetb[1][2] and wth.relaySec == 'On' then
        switch(pins.relaySec, 0)
        prt('\n\t\tGarage Blocked By Time')
        return
    end
    if tm.hour == timetb[2][1] and tm.min >= timetb[2][2] and wth.relaySec == 'Off' then
        switch(pins.relaySec, 1)
        prt('\n\t\tGarage Unblocked By Time')
    end
end