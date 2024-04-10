A fan service

This service was implemented in firmware version `1.7.0`
<!-- FIXME: Remove this line after September 2020 -->

| Type | Service Type |
|:----:|:------------|
| `65` | Fan

The following configuration is available for fans:

<!-- markdownlint-disable MD013 -->
| Section | Key | Description |
|---------|:-----:|-------------|
| [Actions](#actions) | `"0"`, `"1"`, etc. | The actions performed by the service
| [Binary Inputs](#binary-inputs) | `"b"` | GPIOs that invoke specific actions
| [Inching Time](accessory-configuration#inching-time) | `"i"` | Time period before returning service to previous state
| [State & Status Inputs](#state-and-status-inputs) | `"f[n]"` & `"g[n]"` | Inputs that manage service state
| [ICMP Ping Inputs](#icmp-ping-inputs) | `"q[n]"` & `"p[n]"` | Ping inputs that manage service state
| [Wildcard Actions](#wildcard-sctions) | `"y[n]"` | Perform an action when an service reaches a target value
| [Service Notifications](#service-notifications) | `"m"` | Notifications sent by another service
| [Initial Lock State](#initial-lock-state) | `"ks"` | Lock state at boot
| [Initial State](#initial-state) | `"s"` | State a switch service enters on boot
| [Total Speed Steps](#total-of-speed-steps) | `"e"` | Available Speed Steps
| [Actions on Boot](accessory-configuration#execution-of-actions-on-boot) | `"xa"` | Enable / Disable execution of service actions on boot
| [Service Characteristics](#service-characteristics) ||
<!-- markdownlint-enable MD013 -->

### Example of a Sonoff iFan03 script:
<!-- markdownlint-disable MD013 -->
```json
{
  "c":{"io":[[[9,12,14,15,13],2],[[0],6]],"l":13,"b":[[0,5]]},
  "a":[{
    "t":65,
    "0":{"r":[[15],[12],[14]]},
    "y0":[
      {"v": 1, "0":{"r":[[15,1,0.5],[12],[14,0,0.6]]} },
      {"v":33, "0":{"r":[[15,1,0.5],[12,0,0.6],[14,0,0.6]]} },
      {"v":67, "0":{"r":[[15,1],[12],[14]]} }
    ],
    "es":[{
      "t":1,
      "1":{"r":[[9]]},
      "0":{"r":[[9,1]]},
      "b":[[0]]
    }]
    }
  ]
}
```
<!-- markdownlint-enable MD013 -->

This is an example of a Sonoff iFan03 (`"t":65`).
The fan speed is controlled using GPIOs `15`, `12` and `14`.
The button is connected to GPIO `0` and the on/off relay is connected to GPIO `9`.
A wildcard action (`"y0"`) is defined to control the speed of the fan.
Each step change in the value monitored by the wildcard action changes the
fan control GPIO lines to adjust its speed.

# Actions

<!-- markdownlint-disable MD013 -->
| Key | Action | Description |
|:----:|:-------|:------------|
| `"0"` | Off | The default action after boot unless the [Initial State](#initial-state) has been set
| `"1"` | On |
<!-- markdownlint-enable MD013 -->

A fan has two actions. The [Binary Outputs](accessory-configuration#binary-outputs)
`"r": [ ]` for each should be configured to attain the desired state.

# Total of Speed Steps

The Speed Step option is used to define the number of speed steps the fan has.
When a request is made to increment or decrement the fan speed then the next
or previous step in speed will be selected.

Total of Speed Steps is defined by the `"e"` key contained within the
service object.

<!-- markdownlint-disable MD013 -->
| Key | Value | Description |
|:----:|:-----:|:------------|
| `"e"` | `100` | **(_default_)**
|  | `1` to `100` | Integer value specifying total of speed steps
<!-- markdownlint-enable MD013 -->

Setting the Total of Speed Steps to a value of `3` gives the fan three speeds, plus stop.
When viewing the fan speed from within the Home App the fan service will show
speeds of 0%, 33%, 66% & 100% depending on which speed step has been selected. But internally, speeds will be
0, 1, 2 and 3.

# Service Notifications

The list of Service Notifications `"m"` values supported are:

| Value | Notification |
|:-----:|:------------|
| `0`   | **Fan OFF (_default_)**
| `101` | Fan ON
| `1` to `100` | Set fan target speed
| `-100` to `-1` | Increase fan target speed
| `-200` to `-101` | Decrease fan target speed (-100)
| `-201` | Reset inching timer

See the general [Service Notifications](accessory-configuration#service-notifications)
section for details of how to configure these notifications.

# Binary Inputs

Binary Inputs `"b"` are supported by this service.

See [Binary Inputs](accessory-configuration#binary-inputs) for
details on how to define this mandatory option.

# State and Status Inputs

State inputs `"f[n]"` & Status Inputs `"g[n]"` are supported by this service.
The supported list is:

| Key | Action |
|:------:|:-----|
| `"f0"` | Set service state and perform action `"0"` (_Off_)
| `"f1"` | Set service state and perform action `"1"` (_On_)
||
| `"g0"` | Set service state to _Off_
| `"g1"` | Set service state to _On_

Refer to [State Inputs](accessory-configuration#fixed-state-inputs) for
more detail and examples.

# ICMP Ping Inputs

ICMP Ping inputs `"p[n]"` and `"q[n]"` are supported by this service.
The supported list is:

| Key | Action |
|:------:|:-----|
| `"p0"` | Set service state and perform action `"0"` (_Off_)
| `"p1"` | Set service state and perform action `"1"` (_On_)
||
| `"q0"` | Set service state to _Off_
| `"q1"` | Set service state to _On_

Refer to [ICMP Ping Inputs](accessory-configuration#icmp-ping-inputs) for
more detail.

# Wildcard Actions

Wildcard Actions `"y[n]"` are supported by this service.
The supported list is:

| Key | Action |
|:------:|:-----|
| `"y0"` | Trigger action when accessory reaches a specific fan speed

Wildcard actions cam be mapped to each of the [Speed Steps](#speed-step).
For example, if a Total of `3` Speed Steps have been defined (`"e":3`) then wildcard actions
can be set for `1`, `2` and `3`.

Refer to [Wildcard Actions](accessory-configuration#wildcard-actions) for
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
Refer to [Initial State](accessory-configuration#initial-state) for details
of the available values.

# Service Characteristics

| Characteristic | Description |
|:------:|:-----|
| `0` | On / Off
| `1` | Rotation speed
