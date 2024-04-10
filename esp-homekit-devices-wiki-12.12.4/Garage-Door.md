A HomeKit Garage Door service. This can be used to manage your garage
door driver, or be a stand-alone fully working driver.

If you don't use a sensor, or use only one, [Door Working Time](#Door-Working-Time)
will be used to determine door state.
If you use both sensors (for open and close: `"f2"` to `"f5"`),
[Door Working Time](#Door-Working-Time) will be used as a security measure alerting
when an obstruction is detected if the door does not complete operation before
the working time expires.
If you also define an [Obstruction Detection Time](#Obstruction-Detection-Time)
then the sum of the Working Time and Obstruction Detection Time is used.

| Type | Service Type |
|:----:|:------------|
| `40` | Garage Door

The following configuration is available for garage doors:

<!-- markdownlint-disable MD013 -->
| Section | Key | Description |
|---------|:-----:|-------------|
| [Actions](#Actions) | `"0"`, `"1"`, etc. | The actions performed by the service
| [Binary Inputs](#Binary-Inputs) | `"b"` | GPIOs that invoke specific actions
| [Inching Time](Accessory-Configuration#Inching-Time) | `"i"` | Time period before returning service to close state
| [State & Status Inputs](#State-and-Status-Inputs) | `"f[n]"` | Inputs that manage service state
| [Service Notifications](#Service-Notifications) | `"m"` | Notifications sent from another service
| [Initial Lock State](#Initial-Lock-State) | `"ks"` | Lock state at boot
| [Initial State](#Initial-State) | `"s"` | State a garage door service enters on boot
| [Door Opening Time](#Door-Opening-Time) | `"d"` | Time door takes to open
| [Door Closing Time](#Door-Closing-Time) | `"c"` | Time door takes to close
| [Obstruction Detection Time](#Obstruction-Detection-Time) | `"e"` | Time allowed to detect door obstruction
| [Virtual Stop](#Virtual-Stop) | `"vs"` | Simulates stop function from Home App
| [Service Characteristics](#Service-Characteristics) ||
<!-- markdownlint-enable MD013 -->

# Garage Door Example

<!-- markdownlint-disable MD013 -->
```json
{
  "c":{
    "io":[[[12,13],2],[[0],6],[[14],6,1]],
    "l":13,"b":[[0,5]]
  },
  "a":[{
    "t":40,
    "d":18,
    "0":{"r":[[12,1,0.5]]},
    "1":{"a":0},
    "2":{"r":[[12,0,1.5],[12,1,0.5],[12,1,2]]},
    "3":{"a":2},
    "f3":[[14,0]],
    "f4":[[14]]
  }]
}
```
<!-- markdownlint-enable MD013 -->

This is an example of a device used to control a garage door (`"t":40`).
The door takes 18 seconds to open (`"d":18`).

The four key actions are defined; Door is opened and receives closing order (`"0"`),
door is closed and receives opening order (`"1"`), door is opening and receives
closing order (`"2"`) & door is closing and receives opening order (`"3"`).

The door control is done using GPIO 12 and actions `"1"` and `"3"` are duplicates
of actions `"0"` and `"2"` respectively (see
[Copy Action](Accessory-Configuration#Copy-Actions)).

GPIO 14 indicates the the closed state of the door i.e. when the door is
fully closed `"f3"` is triggered. When the door begins to open `"f4"` is
triggered indicating, via GPIO `14` that the door is no longer closed.

# Actions

A garage door has a number of actions as documented below:

| Key | Action | Description |
|:------:|:------|:------------|
| `"0"` | Close an open door | Handle request to close an open door
| `"1"` | Open a closed door | Handle request to open a closed door
| `"2"` | Close an opening door | Handle changing direction of opening action
| `"3"` | Open a closing door | Handle changing direction of closing action
| `"4"` | Opened door detected | Handle door has opened
| `"5"` | Closed door detected | Handle door has closed
| `"6"` | Opening door detected | Handle door opening
| `"7"` | Closing door detected | Handle door closing
| `"8"` | Obstruction removed | Handle the removal of an obstruction
| `"9"` | Obstruction detected | Handle the detection of an obstruction
| `"10"` | Emergency stop | Handle an emergency stop
| `"11"` | Obstruction detected by time | Handle the detection of an obstruction by [Obstruction Detection Time](#Obstruction-Detection-Time)
| `"12"` | Close a stopped door | Handle request to close a middle open stopped door
| `"13"` | Open a stopped door | Handle request to open a middle open stopped door

The [Binary Outputs](Accessory-Configuration#Binary-Outputs)
`"r": [ ]` for each should be configured to attain the desired state.

# Door Opening Time

The door opening time is defined by the `"d"` key contained within the
service object.

| Key | Value | Description |
|:----:|:-----:|:------------|
| `"d"` | `30` | **Door takes 30 seconds to open (_default_)**
|  | `1` to `65535` | Integer value specifying number of seconds

This option specifies the time needed for the garage door to completely open.
It is an integer (no decimals).

# Door Closing Time

Door Closing Time was introduced in firmware version `1.0.0`
<!-- FIXME: Remove this line after July 2020 -->

The door closing time is defined by the `"c"` key contained within the
service object. If this key is not declared, the door opening time value will
be used i.e. the value from the `"d"` key.

| Key | Value | Description |
|:----:|:-----:|:------------|
| `"c"` | `1` to `65535` | Integer value specifying number of seconds

This option specifies the time needed for the garage door to completely close.
It is an integer (no decimals).

# Obstruction Detection Time

Obstruction detection time was introduced in firmware version `0.8.7`
<!-- FIXME: Remove this line after July 2020 -->

Obstruction detection time is defined by the `"e"` key contained within the
service object.

| Key | Value | Description |
|:----:|:-----:|:------------|
| `"e"` | `0` | **Door obstruction detection disabled (_default_)**
|  | `1` to `65535` | Integer value specifying number of seconds

This option specifies the time allowed for the garage door to detect an obstruction
when door open/close sensors are used.
It is an integer (no decimals).

By default this option is disabled. When enabled, the timer begins when and wait until sensor detects movement, and once the
[Door Working Time](#Door-Working-Time) has expired. The service then has the defined number of seconds to report an obstruction is detected.

# Virtual Stop

When enabled, it simulates emergency stop function from Home App when Garage Door is moving and service is triggered
again from Apple Home App, instead changing movement direction. It will exec Emergency Stop action.

| Key | Value | Description |
|:----:|:-----:|:------------|
| `"vs"` | `0` | **Virtual Stop disabled (_default_)**
|  | `1` | Virtual Stop enabled

# Service Notifications

The list of notifications `"m"` supported by a garage door are as follows:

| Value | Notification |
|:-----:|:------------|
|  `0` | **Door open (_default_)**
|  `1` | Door close
|  `2` | Emergency stop
|  `3` | Obstruction removed
|  `4` | Obstruction detected
|  `5` | Toggle door target state
|  `6` | Obstruction detected by [Obstruction Detection Time](#Obstruction-Detection-Time)
| `10` | Set Door state to opened
| `11` | Set Door state to closed
| `12` | Set Door state to opening
| `13` | Set Door state to closing
| `-1` | Reset inching time

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
| `"f0"` | Set garage door to open
| `"f1"` | Set garage door to close
| `"f2"` | Indicates that garage door is open
| `"f3"` | Indicates that garage door is closed
| `"f4"` | Indicates that garage door is opening
| `"f5"` | Indicates that garage door is closing
| `"f6"` | Indicates that there is not obstruction
| `"f7"` | Indicates that there is obstruction
| `"f8"` | Emergency stop

Refer to [State Inputs](Accessory-Configuration#State-Inputs) for
more detail and examples.

# ICMP Ping Inputs

ICMP Ping inputs `"p[n]"` and `"q[n]"` are supported by this service.
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
| `"s"` | `0` | Open
| | `1` | **Closed (_default_)**
| | `5` | Last state before restart
| | `6` | Opposite to last state before restart

# Service Characteristics

| Characteristic | Description |
|:------:|:-----|
| `0` | Current Door State
| `1` | Target Door State
| `2` | Obstruction detected
