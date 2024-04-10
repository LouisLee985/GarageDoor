This service allow to save a register in time of a defined characteristic of other service. It can save any
numeric value from any characteristic of any service, even from hidden services.

| Type | Service Type |
|:----:|:-------------|
| `95` | Data History

[HAA Home Manager App](HAA-Home-Manager) is needed to read data history. Other third-party HomeKit clients will not work. It will save all data in your device only opening it. There is not needed to enter into each data history service.

A NTP server is required in order to this service works.

This service can be declared as a main service of an accessory, however, it is recommended to setup it into extra services array, but it must be declared in MEPLHAA script after target service.

The following configuration is available:

<!-- markdownlint-disable MD013 -->
| Section | Key | Description |
|---------|:-----:|-------------|
| [Configuration Data](#configuration-data) | `"h"` | Information to configure the service
| [Polling Time](#polling-time) | `"j"` | How often the characteristic value is read
| [Read on Clock Ready](#read-on-clock-ready) | `"x"` | Read value when HAA clock is ready
| [Service Notifications](#service-notifications) | `"m"` | Notifications sent from another service
| [Initial Lock State](#initial-lock-state) | `"ks"` | Lock state at boot
<!-- markdownlint-enable MD013 -->

# Example

```json
{
  "a": [{
    "t": 1,
    "es": [{
      "t": 95,
      "h": [ 1, 0, 5 ]
    }]
  }]
}
```

In this example, there is an accessory with a switch as a main service, and a historical data as an extra service.
That service will store switch (service number 1) value (characteristic 0) each time it is triggered, saving last 500 changes (5 blocks).

# Configuration Data

This array is used to define configuration of service.

<!-- markdownlint-disable MD013 -->
| Key | Value |
|:------:|:------|
| `"h"` | `[ Service, Characteristic, Blocks ]`
<!-- markdownlint-enable MD013 -->

- Service: Index number of the service that has the characteristic to register. It is the same used by Service Notification action.
- Characteristic: Index number of characteristic to register. See each service to know them.
- Blocks: Number of blocks used to store data in DRAM. Each block can store 100 registers, and used about 1KB of DRAM.

Characteristics marked with **\*** will not be saved with each change. However, they must be read using [Polling Time](#polling-time) or [Service Notifications](#service-notifications).

When all blocks are full, oldest values will be overwritten with news.

# Polling Time

Polling time is defined by the `"j"` key contained within the service object.

Characteristic value will be saved each defined polling time seconds.

| Key | Value | Description |
|:-----:|:----:|:------------|
| `"j"` | `0` | **Polled is disabled (_default_)**
| | `0.1` to `65535` | Float specifying the number of seconds between polls

# Read on Clock Ready

Take a read when HAA clock is ready with NTP server.

| Key | Value | Description |
|:-----:|:----:|:------------|
| `"x"` | `0` | **Disabled (_default_)**
| | `1` | Enable

# Service Notifications

The list of Service Notifications `"m"` values supported are:

| Key | Value | Notification |
| :--:|:-----:|:------------|
| `"v"` | `0` | **Save current characteristic value (_default_)**

See the general [Service Notifications](accessory-configuration#service-notifications)
section for details of how to configure these notifications.

# Initial Lock State

The Initial Lock State about Service and Physical controls.

| Key  | Value | Notification |
| :---:|:-----:|:------------|
| `"ks"` | `0` | Locked
| | `1` | **Unlocked (_default_)**