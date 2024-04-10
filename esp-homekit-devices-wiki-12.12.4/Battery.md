A battery service with "low battery" threshold. Battery level must be set using [Free Monitor](free-monitor) or [Service Notifications](#service-notifications).

This service was implemented in firmware version `1.8.0`
<!-- FIXME: Remove this line after December 2022 -->

| Type | Service Type |
|:----:|:------------|
| `70` | Battery

Battery Service is incompatible with a main service and it should be declared as extra service.

The following configuration is available:

<!-- markdownlint-disable MD013 -->
| Section | Key | Description |
|---------|:-----:|-------------|
| [Low Battery Threshold](#low-battery-threshold) | `"l"` | Sets low battery threshold value
| [Actions](#actions) | `"0"`, `"1"` | The actions performed by the service
| [Wildcard Actions](#wildcard-actions) | `"y[n]"` | Perform an action when an service reaches a target value
| [Service Notifications](#service-notifications) | `"m"` | Notifications sent by another service
| [Initial Lock State](#initial-lock-state) | `"ks"` | Lock state at boot
| [Service Characteristics](#service-characteristics) ||
<!-- markdownlint-enable MD013 -->

Example of a switch with a Battery Service taking values from a Free Monitor Service using ADC pin. Low battery threshold is set to 25%:
```json
{
  "a":[
    {
      "t" : 1,
      "es" : [
        {
          "t" : 70,
          "l" : 25
        }
    ]
    }, {
      "t"  : 80,
      "h"  : 0,
      "n"  : 10,
      "j"  : 5,
      "ff" : 0.09775171066,
      "tg" : [ 2, 0 ]
    }
  ]
}
```

# Low Battery Threshold

| Key | Default | Type | Description
|:----:|:------:|------| -----------
| `"l"` | `20` | integer | Sets low battery threshold value

When battery level changes, if new value is equal or under this, low battery status will be enabled. And disabled when battery level is over the threshold.

# Actions

These actions are onkly related to LOW battery threshold, and will be triggered when its state changes.
<!-- markdownlint-disable MD013 -->
| Key | Action | Description |
|:----:|:-------|:------------|
| `"0"` | No LOW battery |
| `"1"` | LOW battery |
<!-- markdownlint-enable MD013 -->

# Service Notifications

The list of Service Notifications `"m"` values supported are:

| Value | Notification |
|:-----:|:------------|
| `0` to `100` | Set remaining battery level
| `-100` to `-1` | Increase battery level
| `-200` to `-101` | Decrease battery level (-100)

See the general [Service Notifications](accessory-configuration#service-notifications)
section for details of how to configure these notifications.

# Wildcard Actions

Wildcard Actions `"y[n]"` are supported by this service.
The supported list is:

| Key | Action |
|:------:|:-----|
| `"y0"` | Trigger action when service reaches a specific battery level

Refer to [Wildcard Actions](accessory-configuration#wildcard-actions) for
more detail.

# Initial Lock State

The Initial Lock State about Service and Physical controls.

| Key  | Value | Notification |
| :---:|:-----:|:------------|
| `"ks"` | `0` | All locked
| | `3` | **All unlocked (_default_)**

# Service Characteristics

| Characteristic | Description |
|:------:|:-----|
| `0` | Battery % value
| `1` | Low battery threshold
