The HomeKit light sensors have a number of common options and
are grouped here.

| Type | Service Type |
|:----:|:------------|
| `50` | Light Sensor

The following configuration is available:

<!-- markdownlint-disable MD013 -->
| Section | Key | Description |
|---------|:-----:|-------------|
| [Wildcard Actions](#Wildcard-Actions) | `"y[n]` | Perform an action when a service reaches a target lux value
| [Sensor Type](#Sensor-Type) | `"n"` | Type of sensor attached to service
| [GPIO](#GPIO) | `"g"` | GPIO used by ADC for ESP32 chips
| [Configuration Data Array](#Configuration-Data) | `"dt"` |
| [Resistor Value](#Resistor-Value) | `"re"` | 
| [Power Value](#Power-Value) | `"po"` | 
| [Sensor Polling Time](#Sensor-Polling-Time) | `"j"` | Frequency sensor is read
| [Light Sensor Factor](#Light-Sensor-Factor) | `"f"` | Correction factor to apply
| [Light Sensor Offset](#Light-Sensor-Offset) | `"o"` | Correction offset to apply
| [Service Characteristics](#Service-Characteristics) ||
<!-- markdownlint-enable MD013 -->

# Example 1

<!-- spellchecker: disable -->
```json
{
  "c": { "io": [ [ [ 13 ], 2 ] ], "l": 13 },
  "a": [{
    "t": 50,
    "n": 0,
    "f": 14357564.33,
    "po": 1.396066767,
    "re": 8550
  }]
}
```
<!-- spellchecker: enable -->

# Sensor Type

Sensor type is defined by the `"n"` key contained within the service object.

<!-- markdownlint-disable MD013 -->
| Key | Type | Description |
|:---:|:----:|:-------------|
| `"n"` | `0` | ADC
|     | `1` | ADC
|     | `2` | BH1750. Requires I2C bus declaration
<!-- markdownlint-enable MD013 -->

# GPIO

Only needed for ESP32, because ESP8266 has only one ADC pin.

Remember to declare GPIO as ADC into `"io":[...]` array. See [GPIOs Configuration](GPIOs-Configuration)

| Key | Type | Description |
|:---:|:----:|:-------------|
| `"g"` | integer | GPIO number

# Configuration Data

Array with information about sensor. For BH1750, `"dt"` key must be in this format:
`"dt" : [I2C Bus, Address]`

Code Address as follow:
| Addr Pin | Address |
|:--------:|:-------:|
| LOW / GND | `35`
| HIGH / VCC | `92`

# Resistor Value

TO-DO

# Power Value

TO-DO

# Sensor Polling Time

Sensor polling time is defined by the `"j"` key contained within the
service object.

| Key | Value | Description |
|:-----:|:----:|:------------|
| `"j"` | `3` | **Sensor is polled every 3 seconds (_default_)**
| | `0.1` to `65535` | Float specifying the number of seconds between polls

A light sensor is polled on a regular basis to read the
latest values. These values are then posted to HomeKit. If this option is not
specified then the sensor will be polled once every 3 seconds.

# Light Sensor Factor

Light sensor factor is defined by the `"f"` key contained within the service
object.

| Key | Value | Description |
|:-----:|:----:|:------------|
| `"f"` | `1` | **No factor is applied (_default_)**
| | `-∞` to `+∞` | factor is applied to lux value read

The option uses is a floating point value, accurate to 1 decimal place e.g. 1.1


# Light Sensor Offset

Light sensor offset is defined by the `"o"` key contained within the service
object.

| Key | Value | Description |
|:-----:|:----:|:------------|
| `"o"` | `0.0` | **No offset is applied (_default_)**
| | `-∞` to `+∞` | Offset is added to lux value read

The option uses is a floating point value, accurate to 1 decimal place e.g. 1.1

# Wildcard Actions

Wildcard Actions `"y[n]"` are supported by this service.
The supported list is:

| Key | Action |
|:------:|:-----|
| `"y0"` | Trigger action when service reaches a specific lux value

Refer to [Wildcard Actions](Accessory-Configuration#Wildcard-Actions) for
more detail.

# Service Characteristics

| Characteristic | Description |
|:------:|:-----|
| `0` | * Current light level