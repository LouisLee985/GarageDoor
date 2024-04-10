A Security System, that can be used to trigger an alarm and send notifications. Can be
activated with a group of sensors using HomeKit automations.

| Type | Service Type |
|:----:|:------------|
| 55 | Security System

The following configuration is available:

<!-- markdownlint-disable MD013 -->
| Section | Key | Description |
|---------|:-----:|-------------|
| [Modes](#Modes) | "n" | Customize modes to use
| [Actions](#Actions) | "0", "1" etc. | The actions performed by the service
| [Service Notifications](#Service-Notifications) | "m" | Notifications to send by another service
| [Initial Lock State](#Initial-Lock-State) | "ks" | Lock state at boot
| [Initial State](#Initial-State) | "s" | State an service enters on boot
| [Actions on Boot](Accessory-Configuration#Execution-of-Actions-on-Boot) | "xa" | Enable / Disable execution of service actions on boot
| [Historical Data Characteristics](#Historical-Data-Characteristics) ||
<!-- markdownlint-enable MD013 -->

# Example

```json
{
  "a": [{
    "t": 55,
    "s": 5,
    "es":[{
      "i": 1,
      "1": { "m": [ [ -1, 4 ] ] }
    }]
  }]
}
```

This is an example of a security system (`"t": 55`) with a switch used
to trigger alarm when security system is activated. If you want to use a hidden
switch not visible in Apple Home App, add `"h":2` to switch service.

# Modes

| Key | Default | Description |
|:------:|:------|:------------|
| "n" | [ 0, 1, 2, 3 ] | **(_default_)**

Standard HomeKit Security System has 4 modes (Descriptions by @Unteins):
- `0` At Home. People at home, ignore some sensors like your front door sensor and your motion sensors because you’re coming and going through the house
- `1` Away from Home. No one at home, listen to ALL the sensors and sound alarms.
- `2` Night. everyone should be inside, ignore motion sensors in the house because we might get a glass of water in the middle of the night but all door and window sensors should trigger alarms because no one should be going on and out.
- `3` Off.

You can override those modes and select your own combination declaring `"n":[...]` array with modes that you want. For example, to have only 2 states: `"n":[1,3]`

IMPORTANT: Order must be from lower to higher.

Some modes combinations could not work in HomeKit.

# Actions

| Key | Action | Description |
|:------:|:------|:------------|
| "0" | Stay at Home mode selected | **(_default_)**
| "1" | Away from Home mode selected |
| "2" | Night mode selected |
| "3" | OFF mode selected |
| "4" | Alarm triggered |
| "5" | Alarm triggered when Stay at Home mode selected |
| "6" | Alarm triggered when Away from Home mode selected |
| "7" | Alarm triggered when Night mode selected |
| "8" | Alarm is stopped |

# Service Notifications

The list of notifications `"m"` supported are as follows:

| Value | Notification |
|:-----:|:------------|
| 0 | Set Stay at Home mode | **(_default_)**
| 1 | Set Away from Home mode |
| 2 | Set Night mode |
| 3 | Set OFF mode |
| 4 | Trigger alarm |
| 5 | Trigger alarm if Stay at Home mode selected |
| 6 | Trigger alarm if Away from Home mode selected |
| 7 | Trigger alarm if Night mode selected |
| 8 | Stop alarm |
| 10 | Set Stay at Home mode status only |
| 11 | Set Away from Home mode status only |
| 12 | Set Night mode status only |
| 13 | Set OFF mode status only |
| 14 | Trigger recurrent alarm |
| 15 | Trigger recurrent alarm if Stay at Home mode selected |
| 16 | Trigger recurrent alarm if Away from Home mode selected |
| 17 | Trigger recurrent alarm if Night mode selected |

Setting status only will not exec any associated action.

See the general [Service Notifications](Accessory-Configuration#Service-Notifications)
section for details of how to configure these notifications.

# Initial Lock State

The Initial Lock State about Service and Physical controls.

| Key  | Value | Notification |
| :---:|:-----:|:------------|
| "ks" | 0 | All locked
| | 1 | Service unlocked. Physical controls locked
| | 2 | Service locked. Physical controls unlocked
| | 3 | **All unlocked (_default_)**

# Initial State

Initial state is defined by the `"s"` key contained within the accessory object.

| Key | State | Description |
|:----:|:-----:|:------------|
| "s" | 0 | At Home
| | 1 | Away from Home
| | 2 | Night
| | 3 | **OFF (_default_)**
| | 5 | Last state before restart

The initial state that a service enters on boot can be set using the `"s"` option.

# Historical Data Characteristics

| Characteristic | Description |
|:------:|:-----|
| 0 | Current State