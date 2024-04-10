Depending of fastest compatible SPI mode, available modes are:

| QIO | QOUT | DIO | DOUT |
|:---:|:----:|:---:|:----:|
|  ✓  |  ✓   |  ✓  |  ✓   |
|  ✗  |  ✓   |  ✗  |  ✓   |
|  ✗  |  ✗   |  ✓  |  ✓   |
|  ✗  |  ✗   |  ✗  |  ✓   |

## ESP32

| Device             | Flash ID | Fastest Mode
|:-------------------|:---------|:------------
| ESP32-WROOM-32D    | 204016   | DIO
| Shelly Plus 1PM    | 204016   | DIO

## ESP8266

Quad modes (QIO and QOUT) need GPIO 9 and 10. If device uses GPIO 9 or 10 with any function, possibles modes will be only DIO and DOUT.

All devices with an ESP8285 chip supports only DOUT mode because flash is integrated into ESP chip.

| Device             | Flash ID | Fastest Mode
|:-------------------|:---------|:------------
| ESP8285 chips      | All      | DOUT
| DoHome             | 144051   | Unknown
| ESP-01S            | 14325e   | DOUT
| ESP-01S            | 14301c   | Unknown
| ESP-01S            | 1440e0   | QIO
| ESP-01S            | 14605e   | QIO
| ESP-01S            | 1460ba   | DOUT
| ESP-01S            | 1640ef   | QIO
| ESP-12F            | 16400e   | QIO
| ESP-12F            | 164020   | QIO
| ESP-12F            | 16405e   | QIO
| ESPDuino           | 1640e0   | QIO
| Gosund             | 144068   | Unknown
| Shelly             | 15400b   | QIO
| Shelly             | 1540a1   | Unknown
| Shelly             | 1540c8   | QIO
| Shelly             | 1540ef   | QIO
| Shelly             | 15605e   | QIO
| Shelly             | 15701c   | QOUT
| Shelly             | 1620c2   | DOUT
| Smart Home         | 1440a1   | QIO
| Teckin SP22        | 1440a1   | QIO
| TYWE3S             | 1540c8   | QIO
| Wemos              | 1640c8   | DIO
| Wemos              | 1640d8   | QIO
| Wemos              | 1640e0   | QIO

| ESP8285 Devices    | Flash ID
|:-------------------|:-----------
| Gosund             | 144051
| Sonoff             | 14325e
| Sonoff             | 144051
 