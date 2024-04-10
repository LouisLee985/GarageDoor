The HomeKit temperature and humidity sensors have a number of common options and
are grouped here.

| Type | Service Type |
|:----:|:------------|
| `22` | Temperature Sensor
| `23` | Humidity Sensor
| `24` | Temperature & Humidity Sensors

The following configuration is available for temperature and humidity sensors:

<!-- markdownlint-disable MD013 -->
| Section | Key | Description |
|---------|:-----:|-------------|
| [Actions](#Actions) | `"0"`, `"1"`, etc. | The actions performed by the service
| [Wildcard Actions](#Wildcard-Actions) | `"y[n]"` | Perform an action when an service reaches a target value
| [Sensor GPIO](#Sensor-GPIO) | `"g"` | GPIO line sensor is attached to
| [Sensor Type](#Sensor-Type) | `"n"` | Type of sensor attached to service
| [Sensor Polling Time](#Sensor-Polling-Time) | `"j"` | Frequency sensor is read
| [Humidity Offset](#Humidity-Offset) | `"k"` | Correction offset to apply
| [Temperature Offset](#Temperature-Offset) | `"z"` | Correction offset to apply
| [Sensor Index](#DS18B20-Sensor) | `"u"` | Sensor to use when multiple sensors attached to same GPIO. **DS18B20 only**
| [Data History Characteristics](#Data-History-Characteristics) ||
<!-- markdownlint-enable MD013 -->

# Example 1

<!-- spellchecker: disable -->
```json
{
  "c": { "io":[[[12,13],2],[[0],6]], "l": 13 },
  "a": [{
    "t": 1,
    "0": { "r": [[12]] },
    "1": { "r": [[12,1]] },
    "b": [[0]],
    "s": 5
  }, {
    "t": 24,
    "g": 14,
    "n": 4,
    "j": 30,
    "z": -0.8
  }]
}
```
<!-- spellchecker: enable -->

This is an example of a Sonoff TH10 unit with a temperature & humidity sensor
connected to GPIO 14 and an LED connected to GPIO 13 (`"l": 13`).
The device also has a switch output (`"t": 1`) connected to GPIO 12 with
actions `"0"` & `"1"`. The switch has a button connected to GPIO 0
(`"b": [[0]]`).

A second accessory, with the temperature & humidity sensor services (`"t": 24`),
is attached to GPIO 14 (`"g": 14`) and is a Si7021 sensor (`"n": 4`). The
polling time has been set to 30 seconds (`"j": 30`) and to improve the accuracy
of the reading an offset of -0.8ºC is applied (`"z": -0.8`). No offset is being
applied to the humidity sensor.

**NOTE: The following options are not needed in this example as they are the
default options but are included to make the example more readable:**
`"t": 1` & `"j": 30`

# Example 2

<!-- spellchecker: disable -->
<!-- markdownlint-disable MD013 -->
```json
{
  "c": { "io":[[[13],3]], "l": 13 },
  "a": [{
    "t": 22,
    "n": 5,
    "j": 10,
    "y0": [{
      "v": 30,
      "r": 0,
      "0": { "h": [{ "h": "influxdb.lan", "p": 8086, "m": 2, "u": "write?db=haadb", "c": "sensor,device=office value=30" }] }
    }]
  }]
}
```
<!-- markdownlint-enable MD013 -->
<!-- spellchecker: enable -->

This is an example of a NTC Thermistor temperature sensor `"n":5`, that is polled
every 10 seconds `"j":10` and sends an HTTP request to an Influxdb database when
the sensor reading is >30ºC.

# Actions

| Action | State | Description |
|:------:|:------|:------------|
| `"5"` | Sensor Error | Action to perform when there is a sensor error

Temperature and humidity sensors only have one action.

# Sensor GPIO

Sensor GPIO is defined by the `"g"` key contained within the service object.

This GPIO must NOT be declared into `"io":[...]` array.

| Key | Value | Description |
|:----:|:-----:|:---|
| `"g"` | `GPIO #` | GPIO line the temperature and/or humidity sensor is connected to

Home Accessory Architect only supports one-wire temperature and humidity sensors.
This is a mandatory option that specifies the GPIO the sensor is connected to.

**NOTE:** When specifying a thermistor sensor type (ADC) for ESP8266, the value of `"g"` will be
ignored.

# Sensor Type

Sensor type is defined by the `"n"` key contained within the service object.

A variety of one-wire sensors are available and supported by HAA.

<!-- markdownlint-disable MD013 -->
| Key | Type | Device Type Support | Description |
|:----:|:-----|:--------------------|-------------|
| `"n"`  |  `1` | `22`, `23` & `24` | [DHT11](#DHT11-Sensor) Temperature and humidity sensor
| |  `2`  | `22`, `23` & `24` | [DHT22](#DHT22-Sensor) Type 1 **(_default_)** Temperature & humidity sensor
| |  `3`  | `22` | [DS18B20](#DS18B20-Sensor) Temperature sensor
| |  `4`  | `22`, `23` & `24` | [Si7021 1-Wire version](#Si7021-Sensor) Temperature and humidity sensor
| |  `5`  | `22` | ADC NTC [Thermistor](#Thermistor-Sensor)
| |  `6`  | `22` | ADC PTC [Thermistor](#Thermistor-Sensor)
| |  `7`  | `22` | Raw ADC NTC [Thermistor](#Thermistor-Sensor)
| |  `8`  | `22` | Raw ADC PTC [Thermistor](#Thermistor-Sensor)
| |  `9`  | `23` | Raw ADC Humidity Sensor
| |  `10` | `23` | Raw ADC Humidity Sensor (Inverted logic)
| | `100` | `22` | Built-in chip temperature sensor (Only ESP32-C and ESP32-S)
<!-- markdownlint-enable MD013 -->

Sensor type `3` can only be used with device type `22` (`Temperature Sensor`),
but sensor types `1`, `2` & `4` can be used with any device type as they contain both
a temperature sensor and a humidity sensor.

## DHT11 Sensor

Datasheet: [DHT11](https://www.electronicoscaldas.com/datasheet/DHT11_Aosong.pdf)

The DHT11 sensor is a good value temperature & humidity sensor giving a ±2ºC
temperature accuracy and a ±5%RH humidity accuracy. It is one of the most common
sensors used in Smart Devices.

## DHT22 Sensor

Datasheet: [DHT22](https://kropochev.com/downloads/humidity/AM2301.pdf)

The DHT22 sensor seems to be available in two forms; a new type branded as a
Sonoff product and older types branded as ASAIR and other names.
The older types should be configured as DHT22 Type 1 `"n": 2` and the newer
[Sonoff](https://sonoff.tech/product/accessories/am2301)
branded type should be configured as a Si7021 `"n": 4`.

## DS18B20 Sensor

Datasheet: [DS18B20](https://datasheets.maximintegrated.com/en/ds/DS18B20.pdf)

The DS18B20 sensor is capable of measuring temperatures from -55ºC to +125ºC
(-67ºF to +257ºF) and has an accuracy of ±0.5ºC. It is available for [Sonoff](https://sonoff.tech/product/accessories/ds18b20)
TH10/TH16 devices.

Firmware version 3.0.0 introduced the ability to read multiple DS18B20 sensors
when connected to the same GPIO. The `"u"` option is used to specify the sensor
index.

### Multiple DS18B20 Sensors Example

Three DS18B20 sensors connected to GPIO 14:

```json
{
  "a": [
    {"t": 22, "g": 14, "n": 3},
    {"t": 22, "g": 14, "n": 3, "u": 2},
    {"t": 22, "g": 14, "n": 3, "u": 3}
  ]
}
```

## Si7021 Sensor

Datasheet: [Si7021](https://www.silabs.com/documents/public/data-sheets/Si7021-A20.pdf)

**HAA supported version is 1-Wire.**

The Si7021 sensor chip is an I<sup>2</sup>C device.
The [Sonoff](https://www.itead.cc/wiki/Sonoff_Sensor_Si7021) branded sensor has
a Si7021 sensor and an 8-bit MCU combined.
The MCU translates the I<sup>2</sup>C commands into a 1-bit interface suitable
for 1-Wire communication.

**NOTE:** The Si7021 sensor contains an integrated resistive heating element that
can be used to drive off condensation. The data sheet recommends enabling the
heater when the humidity readings are >80% as above this the sensor readings can
become unreliable. This feature is not currently supported.

Bear this in mind if you are intending to use this sensor outdoors.

## Thermistor Sensor

Thermistors (thermal resistors) are temperature dependent variable resistors.
There are two types of thermistors, Negative Temperature Coefficient (NTC)
`"n":5` and Positive Temperature Coefficient (PTC) `"n":6`.
When the temperature increases, PTC thermistor resistance will increase and
NTC thermistor resistance will decrease.
They exhibit the opposite response when the temperature decreases.

HAA assumes the thermistor is connected to the ADC pin on the ESP8266 MCU.

Sensor types 5 & 6 assume that the device is using a standard 10K Ohm thermistor
and the temperature is calculated in ºC from the ADC value.
Sensor types 7 & 8 return the raw ADC value (see note on [humidity offset](#Humidity-Offset))
for a way to reduce the raw ADC value so that it can be viewed within HomeKit.

# Sensor Polling Time

Sensor polling time is defined by the `"j"` key contained within the
service object.

| Key | Value | Description |
|:-----:|:----:|:------------|
| `"j"` | `30` | **Sensor is polled every 30 seconds (_default_)**
| | `0.1` to `65535` | Float specifying the number of seconds between polls

A temperature and/or humidity sensor is polled on a regular basis to read the
latest values. These values are then posted to HomeKit. If this option is not
specified then the sensor will be polled once every 30 seconds.

# Temperature Offset

Temperature offset is defined by the `"z"` key contained within the service
object.

**NOTE: This option is NOT available for device type 23**

| Key | Value | Description |
|:-----:|:----:|:------------|
| `"z"` | `0.0` | **No offset is applied (_default_)**
| | `-∞ < 0.0 > +∞` | Offset is added to temperature value read

The accuracy of the available one-wire sensors varies and may sometimes read
consistently higher or lower than the actual temperature. The temperature offset
option enables calibration of the sensor by specifying a positive or negative
offset to apply to the reading.

The option uses is a floating point value, accurate to 1 decimal place e.g. 1.1

# Humidity Offset

Humidity offset is defined by the `"k"` key contained within the service
object.

| Key | Value | Description |
|:-----:|:----:|:------------|
| `"k"` | `0` | **No offset is applied (_default_)**
| | `-∞ < 0 > +∞` | Offset is added to humidity value read

The accuracy of the available one-wire sensors varies and may sometimes read
consistently higher or lower than the actual humidity. The humidity offset
option enables calibration of the sensor by specifying a positive or negative
offset to apply to the reading.

The option uses is an integer point value.

**NOTE:** The humidity offset can be used with a temperature sensor (`"t":22`)
in conjunction with thermistor types `"n":5`,`"n":6`,`"n":7` & `"n":8`.
The temperature value will then be multiplied by the humidity offset value
e.g.

## Humidity Offset as ADC multiplier example

```json
{
  "c": { "io":[[[13],3]], "l": 13 },
  "a": [{
    "t": 22,
    "n": 8,
    "k": -3,
    "j": 10
  }]
}
```

In this example the raw ADC value returned from the PTC thermistor is multiplied
by 0.1 before being returned to HomeKit. This can be used to overcome the maximum
value a HomeKit temperature sensor can report i.e. 200°C.

# Wildcard Actions

Wildcard Actions `"y[n]"` are supported by this service.
The supported list is:

| Key | Action |
|:------:|:-----|
| `"y0"` | Trigger action when service reaches a specific temperature
| `"y1"` | Trigger action when service reaches a specific humidity

Refer to [Wildcard Actions](Accessory-Configuration#Wildcard-Actions) for
more detail.

# Data History Characteristics

| Characteristic | Description |
|:------:|:-----|
| `0` | * Current Temperature
| `1` | * Current Relative Humidity
