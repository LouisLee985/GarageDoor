Stateless buttons can be used to trigger state changes in HomeKit based on
the type of press placed on the button.

| Type | Service Type |
|:----:|:------------|
| `3` | Stateless Button
| `13` | Stateless Button + Doorbell

The following configuration is available for stateless buttons and doorbells:

<!-- markdownlint-disable MD013 -->
| Section | Key | Description |
|---------|:-----:|-------------|
| [Actions](#Actions) | `"0"`, `"1"` etc. | The actions performed by the service
| [Initial Lock State](#Initial-Lock-State) | `"ks"` | Lock state at boot
| [State & Status Inputs](#State-and-Status-Inputs) | `"f[n]"` & `"g[n]"` | Inputs that manage service state
| [Service Notifications](#Service-Notifications) | `"m"` | Notifications to send to another service
| [Historical Data Characteristics](#Historical-Data-Characteristics) ||
<!-- markdownlint-enable MD013 -->

Doorbell service works like a stateless button, and it sends a notification when
single press type is triggered. All Stateless Button functions will work too.

# Example

```json
{
  "c": {
    "io": [ [ [ 0 ], 6 ] ],
    "b": [ [ 0, 5 ] ]
  },
  "a": [{
    "t": 3,
    "f0": [ [ 0, 1 ] ],
    "f1": [ [ 0, 2 ] ],
    "f2": [ [ 0, 3 ] ]
  }]
}
```

This is an example of a stateless button (`"t": 3`) connected to GPIO 0 with 3
state inputs defined; single press (`1`), double press (`2`) & long press
(`3`)

# Actions

A stateless button has three actions.

| Action | Press | Description |
|:------:|:------|:------------|
| `"0"` | Single | **(_default_)**
| `"1"` | Double |
| `"2"` | Long |

The [Digital Outputs](Accessory-Configuration#Digital-Outputs)
`"r": [{}]` for each should be configured to attain the desired state.

# Service Notifications

The list of notifications `"m"` supported by a stateless button are as follows:

| Value | Notification |
|:-----:|:------------|
| `0` | **Single press (_default_)**
| `1` | Double press
| `2` | Long press

See the general [Service Notifications](Accessory-Configuration#Service-Notifications)
section for details of how to configure these notifications.

# Initial Lock State

The Initial Lock State about Service and Physical controls.

| Key  | Value | Notification |
| :---:|:-----:|:------------|
| "ks" | `0` | All locked
| | `1` | Service unlocked. Physical controls locked
| | `2` | Service locked. Physical controls unlocked
| | `3` | **All unlocked (_default_)**

# State and Status Inputs

State inputs `"f[n]"` & Status Inputs `"g[n]"` are supported by this service.
The supported list is:

| Key | Required State |
|:------:|:-----|
| `"f0"` | Single press
| `"f1"` | Double press
| `"f2"` | Long press

Refer to [State Inputs](Accessory-Configuration#State-Inputs) for
more detail and examples.

# Historical Data Characteristics

| Characteristic | Description |
|:------:|:-----|
| `0` | Triggered event
| `1` | Triggered Doorbell
