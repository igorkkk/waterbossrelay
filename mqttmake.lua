return function(subscribe, merror, msg)
    m = mqtt.Client(dat.clnt, 45, dat.clnt, 'pass22')
    m:lwt(dat.clnt..'/state', "Off", 0, 1)
    m:on("offline", merror)
    m:on("message", msg)
    print('Connect to', dat.brk, '\nHeap', node.heap())
    m:connect(dat.brk, dat.port, false, subscribe, merror)
end