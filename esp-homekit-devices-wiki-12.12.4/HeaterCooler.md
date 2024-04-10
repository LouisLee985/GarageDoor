A HomeKit Heater Cooler service.

| Type | Service Type |
|:----:|:------------|
| `21` | Heater Cooler
| `25` | Heater Cooler with humidity sensor

The following configuration is available:

<!-- markdownlint-disable MD013 -->
| Section | Key | Description |
|---------|:-----:|-------------|
| [Actions](#Actions) | `"0"`, `"1"`, etc. | The actions performed by the service
| [Binary Inputs](#Binary-Inputs) | `"b"` | GPIOs that invoke specific actions
| [State & Status Inputs](#State-and-Status-Inputs) | `"f[n]"` & `"g[n]"` | Inputs that manage service state
| [Service Notifications](#Service-Notifications) | `"m"` | Notifications sent by other services
| [ICMP Ping Inputs](#ICMP-Ping-Inputs) | `"q[n]"` & `"p[n]"` | Ping inputs that manage service state
| [Wildcard Actions](#Wildcard-Actions) | `"y[n]"` | Perform an action when an service reaches a target value
| [Initial Lock State](#Initial-Lock-State) | `"ks"` | Lock state at boot
| [Initial State](#Initial-State) | `"s"` | State a service enters on boot
| [Initial Mode](#Initial-Mode) | `"e"` | Mode a service enters on boot
| [Sensor GPIO](#Sensor-GPIO) | `"g"` | GPIO line sensor is attached to
| [Sensor Type](#Sensor-Type) | `"n"` | Type of sensor attached to service
| [Sensor Polling Time](#Sensor-Polling-Time) | `"j"` |How often the temperature sense is read
| [Temperature Offset](#Temperature-Offset) | `"z"` | Correction offset to apply
| [Humidity Offset](#Humidity-Offset) | `"k"` | Correction offset to apply
| [HeaterCooler Type](#HeaterCooler-Type) | `"w"` | Type of HeaterCooler connected to service
| [Minimum Temperature](#Minimum-Temperature) | `"m"` | Minimum temperature that can be set
| [Maximum Temperature](#Maximum-Temperature) | `"x"` | Maximum temperature that can be set
| [Target Temperature Step](#Target-Temperature-Step) | `"st"` | Target temperature step to use by HomeKit clients
| [Deadband Temperature](#Deadband-Temperature) | `"d"` | Deadband/Hysteresis of HeaterCooler
| [Deadband Temperature Force Idle](#Deadband-Temperature-Force-Idle) | `"df"` | Deadband/Hysteresis of HeaterCooler to exec Force Idle Actions
| [Deadband Temperature Soft On](#Deadband-Temperature-Soft-On) | `"ds"` | Deadband/Hysteresis of HeaterCooler to exec Soft On Actions
| [Delay time to process](#Delay-time-to-process) | `"dl"` | Time in seconds to wait for process HeaterCooler logic
| [HAA iAirZoning Index](#HAA-iAirZoning-Index) | `"ia"` | Number of HAA iAirZoning Service that manages this HeaterCooler
| [Service Characteristics](#Service-Characteristics) ||
<!-- markdownlint-enable MD013 -->

# Example

```json
{
  "c":{"io":[[[3],2]],"t":3},
  "a":[{
    "t":25,
    "w":3,
    "p":"HPDRAGAAAGCKAE",
    "s":5,
    "g":14,
    "0":{"i":[{"c":"BcAbBaAbBaBbAbAdArAdCdBdAuHaDcDbDaU"}]},
    "1":{"i":[{"c":"BcAbBaAbBaBbAbAdApAbAbAgBdAuFaBaBaGbDaU"}]},
    "2":{"i":[{"c":"BcAbBaAbBaBbAbAdApAaAdCdBdAuFaAaDcDbDaU"}]},
    "3":{"i":[{"c":"BcAbBaAbBaBbAbAdApAbAdBdBdAuFaBaDbDbDaU"}]},
    "4":{"i":[{"c":"BcAbBaAbBaBbAbAdApAaAcBfBdAuFaAaCbFbDaU"}]},
    "5":{"a":0}
  }]
}
```

This is an example of a Mitsubishi HVAC IrDA Remote HeaterCooler and
Humidity sensor (`"t":25`).
The type (`"w":3`) is a heater & cooler.
The HeaterCooler is controlled via a infra-red and the protocol is defined by
`"p":"HPDRAGAAAGCKAE"`.
A sensor is connected to GPIO 14 (`"g":14`) and is is the default type 2 (`"n":2`
not required as the default).
Control of the sensor is via actions 0 to 5 and their respective IR strings.
The initial state has been set to "last state before restart" (`"s":5`).

# Actions

| Key | Action | Description |
|:------:|:------|:------------|
| "0"  | All OFF | Turns off all components of the HeaterCooler
| "1"  | HeaterCooler ON, Heating OFF | Turn on HeaterCooler but heating is in idle-mode
| "2"  | HeaterCooler ON, Cooling OFF | Turn on HeaterCooler but cooling is in idle-mode
| "3"  | HeaterCooler ON, Heating ON | HeaterCooler is active and heating
| "4"  | HeaterCooler ON, Cooling ON | HeaterCooler is active and cooling
| "5"  | Sensor Error | Action to perform when there is a sensor error
| "6"  | `"f3"` triggered | Change target temperature by +0.5°C
| "7"  | `"f4"` triggered | Change target temperature by -0.5°C
| "8"  | HeaterCooler ON, Heating Force OFF | Turn on HeaterCooler but heating is in force idle-mode
| "9"  | HeaterCooler ON, Cooling Force OFF | Turn on HeaterCooler but cooling is in force idle-mode
| "10" | HeaterCooler ON, Heating Soft ON | HeaterCooler is active and heating in soft mode
| "11" | HeaterCooler ON, Cooling Soft ON | HeaterCooler is active and cooling in soft mode
| "12" | Close gate | Close gate when it is managed by a [HAA iAirZoning](HAA-iAirZoning) service
| "13" | Open gate | Open gate when it is managed by a [HAA iAirZoning](HAA-iAirZoning) service
| "14" | HeaterCooler ON | Execs only when prior state was total OFF

Multiple actions are supported by a HeaterCooler. The [Binary Outputs](Accessory-Configuration#Binary-Outputs)
`"r": [ ]` for each should be configured to attain the desired state.

# Sensor GPIO

Sensor GPIO is defined by the `"g"` key contained within the service object.

| Key | Value | Description |
|:----:|:-----:|:---|
| "g" | GPIO # | GPIO line the temperature sensor is connected to

Home Accessory Architect only supports one-wire temperature sensors.
This is a mandatory option that specifies the GPIO the sensor is attached to
e.g. `"g": 14`

# Sensor Type

Sensor type is defined by the `"n"` key contained within the service object.

A variety of one-wire sensors are available and supported by HAA.

Refer to [Sensor Type](Temperature-and-Humidity-Sensors#Sensor-Type) for
details of the sensors that are supported.

# Sensor Polling Time

Sensor polling time is defined by the `"j"` key contained within the
service object.

| Key | Value | Description |
|:-----:|:----:|:------------|
| "j" | 30 | **Sensor is polled every 30 seconds (_default_)**
| | 0.1 to 65535 | Float specifying the number of seconds between polls

The HeaterCooler temperature is polled on a regular basis to read the
latest values. These values are then posted to HomeKit. If this option is not
specified then the sensor will be polled once every 30 seconds.

# Temperature Offset

Temperature offset is defined by the `"z"` key contained within the service
object.

| Key | Value | Description |
|:-----:|:----:|:------------|
| "z" | 0.0 | **No offset is applied (_default_)**
| | -∞ < 0.0 > +∞ | Offset is added to temperature value read

The accuracy of the temperature sensor varies and may sometimes read
consistently higher or lower than the actual temperature. The temperature offset
option enables calibration of the sensor by specifying a positive or negative
offset to apply to the reading.

The option uses is a floating point value, accurate to 1 decimal place e.g. 1.1

# Humidity Offset

Humidity offset is defined by the `"k"` key contained within the service
object.

**NOTE: This option is available only for device type 25**

| Key | Value | Description |
|:-----:|:----:|:------------|
| "k" | 0 | **No offset is applied (_default_)**
| | -∞ < 0 > +∞ | Offset is added to humidity value read

The accuracy of the available one-wire sensors varies and may sometimes read
consistently higher or lower than the actual humidity. The humidity offset
option enables calibration of the sensor by specifying a positive or negative
offset to apply to the reading.

The option uses is an integer point value.

# HeaterCooler Type

HeaterCooler type is defined by the `"w"` key contained within the service object.

| Key | Type | Description |
|:-----:|:----:|:------------|
| "w" | 1 | **Heater (_default_)**
| | 2 | Cooler
| | 3 | Heater and Cooler
| | 4 | Heater and Cooler without Auto mode

This option is used to select the type of HeaterCooler controlled by the
device.

# Minimum Temperature

Minimum temperature is defined by the `"m"` key contained within the
service object.

| Key | Value | Description |
|:-----:|:----:|:------------|
| "m" | 10.00 | **Set minimum temperature to 10°C (_default_)**
| | -∞ < 0.00 > +∞ | Minimum temperature allowed

This option is used to set the minimum temperature in °C you can set. The
value is a floating point variable accurate to 2 decimal places e.g. 10.04.

# Maximum Temperature

Maximum temperature is defined by the `"x"` key contained within the
service object.

| Key | Value | Description |
|:-----:|:----:|:------------|
| "x" | 38.00 | **Set maximum temperature to 38°C (_default_)**
| | -∞ < 0.00 > +∞ | Maximum temperature allowed

This option is used to set the maximum temperature in °C you can set. The
value is a floating point variable accurate to 2 decimal places e.g. 10.04.

# Target Temperature Step

Target temperature step to use by HomeKit clients.

| Key | Value | Description |
|:-----:|:----:|:------------|
| "st" | 0.1 | **Set step to 0.1°C (_default_)**
| | 0.1 > +∞ | Step value allowed

# Deadband Temperature

Deadband temperature is defined by the `"d"` key contained within the
service object.

| Key | Value | Description |
|:-----:|:----:|:------------|
| "d" | 0.00 | **Set temperature deadband to 0°C (_default_)**
| | 0.00 > +∞ | Temperature deadband allowed

The `"d"` option is used to set the temperature deadband in °C to adjust how
HeaterCooler works. The value is a floating point variable accurate to 2 decimal
places e.g. 10.04.

![HeaterCooler Deadband](https://raw.githubusercontent.com/RavenSystem/ravensystem-media/master/Thermostat_Deadband.svg)

A HeaterCooler deadband (or hysteresis) is designed to lag the inputs
from the environment for the purposes of saving you energy and saving your
air conditioner or furnace wear and tear from turning on and off frequently.

The deadband represents a temperature range around the automatic mode set point
that is your “comfort zone”.
For example, with a 4°C wide deadband (`"d": 4.0`) and a setpoint of 20°C,
the deadband will be 18 - 22°C. This keeps the system from bouncing quickly
between heating and cooling when in automatic mode.

When temperatures fall within the deadband, neither heating nor cooling can occur.
A larger deadband will have your system run more economically, while a smaller
deadband will have your system hold the temperature closer to the setpoint and
increase comfort. The deadband does not affect your HeaterCooler's operation when
in HEAT or COOL modes.

Example: If you have an 8ºC deadband and you set your desired temperature to 22ºC
in AUTO mode, your heating set point will be 18º and your cooling set point will
be 26ºC.

# Deadband Temperature Force Idle

Deadband temperature force idle is defined by the `"df"` key contained within the
service object.

| Key | Value | Description |
|:-----:|:----:|:------------|
| "df" | 0.00 | **Set temperature deadband to 0°C (_default_)**
| | 0.00 > +∞ | Temperature deadband allowed

# Deadband Temperature Soft On

Deadband temperature soft on is defined by the `"ds"` key contained within the
service object.

| Key | Value | Description |
|:-----:|:----:|:------------|
| "ds" | 0.00 | **Set temperature deadband to 0°C (_default_)**
| | 0.00 > +∞ | Temperature deadband allowed

# Delay time to process

Time to wait until HeaterCooler data in processed. It is used to avoid conflicts when many HomeKit orders are sent at same time.

| Key | Value | Description |
|:-----:|:----:|:------------|
| "dl" | 3.0 | **Set delay time to 4 seconds (_default_)**
| | 0.15 > +∞ | Delay time allowed in seconds

# HAA iAirZoning Index

This service can be part of a [HAA iAirZoning](HAA-iAirZoning) service, working as a group in a different way.

| Key  | Description |
|:----:|:------------|
| "ai" |  Index of HAA iAirZoning service that manages this HeaterCooler

# Service Notifications

The list of notifications `"m"` supported by this service are as follows:

| Value | Notification |
|:-----:|:------------|
| 0.02  | HeaterCooler OFF
| 0.03  | HeaterCooler ON
| 0.04  | Cooler mode
| 0.05  | Heater mode
| 0.06  | Auto mode
| XX.Y0 | Set heater temperature to XX.Yº
| XX.Y1 | Set cooler temperature to XX.Yº

See the general [Service Notifications](Accessory-Configuration#Service-Notifications)
section for details of how to configure these notifications.

# Binary Inputs

Binary Inputs `"b"` are supported by this service.

See [Binary Inputs](Accessory-Configuration#Binary-Inputs) for
details on how to define this mandatory option.

# State and Status Inputs

State inputs `"f[n]"` & Status Inputs `"g[n]"` are supported by this service.
The supported list is:

| Key | Required State |
|:------:|:-----|
| "f0" | HeaterCooler `OFF`
| "f1" | HeaterCooler `ON`
| "f3" | Change target temperature by +0.5°C
| "f4" | Change target temperature by -0.5°C
| "f5" | Cooler mode `ON`
| "f6" | Heater mode `ON`
| "f7" | Auto mode `ON`

**NOTE: Fixed states `"f5"`, `"f6"` & `"f7"` are only available when HeaterCooler
type `3` is selected (`"w": 3`)**

Refer to [State Inputs](Accessory-Configuration#State-Inputs) for
more detail and examples.

# ICMP Ping Inputs

ICMP Ping inputs `"p[n]"` and `"q[n]"` are supported by this service.
Refer to [ICMP Ping Inputs](Accessory-Configuration#ICMP-Ping-Inputs) for
more detail.

# Wildcard Actions

Wildcard Actions `"y[n]"` are supported by this service.
The supported list is:

| Key | Action |
|:------:|:-----|
| "y0" | Trigger action when service reaches a specific temperature
| "y1" | Trigger action when service reaches a specific humidity
| "y2" | Trigger action when heater target temperature reaches a specific value
| "y3" | Trigger action when cooler target temperature reaches a specific value

Refer to [Wildcard Actions](Accessory-Configuration#Wildcard-Actions) for
more detail.

# Initial Lock State

The Initial Lock State about Service and Physical controls.

| Key  | Value | Notification |
| :---:|:-----:|:------------|
| "ks" | 0 | All locked
| | 1 | Service unlocked. Physical controls locked
| | 2 | Service locked. Physical controls unlocked
| | 3 | **All unlocked (_default_)**

# Initial State

The Initial State key is supported by this service.
Refer to [Initial State](Accessory-Configuration#Initial-State) for details
of the available values.

# Initial Mode

Initial mode is defined by the `"e"` key contained within the service object.

| Key | State | Description |
|:----:|:-----:|:------------|
| `"e"` | `0` | Auto
| | `1` | Heat
| | `2` | Cool
| | `3` | Last mode before restart **(_default_)**

# Service Characteristics

| Characteristic | Description |
|:------:|:-----|
| 0 | * Current Temperature
| 1 | * Current Humidity
| 2 | On / Off
| 3 | Current Heater/Cooler State
| 4 | Target Heater/Cooler State
| 5 | Heater target temperature
| 6 | Cooler target temperature
