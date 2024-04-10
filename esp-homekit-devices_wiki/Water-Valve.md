A HomeKit water valve.

| Type | Service Type |
|:----:|:------------|
| `20` | Water Value

The following configuration is available for thermostats:

<!-- markdownlint-disable MD013 -->
| Section | Key | Description |
|---------|:-----:|-------------|
| [Actions](#Actions) | `"0"`, `"1"`, etc. | The actions performed by the service
| [Inching Time](Accessory-Configuration#Inching-Time) | `"i"` | Time period before returning service to previous state
| [Binary Inputs](#Binary-Inputs) | `"b"` | GPIOs that invoke specific actions
| [State & Status Inputs](#State-and-Status-Inputs) | `"f[n]"` & `"g[n]"` | Inputs that manage service state
| [ICMP Ping Inputs](#ICMP-Ping-Inputs) | `"q[n]"` & `"p[n]"` | Ping inputs that manage service state
| [Service Notifications](#Service-Notifications) | `"m"` | Notifications to send to another service
| [Initial Lock State](#Initial-Lock-State) | `"ks"` | Lock state at boot
| [Initial State](#Initial-State) | `"s"` | State a switch service enters on boot
| [Valve Type](#Valve-Type) | `"w"` | Type of valve
| [Maximum Use Time](#Maximum-Use-Time) | `"d"` | Maximum time valve can be on
| [Actions on Boot](Accessory-Configuration#Execution-of-Actions-on-Boot) | `"xa"` | Enable / Disable execution of service actions on boot
| [Historical Data Characteristics](#Historical-Data-Characteristics) ||
<!-- markdownlint-enable MD013 -->

# Example

```json
{
  "c": {
    "io": [ [[12,13],2], [[0],6] ],
    "l": 13, "b": [ [ 0, 5 ] ]
  },
  "a": [{
    "t": 20,
    "0": { "r": [ [ 12 ] ] },
    "1": { "r": [ [ 12, 1 ] ] },
    "b": [ [ 0 ] ],
    "s": 0,
    "w": 1,
    "d": 600
  }]
}
```

The above example defines a Sonoff SV controlling a Water Valve.
The valve switch is controlled using GPIO 12 and the valve can be manually turned
on and off using a single press button connected to
GPIO 0 (`"b": [ [ 0 ] ]`).
The valve is of type "Sprinkler" (`"w": 1`) and
the maximum use time has been set to 10 minutes (`"d": 600`).
The initial state on power up is set to "Off" (`"s": 0`).

# Actions

| Key | Action | Description |
|:------:|:------|:------------|
| `"0"` | OFF | **(_default_)**
| `"1"` | ON |

A water valve has two actions. The [Digital Outputs](Accessory-Configuration#Digital-Outputs)
`"r": [{}]` for each should be configured to attain the desired state.

# Valve Type

Valve Type defined by the `"w"` key contained within the service object.

| Type | Key | Description |
|:----:|:-----|:------------|
| `0` | Water Valve | **(_default_)**
| `1` | Irrigation (Sprinkler) |
| `2` | Shower |
| `3` | Tap / Faucet |

Set the valve type to indicate what type of water device is attached e.g.
`"w":1` indicates a sprinkler is attached.

# Maximum Use Time

Maximum use time is defined by the `"d"` key contained within the service
object.

| Key | State | Description |
|:----:|:-----:|:------------|
| `"d"` | `0` | Timer disabled
| | `3600` | **Timer set to 1 hour (_default_)**
| | `1` to `∞` | Time in seconds to set the use time

This option limits the maximum amount of time that the water valve can be in the
ON state. The default is to limit the valve on time to 3,600 seconds (1 hour),
but this time period can be disabled, lengthened or shortened.

When the timer is enabled then the valve will be turned OFF after the maximum
use time has elapsed.

<!-- TODO:: Find out what happens to the timer is the device is rebooted -->

# Service Notifications

The list of Service Notifications `"m"` values supported by a water valve are:

| Value | Notification |
|:-----:|:------------|
| `0` | **Valve OFF (_default_)**
| `1` | Valve ON
| `-1` | Reset timer
| `-N < -1` | Set time to `N - 2`. If timer is working and new value is lower than current countdown, it will be reset.

See the general [Service Notifications](Accessory-Configuration#Service-Notifications)
section for details of how to configure these notifications.

# Binary Inputs

Binary Inputs `"b"` are supported by this service.

See [Binary Inputs](Accessory-Configuration#Binary-Inputs) for
details on how to define this mandatory option.

# State and Status Inputs

State inputs `"f[n]"` & Status Inputs `"g[n]"` are supported by this service.
The supported list is:

| Key | Action |
|:------:|:-----|
| `"f0"` | Set service state and perform action "0" (_Off_)
| `"f1"` | Set service state and perform action "1" (_On_)
||
| `"g0"` | Set service state to _Off_
| `"g1"` | Set service state to _On_

Refer to [State Inputs](Accessory-Configuration#Fixed-State-Inputs) for
more detail and examples.

# ICMP Ping Inputs

ICMP Ping inputs `"p[n]"` and `"q[n]"` are supported by this service.
The supported list is:

| Key | Action |
|:------:|:-----|
| `"p0"` | Set service state and perform action "0" (_Off_)
| `"p1"` | Set service state and perform action "1" (_On_)
||
| `"q0"` | Set service state to _Off_
| `"q1"` | Set service state to _On_

Refer to [ICMP Ping Inputs](Accessory-Configuration#ICMP-Ping-Inputs) for
more detail.

# Initial Lock State

The Initial Lock State about Service and Physical controls.

| Key  | Value | Notification |
| :---:|:-----:|:------------|
| `"ks"` | `0` | All locked
| | `1` | Service unlocked. Physical controls locked
| | `2` | Service locked. Physical controls unlocked
| | `3` | **All unlocked (_default_)**

# Initial State

The Initial State key is supported by this service.
Refer to [Initial State](Accessory-Configuration#Initial-State) for details
of the available values.

# Historical Data Characteristics

| Characteristic | Description |
|:------:|:-----|
| `0` | On / Off
| `2` | Set duration
| `3` | * Remaining duration