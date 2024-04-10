A HomeKit Dimmable Lightbulb service with auto-dimmer managed by external
switches/buttons. It can be Single Color, 2-channels selectable temperature
color, RGB, RGBW, RGB-CW-WW and RGBW-CW-WW.

The lightbulb service has an automatic dimmer function that will continuously
apply the next [brightness step](#Automatic-Dimmer-Step), with a
[delay](#Automatic-Dimmer-Step-Delay) between each step.

To activate it, ensure that light is on. Then, toggle twice switch or double
press button. To stop, press it again once.

**To use PWM, hardware must be PWM controlled. Max total PWM channels are 8.**

| Type | Service Type |
|:----:|:------------|
| `30` | Lightbulb

The following configuration is available for lightbulbs:

<!-- markdownlint-disable MD013 -->
| Section | Key | Description |
|---------|:-----:|-------------|
| [Type](#Type) | `"ty"` | Type of lightbulb
| [Actions](#Actions) | `"0"`, `"1"`, etc. | The actions performed by the service
| [Binary Inputs](#Binary-Inputs) | `"b"` | GPIOs that invoke specific actions
| [State & Status Inputs](#State-and-Status-Inputs) | `"f[n]"` & `"g[n]"` | Inputs that manage service state
| [Service Notifications](#Service-Notifications) | `"m"` | Notifications sent by other services
| [Wildcard Actions](#Wildcard-Actions) | `"y[n]"` | Perform an action when a service reaches a target value
| [Initial Lock State](#Initial-Lock-State) | `"ks"` | Lock state at boot
| [Initial State](#Initial-State) | `"s"` | State a lightbulb service enters on boot
| [GPIOs](#RGBW-GPIO-Channels) | `"g"` | GPIO pins for colour controls
| [NRZ Protocol](#NRZ-Protocol) | `"nrz"` | NRZ Protocol to use
| [Color Map](#Color-Map) | `"cm"` | Set order of colors for some lightbulb types
| [Channels](#Channels) | `"n"` | Number of channels
| [LED coordinates](#LED-coordinates) | `"ca"` | XY chromaticity coordinates for each LED
| [Flux array](#Flux-array) | `"fa"` | Each channel will be rescaled by the entry in the flux array
| [Color matching](#Color-matching) | `"rgb"` & `"cmy"` | To calibrate colors
| [White point](#White-point) | `"wp"` | Make colors warmer or cooler
| [Max power](#Max-power) | `"mp"` | Limit the maximum LED usage
| [Curve factor](#Curve-factor) | `"cf"` | 
| [Initial values](#Initial-values) | `"it"` | Brightness, hue and saturation values used at boot
| [Colour Transition Step](#Colour-Transition-Step) | `"st"` | Colour step value
| [Automatic Dimmer Step Delay](#Automatic-Dimmer-Step-Delay) | `"d"` | Dimmer step delay
| [Automatic Dimmer Step](#Automatic-Dimmer-Step) | `"e"` | Dimmer step value
| [Service Characteristics](#Service-Characteristics) ||
<!-- markdownlint-enable MD013 -->

## Example 1

Software PWM.

```json
{
  "c":{"q":500,"io":[[[15,13,12],7],[[0],6]],"b":[[0,5]]},
  "a":[{
    "t":30,
    "g":[15,13,12],
    "b":[[0]]
  }]
}
```

This is an example of a RGB Lightbulb (`"t":30`).

The PWM frequency has been set to 500Hz (`"q":500`) in the general configuration.

The GPIO lines for the red, green & blue lights are 15, 13 & 12 respectively (`"g":[15,13,12]`).

The on/off button is connected to GPIO 0 (`"b":[{"g":0}]`).

## Example 2

Rotary Encoder to control brightness.

```json
{
  "c":{
    "io":[[[12],6],[[4,5],6,0,0,1]],
    "z":0,"b":[[12,5]]
  },
  "a":[
    {"t":30,"b":[[12]]},
    {"h":0,"i":0.2,"1":{"m":[[7001,-10000],[7003,1],[7003,-1],[1,305]]},"f1":[[4,0]]},
    {"h":0,"i":0.2,"1":{"m":[[-1,-10000],[7001,1],[7001,-1],[1,605]]},"f1":[[5,0]]},
    {"h":0,"i":0.4,"0":{"m":[[-2,-10001]]}},
    {"h":0,"i":0.4,"0":{"m":[[-2,-10001]]}}
  ]
}
```

This is an example of a rotary encoder managing a Virtual Lightbulb (`"t":30`).

The on/off button is connected to GPIO 12.

Rotary encoder pins are connected to GPIOs 4 and 5.

# Type

It defines type of lightbulb based on hardware to use.

| Key | Value | Description
|:---:|:-----:|:-----------
|`"ty"`| `0` | Virtual lightbulb, without any hardware management. Default channels: 1
| | `1` | Standard PWM system. Default channels: number of GPIOs.
| | `2` | 2 Channels PWM. One to manage brightness and other temperature color. Default channels: 2
| | `8` | NRZ Protocol. Default channels: 3.

# Actions

| Action | State | Description |
|:------:|:------|:------------|
| `"0"` | Off | The default action after boot unless the Initial State has been set
| `"1"` | On |

A lightbulb has two actions. The [Binary Outputs](Accessory-Configuration#Binary-Outputs)
`"r": [ ]` for each should be configured to attain the desired state.

# RGBW GPIO Channels

Depending on the lightbulb type connected to the device you will need to define
the GPIO channels to control it. Available channels must be in a array.

Remember to declare used GPIOs as PWM Output into `"io":[...]` array. See [GPIOs Configuration](GPIOs-Configuration)

The rules for setting these channels with a PWM Lightbulb type are as follows:

<!-- markdownlint-disable MD013 -->
| Colours | Rule |
|---------|------|
| Single | `"g": [ W ]` 
| Two Colour | `"g": [ CW, WW ]`
| RGB | `"g": [ R, G, B ]`
| RGBW | `"g": [ R, G, B, W ]`
| RGB-CW-WW | `"g": [ R, G, B, CW, WW ]`
<!-- markdownlint-enable MD013 -->

**NOTE: A two colour light is a light with 2 channels to enable a colour temperature**

Mixing up this order will result in anomalous colors, so first verify these are correct. 

NRZ Protocol type uses declaration as follow:

<!-- markdownlint-disable MD013 -->
| Array |
|---------|
| `"g": [ GPIO, First LED of range, Last LED of range ]`
<!-- markdownlint-enable MD013 -->

Different NRZ Lightbulbs can be declared using same GPIO but different LED ranges.

# NRZ Protocol

Note: NRZ is NOT supported by ESP32-C2 chips.

When NRZ Lightbulb type is selected, a NRZ Protocol must be defined. This protocol uses different times of pulses to 
manage an array of LEDs. By default, NRZ Protocol uses WS2812b at 800MHz times, but any other protocol times can be used.

Used GPIOs must not be into `"io":[...]` array.

Times are available in datasheet of each LED type. Needed vales are `T0H`, `T1H` and `T0L`, and must be in us (microseconds).

If several lightbulbs with NRZ Protocol and same GPIO are declared, `"nrz"` array must be declare only once, in one of them.

Format and some of them are:

| Protocol | Array |
|:---------|:------
|          | `"nrz" : [ T0H, T1H, T0L ]`
| WS2812B 800Mhz | `"nrz" : [ 0.4, 0.8, 0.85 ]` **Default**
| WS2811 Slow  | `"nrz" : [ 0.5, 1.2, 2 ]`
| WS2811 Fast  | `"nrz" : [ 0.25, 0.6, 1 ]`
| WS2812 | `"nrz" : [ 0.35, 0.7, 0.9 ]`
| WS2812B 400MHz | `"nrz" : [ 0.8, 1.6, 1.7 ]`
| WS2812B V2 | `"nrz" : [ 0.4, 0.85, 0.85 ]`
| WS2812B V3 | `"nrz" : [ 0.35, 0.9, 0.9 ]`
| WS2813 | `"nrz" : [ 0.22, 0.58, 1.03 ]`
| WS2815 | `"nrz" : [ 0.22, 0.75, 0.75 ]`
| SK6812 | `"nrz" : [ 0.3, 0.6, 0.9 ]`

### NRZ Protocol Examples

A WS2812B 800MHz RGB LED strip with a total of 20 LEDs attached to GPIO 5:

```json
{
  "a":[{
    "t":30,
    "ty":8,
    "g":[5,1,20]
  }]
}
```

A SK6812 RGBW LED strip configured in 3 segments (5, 10 and 5 LEDs) attached to GPIO 5:

```json
{
  "a":[{
    "t":30,
    "ty":8,
    "n":4,
    "nrz":[0.3,0.6,0.9],
    "g":[5,1,5],
    "es":[{
      "t":30,
      "ty":8,
      "n":4,
      "g":[5,6,15]
    },{
      "t":30,
      "ty":8,
      "n":4,
      "g":[5,16,20]
    }]
  }]
}
``` 

# Color Map

Used by NRZ Protocol Lightbulb to swap channels.

Definitions are:

- `0`: Red
- `1`: Green
- `2`: Blue
- `3`: Cool white
- `4`: Warm white

By default, `"cm" : [ 1, 0, 2, 3, 4 ]` is used, meaning that LED order is GRB (default for WS2812B 800MHz).

Declare each color in right order.

# Channels

It is possible to set number of channels manually.

<!-- markdownlint-disable MD013 -->
| Key | Value | Description |
|:---:|:-----:|:------------|
| `"n"` |   `1`   | Single channel. Only brightness is managed. (_default_)
|       |   `2`   | Dual channel. To manage colour temperature
|       |   `3`   | Full color RGB
|       |   `4`   | Full color RGBW
|       |   `5`   | Full color RGB-CW-WW
<!-- markdownlint-enable MD013 -->

# LED coordinates

The new color mixing function created by Kevin Cutler (@kevinjohncutler) at https://github.com/kevinjohncutler/colormixing supports RGB, RGBW, and RGB-CW-WW, and by default it maximizes brightness and stretches the sRGB color gamut to fill the gamut of your LEDs, meaning that that colors are as saturated as possible. The defaults in HAA work well for typical LED strips, but there are a number of ways to get your bulbs looking just right. Logs are suggested. Throughout this guide we will refer to ‘chromaticity coordinates’, meaning the tuple `[x,y]` in the CIE xyY color space corresponding to a unique color. 

Attempt to get the ‘spectrum test report’ for your bulbs. This will give the xy chromaticity coordinates for each LED, and you can put this into your MEPLHAA script as the coordinate array `"ca"`:

| Type   | Format |
|:------:|:------|
| RGB | `"ca": [ rx, ry, gx, gy, bx, by ]`
| RGBW | `"ca": [ rx, ry, gx, gy, bx, by, wx, wy]`
| RGB-CW-WW | `"ca": [ rx, ry, gx, gy, bx, by, cwx, cwy, wwx, wwy ]`

The reports collected so far show that typical bulbs and strips have very similar reds and blues, with he most variation being in green and warm white. If you cannot get the test report, then you can continue to the next steps and still get good results. 

# Flux array

Internal color calculations assume the brightness of each channel is the same, but this is never true, especially for lightbulbs, which will have many more white LEDs than RGB LEDs. Each channel will be rescaled by the entry in the flux array. The MEPLHAA script syntax is

| Type   | Format |
|:------:|:-------|
| W | `"fa": [ W ]`
| CW-WW | `"fa": [ CW, WW ]`
| RGB | `"fa": [ R, G, B ]`
| RGBW | `"fa": [ R, G, B, W ]`
| RGB-CW-WW | `"fa": [ R, G, B, CW, WW ]`

For example, an RGB-CW-WW bulb with 4 RGB modules, 12 CW modules, and 14 WW modules should be `"fa": [ 4, 4, 4, 12, 14 ]`. This is equivalent to `"fa": [ 2, 2, 2, 6, 7 ]`. These numbers can be changed further to reflect differences in intrinsic LED flux as well (white LEDS are usually brighter than RGB, and the green LED may be brighter than the red etc.). Since channel outputs are divided by the flux array, this will lead to more accurate but less bright colors. 

# Color matching

The current software enables users to set the act chromaticity coordinates to which the following Siri colors correspond: red, green, blue, cyan, magenta, and yellow. By default, red, green, and blue are mapped to the LED coordinates so that you will see the purest red, green, and blue that your hardware can make (that is, only one color LED is turned on). Cyan (the same as Siri teal), magenta (the same as Siri purple), and yellow are much more likely to look off, so there are two separate arrays:

- `"rgb": [ rx, ry, gx, gy, bx, by ]`
- `"cmy": [ cx, cy, mx, my, yx, yy ]`

To calibrate your lights, enable logs and tell Siri to set the light cyan. Adjust this in the Home app until you get a color that you think looks the most ‘cyan’ to you. The logs will show a "new chromaticity" every time you change a color, and once you found one you like, write it down to use as `[ cx, cy ]`. Do the same for magenta and yellow. Once the CMY array is in your MEPLHAA script, the bulb will now perfectly reproduce the cyan, magenta, and yellow that you chose, which should also improve the look of interpolated colors (such as orange). 

# White point

The D50 standard illuminant is the default, but you can change this to make your colors warmer or cooler. For example, standard illuminant A Is a lot warmer and will shift all your whites towards the warm end of the Planckian locus. Refer to the table here for a list of standard illuminates to try. The MEPLHAA script syntax is `"wp": [ wx, wy ]`.

Table: TO-DO



# Max power

This variable is between 0 and 1 and can be used to limit the maximum LED usage to prevent overheating (though it seems like lower PWM has fixed that).

| Key | Value | Description |
|:-----:|:----:|:------------|
| `"mp"` | `1.00` | **(_default_)**
| | `0.01` to `1` | Total factor applied to each PWM channel value

# Curve factor

If you wish to keep your whites as bright as possible but also subdue the white LEDs for better pastels, this may be for you. This curve factor is the parameter "a" in the ‘power curve’ function 1-(exp(ax)-1)/(exp(a)-1), where x is the saturation in the range (0,1). The syntax is `"cf":#`, and typical ranges would be between -5 and 5. Negative values suppress the white LEDs and positive values keep them turned on (relative to how they are to begin with), so start with something like "cf":-1 if you want to play with it. While 0 technically corresponds to a linear power curve, I use this case to turn off the power curve altogether. If you want something close to linear, use `"cf":0.1`. 

# Initial values

By default, lightbulb service will load last brightness, hue and saturation 
used values. To set initial BRI, HUE and SAT at boot, `"it:"` key is used.

- 1 channel: `"it": [ BRI ]`
- 2 channels: `"it": [ BRI, TEMP ]`
- 3+ channels: `"it": [ BRI, HUE, SAT ]`

# Colour Transition Step

Colour transition step is defined by the `"st"` key contained within the
service object.

| Key | Value | Description |
|:-----:|:----:|:------------|
| `"st"` | `2048` | Step the colour transition value by `2048` **(_default_)**
| | `1` to `65535` | Step value to apply to colour transitions

The `"st"` option defines the colour step value. This is the increment that will
be applied to a colour value each time a step is requested, each 20ms.

# Automatic Dimmer Step Delay

Automatic dimmer step delay is defined by the `"d"` key contained within the
service object.

| Key | Value | Description |
|:-----:|:----:|:------------|
| `"d"` | `1.00` | Delay between dimmer steps is 1 second **(_default_)**
| | `0.01` to `65.50` | Delay to apply between each step when dimming

This option specifies the delay in seconds to apply between each automatic
dimmer step.

The option uses is a floating point value, accurate to 2 decimal places e.g. 1.14

# Automatic Dimmer Step

Automatic dimmer step is defined by the `"e"` key contained within the
service object.

| Key | Value | Description |
|:-----:|:----:|:------------|
| `"e"` | `20` | **Automatically step the dimmer brightness by 20% (_default_)**
| | `1` to `100` | Brightness percentage step to apply when dimming
| | `0` | Disable feature

This option defines the brightness step percentage that will be applied to each
automatic dimmer step.

A value of `0` will disable Automatic dimmer feature.

# Service Notifications

The list of notifications `"m"` supported by a lightbulb are as follows:

| Value | Notification |
|:-----:|:------------|
| `0` | **Switch is OFF (_default_)**
| `1` | Switch is ON
| `2` to `102` | Change brightness from 0 to 100. Final value will be `value - 2`.
| `301` to `400` | Reduce brightness from 1 to 100. Final value will be `value - 300`.
| `601` to `700` | Increase brightness from 1 to 100. Final value will be `value - 600`.
| `1000` to `1360` | Change hue from 0 to 360. Final value will be `value - 1000`.
| `2000` to `2100` | Change saturation from 0 to 100. Final value will be `value - 2000`.
| `3050` to `3400` | Change color temperature from 50 to 400. Final value will be `value - 3000`.
| `-1` | Start autodimmer
| `-2` | Stop autodimmer

Service notifications can be included as part of an action definition.
When an action occurs any one of the above notifications can be sent to
another service using the `"m"` option within the action object.

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
| `"f0"` | Lightbulb off
| `"f1"` | Lightbulb on
| `"f2"` | Increase brightness by 10%
| `"f3"` | Decrease brightness by 10%

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
| `"y0"` | Trigger action when lightbulb reaches a specific brightness

The brightness is expressed as a percentage e.g. if you want to trigger a
wildcard action when a lightbulb reaches 20% brightness then use
`{"y0": [{"v":20, "0":{...}}]}`

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

# Service Characteristics

| Characteristic | Description |
|:------:|:-----|
| `0` | On / Off
| `1` | Brightness
| `2` | Hue or Color temperature
| `3` | Saturation
