This section is optional, and default values will be used if you don't use it.

<!-- markdownlint-disable MD013 -->
| Option | Key | Default | Type | Description
|--------|:----:|:------:|------| -----------
| [Invoke setup mode](#buttons-to-invoke-setup-mode) | `"b"` | none | array | Inputs that can be used to enter setup mode
| [Boot delay](#boot-delay) | `"v"` | `0` | float | Set delay in seconds at boot
| [Initial delay](#initial-delay) | `"cd"` | `0` | float | Set delay in seconds before first service creation
| [HomeKit Device Category](#homekit-device-category) | `"ct"` | none | integer | Customized device category
| [Gratuitous ARP Period](#gratuitous-arp-period) | `"e"` | `285` | float | Set a custom Gratuitous ARP packet period
| [Binary Software Input Filter](#binary-input-filter) | `"f"` | `10` | integer | Binary input debounce filter
| [Flex Input Filter](#flex-input-filter) | `"fl"` | none | array | Flex Input Hardware Filter
| [Binary Input Continuous Mode](#binary-input-continuous-mode) | `"c"` | `0` | integer | Binary input continuous mode setting
| [HomeKit Clients](#homekit-clients) | `"h"` | `12` | integer | Maximum number of simultaneous HomeKit Clients
| [Invert Status LED](#invert-status-led-signal) | `"i"` | `1` | integer | Invert status LED GPIO and open-drain options
| [I2C Bus](#i2c-bus) | `"ic"` | none | array | I2C bus declaration
| [I/O Expanders](#io-expanders) | `"mc"` | none | array | I/O GPIO Expansion interfaces
| [GPIOs Configuration Array](#gpios-configuration-array) | `"io"` | none | array | Array to declare all GPIO behaviors
| [NTP Server](#ntp-server) | `"ntp"` | Gateway IP Address | string | NTP Server to get current date and time
| [Timezone](#timezone) | `"tz"` | `"UTC0"` | string | Timezone to set internal clock
| [Timetable Actions](#timetable-actions) | `"tt"` | none | array | Actions that occur when configured time and date
| [Status LED GPIO](#status-led) | `"l"` | none | integer | GPIO pin for status LED
| [Setup mode timeout](#setup-mode-timer) | `"m"` | `0` | integer | Time after boot setup mode can be invoked
| [Hostname](#custom-hostname) | `"n"` | `"HAA-XXXXXX"` | string | Set a custom hostname in DHCP option
| [Log output](#log-output) | `"o"` | `0` | integer | UART and network log output type
| [Log server](#log-server) | `"ot"` | `"255.255.255.255:45678"` | string | Host and port to send UDP network logs
| [Ping Action Period](#ping-action-period) | `"pt"` | `5` | float | Time between ping actions
| [Ping Gateway Watchdog](#ping-gateway-watchdog) | `"w"` | disabled | integer | Network watchdog action
| [Software PWM Frequency](#software-pwm-frequency) | `"q"` | `305` | integer | Set a custom software PWM frequency
| [Hardware PWM Frequency](#hardware-pwm-frequency) | `"y"` | `[5000,5000,...]` | array | Set custom hardware PWM frequencies
| [Zero Cross GPIO](#zero-cross-gpio) | `"zc"` | none | array | Configure Zero-Cross GPIO
| [HAA Setup Service](#haa-setup-service) | `"s"` | `1` | integer | Set accessory number where HAA Setup Service will be
| [UART Configuration](#uart-configuration) | `"r"` | none | array | UART configuration settings
| [IR Configuration](#infra-red-configuration) | `"t"`<br>`"j"`<br>`"x"`<br>`"p"` | none | integer<br>integer<br>integer<br>string | Infra-red configuration settings
| [Serial Number Prefix](#cerial-number-prefix) | `"sn"` | `XXXXXX-<Acc#>` | string | Customise serial number provided to HomeKit on pairing
| [WiFi Sleep Mode](#wifi-sleep-mode) | `"d"` | `1` | integer | Select WiFi Sleep mode for power save (Only ESP32 models)
| [WiFi Bandwidth 40MHz](#wifi-bandwidth-40mhz) | `"dt"` | `0` | integer | Enable Wifi bandwidth 40MHz (Only ESP32 models)
| [mDNS TTL](#homekit-mdns-ttl) | `"ttl"` | `[4500,2250]` | array | mDNS configuration
| [Unsecure HomeKit Rest API](#enable-unsecure-homekit-rest-api) | `"u"` | `0` | integer | Enable / Disable HomeKit unencrypted Rest API
| [Setup Mode Toggle Count](#setup-mode-toggle-count) | `"z"` | `8` | integer | Count of times I/O must be toggled to enter setup mode
<!-- markdownlint-enable MD013 -->

Each of the above configuration options are described below, along with their
default values.

Additional to the above list of configuration options a set of [Device Actions](#device-actions)
can be configured to be taken when specific device events occur.

## Log Output

| Key | Value | Description |
|:----:|:-----:|:---|
| `"o"` | `0` | **Disable log output (_default_)**
| | `1` | Enable UART0 log output
| | `2` | Enable UART1 log output
| | `3` | Enable UART2 log output (Only ESP32 models)
| | `4` | Enable Network log output. View with `nc -kulnw0 45678`
| | `5` | Enable UART0 & Network log output
| | `6` | Enable UART1 & Network log output
| | `7` | Enable UART2 & Network log output (Only ESP32 models)
| | `8` | Enable Network log output with buffer
| | `9` | Enable UART0 & Network log output with buffer
| | `10` | Enable UART1 & Network log output with buffer
| | `11` | Enable UART2 & Network log output with buffer (Only ESP32 models)

The new _Advanced Logger Library_ was implemented in HAA v2.4.0.
This library provides additional options for outputting log information and
supports the new UART configurations  added in v2.1.0. You can now choose to
disable logs, output them to serial ports, the network, or both.

If you are not intending to view or capture logs then it is recommended to
leave the option as the default (`"o":0`) i.e. disable log output.

Enabling log output is only useful if you need to see what the firmware is doing.

When enabling serial port logging ensure that you have a terminal attached to
the UART output. In order to view the output.

Remember to [configure used UART](#uart-configuration) when enabling serial port logging.

If network logging is enabled then the log output can be captured and viewed
using the following command on macOS or GNU/Linux:

```shell
nc -kulnw0 45678
```

**NOTE:** Network logs can impact system stability. If you want to use network logs for
a long time, buffered options are recommended (8, 9, 10 and 11), but they take more RAM memory.

## Log server

| Key | Value | Description |
|:----:|:-----:|:---|
| `"ot"` | `"255.255.255.255:45678"` | **Server and port to send UDP logs (_default_)**
| | `"<server>:<port>"` | Override default server and port to send UDP logs

Use `"ot":"<server>:<port>"` option to specify destination address for network logs, 
and port. A FQDN hostname can be used.

## Status LED

| Key | Value | Description |
|:----:|:-----:|:---|
| `"l"` | none | **No status LED  (_default_)**
| | `GPIO #` | GPIO line the status LED is connected to

Set the GPIO pin used for LED status information. If you are using Sonoff
devices, the LED is usually connected to GPIO 13 e.g. `{"l": 13}`

Remember to declare used GPIO as Output into `"io":[...]` array. See [GPIOs Configuration](gpios-configuration)

| Blinks | Description |
|:------:|:------------|
| `1` | Accessory changes status
| `2` | End of initial boot process
| `3` | WiFi disconnected
| `4` | Connected to WiFi
| `5` | Reboot / TH sensor error
| `6` | Identify
 
## Invert Status LED Signal

| Key | Value | Description |
|:----:|:-----:|:---|
| `"i"` | `0` | Do not invert
| | `1` | Invert **(_default_)**

Set the activation level for the LED GPIO output. On a Sonoff device the LED
GPIO is usually active low, so you will need to invert the output of the GPIO
in order to ensure the LED lights when enabling the output e.g. `{"i": 1}`,
but since the default is `1` this option can be omitted from the string to save
device memory.

## Buttons to Invoke Setup Mode

| Key | Value | Description |
|:----:|:-----:|:---|
| `"b"` | none | **No button array (_default_)**

If your device has one or more buttons and you want to use any of them to have
a physical means of invoking the setup mode then you will need to define `"b"`
to contain a list of those buttons and the action that will cause setup mode
to be entered e.g.

```json
{
  "c": {
    "io": [ [ [ 13 ], 2 ], [ [ 0 ], 6 ] ],
    "l": 13,
    "b": [ [ 0, 5 ] ]
  }
}
```

In this example the binary input `"b"` key contains a single definition of a
button connected to GPIO 0 and configured with a press type 5, of
`Hold for 8 seconds`.

See here for more examples of different [press types](accessory-configuration#press-type).

To understand more about defining binary inputs refer to
[binary input declarations](accessory-configuration#binary-inputs).

## Binary Input Filter

| Key | Value | Description |
|:----:|:-----:|:---|
| "f" | 10 | **Soft debounce (_default_)**

The binary software input filter `"f"` can be set to any integer value between 10 (soft)
and 2550 (hard) to avoid interference such as debounce from the input when a button
pressed.

**NOTE: The binary software input filter value is used for all binary inputs defined in the MEPLHAA script.**

## Flex Input Filter

_Only available in ESP32-C6._

Chip provides 8 hardware flexible input filters, whose duration is configurable. Each of them can be applied to any input GPIO. However, applying multiple filters to the same GPIO does not make difference from one.

| Key | Value | Description |
|:----:|:-----:|:---|
| `"fl"` | `[ [ GPIO, Threshold, Width ], [ ... ] ]` | Array of flex input filters

- `GPIO`: Number of GPIO to apply filter.
- `Threshold`: Threshold time in nanoseconds (Integer). 
- `Width`: Width time in nanoseconds (Integer). 

During window Width, any pulse whose width is shorter than window Threshold will be discarded. Please note that you can not set Threshold time bigger than Width time.

Please note, the glitch filter and flex filter are independent. You can enable both of them for the same GPIO.

## Binary Input Continuous Mode

| Key | Value | Description |
|:----:|:-----:|:---|
| `"c"` | `0` | **Disable (_default_)**
|  | `1` | Enable

By default, Binary Input Continuous Mode is not used because HAA uses ISRs (Hardware interruptions) to detect changes in input GPIOs. But there are some GPIOs that don't allow hardware interruptions, like GPIO 16 of ESP8266. Use of I/O expanders as input are incompatible with interruptions too, and GPIOs using pulse mode. In these cases, it is needed to enable Continuous Mode to avoid use of hardware interruptions.

To summarize, Binary Input Continuous Mode must be enable for any of these cases:
- Using a GPIO as input button/switch that doesn't allow ISR, like GPIO 16 of ESP8266.
- Using a GPIO as input button/switch with pulse mode.
- Using an expansion interface as inputs buttons/switches.

## Custom Hostname

| Key | Value | Description |
|:----:|:-----:|:---|
| "n" | string | Custom hostname to use for the device

This option enables you to change the hostname of a device. By default the
hostname is set to `HAA-XXXXXX` where "XXXXXX" are the last 6 characters of the
Ethernet MAC address of the device.

If you want to use a friendly name to identify your device in your router's DHCP
list etc. then put it in this option.

```json
{
  "c": {
    "io": [ [ [ 13 ], 2 ], [ [ 0 ], 6 ] ],
    "l": 13,
    "b": [ [ 0, 5 ] ],
    "n": "sonoff-laptop"
  }
}
```

In the above example the device hostname has been set to a _friendly name_ of
"sonoff-laptop".
The custom hostname must be in quotes and and must not use special characters or
blank spaces. Refer to [Hostnames](hostname) to
get more details on valid hostnames.

**NOTE: During initial device setup i.e. after factory reset or very first
boot, the name will be `HAA-XXXXXX`.**

## Gratuitous ARP Period

| Key | Value | Description |
|:----:|:-----:|:---|
| `"e"` | `1.5` to `382.5` | 285 Seconds **(_default_)**
|       | `0` | Disable Gratuitous ARP

HAA sends a Gratuitous ARP packet (GARP) each 285 seconds, by default, to prevent ARP spoofing attacks and keep WiFi connectivity. Normally, switches and routers have an ARP TTL of 300 seconds. Using a very low value, like `"e":3`, could help to keep WiFi connectivity and avoid disconnections in noise environments.

## Software PWM Frequency

| Key | Value | Description |
|:----:|:-----:|:---|
| `"q"` | `1` to `2000` | **305 Hz (_default_)**

This option enables the setting of a custom software PWM frequency in Hz. The value can
be set from 1 to 2000. The default is 305 Hz.

A custom PWM frequency is predominantly used when controlling lighting. Setting `"q"` 
to lower values may result in lights blinking very fast.

## Hardware PWM Frequency

Only for ESP32 models.

| Key | Value | Description |
|:----:|:-----:|:---|
| `"y"` | `[ freq_0, freq_1, ... ]` | Array of frequencies for each PWM timer
| |`1` to `29000` | **5000 Hz (_default_)**

This option enables the setting of custom hardware PWM frequencies in Hz for each PWM timer. The value can
be set from 1Hz to 29KHz. The default is 5KHz.

A custom PWM frequency is predominantly used when controlling lighting. Setting `"y"` 
to lower values may result in lights blinking very fast.

## Zero Cross GPIO

Enables Software PWM to be used by Zero-Cross detection. [PWM Frequency](#custom-pwm-frequency) should be double of AC frequency, and even a bit more (Double + 10%). For example, for AC 50Hz, a right value of [PWM Frequency](#custom-pwm-frequency) could be `"q" : 110`.

| Key | Value | Description |
|:----:|:-----:|:---|
| `"zc"` | array | `[ GPIO, Interruption type ]`

- GPIO: Number of GPIO where Zero-Cross pin is connected.

Remember to declare used GPIO as Input into `"io":[...]` array. See [GPIOs Configuration](gpios-configuration)

- Interrupt type:
Depending of how Zero-Cross hardware works, it is necessary to select correct interrupt. Normally, `HIGH to LOW` is the recommended value.

| Type | Description |
|:-----:|:------------|
| `1` | LOW to HIGH
| `2` | HIGH to LOW
| `3` | Both

## HAA Setup Service

Determines Accessory number (not Service) where HAA Setup Service will be placed. This service is only compatible with [HAA Home Manager](haa-home-manager) App, to update, enable setup mode, reboot...

| Key | Value | Description |
|:----:|:-----:|:---|
| `"s"` | `1` | **Put at first Accessory(_default_)**
|     | `0` | Removes HAA Setup Service
|     | `N` | Put at Accessory number N

By default, service is placed at first accessory. But in some cases it is useful to put it in other accessory, for example, when first accessory has a TV Service, that is not showed in HomeKit third-party Apps.

A value of `0` will disable HAA Setup Service. Useful to save DRAM when [HAA Home Manager](haa-home-manager) App is not used.

## I2C Bus

You can declare up to 2 different I2C buses. To declare them, you must use `"ic"` 
key in configuration section. It contains an array of I2C buses.

Each bus must have these settings:
```
[ SCL, SDA, Frequency, SCL pull-up,  SDA pull-up ]
```

  - `SCL`: SCL GPIO.
  - `SDA`: SDA GPIO.
  - `Frequency`: Bus frequency in KiloHertz.
  - `SCL pull-up`: Internal SCL GPIO pull-up resistor. `0` disable, `1` enable.
  - `SDA pull-up`: Internal SDA GPIO pull-up resistor. `0` disable, `1` enable.

`SCL pull-up` and `SDA pull-up` are optional. Default value is `0` for both.

First declared bus will be bus 0, and second will be bus 1.

Example:
```json
"ic" : [ [ 3, 2, 80, 1, 1 ], [ 13, 14, 500 ] ]
```

## IO Expanders

IO Expansion interfaces are used to add extra GPIOs for inputs and outputs. They must declare in configuration section using `"mc"` key. It is an array that contains all connected expansion interfaces.

MCP23017 and Shift Registers are supported:

### MCP23017 Interface

You can connect up to 16 MCP23017 interfaces (8 per I2C bus), having up to 256 extra GPIOs for binary 
inputs and outputs. I2C bus must be declared to use these interfaces.

Each MCP23017 interface must be declared with an array:
```
[ Bus, Address, Channel A, Channel B ]
```

Example of 2 MCPs declaration (first for inputs and second for outputs):
```json
"mc" : [ [ 0, 32, 256, 256 ], [ 0, 33, 0, 0 ] ]
```

Channel A and B are optional. If they are missed, default value is `258`.
  - `Bus`: I2C Bus.
  - `Address`: Access address. First MCP23017 begins at 32. MCP address is configured using `A2`, `A1` and `A0` pines. FInal address will be `32 + (A2, A1, A0)`; where A2, A1 and A0 represent a binary number of 3 bits, and each bit is 0 or 1 depending is pin is connected to GND or VCC.
  - `Channel A`: from 0 to 259. Mode and initial state of all channel A GPIOs.
  - `Channel B`: from 0 to 259. Mode and initial state of all channel B GPIOs.

Channel config values (Default `0`):
  - `0 - 255` : OUTPUT. Values are the result of convert 8 bits binary string to decimal.

For example, to set all channel A GPIOs to LOW, but second GPIO to HIGH, you must 
use `00000010` in decimal: `2`.

  - `256 - 259` : INPUTs
    - `256` : INPUT with internal pull-up resistor.
    - `257` : INPUT with internal pull-up resistor, inverted logic.
    - `258` : INPUT without internal pull-up resistor. Use this if channel is not used.
    - `259` : INPUT without internal pull-up resistor, inverted logic.

Remember to activate [Binary Input Continuous Mode](#binary-input-continuous-mode) in order to work with INPUTs.

### OUTPUT Shift Register

You can connect one shift register, or a daisy-chained group of them, for each 3 GPIOs (or 2 if shift register does not use latch pin). Each shift register can manage up to 100 OUTPUTs (from 0 to 99).

To declare a shift register as OUTPUT, declare it as:
```
[ Clock GPIO + 100, Data GPIO, Latch GPIO, Length, Initial values 1, Initial values 2, ... ]
```

- `Clock GPIO + 100`: Signal clock. If you want to use GPIO 5, this will be `105`. By default, it is declared as OUTPUT.
- `Data GPIO`: Pin to send bit states to shift register. By default, it is declared as OUTPUT.
- `Latch GPIO`: Pin to send order to activate sent data. If `Latch GPIO` is not needed, set this as `-1`. By default, it is declared as OUTPUT.
- `Length`: Numbers of bits/outputs of shift register of daisy-chained group. Maximum value is `100` (from 0 to 99).
- `Initial values`: Each default value is a 8 bits number that correspondes to initial output states. Default value is `0`.

### INPUT Shift Register

You can connect one shift register, or a daisy-chained group of them, for each 2 GPIOs. Each shift register can manage up to 100 INPUTs (from 0 to 99).

Remember to activate [Binary Input Continuous Mode](#binary-input-continuous-mode) in order to work with INPUTs.

To declare a shift register as INPUT, declare it as:
```
[ Clock GPIO + 100, Data GPIO, -2, Length ]
```

- `Clock GPIO + 100`: Signal clock. If you want to use GPIO 5, this will be `105`. By default, it is declared as OUTPUT.
- `Data GPIO`: Pin to read bit states to shift register. By default, it is declared as INPUT, floating.
- `Length`: Numbers of bits/outputs of shift register of daisy-chained group. Maximum value is `100` (from 0 to 99).

_It is possible to override shift registers default GPIOs type declarations in `"io":[ ... ]` [GPIOs Configuration Array](#gpios-configuration-array)._

### Usage of IO Expander

Use `"r":[ pin, value ]` with I/O expander index and GPIO number. For example: GPIO 12 of first declared IO expander will be `112`.

To call a GPIO from a expansion interface, you must use normal `"r":[ pin, value ]` array. 
ESP8266 GPIOs are from 0 to 16, but expander GPIOs are used in this format: `XYY`
  - X: is the index of expansion interface in MEPLHAA script.
  - YY: is the number of GPIO. (For MCP23017, Channel A GPIOs are from 00 to 07; and channel B, from 08 to 15).

For example, to set to HIGH GPIO 4 of third declared expansion interface:
```json
"r" : [ [ 304 , 1 ] ]
```

## GPIOs Configuration Array

Since HAA V12 Merlin, used GPIOs must be declared into an array with needed options, initial values, and behaviors.

See [GPIOs Configuration](gpios-configuration) page to know details.

## NTP Server

HAA has an internal software clock to write a timestamp in logs and to perform
timedate based actions. Because ESP8266 has not a RTC with a battery, it is needed
to get date and time information from a NTP server.

<!-- markdownlint-disable MD013 -->
| Key | Value | Description |
|:----:|:-----:|:---|
| "ntp" | Gateway IP Address | **Gateway IP address provided by DHCP server (_default_)**
|  | `"0"` | Disable NTP entirely. This will disable TimeTable Actions too.
|  | Any | String with desired NTP server (IP Address or FQDN)
<!-- markdownlint-enable MD013 -->

Example: 
```json
"ntp" : "time.apple.com"
```

If configured or default NTP server fails twice, HAA will use `pool.ntp.org` as fallback server.

## Timezone

<!-- markdownlint-disable MD013 -->
| Key | Value | Description |
|:----:|:-----:|:---|
| "tz" | "UTC0" | ** Default**
|  | Any | String with timezone in UNIX style
<!-- markdownlint-enable MD013 -->

Timezone for Europe/Paris with daylight saving time:
```json
"tz" : "CET-1CEST-2,M3.5.0/2,M10.5.0/3"
```

## Timetable Actions

These actions will occur only if there is a working NTP server to get current date and time.

<!-- markdownlint-disable MD013 -->
| Key | Value | Description |
|:----:|:-----:|:---|
| "tt" | [ [ A, h, m, W, D, M ], ... ] | Array of arrays with all [device actions](#device-actions) and timetable declarations
|  | A | [Device action](#device-actions) to exec, from `0` to `50`
|  | h | Hour, from 0 to 23
|  | m | Minute, from 0 to 59
|  | W | Day of the week, from 0 (Sunday) to 6 (Saturday)
|  | D | Day of the month, from 1 to 31
|  | M | Month, from 0 (January) to 11 (December)
<!-- markdownlint-enable MD013 -->

If action must occur in all units, value of `-1` must be used.

There is not needed to declare all timedate units. Missing units will take default value of `-1`.

## Setup Mode Toggle Count

Setup mode toggle count was introduced in firmware version `0.8.7`
<!-- FIXME: Remove this line after July 2020 -->

<!-- markdownlint-disable MD013 -->
| Key | Value | Description |
|:----:|:-----:|:---|
| "z" | 8 | **Number of times I/O line needs to be toggled (_default_)**
|  | 0 - 127 | Integer value specifying number of togglations
<!-- markdownlint-enable MD013 -->

One way to enter setup mode is to toggle the I/O line of one of the buttons
defined for [entering setup mode](#buttons-to-invoke-setup-mode).

This option allows the configuration of the number of times to toggle the I/O.
A value of `0` will disable this method of entering setup mode.

## Setup Mode Timer

| Key | Value | Description |
|:----:|:-----:|:---|
| "m" | 0 | **Disable. Always respond to setup mode requests (_default_)**
|  | 1 - 65535 | Integer value specifying number of seconds

This option specifies the time in seconds that the user has to enter setup mode
after a device boot. Any value between `0` (disable) and `65535` can be set.
See [Setup Mode](setup-mode#entering-setup-mode) for details on how to enter
the mode.

If this option is set then once the time has passed after a reset the user will
not be able to enter setup mode without rebooting the device.

```json
{
  "c": {
    "io": [ [ [ 13 ], 2 ], [ [ 0 ], 6 ] ],
    "l": 13,
    "b": [ [ 0, 5 ] ],
    "m": 10
  }
}
```

In this example the Setup Mode Timer has been set to `10 seconds` (`"m": 10`).
Beware not to set it to a value to less than 8 if you are using option `"b"`
with a long press button of 8 seconds (`"t": 5`)...

# Boot delay

The Delay at boot option, before any hardware configuration or GPIO setup has been done, is defined by the `"v"` key.

| Key | Default | Type | Description |
|:----:|:------:|:-----|-------------|
| "v" | 0 | float | Time in seconds to delay before first accessory creation

Useful when peripherals and external hardware need more time to boot than ESP chip.

# Initial delay

The Delay before services creation option is defined by the `"cd"` key.

| Key | Default | Type | Description |
|:----:|:------:|:-----|-------------|
| "cd" | 0 | float | Time in seconds to delay before first accessory creation

By default accessories are created within HAA immediately after boot.
There are times when a delay is required to allow some hardware to be ready.

When this is required the `"cd"` option can be used. Set it to a positive value
in seconds and a delay of that time will occur once the device has booted.

The option only needs to be added if a delay is required. If it
is not present then no delay will be executed.

## HomeKit Clients

| Key | Value | Description |
|:---:|:-----:|:---|
| "h" | 12 | **Maximum number of simultaneous Homekit Clients (_default_)**
|     | 0 | Disable HomeKit Server
|     | 2 - 12 | 

The `"h"` option allows you to change maximum number of simultaneous HomeKit clients that
can connect to device, or completely disable the HomeKit server component.

HomeKit clients are iPhones, iPads, Macs, HomePods, AppleTVs and AppleWatches.

By default, up to 20 concurrent clients can be connected; and allowing to connect new clients while 
dropping others. Then, there is not limit of clients to connect, but new clients access will be
a bit slower than connected clients. If there are many HomeKit clients, it is possible to increase
this limit to let more clients to connect before dropping others, but this will use more DRAM.

## Enable Unsecure HomeKit Rest API

| Key | Value | Description |
|:----:|:-----:|:---|
| "u" | 0 | **Disable Unsecure Rest API (_default_)**
| | 1 | Enable Unsecure Rest API

This option enables the use of HomeKit third-party tools without an encrypted
connection or authentication.

Enabling this is **NOT** recommended for security reasons, because your accessory
will be exposed without any security mechanism, but you can use this feature
to manage it under other domestic systems.

You can use commands like these:

Get current accessory status:

``` text
curl -X GET http://device_ip_address:5556
```

Set a "turn on" status of accessory with aid 1 and iid 9:

``` text
curl -X PUT -d '{"characteristics":[{"aid":1,"iid":9,"value":true}]}' http://device_ip_address:5556/characteristic
```

You can download HomeKit specifications to know how to build its JSON from
here: <https://developer.apple.com/homekit/specification/>

<!-- TODO:: Add a new section on controlling your device via the REST API -->

## WiFi Sleep Mode

Only ESP32 models. ESP8266 has not wifi sleep DTIM mode.

Option to enable or disable WiFi Modem sleep. By default, WiFi driver will use router DTIM beacon to transmit and receive data; but some networks can be incompatible with this, and disable WiFi sleep modem is needed.

| Key | Value | Description |
|:----:|:-----:|:---|
| `"d"` | `1` | **Enable WiFi Modem Sleep (_default_)**
| | 0 | Disable WiFi Sleep


## WiFi Bandwidth 40MHz

Only ESP32 models. ESP8266 has not wifi bandwidth 40MHz.

By default, wifi bandwidth is 20MHz. It is enough for all HAA network traffic, and to mitigate interferences.

It is possible to select 40MHz, but only for HAA Main firmware running in normal mode.

Installer firmwares and setup modes will use only 20MHz to maximize compatibility and minimize interferences.

| Key | Value | Description |
|:----:|:-----:|:---|
| `"dt"` | `0` | **Wifi Bandwidth 20MHz (_default_)**
| | 1 | Wifi Bandwidth 40MHz

## HomeKit mDNS TTL

Configurable option to set the TTL value of the mDNS entry held for the device.

This option was implemented in firmware version `2.2.0`
<!-- FIXME: Remove this line after September 2020 -->

| Key | Format | Type | Description |
|:---:|:-------:|:----:| ----------- |
| `"ttl"` | `[ TTL, period ]` | array | HomeKit mDNS Time To Live and period
|         | `16 - 65535` | seconds | Min - Max values for TTL and period

Default: `"ttl" : [ 4500, 2250 ]`

If period is not given, it will be same value as TTL.

Setting period to a very low value such as `"ttl" : [ 4500, 120 ]` could be used as a workaround
for networks without a good mDNS support.

## Serial Number Prefix

This option was implemented in firmware version `3.5.0`
<!-- FIXME: Remove this line after February 2021 -->

| Key | Default | Type | Description |
|:---:|:-------:|:----:| ----------- |
| "sn" | XXXXXX-<Acc#> | string | Serial Number Prefix

This option enables you to add a prefix to the serial number supplied to HomeKit
when pairing a device.

Prior to release `3.5.0` the serial number provided for each accessory when
pairing a device was of the format `HAA-XXXXXX` where the _XXXXXX_ part
consists of the last 6 characters of the devices MAC address e.g. `HAA-669CD4`.
From `3.5.0` onwards the serial number provided is of the format
`XXXXXX-<Acc#>`. Where _<Acc#>_ is the configured accessory number e.g. `669CD4-1`.
This change enables applications such as [Home Assistant](https://home-assistant.io)
to recognise the multiple accessories within a device (NOTE: the Apple Home App has
always been lenient on the serial number, but recommends a unique serial number
for each device/accessory).

The user also has the option to prefix the serial number provided with their own
string e.g. `{ "sn": "ABC" }`. This would result in a serial number of
`ABC-669CD4-1`

Additionally, if you specify a prefix of `{ "sn": "cn" }` the HomeKit config
number will be used as the prefix. The config number will be incremented each
time the _Save_ button is pressed in the Setup page and after the device's
firmware is updated e.g. `1-669CD4-1`, `2-669CD4-1`

Setting this option in the General Configuration section will apply it to all
accessories.

**NOTE** This option can also be placed in an accessory's configuration section.
If used in the [Accessory Configuration](accessory-configuration) section then it
will override any value that has been set as part of the General Configuration.

## Ping Action Period

This option was implemented in firmware version `2.2.0`
<!-- FIXME: Remove this line after September 2020 -->

| Key | Default | Type | Description |
|:---:|:-------:|:----:| ----------- |
| "pt" | 5 | float | Period between pings

This option enables you to configure the period between pings being transmitted
by an accessory that determine actions to take or statuses to set.

The value is a float and so fractions of a second can be specified e.g. `"pt": 0.5`

## Ping Gateway Watchdog

_This option was implemented in firmware version `2.5.0`_
<!-- FIXME: Remove this line after September 2020 -->

| Key | Default | Type | Description |
|:---:|:-------:|:----:| ----------- |
| "w" | disabled | integer | Number of consecutive ping failures before reconnection

When this option is added to the general configuration the device will monitor
the network by performing an ICMP ping to the gateway every second.
If the configurable number of consecutive ping failures occur then the device
will start the connection process again.

This feature is disabled by default. If enable, default [Gratuitous ARP](#gratuitous-arp-period) will be disabled. 
To enable [Gratuitous ARP](#gratuitous-arp-period), it must be declare explicitly.

**NOTE:** If a value of 0 is used (`"w":0`) then the device will attempt to
reconnect after the first ping failure.

## Infra-red Configuration

| Key | Default | Type | Description
|:----:|:------:|------| -----------
| "t" | none | integer | GPIO used by the IR Tx LED **(Mandatory)**
| "j" | 0 | integer | Use to invert IR Tx LED state **(_default: 0_)**
| "x" | 38 | integer | Frequency (in KHz) of IR marks
| "p" | none | integer | IR protocol to use

When using your device to transmit infra-red commands to control other devices
you need to, **as a minimum**, set the `"t"` option to define the GPIO
pin that the infra-red transmitter is connected to.

Remember to declare used GPIO as Output into `"io":[...]` array. See [GPIOs Configuration](gpios-configuration)

The `"j"` option is used to invert the state of the IR Tx LED GPIO pin and configure open-drain HIGH output.

| Key | Value | Description |
|:----:|:-----:|:---|
| `"j"` | `0` | Do not invert **(_default_)**
| | `1` | Invert
| | `2` | Do not invert and set as open-drain
| | `3` | Invert and set as open-drain

The `"x"` option allows you to define the frequency in Kilohertz (KHz) that the
IR LED flashes. The default is 38KHz.
This frequency is used by the majority of infra-red controllers on the market
today.

The `"p"` option allows you to define the default IR protocol.
This protocol will be used by any IR Code Actions unless the action specifies
an alternate protocol using the `"p"` option in the action object.

| Protocol | Setting |
|----------|---------|
| 2 bits | `"p":"HHHH00001111FF"` |
| 4 bits | `"p":"HHHH0000111122223333FF"` |
| 6 bits | `"p":"HHHH000011112222333344445555FF"` |

Refer to the [IR Code Actions](accessory-configuration#send-ir-code-actions) section
in the Accessory Configuration details for information on defining IR code actions.

Refer to the [Using Infra-red in HAA](haa-infra-red) for details on defining the
protocol and protocol codes.

## UART Configuration

| Key | Default | Type | Description
|:----:|:------:|------| -----------
| "r" | none | array | Array of UARTs for use with [UART Actions](accessory-configuration#uart-actions)

Your device can use up to two UART ports to control accessories.
To use UART ports you must configure them within the General Configuration and
then use [UART Actions](accessory-configuration#uart-actions) to send commands,
but can not get status from your attached accessory.

### Example

``` json
{
  "c":{
    "io": [ [ [ 13 ], 2 ], [ [ 0 ], 6 ] ],
    "l": 13,
    "b": [ [ 0, 5 ] ],
    "r": [
      { "n":0, "s":9600, "p":0, "b":0 }
    ]
  }
}
```

In this example UART0 has been set up to communicate at 9600 baud, no parity
and 0 stop bits.

In esp8266, the UART will use GPIO lines 1 & 3 for communication.

### UART Number

This option was implemented in firmware version `2.1.0`
<!-- FIXME: Remove this line after September 2020 -->

The `"n"` key is used to define up to two UARTs can be configured and used to
control accessories.
In **ESP8266**, there are 2 UARTs. UART0 supports both receive and transmit, UART1 supports only transmit.

| Key | Value | Description |
|:----:|:-----:|:---|
| `"n"` | `0` | UART0, using GPIO 1 (_Tx_) & 3 (_Rx_)
| | `1` | UART1, using GPIO 2 (_Tx_)
| | `2` | UART0, using GPIO 15 (_Tx_) & 13 (_Rx_)
| | `10` | Same as `0`, but enabling [Free Monitor Receiver](free-monitor#23-24-and-25-uart-receiver)
| | `12` | Same as `2`, but enabling [Free Monitor Receiver](free-monitor#23-24-and-25-uart-receiver)

In **ESP32** models, there are 3 UARTs with receive and transmit support.

| Key | Value | Description |
|:----:|:-----:|:---|
| "n" | 0 | UART0
| | 1 | UART1
| | 2 | UART2
| | 10 | Same as `0`, but enabling [Free Monitor Receiver](free-monitor#23-24-and-25-uart-receiver)
| | 11 | Same as `1`, but enabling [Free Monitor Receiver](free-monitor#23-24-and-25-uart-receiver)
| | 12 | Same as `2`, but enabling [Free Monitor Receiver](free-monitor#23-24-and-25-uart-receiver)

### UART GPIOs (Only ESP32 models)

ESP32 can use any combination of GPIOs with UARTs. There is not default GPIOs, then it is mandatory to declare used GPIOs into 
an array `"g":` for each UART port.

`"g" : [ TX, RX, RTS, CTS ]`

Pins that are not used must be declared with `-1`, or don't declare them, using a shorter array.

For example, if you only want to use UART TX pin with GPIO 1, because it will be only used for output, you can declare array as:

`"g" : [1]`

Or if only RX pin will be used at GPIO 3:

`"g" : [ -1, 3]`

### Mode (Only ESP32 models)

UART supports different modes.

| Key | Value | Description |
|:----:|:-----:|:---|
| "m" | 0 | UART/RS232 **_default_**
| | 1 | RS485 Half duplex
| | 2 | IrDA

### Speed (Baudrate)

The `"s"` key is used to set the baudrate of the UART.
The following baudrates are supported:

| Key | Value | Description |
|:----:|:-----:|:---|
| `"s"` | 460800 | Only ESP32 models
| | 230400 | Only ESP32 models
| | 115200 | **_default_**
| | 57600 |
| | 38400 |
| | 19200 |
| | 14400 |
| | 9600 |
| | 4800 |
| | 2400 |
| | 1200 |

### Parity

The `"p"` key is used to set the parity of the UART.
The following options are supported:

| Key | Value | Description |
|:----:|:-----:|:---|
| "p" | 0 | **None (_default_)**
| | 1 | Even
| | 2 | Odd

### Stop Bits

The `"b"` key is used to set the stop bits of the UART.
The following options are supported:

| Key | Value | Description |
|:----:|:-----:|:---|
| "b" | 0 | 0 bits
| | 1 | 1 bit **(_default_)**
| | 2 | 1.5 bits
| | 3 | 2 bits

### UART Receiver Lengths

Option to configure minimum and maximum length of received UART commands when UART Receiver is used.
```
"l" : [ min , max ]
```

Values must be between `1` and `255`. And `min` value can not be greater than `max` value.

## Device Actions

This option was implemented in firmware version `3.3.0`
<!-- FIXME: Remove this line after November 2020 -->

Certain actions can occur when specific events happen within the device. These
actions are called Device Actions and are documented below.

Available Device events are:

<!-- markdownlint-disable MD013 -->
| Event | Key | Description |
|:----|:-----------:|:------------|
| [Boot](#device-actions) | "0" | Actions to occur at the boot of a device
| [Post Accessory Declaration](#device-actions) | "1" |  Actions to occur after accessory declaration
| [First WiFi Connection](#device-actions) | "2" | Actions to occur after first WiFi connection
| [WiFi Reconnection](#device-actions) | "3" | Actions to occur on a WiFi reconnection
| [WiFi Disconnection](#device-actions) | "4" | Actions to occur on a WiFi disconnection
| [WiFi Disconnection After Retry](#device-actions) | "5" | Actions to occur after about 5 minutes without a WiFi reconnection
| New WiFi Channel | "6" | Actions to occur when WiFi channel has changed
| New IP Address | "7" | Actions to occur when IP address has changed
<!-- markdownlint-enable MD013 -->

See [Actions](accessory-configuration#actions) for details on the actions that
can be defined for each of the above events.

Additional device actions can be declared to use with [Timetable Actions](#timetable-actions), up to action `"50"`.

### Device Action Example

In this example the device is configured to turn on an LED (GPIO 14) when the
device has WiFi connectivity and turn it off when connectivity is lost.

``` json
{
  "c": {
    "io": [ [ [ 13, 12, 14 ], 2 ], [ [ 0 ], 6 ] ],
    "l": 13,
    "2": {  "r": [ [ 14, 1 ] ] },
    "3": {  "r": [ [ 14, 1 ] ] },
    "4": {  "r": [ [ 14, 0 ] ] },
    "5": {  "r": [ [ 14, 0 ] ] }
  },
  "a": [{
    "t": 1,
    "0": { "r": [ [ 12, 0 ] ] },
    "1": { "r": [ [ 12, 1 ] ] },
    "b": [ [ 0, 1 ] ]
  }]
}
```

## HomeKit Device Category

This option was implemented in firmware version `3.2.0`
<!-- FIXME: Remove this line after November 2020 -->

The `"ct"` option enables the HomeKit device category to be overwritten or
customised.
If this option is not specified then the device category that is presented to
HomeKit when a device is added is taken from the first accessory in the
accessory definitions list.

Device categories available are:

| Value | Category |
|:-----:|:---------|
| 1  | Other
| 2  | Bridge
| 3  | Fan
| 4  | Garage Door Opener
| 5  | Lightbulb
| 6  | Door Lock
| 7  | Outlet
| 8  | Switch
| 9  | Thermostat
| 10 | Sensor
| 11 | Security System
| 12 | Door
| 13 | Window
| 14 | Window Covering
| 15 | Programmable Switch
| 16 | Range Extender
| 17 | IP Camera
| 18 | Video Doorbell
| 19 | Air Purifier
| 20 | Heater
| 21 | Air Conditioner
| 22 | Humidifier
| 23 | Dehumidifier
| 24 | Apple TV
| 25 | HomePod
| 26 | Speaker
| 27 | Airport
| 28 | Sprinkler
| 29 | Faucet
| 30 | Shower Head
| 31 | Television
| 32 | Remote Controller
| 33 | Wifi Router
| 34 | Audio Receiver
| 35 | TV Set Top Box
| 36 | TV Streaming Stick
