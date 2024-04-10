Setup mode is used to configure the device and you can perform the following, depending of running firmware and setup web color:

- [Add Extra Pairing](#add-extra-pairing)
- [Remove All Extra Pairings](#remove-all-extra-pairings)
- [Reset HomeKit ID](#reset-homekit-id)
- [Reset Settings](#reset-settings)
- [Remove WiFi Settings](#remove-wifi-settings)
- [Installer Setup](#installer-setup)
- [Firmware Update](#firmware-update)
- [Auto OTA Updates](#auto-ota-updates)
- [WiFi AP](#wifi-ap)
- [WiFi AP Password](#wifi-ap-password)
- [WiFi Mode](#wifi-mode)
- [Current](#current-configured-wifi)
- [Flash](#spi-flash-mode)
- [IR/RF Capture GPIO](#irrf-capture-gpio) 
- [Change WiFi Network](#change-wifi-network)
- [Input / Edit MEPLHAA script](#inputting-configuration)
- [Update Server](#update-server)

Once `Save` button is pressed, device will boot with current firmware in normal mode, resuming operations. This mean that if setup was from HAA Installer, device will start the update process.

_**NOTE: If an invalid MEPLHAA script or no script is detected during boot,
the device will enter setup mode automatically.**_

**NOTE: "⟲ WiFi Networks" will reload web page and search for & show a list of networks
discoverable by your device**

HAA uses 3 different firmwares with 3 different setups. Each firmware has specific functions:

| Firmware      | Setup Color | Description
|:--------------|:-----------:|:--------------
| HAA MAIN      | White       | Main firmware with HomeKit capabilities
| OTA MAIN      | Blue        | Installer of HAA MAIN and HAA BOOT
| HAA BOOT      | Orange      | Installer of OTA MAIN

Different setup pages are:

![HAA Setup Mode image](https://raw.githubusercontent.com/RavenSystem/ravensystem-media/master/setup_white.png)
![HAA Setup Mode image](https://raw.githubusercontent.com/RavenSystem/ravensystem-media/master/setup_blue.png)
![HAA Setup Mode image](https://raw.githubusercontent.com/RavenSystem/ravensystem-media/master/setup_orange.png)

# Entering Setup Mode

To enter setup mode, there are different ways:

- **[HAA Home Manager App](haa-home-manager)**: from the Setup Service of the HAA device, toggling Setup; but this way needs the device added to Apple Home.

- **Service physical controls or from Apple Home App**: you must quickly toggle any action switch/button 8 times. You can change the number of needed toggles or disable this way by [declaring a different value](general-configuration#setup-mode-toggle-count). You can secure this method by [declaring a time](general-configuration#setup-mode-timer) after device boot to perform it.

- **Physical controls from script config section**: Additionally, you can declare a [physical method to enter setup mode](general-configuration#buttons-to-invoke-setup-mode). You can secure this method by [declaring a time](general-configuration#setup-mode-timer) after device boot to perform it.

- **System action "1"**: You can declare a [system action](accessory-configuration#system-actions) to enter setup mode in any [HAA service](service-types). You can secure this method by [declaring a time](general-configuration#setup-mode-timer) after device boot to perform it.

- **Emergency Setup Mode**: If a device has its power cut or freezes within 2 seconds of boot, next time it boots, it will go directly to setup mode. This method is always available and is independent from script or Apple Home.

**If the device's configured WiFi network is unavailable** and [WiFi AP](#wifi-ap) is enabled, when entering setup mode
it will switch to AP mode if it is enabled and you will need to connect directly to it via the
generated SSID e.g. `HAA-XXXXXX` (where XXXXXX are the last six characters of
its Ethernet MAC address), and then open URL in a web browser:

```shell
http://192.168.4.1:4567
```

# Device Connection

If a device has been through initial configuration and is already configured for
a WiFi network then once it has entered setup mode it can be accessed using a
web browser by connecting to its IP address or HAA auto-configured hostname
e.g. `http://192.168.1.45:4567` or `http://HAA-123BC7:4567` (Note: some routers may
require you to use the .local domain `http://HAA-123CB7.local:4567` or if you have
set your local domain then use this instead).

If you load setup web page, device will restart automatically after 15 minutes 
(or try to update if auto OTA updates is enabled).

There is a flash storage settings integrity that will force to enter setup mode at 
boot if it is corrupted. A warning will be displayed in setup web page.

# Change WiFi Network

The setup mode page presents a list of WiFi networks within range of the device.
The list can be refreshed by clicking the `⟲ WiFi Networks` button. If you want
to change the network the device currently connects to on boot then select one
of the available networks and enter the network password when requested.

If your SSID is hidden then you can enter its details manually by clicking on the
`Enter SSID manually` button. You will then be prompted to enter an SSID and a
password. Make sure you enter both correctly.

If you change WiFi Network, HAA WiFi AP will be enabled automatically, and its password will be removed.

# WiFi AP

This option applies only for Setup Mode from HAA Main (White background). For others, WiFi AP can not be disabled.

Enables or disables HAA WiFi Access Point when device is in setup mode.

If device is in setup mode, and it connects to network, HAA WiFi AP will be turned off for security. If you want to keep it enabled, you must set a password.

# WiFi AP Password

This option applies only for Setup Mode from HAA Main (White background). For others, WiFi AP can not have a password.

Set a password to protect HAA WiFi AP. To remove it, disable WiFi AP. 

When a password is defined, HAA WiFi AP will not be disabled when device connects to network.

# WiFi Mode

Depending of your network, you can select a WiFi mode connection:

- **Normal**: Device will connect to first available SSID found.
- **Forced BSSID**: Device will connect only to configured SSID and BSSID, ignoring other 
BSSIDs with same SSID.

Roaming modes: These are useful when Wifi network has several APs with same SSID, or 
network is a Wifi system without roaming support (802.11v, 802.11r, 802.11k...):

- **Passive roaming**: device will scan for Wifi networks at boot connecting to BSSID with best RSSI; 
and when it disconnects, it will search and connect to BSSID with best RSSI.
- **Active roaming**: same as Passive roaming; and every 35 minutes, device will scan for 
Wifi networks and it will reconnect to BSSID with best RSSI when it is connected to other. 
HAA will be unresponsive over Wifi about 2 seconds when it is performing a Wifi networks scan.
- **Roaming at boot**: device will scan for Wifi networks at boot connecting to BSSID with best RSSI; 
and when it disconnects, it will connect only to BSSID that found at boot.

If you change WiFi Mode, HAA WiFi AP will be enabled automatically, and its password will be removed.

## Reconnecting to WiFi Network

If the WiFi network becomes unreachable, the device will continually retry its
connection until it becomes available again.

# Current Configured WiFi

This shows current SSID and BSSID configured on device. If there is not any WiFi network configured, it will show NONE.

# Inputting Configuration

Device configuration is set by inputting a MEPLHAA script into the
Setup Mode page. See the section on [Configuration](configuration) for details
on how to create the script.

![Basic Setup Mode image](https://raw.githubusercontent.com/RavenSystem/ravensystem-media/master/Configured_Setup_Mode_Page.jpg)

The above image shows Setup Mode with a MEPLHAA script entered and ready
for `Save` to be pressed.

# Pairings

Information about number of users that have been paired with device using HomeKit.

# Add Extra Pairing

When device is paired with HomeKit, enabling this option will allow to pair device again with other HomeKit user or controller, like Home Assistant. Device will can be managed by all paired controllers. When extra pairing is used for the first time, a reboot is needed to avoid undesired pairs removed.

# Remove All Extra Pairings

This will remove all paired users and controllers added after initial pairing.

# Reset HomeKit ID

When you make edits to your MEPLHAA script that involve changes to the
accessory type or number of used accessories you will have to remove & re-add
your device from HomeKit and the Home App.

Setting this option will reset the HomeKit ID and all pairings used by the device when you press `Save`.

When making changes to a device that requires the HomeKit ID to be reset follow
this procedure:

1. [Enter Setup Mode](#entering-setup-mode) on the device
2. Remove your device from the Home App
3. Select `Reset HomeKit ID`
4. Select `Save`
5. Pair the device with your Home App again

# Reset Settings

You can remove all current settings and reformat the flash area where settings are
stored by enabling the `Reset Settings` option and clicking `Save`.
This option is useful if you are experiencing problems with upgrading TUYA or
Mongoose installations.

HomeKit ID and pairings will not be removed.

### Step by step to reset settings:

Follow these steps to reset settings keeping current configuration:

1. Enter in setup mode web.
2. Copy and save current MEPLHAA Script in a safe place.
3. Erase MEPLHAA Script field and leave it blank.
4. Enable `Reset Settings`.
5. Click on `Save` button.
6. Connect to generated HAA WiFi AP.
7. Enter in setup mode web at http://192.168.4.1:4567
8. Configure WiFi network.
9. Put your same saved MEPLHAA cript.
10. Click on `Save` button.

# Remove WiFi Settings

You can remove any currently saved WiFi settings by enabling the
`Remove WiFi Settings` option and then clicking `Save`.
The device will remove any previously stored SSID and password then reboot.
As no WiFi settings will be available on reboot the device will immediately
enter `Setup Mode`.

# Installer Setup

Enabling this option, device will boot with Installer firmware OTA MAIN in setup mode, allowing to
modify options of Blue Setup.

# Firmware Update

A manual request for an OTA update can be performed by enabling this option and then clicking `Save`.
The device will then boot with HAA Installer firmware and will check the configured OTA repository for an updated firmware,
download it if available and then restart.

# Auto OTA Updates

DEPRECATED and REMOVED in HAA v11.3.0

Enabling the `Auto OTA Updates` option causes the firmware to search for an OTA
update from the configured OTA repository every time the setup mode is selected and
the setup webpage has not been loaded in a browser within 90 seconds.

If setup web page is loaded, device will restart automatically after 15 minutes, 
or try to update if auto OTA updates is enabled.

# SPI Flash Mode

This option shows the flash chip ID and the current flash mode used by ESP chip to communicate with flash chip.

You can read about different modes here: [Espressif SPI Flash Modes](https://docs.espressif.com/projects/esptool/en/latest/esp8266/advanced-topics/spi-flash-modes.html)

To change SPI flash mode, you must use setup mode from any HAA Installer (OTA MAIN or HAA BOOT).

**IMPORTANT:** If you select an unsupported mode, device will be bricked and it will need to be flashed again with wires.

Check out [SPI Flash Modes Database](flash-modes-database) to see if your device and flash ID is listed.

| Flash Mode
|:------------
| QIO
| QOUT
| DIO
| DOUT (Default)

# IR/RF Capture GPIO

When you want to capture IR codes, you can select here which GPIO has IR/RF receiver connected. 
Device will reboot and launch IR/RF Capture Tool. You can see result of captures using UART0
connection or network logs. When you finish, reboot device and it will run HAA normal mode.

# Update Server

By default a device flashed with the OTA version of HAA will retrieve its
firmware updates from the [RavenSystem/haa](https://github.com/RavenSystem/haa)
GitHub account.

Since HAA Installer v3.0.0 the option has been available for the device to retrieve
its firmware files from a web server of your choice (local or remote) instead of
using the GitHub server.

In order to use your own web server the `Custom server for updates` and `Port`
fields need to be filled in with details of the URL to retrieve the files from.
You also have the option of selecting a secure connection.

When using [Firmware Update](#firmware-update), the device will attempt to retrieve its firmware updates from the Update Server
if specified or GitHub if these fields are left blank.

Firmware can also be downgraded by placing an older copy of the files on your
web server.

**NOTE:** Since HAABoot v3.0.0 the firmware files must be signed and verified with
a hardcoded public key.

# Saving Changes

Clicking `Save` will save any changes you have made while in setup mode,
apply them and reboot the device to use them. All saved states will be removed, and WiFi stack will be cleaned.
