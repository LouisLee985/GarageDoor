A switch can be defined as a `Switch` or an `Outlet`. Both types have the same
set of options available to them.

| Type | Service Type |
|:----:|:------------|
| `1` | Switch
| `2` | Outlet

The following configuration is available for switches:

<!-- markdownlint-disable MD013 -->
| Section | Key | Description |
|---------|:-----:|-------------|
| [Actions](#Actions) | `"0"`, `"1"` etc. | The actions performed by the service
| [Binary Inputs](#Binary-Inputs) | `"b"` | GPIOs that invoke specific actions
| [Inching Time](Accessory-Configuration#Inching-Time) | `"i"` | Time period before returning service to off state
| [State & Status Inputs](#State-and-Status-Inputs) | `"f[n]"` & `"g[n]"` | Inputs that manage service state
| [ICMP Ping Inputs](#ICMP-Ping-Inputs) | `"q[n]"` & `"p[n]"` | Ping inputs that manage service state
| [Service Notifications](#Service-Notifications) | `"m"` | Notifications sent from another service
| [Initial Lock State](#Initial-Lock-State) | `"ks"` | Lock state at boot
| [Initial State](#Initial-State) | `"s"` | State an service enters on boot
| [Maximum Use Time](#Maximum-Use-Time) | `"d"` | Maximum time service can be on
| [Actions on Boot](Accessory-Configuration#Execution-of-Actions-on-Boot) | `"xa"` | Enable / Disable execution of service actions on boot
| [Data History Characteristics](#Data-History-Characteristics) ||
<!-- markdownlint-enable MD013 -->

# Example

```json
{
  "c": { 
    "io": [ [ [ 12, 13 ], 2 ], [ [ 0 ], 6 ] ],
    "l": 13, "b": [ [ 0, 5 ] ]
  },
  "a": [{
    "t": 1,
    "d": 3600,
    "s": 5,
    "0": { "r": [ [ 12, 0 ] ] },
    "1": { "r": [ [ 12, 1 ] ] },
    "b": [ [ 0 ] ]
  }]
}
```

This is an example of a Sonoff Basic unit configured as a switch (`"t": 1`),
using GPIO 12 as the binary output to control the power relay in the device.
The LED is defined as being connected to GPIO 13. A button is also defined
for entering [Setup Mode](Setup-Mode) when the button on GPIO 0 is pressed for longer
then 8 seconds.

A binary input is configured as being connected to GPIO 0 and two button
actions are defined; `"0" & "1"`. The first press of the button invokes action
`"0"` and sets the GPIO `12` to a logic low (`0`). The second press of the button
invokes action `"1"` and sets the output to a logic high (`1`).

Set the type to 2 (`"t": 2`) if you would prefer the switch to appear in HomeKit
as an `Outlet` e.g. when you have the device controlling a power socket or power
strip.

The switch also has a [maximum use time](#Maximum-Use_time) of 1 hour
(`"d": 3600`) and its [initial state](#Initial-State) when the service is
powered on or rebooted will be the last state before it was rebooted (`"s":5`).

**NOTE: The following options are not needed in this example as they are the
default options but are included to make the example more readable:**
`"t": 1` & `"v": 0`

# Actions

| Key | Action | Description |
|:----:|:-------|:------------|
| `"0"` | Off | The default action after boot unless the Initial State has been set
| `"1"` | On |

A switch has two actions. The [Binary Outputs](Accessory-Configuration#Binary-Outputs)
`"r": [ ]` for each should be configured to attain the desired state.

# Maximum Use Time

Maximum use time is defined by the `"d"` key contained within the
service object.

| Key | Value | Description |
|:----:|:-----:|:------------|
| `"d"` | `0` | **Timer is disabled (_default_)**
|  | `1` to `∞` | Integer value specifying number of seconds

This option limits the maximum amount of time that the service can be in the
ON state. The default is no limit.

When the timer is enabled then the service will be turned OFF after the maximum
use time has elapsed.

**NOTE: The value is an integer so no decimals :-)**

# Service Notifications

The list of Service Notifications `"m"` values supported are:

| Value | Notification |
|:-----:|:------------|
| `0` | **Switch OFF (_default_)**
| `1` | Switch ON
| `2` | Switch state only OFF
| `3` | Switch state only ON
| `4` | Toggle switch
| `5` | Toggle switch state
| `-1` | Reset inching and timer
| `-N` to `-2` | Set time to `N - 2` seconds. If timer is working and new value is lower than current countdown, it will be reset.

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

# Data History Characteristics

| Characteristic | Description |
|:------:|:-----|
| `0` | On / Off
| `1` | Set duration
| `2` | * Remaining duration
