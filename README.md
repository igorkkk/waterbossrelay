# waterbossrelay

Дача на охране => MQTT => Подписчики реагируют.

Дача встала на охрану -  возникает соответствующее сообщение в топике MQTT брокера.

Подписчики, Sonof-реле, выключаются, обесточивая ненужные устройства.

Возможно отключение/включение реле по времени, когда устройство не находится в режиме охраны => править timerelay.lua

Sonof можно включить вручную как кнопкой на нем, так и дистанционно через брокер. Sonof переходит при этом в ручной режим, то есть не реагирует на топик постановки на охрану.

Через Брокер можно вернуть автоматический режим.