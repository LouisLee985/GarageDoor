# ESP HomeKit Devices
<!-- markdownlint-disable MD026 -->
<p align="center"><img width="300" src="https://raw.githubusercontent.com/RavenSystem/ravensystem-media/master/works-with-apple-home.svg"></p>

Add native HomeKit support, OTA updates and a lot of custom settings to any device
with an [ESP32, ESP32-S, ESP32-C or ESP8266 microcontroller series](https://www.espressif.com/en/products/modules).

This means that servers like Home Assistant or bridges like HomeBridge are not necessary. This work is focused on any device that uses a compatible chip, like Sonoff, 
Shelly, and custom devices. Any suggestion is welcome, but only official Apple
HomeKit characteristics will be considered (Those that work with stock Apple
Home App), and custom HomeKit characteristics that use third-party Apps will
be rejected.

In addition to this firmware, you can obtain [**HAA Home Manager**](haa-home-manager), the perfect App companion
to manage your HAA devices, with batch updates, enable setup mode, and other extra features: 

<p align="center"><a href="https://apps.apple.com/app/id1556105121"><img src="https://raw.githubusercontent.com/RavenSystem/ravensystem-media/master/badge-app-store.png"></a></p>

And don't forget to subscribe to YouTube Channel:

<p align="center"><a href="https://www.youtube.com/channel/UCRumJzAoAnQ7dUpSnSUuuJw"><img width="40%" src="https://raw.githubusercontent.com/RavenSystem/ravensystem-media/master/YouTube_logo.png"></a></p>

<!-- markdownlint-disable MD013 -->
<img src="https://raw.githubusercontent.com/RavenSystem/ravensystem-media/master/apple_logo.png" width="20"/>

<!-- markdownlint-disable MD001 -->
###### HomeKit Accessory Protocol (HAP) is Apple’s proprietary protocol that enables third-party accessories in the home (e.g., lights, thermostats and door locks) and Apple products to communicate with each other. HAP supports two transports, IP and Bluetooth LE. The information provided in the HomeKit Accessory Protocol Specification (Non-Commercial Version) describes how to implement HAP in an accessory that you create for non-commercial use and that will not be distributed or sold.

###### Although already forbidden by the sources and subsequent licensing, it is notallowed to use or distribute this firmware for a commercial purpose.

###### The HomeKit Accessory Protocol Specification (Non-Commercial Version) can be downloaded from the [HomeKit Apple Developer page.](https://developer.apple.com/apple-home/)

###### Copyright © 2019-2024 Apple Inc. All rights reserved.
<!-- markdownlint-enable MD001 -->
<!-- markdownlint-enable MD013 -->

## [Home Accessory Architect Firmware (RavenCore v2)](home-accessory-architect)

[![downloads](https://img.shields.io/github/downloads/RavenSystem/haa/total.svg)](Home-Accessory-Architect)

It is an advanced firmware that lets you to configure any kind of device using a MEPLHAA Script.

## Documentation

Documentation was originally written by [@WizBangCrash](https://github.com/WizBangCrash).

## Community MEPLHAA Scripts

There are many MEPLHAA scripts in [Wiki Database](devices-database), but users can submit their own MEPLHAA Scripts here: [MEPLHAA Scripts Collection](https://github.com/RavenSystem/esp-homekit-devices/discussions/categories/json-collection)

## Helping and Supporting

This firmware will always be open source and free to use. I'm not in this for the money, but donations are humbly accepted.

[![Donate](https://img.shields.io/badge/donate-PayPal-blue.svg)](https://paypal.me/ravensystem)

All kind of help is welcome. Feedbacks of new devices, testing, documentation
about hardware...

## Official Twitter and Chat

### Follow me on Twitter to stay tuned with last news and releases:

[Official Twitter](https://twitter.com/RavenSystem)

[![Twitter](https://img.shields.io/twitter/follow/RavenSystem.svg?style=social)](https://twitter.com/RavenSystem)

### Here you can ask for help and share experiences with other users who use my firmwares (English, Spanish, Italian and Russian channels):

[Join Official Community Chat](https://discord.com/servers/esp-homekit-devices-594630635696553994)

[![Discord Chat](https://img.shields.io/discord/594630635696553994?style=social)](https://discord.com/servers/esp-homekit-devices-594630635696553994)

## Issues

Issues must be used ONLY to report BUGS and collect data to solve them. Please, for questions, MEPLHAA scripts, suggestion... use [Discussions](https://github.com/RavenSystem/esp-homekit-devices/discussions) or [Discord chat](https://discord.com/servers/esp-homekit-devices-594630635696553994).

Before opening a new issue, check if there is another of same topic.

To open a new issue, is important to provide all possible information about it:
- Detailed steps to reproduce it.
- Used device.
- MEPLHAA Script.
- HAA version.
- iOS/iPadOS version.
- A .txt file with logs. Read [how to capture logs from your device](installation#capture-logs)
- Screen-shots or videos showing issue.

If a new issue is opened without those standards, it will be ignored, moved to discussions, or deleted, depending on my mood at the moment.
