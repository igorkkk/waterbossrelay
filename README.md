# waterbossrelay

Буду выключать Аквафор Waterboss в периоды постановки дачи на охрану путем чтения данных на MQTT брокере.

Устройство - Sonoff basic switch.

Каждые 12 часов на Waterboss на 10 минут подается напряжение. Согласно документации, фильтр держит в памяти свои настройки 16 часов, потому и подкрмливаю свежим током.

Без выкрутасов с временными включениями, реле просто включается при снятии с охраны, выключается при постановке - в ветке [justswitch][1]

[1]: https://github.com/igorkkk/waterbossrelay/tree/justswitch 