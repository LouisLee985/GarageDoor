A HomeKit Window Covering service.

| Type | Service Type |
|:----:|:------------|
| `45` | Window Covering

Window Covering was introduced in firmware version `0.9.0`
<!-- FIXME: Remove this line after July 2020 -->

The following configuration is available for window coverings:

<!-- markdownlint-disable MD013 -->
| Section | Key | Description |
|---------|:-----:|-------------|
| [Actions](#Actions) | `"0"`, `"1"`, etc. | The actions performed by the service
| [Binary Inputs](#Binary-Inputs) | `"b"` | GPIOs that invoke specific actions
| [Service Notifications](#Service-Notifications) | `"m"` | Notifications received from another service
| [Initial Lock State](#Initial-Lock-State) | `"ks"` | Lock state at boot
| [State & Status Inputs](#State-and-Status-Inputs) | `"f[n]"` | Inputs that manage service state
| [Actions on Boot](#Execution-of-Actions-on-Boot) | `"xa"` | Enable / Disable execution of service actions on boot
| [Wildcard Actions](#Wildcard-Actions) | `"y[n]"` | Perform an action when a service reaches a target value
| [Covering Type](#Covering-Type) | `"w"` | Type of covering
| [Opening Time](#Opening-Time) | `"o"` | Time for service to completely open
| [Closing Time](#Closing-Time) | `"c"` | Time for service to completely close
| [Correction Value](#Correction-Value) | `"f"` | Non-linear correction value for
| [Margin](#Margin) | `"m"` | Percentage margin to sync cover when fully open / close
| [Virtual Stop](#Virtual-Stop) | `"vs"` | Simulates stop function from Home App
| [Data History Characteristics](#Data-History-Characteristics) ||
<!-- markdownlint-enable MD013 -->

# Window Covering Example

<!-- markdownlint-disable MD013 -->
```json
{
  "c": {
    "io": [ [[4,15,0],2], [[2],6], [[5,13],6,0,1] ],
    "l": 0, "b": [ [2,5] ]
  },
  "a": [{
    "t": 45,
    "o": 18,
    "c": 14,
    "f": 70,
    "0": { "r": [ [15,1], [4] ] },
    "1": { "r": [ [15], [4,1] ] },
    "2": { "r": [ [15], [4] ] },
    "3": { "r": [ [15,0,0.2], [4] ] },
    "4": { "r": [ [15], [4,0,0.2] ] },
    "f0": [ [5,0] ],
    "f1": [ [13,0] ],
    "f2": [ [5], [13] ]
  }]
}
```
<!-- markdownlint-enable MD013 -->
The above example defines a Shelly 2.5 Window Covering driver with
external switches and a status LED `"c": { "l": 0, "b": [ [2,5] ] }`.
The opening time is defined as 18 seconds `"o": 18`.
The closing time is defined as 14 seconds `"c": 14`.
A non-linear correction of 70% has also been set `"f": 70`.

# Actions

A window covering has a number of actions as documented below:

| Key | Action | Description |
|:------:|:------|:------------|
| `"0"` | Close, from stop | Close the window covering from the stopped state
| `"1"` | Open, from stop | Open the window covering from the stopped state
| `"2"` | Stop | Stop the window covering opening or closing
| `"3"` | Close, from opening | Action a close while window covering is opening
| `"4"` | Open, from closing | Action an open while window covering is closing
| `"5"` | Stop, from closing | Stop the window covering while it is closing
| `"6"` | Stop, from opening | Stop the window covering while it is opening
| `"7"` | Obstruction removed |
| `"8"` | Obstruction detected |

The [Binary Outputs](Accessory-Configuration#Binary-Outputs) `"r": [ ]` for each should be configured to attain the desired state.

# Covering Type

The covering type is defined by the `"w"` key contained within the
service object.

| Key | Value | Description |
|:----:|:-----:|:------------|
| `"w"` | `0` | **Window covering (_default_)** e.g. a roller blind
| | `1` | Window e.g. a motorized window
| | `2` | Door e.g. a motorized door

This option specifies the type of covering. Refer to the HomeKit specifications to
see details on the differences between these device types.

# Opening Time

Opening time is defined by the `"o"` key contained within the
service object.

| Key | Value | Description |
|:----:|:-----:|:------------|
| `"o"` | `15` | **Service opening time (_default_)**
|  | float | Value specifying number of seconds

This option specifies the time the service takes to open completely.
Decimals can be used.

# Closing Time

Closing time is defined by the `"c"` key contained within the
service object.

| Key | Value | Description |
|:----:|:-----:|:------------|
| `"c"` | `15` | **Service closing time (_default_)**
|  | float | Value specifying number of seconds

This option specifies the time the service takes to close completely.
Decimals can be used.

# Correction Value

Correction value is defined by the `"f"` key contained within the
service object.

| Key | Value | Description |
|:----:|:-----:|:------------|
| `"f"` | `0` | **Non-linear correction value (_default)**
|  | `0` to `100` | Percentage value

Some window coverings may require a correction factor to determine their real
position with respect to open or closing state. This may be due to the it being
a roller shutter for instance. Where the amount the covering opens accelerates
as it opens due to the drum of the shutter.

You can modify how the position of the shutter is calculated by providing a
non-linear correction value.

When a correction value is provided the position of the service is calculated
as follows:

`HomeKit Position = motorPosition / (1 + ((100 - motorPosition) * correctionValue * 0.0002))`

This option specifies a percentage. It is an integer between 0 and 100.

# Margin

Margin is defined by the `"m"` key contained within the
service object.

| Key | Value | Description |
|:----:|:-----:|:------------|
| `"m"` | `10` | **Percentage margin (_default_)**
|  | `0` to `100` | Integer value specifying percentage

This option specifies the additional working time when a cover is set to fully open
or fully closed to recalibrate its position. For example, if opening working time is 18 seconds, and
margin is 10% (meaning 10% of 18s = 1.8s), when cover is set to fully open, stop action will exec after 1.8s cover is fully open to ensure that it is at target position.
It is an integer (no decimals) specifying the percentage.

# Virtual Stop

When enabled, it simulates stop function from Home App when window covering is moving and service is triggered
again from Apple Home App, instead changing movement direction.

| Key | Value | Description |
|:----:|:-----:|:------------|
| `"vs"` | `0` | **Virtual Stop disabled (_default_)**
|  | `1` | Virtual Stop enabled

# Service Notifications

The list of notifications `"m"` supported by a window covering are as follows:

| Value | Notification |
|:-----:|:------------|
| `-3` | Toggle current window covering mode between open/stop/close
| `-2` | Obstruction removed
| `-1` | Obstruction detected
| `0` to `100` | Set window covering to specified open percentage
| `101` | It will stop the window covering opening or closing
| `200` to `300` | Set window covering state only to specified open percentage - 200

See the general [Service Notifications](Accessory-Configuration#Service-Notifications)
section for details of how to configure these notifications.

# Binary Inputs

Binary Inputs `"b"` are supported by this service.

See [Binary Inputs](Accessory-Configuration#Binary-Inputs) for
details on how to define this mandatory option.

# State and Status Inputs

State inputs `"f[n]"` are supported by this service.
The supported list is:

| Key | Required State |
|:------:|:-----|
| `"f0"` | Close window covering
| `"f1"` | Open window covering
| `"f2"` | Stop window covering opening or closing
| `"f3"` | Toggle between closing and stop
| `"f4"` | Toggle between opening and stop
| `"f5"` | Indicates that there is no obstruction
| `"f6"` | Indicates that there is an obstruction
| `"f7"` | Toggle current window covering mode between open/stop/close

Refer to [State Inputs](Accessory-Configuration#State-Inputs) for
more detail and examples.

# Initial Lock State

The Initial Lock State about Service and Physical controls.

| Key  | Value | Notification |
| :---:|:-----:|:------------|
| `"ks"` | `0` | All locked
| | `1` | Service unlocked. Physical controls locked
| | `2` | Service locked. Physical controls unlocked
| | `3` | **All unlocked (_default_)**

# Execution of Actions on Boot

Actions on Boot `"xa"` are supported by this service.

See [Execution of Actions on Boot](Accessory-Configuration#Execution-of-Actions-on-Boot)
for details on how to define this mandatory option.

# Wildcard Actions

Wildcard Actions `"y[n]"` are supported by this service.
The supported list is:

| Key | Action |
|:------:|:-----|
| `"y0"` | Trigger action when service reaches a specific position

The position of the window covering is expressed as a percentage
e.g. `{"y0":[{"v": 20, "0"{...}}]}`

Refer to [Wildcard Actions](Accessory-Configuration#Wildcard-Actions) for
more detail.

# Data History Characteristics

| Characteristic | Description |
|:------:|:-----|
| `0` | Current position
| `1` | Target position
| `2` | Position state
| `3` | Obstruction detected
