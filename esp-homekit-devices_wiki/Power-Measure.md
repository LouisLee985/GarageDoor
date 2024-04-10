
Power measuring characteristics can be added as extra service to any accessory and the power measurements
can be reported to HomeKit.

You will need to use [**HAA Home Manager**](HAA-Home-Manager) or other compatible HomeKit application to access
the values that these sensors are reporting.

It is possible to declare this service as primary, but it is not recommended because it
is incompatible with Apple's Home App and an incompatible icon will appear.

To declare a power measuring service type, 

| Type | Service Type |
|:----:|:------------|
| `75` | Power measure

Below are details on how to setup and use the power measurement capabilities.

The following configuration options are available for power measure:

<!-- markdownlint-disable MD013 -->
| Section | Key | Description |
|---------|:-----:|-------------|
| [Chip Type](#Chip-Type) | `"n"` | Chip type configuration
| [Chip Data](#Chip-Data) | `"dt"` | Chip configuration data array
| [Reading Period](#Reading-Period) | `"j"` | Period in seconds between readings
| [Voltage Factor](#Factors-and-Offsets) | `"vf"` | Voltage factor adjustment
| [Voltage Offset](#Factors-and-Offsets) | `"vo"` | Voltage offset adjustment
| [Current Factor](#Factors-and-Offsets) | `"cf"` | Current factor adjustment
| [Current Offset](#Factors-and-Offsets) | `"co"` | Current offset adjustment
| [Power Factor](#Factors-and-Offsets) | `"pf"` | Power factor adjustment
| [Power Offset](#Factors-and-Offsets) | `"po"` | Power offset adjustment
| [Service Notifications](#Service-Notifications) | `"m"` | Notifications sent by other services
| [Wildcard Actions](#Wildcard-Actions) | `"y[n]"` | Perform an action when an service reaches a target value
| [Service Characteristics](#Service-Characteristics) ||
<!-- markdownlint-enable MD013 -->

# Example 1

```json
{
  "c":{
    "io":[[[15,0,2],2],[[13],6]],
    "l":2,"b":[[13,5]]
  },
  "a":[
    {
      "t":2,
      "0":{"r":[[15],[0,1]]},
      "1":{"r":[[15,1],[0]]},
      "b":[[13]],
      "es":[{
        "t":75,
        "dt":[5,4,12],
        "vf":0.13334,
        "cf":0.01295,
        "pf":1.5312,
        "y0":[{"v":245,"0":{"m":[[1]]}}],
        "y1":[{"v":15,"0":{"m":[[1]]}}]
      }]
    }
  ]
}
```

This is an example of a Gosund SP111 v1.1 with over voltage (245VAC) and
over current (15A) protection.

See [Measurement Calibration](#Measurement-Calibration) for setting `"vf"`,
`"cf"` & `"pf"` factors.

# Example 2

```json
{
  "c": {
    "io":[[[14,12,1,13],2],[[3],6,1],[[4,5],1]],
    "l":1,"b":[[3,5]]
  },
  "a": [{
    "t": 2,
    "0": {"r":[[14],[13,1]]},
    "1": {"r":[[14,1],[13]]},
    "b": [[3]]
    "es":[{
      "t": 75,
      "h": 2,
      "n": 0,
      "dt": [4, 5, 12],
      "j": 60,
      "vf": 0.1674,
      "cf": 0.01768,
      "pf": 2.474,
      "y2":[
        {
          "v": 0,
          "r": 1,
          "0": {"h":[{"h":"mynas.local","p": 8086,"m": 2,"u": "write?db=outletdb","c": "sensor,device=2nice-laptop,type=BL0937,location=hall voltage=#HAA@0000,current=#HAA@0001,power=#HAA@0002"}]}
        },
        {
          "v": 2900,
          "0":{"m":[[1,0]]}
        }
      ]
    }]
  }]
}
```

This is an example of a 2nice UP111 WiFi smart plug with over voltage (245VAC) and
over current (13A) protection.

See [Measurement Calibration](#Measurement-Calibration) for setting `"vf"`,
`"cf"` & `"pf"` factors.

Note the first entry in Wildcard `"y2"` sends an entry containing the
voltage, current and power readings to an influx database every 60 seconds (`"j":60`).
The second entry in the wildcard turns off the outlet if is consuming more than
2.9KW of power.

This example also makes use the [HomeKit Visibility](Accessory-Configuration#HomeKit-Visibility)
option added in firmware `v3.0.0` to hide service from Apple Home App, but keep it
enabled for sending readings to an influx databas, showing data in [**HAA Home Manager**](HAA-Home-Manager).

# Chip Type

<!-- markdownlint-disable MD013 -->
| Key | Value | Description |
|:------:|:------|:------------|
| "n" | 0 | **HLW8012/BL0937 with Sel1 GPIO LOW to read current (_default)**
|  | 1 | HLW8012/BL0937 with Sel1 GPIO HIGH to read current
|  | 2 | ADE7953 I2C Channel A
|  | 3 | ADE7953 I2C Channel B
|  | 4 | Virtual Service with calculated consumption based on power
|  | 5 | Virtual Service
<!-- markdownlint-enable MD013 -->

# Chip Data

This array is used to define configuration of desired chip.

<!-- markdownlint-disable MD013 -->
| Chip | Value | Description |
|:------:|:------|:------------|
| HLW8012/BL0937 | `"dt" : [ CF, CF1, Sel ]` | GPIOs needed. If Only CF if used you can use `"dt": [ CF ]`
|   ADE7953 I2C  | `"dt" : [ I2C Bus, Chip Address (decimal) ]` | I2C Bus declaration is needed
<!-- markdownlint-enable MD013 -->

Remember to declare used `CF` and `CF1` GPIOs as Input into `"io":[...]` array, and `Sel` GPIO as Output. See [GPIOs Configuration](GPIOs-Configuration)

# Reading Period

The option `"j"` can be set to define the period of time to take between each
sensor reading.
If this option is omitted the default value of `5` will be used.
State inputs `"f[n]"` & Status Inputs `"g[n]"` are supported by these services.

# Factors and Offsets

Sometimes, read value needs to be recalculated in order to obtain the final value. Factor and offset values are values
applied as:

```
Final Value = (Value * Factor) + offset
```

| Key | Default Value | Description |
| :--:|:-----:|:------------|
| "vf" | `1` | Set factor for voltage
| "vo" | `0` | Set offset for voltage
| "cf" | `1` | Set factor for current
| "co" | `0` | Set offset for current
| "pf" | `1` | Set factor for power
| "po" | `0` | Set offset for power

Each of the measurement types Voltage, Current and Power need to be calibrated
before the sensor will return accurate and meaningful readings.
See the [Measurement Calibration](#Measurement-Calibration) section on how to
go about calibrating a sensor.

Once calibrated the `"vf"`, `"vo"`, `"cf"`, `"co"`, `"pf"` & `"po"` options
need to be set within the service definition.

# Service Notifications

The list of Service Notifications `"m"` values supported are:

| Key | Value | Notification |
| :--:|:-----:|:------------|
| "v" | 0 | Reset consumption. Internal clock must be set.

See the general [Service Notifications](Accessory-Configuration#Service-Notifications)
section for details of how to configure these notifications.

# Wildcard Actions

Wildcard Actions `"y[n]"` are supported by these services.
The supported list is:

| Key | Action |
|:------:|:-----|
| "y0" | Trigger action when service reaches a specific voltage
| "y1" | Trigger action when service reaches a specific current
| "y2" | Trigger action when service reaches a specific power
| "y3" | Trigger action when service reaches a specific consumption

Refer to [Wildcard Actions](Accessory-Configuration#Wildcard-Actions) for
more detail.

# Measurement Calibration

In order for the device to return accurate measurements it must be calibrated.
To calibrate the device you will require:

- An AC capable, calibrated multi-meter
- A **known** wattage load with a power factor as close to 1 as possible e.g.
a resistive load such as a incandescent or halogen light bulb.

**NOTE:** Equipment such as an electric kettle, heater, or blow dryer are also
options but you will also need a power meter since the power draw could vary.

Before attempting to calibrate set the service configuration to:

```json
{"t":75, "j":10, "vf":0.1, "cf":0.1, "pf":1}
```

**NOTE** You will also need to include values for `"dt":`.

## Calibrate the Voltage Factor

Run the device in debug mode and watch the debug output.
Look for a statement like `PM Acc 2: V = 250.22, C = 0, P = 0`
To set the voltage factor:

1. Measure the mains voltage on the socket using the multimeter: we will call
this the _real_ value
2. While measuring the real value record the 'V' value from the debug log output:
we will call this the _sensor_ value
3. Get a few readings and take the average of both the _real_ and _sensor_ values
4. To calculate the offset:

```text
vf = real value average / (sensor value average * 10)
```

## Calibrate the Power Factor

Run the device in debug mode and watch the debug output.
Look for a statement like `PM Acc 2: V = 250.22, C = 0, P = 0`
To set the power factor:

1. Turn on the constant current device
2. Record at least 5 values of the 'P' measurement: call this the _sensor_ value
and take the average
3. Record the value of the constant current device e.g. 60 and call this the
_real_ value
4. To calculate the offset:

```text
pf = real value / sensor value average
```

## Calibrate the Current Factor

Run the device in debug mode and watch the debug output.
Look for a statement like `PM Acc 2: V = 250.22, C = 0, P = 0`
To set the current factor:

1. Turn on the constant current device
2. Record at least 5 values of the 'C' measurement: call this the _sensor_ value
and take the average
3. Use the multimeter to record the real voltage reading: call this the
_real voltage_ value
4. Record the power value of the constant current device e.g. 60 and call this
the _real power_ value
5. To calculate the offset:

```text
cf = (real power value / real voltage value) / (sensor value average * 10)
```

# Service Characteristics

| Characteristic | Description |
|:------:|:-----|
| 0 | * Voltage
| 1 | * Current
| 2 | * Power
| 3 | * Consumption
| 4 | Consumption before reset
