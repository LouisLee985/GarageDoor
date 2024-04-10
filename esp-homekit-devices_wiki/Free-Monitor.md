**Important:** This service is in a BETA stage, and its configuration can change between versions.

A special HomeKit Custom Service, able to obtain data from different sources, like analog pin, GPIO pulses, network, I2C devices, UART and even other services.

Obtained final data must be a number, with or without decimals.

| Type | Service Type |
|:----:|:------------|
| `80` | Free Monitor
| `81` | Free Monitor Accumulative

Free Monitor was introduced in firmware version `10.0 Kestrel`

The following configuration is available:

<!-- markdownlint-disable MD013 -->
| Section | Key | Description |
|---------|:-----:|-------------|
| [Free Monitor Type](#free-monitor-type) | `"n"` | Type of source
| [Target HomeKit Characteristic](#target-homeKit-characteristic) | `"tg"` | Characteristic of other service that receives Free Monitor value
| [GPIO](#gpio) | `"g"` | Declarations used by Pulse Type or ADC
| [I2C Data](#i2c-data) | `"ic"` | Declarations to connect to target I2C device
| [I2C Initial Commands](#i2c-initial-commands) | `"in"` | Declarations used by I2C to init connected hardware
| [I2C Trigger Command](#i2c-trigger-command) | `"it"` | Declarations used by I2C to configure trigger command
| [I2C Value Offset](#i2c-value-offset) | `"io"` | Offset added to read value
| [Buffer Limits](#buffer-limits) | `"bl"` | Length limits of receive data
| [Patterns](#patterns) | `"pt"` | Pattern filters
| [Data Format](#data-format) | `"dt"` | Byte format of read value
| [Value Factor](#factor-and-offset) | `"ff"` | Value factor adjustment
| [Value Offset](#factor-and-offset) | `"fo"` | Value offset adjustment
| [Value Limits](#value-limits) | `"l"` | Array to set lower and upper limits
| [Polling Time](#polling-time) | `"j"` | Frequency value is read
| [Service Notifications](#service-notifications) | `"m"` | Notifications received from another service
| [Initial Lock State](#initial-lock-state) | `"ks"` | Lock state at boot
| [Wildcard Actions](#wildcard-actions) | `"y[n]"` | Perform an action when service reaches a target value
| [Service Characteristics](#service-characteristics) ||

# Free Monitor Type

This service can get data from different source types. This key indicates that type:

|  Key  | Value | Description |
| :----:|:-----:|:------------|
| `"n"` |  `1`  | [Free](#1-free) **(_default_)**
|       |  `2`  | [Pulse Frequency](#2-pulse-frequency)
|       |  `3`  | [Pulse Width](#3-pulse-width)
|       |  `4`  | [PWM Duty](#4-pwm-duty)
|       |  `5`  | [Math Operations](#5-math-operations)
|       |  `10` | [ADC](#10-and-11-adc)
|       |  `11` | [Inverted ADC](#10-and-11-adc)
|       |  `15` | [Network request with text response](#15-16-and-17-network-requests)
|       |  `16` | [Network request with text response and patterns filter](#15-16-and-17-network-requests)
|       |  `17` | [Network request with binary response and patterns filter](#15-16-and-17-network-requests)
|       |  `20` | [I2C](#20-and-21-i2c)
|       |  `21` | [I2C with Trigger](#20-and-21-i2c)
|       |  `23` | [UART Receiver with binary response](#23-24-and-25-uart-receiver)
|       |  `24` | [UART Receiver with binary response and patterns filter](#23-24-and-25-uart-receiver)
|       |  `25` | TO-DO [UART Receiver with text response and patterns filter](#23-24-and-25-uart-receiver)

## 1: Free

Default type. This does not read values from any source. Raw values are sent from other services using [Service Notifications](#service-notifications).

## 2: Pulse Frequency

Raw value is the frequency, in Hertz, that selected GPIO changes the defined state. That change can be from LOW to HIGH, from HIGH to LOW, or both. See [GPIO](#gpio).

## 3: Pulse Width

Raw value is the duration, in microseconds, of a received pulse, direct or inverted. An optional GPIO can be declared to send a pulse of 20us before read raw value. See [GPIO](#gpio).

Example of a Occupancy Sensor service with Free Monitor reading values from a HC-SR04 Ultrasonic sensor using trigger with GPIO 4 and Echo with GPIO 5 and a threshold of 300cm:
```json
{"c":{"io": [ [ [ 5 ], 1 ], [ [ 4 ], 2 ] ] }
 "a":[{
  "t": 6,
  "es": [{
    "t": 80,
    "n": 3,
    "g": [ 5, 3, 4 ],
    "j": 1,
    "ff": 0.01718213058,
    "y0": [{
        "v": 0,
        "0": {"m": [[-1, 1]]}
      },
      {
        "v": 300,
        "0": {"m": [[-1]]}
      }
    ]}
  ]}
]}
```

## 4: PWM Duty

Raw value is the PWM duty cycle (from 0 to 100%) detected in the declared GPIO. Resolution of reads is in microseconds.

Remember to declare GPIO as INPUT into `"io":[...]` array. See [GPIOs Configuration](GPIOs-Configuration), and declare it into `"g":[ GPIO ]` Free Monitor service key.

Example of a Occupancy Sensor service with Free Monitor reading values from a PWM signal connected to GPIO 5:
```json
{"c":{"io": [ [ [ 5 ], 1 ] ] }
 "a":[{
  "t": 6,
  "es": [{
    "t": 80,
    "n": 4,
    "g": [ 5 ],
    "j": 1,
    "y0": [{
        "v": 0,
        "0": {"m": [[-1]]}
      },
      {
        "v": 60,
        "0": {"m": [[-1, 1]]}
      }
    ]}
  ]}
]}
```

## 5: Math Operations

This type is able to read data from other characteristics from other services, and to do different math operations with all data. It can read values from current date and time, and it can generate random numbers too.

Math Operations was introduced in firmware version `11.0 Peregrine`

All operations must be defined with a `"dt":[...]` array. Each operation always uses 3 datas, then `"dt"` array will have always a multiple of 3 elements.

Structure for N operations:
`"dt" : [ x1, y1, z1, x2, y2, z2, x3, y3, z3, ..., xN, yN, zN]`

| Data | Description
|:----:|:--------------
|  `x` | Operation type
|  `y` | Service number or special data source
|  `z` | Characteristic number or immediate fixed value

| Operation type | Description
|:--------------:|:-------------
|       `0`      | None: Set Current value to `0`. It can be used only at first place
|       `1`      | Addition: `Current value + Read value`
|       `2`      | Subtraction: `Current value - Read value`
|       `3`      | Inverted Subtraction: `Read value - Current value`
|       `4`      | Multiplication: `Current value * Read value`
|       `5`      | Division: `Current value / Read value`
|       `6`      | Inverted Division: `Read value / Current value`
|       `7`      | Module (Only integer parts): `Current value % Read value`
|       `8`      | Inverted Module (Only integer parts): `Read value % Current value`
|       `9`      | Power: `Current value ^ Read value`
|      `10`      | Inverted Power: `Read value ^ Current value`
|      `11`      | Inverse: `1 / Current value`
|      `12`      | Absolute of Current value

`Service number` is the index of the service where is the source characteristic to read value. It must be an absolute index, meaning that negative values or 7000 + index relative values can not be used.

`Characteristic number` is the index of the source characteristic from the selected service to read value.

If Service number is 0 or a negative value, it is a Special Data Source, and this table will be used:

| Source Number | Description
|:-------------:|:------------
|       `0`     | Immediate value: `Characteristic number` will be the exact Read value to be used
|      `-1`     | Use current time HOUR as Read value
|      `-2`     | Use current time MINUTE as Read value
|      `-3`     | Use current time SECOND as Read value
|      `-4`     | Use current date DAY OF WEEK (from 0 to 6) as Read value
|      `-5`     | Use current date DAY OF MONTH as Read value
|      `-6`     | Use current date MONTH as Read value
|      `-7`     | Use current date DAY OF YEAR as Read value
|      `-8`     | Use current date YEAR as Read value
|      `-9`     | Use current date DAYLIGHT SAVING (0 or 1) as Read value
|     `-10`     | Use current UNIX Time as Read value
|     `-11`     | Use an integer random number as Read value, from `0` to given `Characteristic number`
|     `-12`     | Use device uptime, in seconds, as Read value
|     `-13`     | Use WiFi RSSI as Read value (Only ESP32, ESP32-C and ESP32-S)
|     `-14`     | Use IP address of connected HomeKit controller when only there is one. If not, `-1` will be used. read value will be `3º byte * 1000 + 4º byte`. Ex: 192.168.1.20: `1 * 1000 + 20 = 1020`.
|     `-15`     | Use number of connected HomeKit controller (iPhones, iPads, HomePods...) as Read Value. A value of `-1`  indicates that HomeKit Server has not been started.

If `Source Number` doesn't need a `Characteristic number`, use a value of `0`. Anyways, this value is useless and it will be ignored.

## 10 and 11: ADC

Raw values come from Analog Pin (ADC). Those raw values are from `0` to `1023`. 

Inverted ADC means that raw value will be `1023 - ADC`.

For ESP32 chips, remember to declare GPIO as ADC into `"io":[...]` array. See [GPIOs Configuration](GPIOs-Configuration), and declare it into `"g":[ GPIO ]` Free Monitor service key.

**Example** of a Free Monitor reading a MQ-135 sensor connected to ADC pin of ESP8266 and setting the state of an Air Quality Service:
```json
{
  "a":[
    {
      "t" : 15
    }, {
      "t" : 80,
      "h" : 0,
      "n" : 10,
      "y0" : [
        {
          "v" : 0,
          "0" : { "m" : [ [ -1, 1 ] ] }
        }, {
          "v" : 500,
          "0" : { "m" : [ [ -1, 2 ] ] }
        }, {
          "v" : 600,
          "0" : { "m" : [ [ -1, 3 ] ] }
        }, {
          "v" : 700,
          "0" : { "m" : [ [ -1, 4 ] ] }
        }, {
          "v" : 800,
          "0" : { "m" : [ [ -1, 5] ] }
        }
      ]
    }
  ]
}
```

## 15, 16 and 17: Network Requests

This service can send a network request and read the network response. To request, action `0` must be used with an array of [Network Request Actions](accessory-configuration#send-network-request-actions).

Response of types `15` and `16` will be processed as text, allowing signed and decimals values. Read raw value will begin at first numeric character found into the received payload.

Response of type `17` will be processed as bytes, and [Data Format](#data-format) is mandatory.

When patterns filter is used, value will be search after filter.

When several network requests are declared, raw value will be last valid value read from all network requests.

## 20 and 21: I2C

It is possible to get raw values from I2C devices. It is necessary to know how I2C device works and what register addresses are needed.

Declaration of [Free Monitor Type](#free-monitor-type) is not necessary when this type is used.

Requirements are:
- [I2C Bus declaration](general-configuration#i2c-bus) in [General Configuration](general-configuration).
- [I2C Data](#i2c-data)
- [Data Format](#data-format)

Optional:
- [I2C Initial Commands](#i2c-initial-commands)
- [I2C Value Offset](#i2c-value-offset)

I2C with Trigger:
This mode will send the specified I2C command to device, and will wait specified time, before read value from I2C bus. It needs additional declarations:
- [I2C Trigger Command](#i2c-trigger-command)

If several Free Monitor services use same I2C and address (Accessing same I2C device), tasks overlapping can occur. Check HAA logs for tasks overlapping, and use [Service delay](https://github.com/RavenSystem/esp-homekit-devices/wiki/accessory-configuration#delay-after-creation) to avoid tasks concurrences.

## 23, 24 and 25: UART Receiver

Read data from selected UART. Data is defined by [Data Format](#data-format) array.

In ESP8266 chips, only `UART0` is available (`UART1` has not RX).

In ESP32 chips, used UART must be selected with `"u":` key. Default is `"u":0`.

In order to work with these types, [UART Configuration](general-configuration#uart-configuration) is required; and [UART Receiver Lengths](general-configuration#uart-receiver-lengths) is available.

# Target HomeKit Characteristic

Final value can be copied to any characteristic of any service declared before this Free Monitor Service.

```
"tg" : [ Service, Characteristic ]
```

- `Service` is the target service index. Absolute index or relative index (negative) can be used.
- `Characteristic` is the target Data History Charateristic.

Value of target characteristic will be overwritten, but no actions will be triggered. Only [HeaterCooler](heatercooler), [Humidifier](humidifier) and [Battery](battery) will be evaluated. To use actions with other target services, you must use directly Free Monitor [Wildcard Actions](#wildcard-actions).

# GPIO

Array that contains GPIO and pulse type, used by Free Monitor Pulse Type. GPIO 16 can NOT be used because it does not support hardware interrupts.

```
"g" : [ GPIO, Type ]
```

Remember to declare GPIO as Input into `"io":[...]` array. See [GPIOs Configuration](gpios-configuration)

Optionally, an extra GPIO can be declared to send a trigger pulse when [Pulse Width](#3-pulse-width) is used. If `trigger GPIO` is inverted, a value of 100 must be added to GPIO number. Example: Inverted GPIO `4` will be `104`.

```
"g" : [ GPIO, Type, Trigger GPIO ]
```

Remember to declare Trigger GPIO as Output into `"io":[...]` array. See [GPIOs Configuration](gpios-configuration)

| Type | Description |
|:-----:|:------------|
| `1` | LOW to HIGH
| `2` | HIGH to LOW
| `3` | Both


# I2C Data

It is an array to declare information about I2C communication. This information is available in datasheet of I2C device.

All values must be in numeric decimal format:

```
"ic" : [ bus, device address, register byte 1, register byte 2, ... ]
```

- `bus`: HAA I2C bus. Can be `0` or `1`. See [I2C Bus declaration](general-configuration#i2c-bus) in [General Configuration](general-configuration).
- `device address`: I2C address used by device, from `0` to `127`. Many I2C devices have options to customize it.
- `register bytes`: These are the register bytes used to read the target value. Each register byte is a number from `0` to `255`. If there is not register bytes needed, declare only `bus` and `device address`.

# I2C Initial Commands

Typically, I2C devices need an initial setup in order to be configured and work. With this array of arrays, it is possible to
declare all information that I2C device needs.

```
"in" : [ [ length, register byte 1, register byte 2, ..., value byte 1, value byte 2, ... ], [...], ... ]
```

- `length`: Number of register bytes to write. If none is used, set it to `0`.
- `register bytes`: Register bytes to write values. Each must be a decimal number from `0` to `255`. They are optional.
- `value bytes`: Value bytes to be written. Each must be a decimal number from `0` to `255`.

Commands will be sent to I2C device in same order as declared in `"in"` array.

If an I2C device is accessed from several Free Monitor Services, `"in"` array must be placed at first of them in MEPLHAA script.

# I2C Trigger Command

It is needed when I2C Trigger Command is used.

```
"it" : [ delay, length, register byte 1, register byte 2, ..., value byte 1, value byte 2, ... ]
```

- `delay`: Seconds to wait after send trigger command and before read new value.
- `length`: Number of register bytes to write. If none is used, set it to `0`.
- `register bytes`: Register bytes to write values. Each must be a decimal number from `0` to `255`. They are optional.
- `value bytes`: Value bytes to be written. Each must be a decimal number from `0` to `255`.

# I2C Value Offset

Number of bytes to forward before read raw value bytes.

| Key | Default Value | Description |
| :--:|:-----:|:------------|
| `"io"` | `0` | Set I2C offset to 0 **(_default_)**
|| `0` to `127` | Set I2C offset to specified value in bytes

Raw value, declared in [Data Format](#data-format), will begin before offset is applied to read I2C bus data.

# Buffer Limits

It is an optional array to define limits to received data when Network request or UART are used. If the received data length is out of declared limits, data will be dropped.

There are no limits by default.

```
"bl" : [ min, max ]
```

# Patterns

Array used by those Free Monitor Types that need patterns filter:

```
"pt" : [ [ "Pattern 1", Offset 1 ], [ "Patter 2", Offset 2 ], ... ]
```

Pattern is, in text or hexadecimal format (depending of Free Monitor Type), the string to search into received response. 

- Type `16` and `25`: Text.
- Types `17` and `24`: Hexadecimal.

When pattern is found, its offset is applied to forward that value, and keep searching for next pattern.

After all patterns are matched, value is read. If a pattern is not found, none value will be read. Patterns are processed in 
same order as declaration into `"pt"` array. 

If only offset is needed, without any pattern, you can use `""` as pattern.

Offset is optional; if offset is not declared, a value of `0` will be used as offset.

# Data Format

It applies to Network with hex patterns, I2C and UART (Types `7`, `8`, `9` and `10`). It is an array that determines 
length and byte format:

```
"dt" : [ Length, Format ]
```

`Length` is the number of bytes to process, from `1` to `4`.

`Format` determines endian and sign, as follow:

| Format | Description |
|:-----:|:------------|
| `0` | Big endian, unsigned
| `1` | Little endian, unsigned
| `2` | Big endian, signed
| `3` | Little endian, signed

- Big Endian (Most common): from MSB (Most Significant Byte) to LSB (Less Significant Byte).
- Little Endian: from LSB to MSB.

# Factor and Offset

Sometimes, read value needs to be recalculated in order to obtain the final value. Factor and offset values are values
applied as:

```
Final Value = (Raw Value * Factor) + Offset
```

| Key | Default Value | Description |
| :--:|:-----:|:------------|
| `"ff"` | `1` | Set factor value
| `"fo"` | `0` | Set offset value

# Value Limits

By default, there is not any limit that final value can take, but it is possible to add a lower and a upper limit
to final value with `"l":` key:

```
"l" : [ Lower Limit, Upper Limit ]
```

Final values outside these limits will be ignored.

For example, if final value must be a number between 5 and 24, declaration will be:
```json
"l" : [ 5, 24 ]
```

# Polling Time

Polling time is defined by the `"j"` key contained within the
service object.

| Key | Value | Description |
|:-----:|:----:|:------------|
| `"j"` | `30` | Value is polled every 30 seconds **(_default_)**
| | `0.1` to `65535` | Float specifying the number of seconds between polls

Value is polled on a regular basis to read the
latest values. These values are then posted to HomeKit. If this option is not
specified then the value will be polled once every 30 seconds.

# Service Notifications

The list of Service Notifications `"m"` values supported are:

| Key | Value | Notification |
| :--:|:-----:|:------------|
| `"v"` | `0` | Set current value to `0` **(_default_)**
|     | `N` | Set current value to `N`
|     | `-2182017` | Set current value of Free Monitor Accumulative to `0`

When Free Monitor Accumulative is used, new value will be added to current value.

# Initial Lock State

The Initial Lock State about Service.

| Key  | Value | Notification |
| :---:|:-----:|:------------|
| `"ks"` | `0` | Service and execution of actions locked
| | `1` | Service unlocked. Execution of actions locked
| | `2` | Service locked. Execution of actions unlocked
| | `3` | **All unlocked (_default_)**


# Wildcard Actions

Wildcard Actions `"y[n]"` are supported by this service.
The supported list is:

| Key | Action |
|:------:|:-----|
| `"y0"` | Trigger action when service reaches a specific value

Refer to [Wildcard Actions](accessory-configuration#wildcard-actions) for
more detail.

# Service Characteristics

| Characteristic | Description |
|:------:|:-----|
| `0` | * Current value
