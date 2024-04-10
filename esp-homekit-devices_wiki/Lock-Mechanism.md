A HomeKit Lock Mechanism service.

| Type | Service Type |
|:----:|:------------|
| `4` | Lock Mechanism

The following configuration is available for lock mechanisms:

<!-- markdownlint-disable MD013 -->
| Section | Key | Description |
|---------|:-----:|-------------|
| [Actions](#Actions) | `"0"`, `"1"`, etc. | The actions performed by the service
| [Inching Time](Accessory-Configuration#Inching-Time) | `"i"` | Time period before returning first mechanism to previous state
| [Binary Inputs](#Binary-Inputs) | `"b"` | GPIOs that invoke specific actions
| [State & Status Inputs](#State-and-Status-Inputs) | `"f[n]"` & `"g[n]"` | Inputs that manage service state
| [ICMP Ping Inputs](#ICMP-Ping-Inputs) | `"q[n]"` & `"p[n]"` | Ping inputs that manage service state
| [Service Notifications](#Service-Notifications) | `"m"` | Notifications sent by other services
| [Initial Lock State](#Initial-Lock-State) | `"ks"` | Lock state at boot
| [Initial State](#Initial-State) | `"s"` | State a lock service enters on boot
| [Actions on Boot](Accessory-Configuration#Execution-of-Actions-on-Boot) | `"xa"` | Enable / Disable execution of service actions on boot
| [Service Characteristics](#Service-Characteristics) ||
<!-- markdownlint-enable MD013 -->

# Example of single lock mechanism

```json
{
  "c":{ "io":[[[4],2],[[5],6,0,1]] },
  "a":[{
    "t":4,
    "i":3,
    "0":{"r":[[4,1,0.5]]},
    "1":{"r":[[4]]},
    "b":[[5,0]]
  }]
}
```

This is an example of a lock mechanism with an external push button (`"t":4`).
The inching time of the service is set to 3 seconds (`"i":3`), causing the
service to automatically re-lock, 3 seconds after being unlocked.
The lock mechanism is controlled using GPIO 4.
The external push button is connected to GPIO 5. With no pull-up (`"p":0),
inverted input (`"i":1`) and single press that is opposite to the default (`"t":0`).

# Actions

A lock mechanism has the following actions.

| Key | Action | Description |
|:------:|:------|:------------|
| `"0"` | UNLOCK | Unlock the mechanism
| `"1"` | LOCK | Lock the mechanism

The [Digital Outputs](Accessory-Configuration#Digital-Outputs)
`"r": [[]]` for each should be configured to attain the desired state.

# Service Notifications

The list of notifications `"m"` supported by a lock mechanism are as follows:

| Value | Notification | Description 
|:-----:|:------------|:---------
| `0` | UNLOCK | **Unlock the mechanism (_default_)**
| `1` | LOCK | Lock the mechanism
| `2` | UNLOCK Status | Change status only to unlock
| `3` | LOCK Status | Change status only to lock
| `4` | Toggle state | Toggle current lock state
| `5` | Toggle status | Toggle current lock status only
| `-1` | Reset inching timer

Service notifications can be included as part of an action definition.
When an action occurs any one of the above notifications can be sent to
another service using the `"m"` option within the action object.

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
| `"f0"` | Perform action "0" (_Unlock_)
| `"f1"` | Perform action "1" (_Lock_)
||
| `"g0"` | Set service state to _Unlock_
| `"g1"` | Set service state to _Lock_

Refer to [State Inputs](Accessory-Configuration#Fixed-State-Inputs) for
more detail and examples.

# ICMP Ping Inputs

ICMP Ping inputs `"p[n]"` and `"q[n]"` are supported by this service.
The supported list is:

| Key | Action |
|:------:|:-----|
| `"p0"` | Perform action "0" (_Unlock_)
| `"p1"` | Perform action "1" (_Lock_)
||
| `"q0"` | Set service state to _Unlock_
| `"q1"` | Set service state to _Lock_

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
Refer to [Initial State](Accessory-Configuration#Initial-State) for more details.

| Key | State | Description |
|:----:|:-----:|:------------|
| `"s"` | `0` | UNLOCKED
| | `1` | **LOCKED (_default_)**
| | `4` | Defined by fixed state inputs
| | `5` | Last state before restart
| | `6` | Opposite to last state before restart

# Service Characteristics

| Characteristic | Description |
|:------:|:-----|
| `1` | Lock Target State
