do
    rtcmem.write32(0, 501)
    m:publish(dat.clnt..'/ip', (wifi.sta.getip()), 0, 1)
    tmr.create():alarm(5500, 0, function() node.restart() end)
end