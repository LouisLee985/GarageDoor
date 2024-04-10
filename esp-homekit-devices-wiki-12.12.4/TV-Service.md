A HomeKit TV service.

| Type | Service Type |
|:----:|:------------|
| `60` | TV Service

The following configuration is available for TVs:

<!-- markdownlint-disable MD013 -->
| Section | Key | Description |
|---------|:-----:|-------------|
| [Actions](#Actions) | `"0"`, `"1"`, etc. | The actions performed by the service
| [Binary Inputs](#Binary-Inputs) | `"b"` | GPIOs that invoke specific actions
| [State & Status Inputs](#State-and-Status-Inputs) | `"f[n]"` & `"g[n]"` | Inputs that manage service state
| [ICMP Ping Inputs](#ICMP-Ping-Inputs) | `"q[n]"` & `"p[n]"` | Ping inputs that manage service state
| [Service Notifications](#Service-Notifications) | `"m"` | Notifications to send to another service
| [Initial Lock State](#Initial-Lock-State) | `"ks"` | Lock state at boot
| [Initial State](#Initial-State) | `"s"` | State a switch service enters on boot
| [Actions on Boot](Accessory-Configuration#Execution-of-Actions-on-Boot) | `"xa"` | Enable / Disable execution of service actions on boot
| [TV Input Sources](#TV-Input-Sources) | `"i"` | Array of supported TV Inputs e.g. HDMI, DVB etc.
| [Historical Data Characteristics](#Historical-Data-Characteristics) ||
<!-- markdownlint-enable MD013 -->

# Example

```json
{
  "c":{ "io":[[[14],2]], "t":14, "p":"J(J(AcAcAcDFAc" },
  "a":[{
    "t":60,
    "xa":0,
    "i":[
      { "n":"MENU", "0":{ "i": [{ "r":2, "c":"CeCfAaBcAaAbC" }] } },
      { "n":"SOURCE", "0":{ "i":[{ "r":2, "c":"CeCeAhG" }] } },
      { "n":"MUTE", "0":{ "i":[{ "r":2,"c":"CeCeDhD" }] } }
    ],
    "0":{ "i":[{ "r":4,"c":"CeCfAfAaF" }] },
    "1":{ "i":[{"r":4,"c":"CeCfAfAaF" }] },
    "6":{ "i":[{ "r":2,"c":"CeCjBaEbA" }] },
    "7":{ "i":[{ "r":2,"c":"CeCeAdBbDbA" }] },
    "8":{ "i":[{ "r":2,"c":"CeCeAaAbBbAaBbA" }] },
    "9":{ "i":[{ "r":2,"c":"CeCfAcBaAaCbA" }] },
    "10":{ "i":[{ "r":2,"c":"CeChAaBaCaAbA" }] },
    "11":{ "i":[{ "r":2,"c":"CeChBaAaCbAaA" }] },
    "13":{ "i":[{ "r":2,"c":"CeCeBaAaBcAaAbA" }] },
    "17":{"i":[{"r":2,"c":"CeCeEhC"}]},
    "22":{"i":[{"r":2,"c":"CeCeChE"}]},
    "23":{"i":[{"r":2,"c":"CeCeBaAfAaD"}]},
    "q0":[{"h":"192.168.1.100","r":0}],
    "q1":[{"h":"192.168.1.100","r":1}]
  }]
}
```

The above example is a real world example provided by @TriderG75.
The example is for a Samsung TV using a universal IR device (such as a
Smart Device IR Blaster).

Execution of all actions is disabled while the device boots (`"xa:0"`) to ensure
neither the power on or power off action will be triggered on boot.

The example has IR commands for each of the TV Service Actions `"0"` thru `"23"`
and defines three TV Input Sources; `MENU`, `SOURCE` & `MUTE`.

Refer the the [IR Action](Accessory-Configuration#Send-IR-Code-Actions)
documentation to see how to set up IR commands to control the TV via the
universal IR device.

Additionally in this example the service has two [ICMP Ping Status](#ICMP-Ping-Inputs)
inputs defined. The On/Off state of this Samsung Smart TV can determined by
pinging the IP address of the TV. If the ping is successful then the TV is on.
The Ping Status inputs set the status the TV Power depending on the response
from the ping.

This example also shows how a dummy switch can be created to allow the device
to enter setup mode by pressing a switch within the HomeKit application:
`{ "i":0.5, "1":{ "s":[{ "a":1 }]} }`

# TV Input Sources

A TV service can provide multiple TV Input Sources `"i"`. These are the inputs
the TV has  e.g. HDMI1, HDMI2, USB etc.

The service can be configured to have as many TV Input Sources as required to
control the TV. TV Input Sources show up within the HomeKit TV App as a scrollable
list of inputs that can be selected.

See above [example](#Example) for ways that the TV Input Sources can be configured.
Each source `"i"` definition requires a name (`"n"`) and an action (`"0"`).
The name `"n"` is a text string. The action `"0"` can be any action you want to
take in order to meet the requirement of the named source, but would normally
be an IR defined string (`"c"`) e.g. `{"n":"HDMI1","0":{"i":[{"c":"CeCjBaEbA"}]}}`

# Actions

A TV Service has many actions. See the list below for all the possible actions
the HAA TV Service provides.

| Key | Action | Description |
|:----:|:-------|:------------|
| `"0"` | Power off | **Power off the TV (_default_)**
| `"1"` | Power on | Power on the TV
| `"6"` | Arrow up |
| `"7"` | Arrow down |
| `"8"` | Arrow left |
| `"9"` | Arrow right |
| `"10"` | Select / OK |
| `"11"` | Back |
| `"13"` | Play / Pause |
| `"17"` | Info |
| `"20"` | No mute |
| `"21"` | Mute |
| `"22"` | Volume up |
| `"23"` | Volume down |
| `"30"` | Show TV Settings |
| `"50"` | Power mode |

# Service Notifications

The list of Service Notifications `"m"` values supported by a TV Service are:

| Value | Notification |
|:-----:|:------------|
|  `0` | **Turn OFF (_default_)**
|  `1` | Turn ON
| `-1` | Set status to ON
| `-2` | Set status to OFF
|  `6` | Arrow up
|  `7` | Arrow down
|  `8` | Arrow left
|  `9` | Arrow right
| `10` | Select / OK
| `11` | Back
| `13` | Play / Pause
| `17` | Info
| `20` | No mute
| `21` | Mute
| `22` | Volume up
| `23` | Volume down
| `30` | Show TV Settings
| `50` | Power mode
| `100 + N` | Change to INPUT N. First declared INPUT is `1`

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
The initial state that a switch enters on boot can be set using the `"s"` option.

# Historical Data Characteristics

| Characteristic | Description |
|:------:|:-----|
| `0` | On / Off
| ... TO-DO
