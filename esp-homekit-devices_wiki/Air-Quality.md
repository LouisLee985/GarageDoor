Air Quality HomeKit Service.

| Type | Service Type |
|:----:|:------------|
| `15` | Air Quality Sensor

Air Quality was introduced in firmware version `10.0 Kestrel`
<!-- FIXME: Remove this line after July 2022 -->

Status must be set using [Service Notifications](#service-notifications). There is not inputs available. To use specific hardware,
[Free Monitor Service](free-monitor) supports many different data sources that can provide needed information to manage this service.

The following configuration is available:

<!-- markdownlint-disable MD013 -->
| Section | Key | Description |
|---------|:-----:|-------------|
| [Actions](#actions) | `"0"`, `"1"`, etc. | The actions performed by the service
| [Extra Data](#extra-data) | `"dt"` | Array to enable extra characteristics with more info
| [Service Notifications](#service-notifications) | `"m"` | Notifications sent from another service
| [Initial Lock State](#initial-lock-state) | `"ks"` | Lock state at boot
| [Service Characteristics](#service-characteristics) ||

Example:
```json
{ "a" :
  [
    { "t" : 15 }
  ]
}
```

# Actions

| Key | Action | Description |
|:----:|:-------|:------------|
| `"0"` | Unknown Status | The default action after boot
| `"1"` | Excellent |
| `"2"` | Good |
| `"3"` | Fair |
| `"4"` | Inferior |
| `"5"` | Poor |

# Extra Data

Some extra characteristics can be added to this service:

| Key | Description |
|:----:|:------------|
| `1` | Ozone Density
| `2` | Nitrogen Dioxide Density
| `3` | Sulphur Dioxide Density
| `4` | PM25 Density
| `5` | PM10 Density
| `6` | VOC Density

It is possible to add some or all of them using `"dt"` array.

To populate this information, [Service Notifications](#service-notifications) or [Free Monitors](free-monitor) must be used.

Valid values are from `0` to `1000`.

Elements order in the declaration is important because [Service Notifications](#service-notifications) and [Data History Characteristics](#data-history-characteristics) will use place number instead characteristic keys. For example, `"dt" : [ 2, 4 ]` will add Nitrogen Dioxide Density and PM25 Density, but these characteristics will be `1` and `2` when use them in [Service Notifications](#Service-Notifications) and [Data History Characteristics](#dData-history-characteristics).

# Service Notifications

The list of Service Notifications `"m"` values supported are:

| Value | Notification |
|:-----:|:------------|
| `0` | **Unknown Status (_default_)**
| `1` | Excellent
| `2` | Good
| `3` | Fair
| `4` | Inferior
| `5` | Poor
| `N * 10000 + value` | Where `N` is [Extra Data](#extra-data) and `value` is the value to set

See the general [Service Notifications](accessory-configuration#service-notifications)
section for details of how to configure these notifications.

# Initial Lock State

The Initial Lock State about Service.

| Key  | Value | Notification |
| :---:|:-----:|:------------|
| `"ks"` | `0` | Service locked
| | `1` | Service unlocked

# Service Characteristics

| Characteristic | Description |
|:------:|:-----|
| `0` | * Current State
| `1` to `6` | * [Extra Data](#extra-data) 
