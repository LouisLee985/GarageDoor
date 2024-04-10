A HomeKit Humidifier/Dehumidifier service. It requires a compatible sensor.

| Type | Service Type |
|:----:|:------------|
| `26` | Humidifier
| `27` | Humidifier with temperature sensor

The following configuration is available:

<!-- markdownlint-disable MD013 -->
| Section | Key | Description |
|---------|:-----:|-------------|
| [Actions](#Actions) | `"0"`, `"1"`, etc. | The actions performed by the service
| [Binary Inputs](#Binary-Inputs) | `"b"` | GPIOs that invoke specific actions
| [State & Status Inputs](#State-and-Status-Inputs) | `"f[n]"` & `"g[n]"` | Inputs that manage service state
| [Service Notifications](#Accessory-Notifications) | `"m"` | Notifications sent by other services
| [ICMP Ping Inputs](#ICMP-Ping-Inputs) | `"q[n]"` & `"p[n]"` | Ping inputs that manage service state
| [Wildcard Actions](#Wildcard-Actions) | `"y[n]"` | Perform an action when an service reaches a target value
| [Initial Lock State](#Initial-Lock-State) | `"ks"` | Lock state at boot
| [Initial State](#Initial-State) | `"s"` | State a service enters on boot
| [Initial Mode](#Initial-Mode) | `"e"` | Mode a service enters on boot
| [Sensor GPIO](#Sensor-GPIO) | `"g"` | GPIO line sensor is attached to
| [Sensor Type](#Sensor-Type) | `"n"` | Type of sensor attached to service
| [Sensor Polling Time](#Sensor-Polling-Time) | `"j"` | How often the humidity sense is read
| [Temperature Offset](#Temperature-Offset) | `"z"` | Correction offset to apply
| [Humidity Offset](#Humidity-Offset) | `"k"` | Correction offset to apply
| [Humidifier Type](#Humidifier-Type) | `"w"` | Type of humidifier connected to service
| [Deadband Humidity](#Deadband-Humidity) | `"d"` | Deadband/Hysteresis of humidifier
| [Deadband Humidity Force Idle](#Deadband-Humidity-Force-Idle) | `"df"` | Deadband/Hysteresis of humidifier to exec Force Idle Actions
| [Deadband Humidity Soft On](#Deadband-Humidity-Soft-On) | `"ds"` | Deadband/Hysteresis of humidifier to exec Soft On Actions
| [Delay time to process](#Delay-time-to-process) | `"dl"` | Time in seconds to wait for process humidifier logic
| [Service Characteristics](#Service-Characteristics) ||
<!-- markdownlint-enable MD013 -->

# Actions

| Key | Action | Description |
|:------:|:------|:------------|
| `"0"`  | All OFF | Turns off all components of the humidifier
| `"1"`  | Device ON, Humidifying OFF | Turn on but humidifier is in idle-mode
| `"2"`  | Device ON, Dehumidifying OFF | Turn on but dehumidifier is in idle-mode
| `"3"`  | Device ON, Humidifying ON | Humidifier is active and humidifying
| `"4"`  | Device ON, Dehumidifying ON | Humidifier is active and dehumidifyng
| `"5"`  | Sensor Error | Action to perform when there is a sensor error
| `"6"`  | `"f3"` triggered | Change target humidity by +5%
| `"7"`  | `"f4"` triggered | Change target humidity by -5%
| `"8"`  | Device ON, Humidifying Force OFF | Turn on but humidifier is in force idle-mode
| `"9"`  | Device ON, Dehumidifying Force OFF | Turn on but dehumidifier is in force idle-mode
| `"10"` | Device ON, Humidifying Soft ON | Humidifier is active and humidifying in soft mode
| `"11"` | Device ON, Dehumidifying Soft ON | Humidifier is active and dehumidifying in soft mode
| `"14"` | Device ON | Humidifier is active. It execs only when prior state was All OFF

Multiple actions are supported by a humidifier. The [Binary Outputs](Accessory-Configuration#Binary-Outputs)
`"r": [ ]` for each should be configured to attain the desired state.

# Sensor GPIO

Sensor GPIO is defined by the `"g"` key contained within the service object.

| Key | Value | Description |
|:----:|:-----:|:---|
| `"g"` | GPIO # | GPIO line the temperature sensor is connected to

# Sensor Type

Sensor type is defined by the `"n"` key contained within the service object.

A variety of one-wire sensors are available and supported by HAA.

Refer to [Sensor Type](Temperature-and-Humidity-Sensors#Sensor-Type) for
details of the sensors that are supported.

# Sensor Polling Time

Sensor polling time is defined by the `"j"` key contained within the
service object.

| Key | Value | Description |
|:-----:|:----:|:------------|
| `"j"` | `30` | **Sensor is polled every 30 seconds (_default_)**
| | `0.1` to `65535` | Float specifying the number of seconds between polls

The humidity is polled on a regular basis to read the
latest values. These values are then posted to HomeKit. If this option is not
specified then the sensor will be polled once every 30 seconds.


**NOTE: This option is available only for device type 27**
# Temperature Offset

Temperature offset is defined by the `"z"` key contained within the service
object.

| Key | Value | Description |
|:-----:|:----:|:------------|
| `"z"` | `0.0` | **No offset is applied (_default_)**
| | `-∞` to `+∞` | Offset is added to temperature value read

The accuracy of the temperature sensor varies and may sometimes read
consistently higher or lower than the actual temperature. The temperature offset
option enables calibration of the sensor by specifying a positive or negative
offset to apply to the reading.

The option uses is a floating point value, accurate to 1 decimal place e.g. 1.1

# Humidity Offset

Humidity offset is defined by the `"k"` key contained within the service
object.

| Key | Value | Description |
|:-----:|:----:|:------------|
| `"k"` | `0` | **No offset is applied (_default_)**
| | `-∞` to `+∞` | Offset is added to humidity value read

The accuracy of the available one-wire sensors varies and may sometimes read
consistently higher or lower than the actual humidity. The humidity offset
option enables calibration of the sensor by specifying a positive or negative
offset to apply to the reading.

The option uses is an integer point value.

# Humidifier Type

Humidifier type is defined by the `"w"` key contained within the service object.

| Key | Type | Description |
|:-----:|:----:|:------------|
| `"w"` | `1` | **Humidifier (_default_)**
| | `2` | Dehumidifier
| | `3` | Humidifier and Dehumidifier
| | `4` | Humidifier and Dehumidifier without Auto mode

This option is used to select the type of humidifier controlled by the
device.

# Deadband Humidity

Deadband Humidity is defined by the `"d"` key contained within the
service object.

| Key | Value | Description |
|:-----:|:----:|:------------|
| `"d"` | `0` | **Set humidity deadband to 0% (_default_)**
| | `0` to `+∞` | Humidity deadband allowed

The `"d"` option is used to set the humidity deadband in % to adjust how
humidifier works. The value is an integer variable.

![Humidifier Deadband](https://raw.githubusercontent.com/RavenSystem/ravensystem-media/master/Humidifier_Deadband.svg)

A humidifier deadband (or hysteresis) is designed to lag the inputs
from the environment for the purposes of saving you energy and saving your
air conditioner or furnace wear and tear from turning on and off frequently.

The deadband represents a humidity range around the automatic mode set point
that is your “comfort zone”.
For example, with a 4% wide deadband (`"d": 4`) and a setpoint of 20%,
the deadband will be 18 - 22%. This keeps the system from bouncing quickly
between humidifying and dehumidifying when in automatic mode.

When humidity fall within the deadband, neither humidifying nor dehumidifying can occur.
A larger deadband will have your system run more economically, while a smaller
deadband will have your system hold the humidity closer to the setpoint and
increase comfort.

# Deadband Humidity Force Idle

Deadband humidity force idle is defined by the `"df"` key contained within the
service object.

| Key | Value | Description |
|:-----:|:----:|:------------|
| `"df"` | `0` | **Set humidity deadband to 0% (_default_)**
| | `0` to `+∞` | Humidity deadband allowed

# Deadband Humidity Soft On

Deadband humidity soft on is defined by the `"ds"` key contained within the
service object.

| Key | Value | Description |
|:-----:|:----:|:------------|
| `"ds"` | `0` | **Set humidity deadband to 0% (_default_)**
| | `0` to `+∞` | Humidity deadband allowed

# Delay time to process

Time to wait until humidifier data in processed. It is used to avoid conflicts when many HomeKit orders are sent at same time.

| Key | Value | Description |
|:-----:|:----:|:------------|
| `"dl"v | `3.0` | **Set delay time to 3 seconds (_default_)**
| | `0.15` to `+∞` | Delay time allowed in seconds

# Service Notifications

The list of notifications `"m"` supported by a thermostat are as follows:

| Value | Notification |
|:-----:|:------------|
| `0`     | Humidifier OFF
| `1`     | Humidifier ON
| `-3`  | Auto mode
| `-2`  | Humidifier mode
| `-1`  | Dehumidifier mode
| `1000` to `1100` | Set humidifier threshold humidity to `value - 1000`
| `2000` to `2100` | Set dehumidifier threshold humidity to `value - 2000`

See the general [Service Notifications](Accessory-Configuration#Service-Notifications)
section for details of how to configure these notifications.

# Binary Inputs

Binary Inputs `"b"` are supported by this service.

See [Binary Inputs](Accessory-Configuration#Binary-Inputs) for
details on how to define this mandatory option.

# State and Status Inputs

State inputs `"f[n]"` & Status Inputs `"g[n]"` are supported by this service.
The supported list is:

| Key | Required State |
|:------:|:-----|
| `"f0"` | Humidifier `OFF`
| `"f1"` | Humidifier `ON`
| `"f3"` | Change target humidity by +5%
| `"f4` | Change target humidity by -5%
| `"f5"` | Dehumidifier mode `ON`
| `"f6"` | Humidifier mode `ON`
| `"f7"` | Auto mode `ON`

**NOTE: Fixed states `"f5"`, `"f6"` & `"f7"` are only available when thermostat
type `3` is selected (`"w": 3`)**

Refer to [State Inputs](Accessory-Configuration#State-Inputs) for
more detail and examples.

# ICMP Ping Inputs

ICMP Ping inputs `"p[n]"` and `"q[n]"` are supported by this service.
Refer to [ICMP Ping Inputs](Accessory-Configuration#ICMP-Ping-Inputs) for
more detail.

# Wildcard Actions

Wildcard Actions `"y[n]"` are supported by this service.
The supported list is:

| Key | Action |
|:------:|:-----|
| `"y0"` | Trigger action when service reaches a specific temperature
| `"y1"` | Trigger action when service reaches a specific humidity
| `"y2"` | Trigger action when humidifier target humidity reaches a specific value
| `"y3"` | Trigger action when dehumidifier target humidity reaches a specific value

Refer to [Wildcard Actions](Accessory-Configuration#Wildcard-Actions) for
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

# Initial Mode

Initial mode is defined by the `"e"` key contained within the service object.

| Key | State | Description |
|:----:|:-----:|:------------|
| `"e"` | `0` | Auto
| | `1` | Humidifier
| | `2` | Dehumidifier
| | `3` | Last mode before restart **(_default_)**

# Service Characteristics

| Characteristic | Description |
|:------:|:-----|
| `0` | * Current Temperature
| `1` | * Current Humidity
| `2` | On / Off
| `3` | Current Humidifier/Dehumidifier State
| `4` | Target Humidifier/Dehumidifier State
| `5` | Humidifier target humidity
| `6` | Dehumidifier target humidity