Many HomeKit sensors have the same configurable options. The common sensors are
defined here along with their available options.

| Type | Service Type |
|:----:|:------------|
| `5` | Contact Sensor
| `6` | Occupancy Sensor
| `7` | Leak Sensor
| `8` | Smoke Sensor
| `9` | Carbon Monoxide Sensor
| `10` | Carbon Dioxide Sensor
| `11` | Filter Change Sensor*
| `12` | Motion Sensor

\*Filter Change Sensor is incompatible with a main service and it should be declared as extra service.

The following configuration is available for sensors:

<!-- markdownlint-disable MD013 -->
| Section | Key | Description |
|---------|:-----:|-------------|
| [Actions](#Actions) | `"0"`, `"1"`, etc. | The actions performed by the service
| [Binary Inputs](#Binary-Inputs) | `"b"` | GPIOs that invoke specific actions
| [Inching Time](Accessory-Configuration#Inching-Time) | `"i"` | Time period before returning service to previous state
| [State & Status Inputs](#State-and-Status-Inputs) | `"f[n]"` & `"g[n]"` | Inputs that manage service state
| [Extra Characteristics](#extra-characteristics) | `"dt"` | Extra characteristics for Monoxide and Dioxide Carbon Sensors
| [Service Notifications](#Service-Notifications) | `"m"` | Notifications to send to another service
| [Initial Lock State](#Initial-Lock-State) | `"ks"` | Lock state at boot
| [Actions on Boot](Accessory-Configuration#Execution-of-Actions-on-Boot) | `"xa"` | Enable / Disable execution of service actions on boot
| [Service Characteristics](#Service-Characteristics) ||
<!-- markdownlint-enable MD013 -->

# Example

```json
{
  "c": { "io":[ [[16,13],2], [[14],6,1] ], "l": 13},
  "a": [{
    "t": 12,
    "i": 10,
    "0": { "r": [ [ 16 ] ] },
    "1": { "r": [ [ 16, 1 ] ] },
    "f1": [ [ 14 ] ]
  }]
}
```

This is an example of a Sonoff Basic unit with a motion sensor (`"t": 12`)
connected to GPIO 14 (`"f1": [{ "g": 14 }]`) and an LED connected to GPIO 13
(`"l": 13`).

The motion sensor service (`"t": 12`) causes
action `"1"` to be performed when activated (`"f1"`). 10 seconds later
action `"0"` will be performed because of the inching time option (`"i": 10`)

**NOTE: The following options are not needed in this example as they are the
default options but are included to make the example more readable:**
`"t": 1` & `"v": 0`

# Binary Inputs

Binary Inputs `"b"` are supported by this service.

See [Binary Inputs](Accessory-Configuration#Binary-Inputs) for
details on how to define this mandatory option.

# Actions

A sensor has two actions.

<!-- markdownlint-disable MD013 -->
| Action | State | Description |
|:------:|:------|:------------|
| `"0"` | Deactivated | This action should be performed when sensor is deactivated. This is the default action on boot.
| `"1"` | Activated | This action should be performed when sensor is activated
<!-- markdownlint-enable MD013 -->

The [Digital Outputs](Accessory-Configuration#Digital-Outputs)
`"r": [{}]` for each should be configured to attain the desired state.

# Extra Characteristics

This option allow to add Level and Peak Level characteristics for Monoxide and Dioxide Carbon Sensors. Their values must be assigned using other services, like Free Monitor.

| Key | Value | Description
|:---:|:-----:|:-----------
|`"dt"`| `0`  | **None (_Default_)**
| | `1` | Level characteristic
| | `2` | Level and Peak Level characteristics

# Service Notifications

The list of notifications `"m"` supported by a sensor are as follows:

| Value | Notification |
|:-----:|:------------|
| `0` | **Sensor DEACTIVATED (_default_)**
| `1` | Sensor ACTIVATED
| `2` | Sensor status only DEACTIVATED
| `3` | Sensor status only ACTIVATED
| `4` | Toggle current state
| `5` | Toggle status only
| `-1` | Reset inching timer

See the general [Service Notifications](Accessory-Configuration#Service-Notifications)
section for details of how to configure these notifications.

# Initial Lock State

The Initial Lock State about Service and Physical controls.

| Key  | Value | Notification |
| :---:|:-----:|:------------|
| `"ks"` | `0` | All locked
| | `1` | Service unlocked. Physical controls locked
| | `2` | Service locked. Physical controls unlocked
| | `3` | **All unlocked (_default_)**

# State and Status Inputs

State inputs `"f[n]"` & Status Inputs `"g[n]"` are supported by this service.
The supported list is:

| Key | Action |
|:------:|:-----|
| `"f0"` | Perform action `"0"` (_Deactivate_)
| `"f1"` | Perform action `"1"` (_Activate_)
||
| `"g0"` | Set service state to _Deactivated_
| `"g1"` | Set service state to _Activated_

Refer to [State Inputs](Accessory-Configuration#Fixed-State-Inputs) for
more detail and examples.

# ICMP Ping Inputs

ICMP Ping inputs `"p[n]"` and `"q[n]"` are supported by this service.
The supported list is:

| Key | Action |
|:------:|:-----|
| `"p0"` | Perform action `"0"` (_Deactivate_)
| `"p1"` | Perform action `"1"` (_Activate_)
||
| `"q0"` | Set service state to _Deactivated_
| `"q1"` | Set service state to _Activated_

Refer to [ICMP Ping Inputs](Accessory-Configuration#ICMP-Ping-Inputs) for
more detail.

# Service Characteristics

| Characteristic | Description |
|:------:|:-----|
| `0` | Sensor State
| `1` | * Level
| `2` | * Peak Level
