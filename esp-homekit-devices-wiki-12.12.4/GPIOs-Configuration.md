Since HAA V12 Merlin, GPIOs behavior must be configured in an array to determine how hardware will work.

This array is declared by the key `"io":[...]` and contains other arrays. Each other array is a group of GPIOs declaration.

By default, GPIOs are disabled, but they must be configured as INPUT, OUTPUT, OPEN-DRAIN... with different options, like pull-up resistors, modes, PWM...

Structure of `"io":[...]` array is:

```
"io" : [ 
  [ [ gpio 1, gpio 2, gpio N, ...], mode, pull-up/down, options... ], 
  [ [ gpio 1, gpio 2, gpio N, ...], mode, pull-up/down, options... ], 
  [ [ gpio 1, gpio 2, gpio N, ...], mode, pull-up/down, options... ], 
  ...
]
```

- `[ gpio 1, gpio 2, gpio N, ...]` is a GPIO array, according to hardware. All GPIO numbers into this array will have same configuration as follow.
- `mode` is the main operation mode for these `[ gpios ]`.

Depending of selected mode, different options are available.

ADC pin of ESP8266 doesn't need any declaration here.

**- Options with \* are available only for ESP32 models. They are incompatible with ESP8266 models.**

|  Mode  | Description
|:------:|:----------------
|   `0`  | [Disable](#mode-0-disable) __(default)__
|   `1`  | [Input only](#mode-1-input)
|   `2`  | [Output only](#modes-2-3-4-and-5-output-options)
|   `3`  | [Output only with open-drain](#modes-2-3-4-and-5-output-options)
|   `4`  | * [Output and input with open-drain](#modes-2-3-4-and-5-output-options)
|   `5`  | * [Output and input](#modes-2-3-4-and-5-output-options)
|   `6`  | [Input only with binary input (button/switch) support](#mode-6-input-only-with-binary-input-buttonswitch-support)
|   `7`  | [Software PWM, only output](#modes-7-and-8-software-pwm-options)
|   `8`  | [Software PWM, only output with open-drain](#modes-7-and-8-software-pwm-options)
|   `9`  | * [Hardware PWM, only output](#mode-9-hardware-pwm-options-only-esp32)
|  `10`  | * [ADC Input](#mode-10-adc-only-esp32)

Depending on the hardware attached to a GPIO there may be a need for
enabling an internal pull-up or pull-down resistor.

|  Pull-up/down  | Description
|:--------------:|:----------------
|  `-1`  | Don't apply any pull-up/down setting to GPIO and leave it as SDK init
| `-11`  | ** Same as `-1`, but enabling glitch filter
|   `0`  | Floating. Disable internal pull-up and pull-down resistors. __(default)__
|   `1`  | Enable internal pull-up resistor
|   `2`  | * Enable internal pull-down resistor
|   `3`  | * Enable internal pull-up and pull-down resistors
|  `10`  | ** Same as `0`, but enabling glitch filter
|  `11`  | ** Same as `1`, but enabling glitch filter.
|  `12`  | ** Same as `2`, but enabling glitch filter.
|  `13`  | ** Same as `3`, but enabling glitch filter.

#### Glitch Filter

** Glitch filter is only available for ESP32-C and ESP32-S. They feature hardware filters to remove unwanted glitch pulses from the **INPUT GPIO**, which can help reduce false triggering of the interrupt and prevent a noise being routed to the peripheral side. Each GPIO can be configured with a glitch filter, which can be used to filter out pulses shorter than two sample clock cycles.

### Mode `0`. Disable:

`[ [ gpios ], mode, pull-up/down ]`

Used to set a GPIO disable. This sets GPIO in a high impedance state without any function.

In ESP32 chips, disabled GPIOs must be declared explicitly.

### Mode `1`. Input:

`[ [ gpios ], mode, pull-up/down ]`

Used to set a GPIO as input, needed for some drivers. This mode is not the proper to use with buttons, switches, or any other binary sensor. For those, use mode `6`.

In ESP8266, all user GPIOs (except 9 an 10) are set as INPUT at boot because disabling them can cause some hardware issues.

### Modes `2`, `3`, `4` and `5`. Output options:

`[ [ gpios ], mode, pull-up/down, initial value ]`

|  Initial value  | Description
|:---------------:|:----------------
|       `0`       | Set GPIO output to LOW value __(default)__
|       `1`       | Set GPIO output to HIGH value


### Mode `6`. Input only with binary input (button/switch) support

If expansion interfaces are used, remember to use hundreds to select expander of GPIO. For example, GPIO 6 of first I/O Expander will be `106`.

`[ [ gpios ], mode, pull-up/down, button mode, button filter, max us pulse duration ]`

With some peripherals and hardware the actual GPIO signal may need to be inverted
to ensure the correct action is performed when the GPIO changes state. This is
normal for binary inputs that are active _low_.

Other peripherals send a pulse instead setting GPIO signal _high_ constantly. For example, an AC@50Hz signal from mains, that will do 
GPIO signal to trigger low and high 50 times per second. In this cases, input with pulse detection is needed.

|  Button mode  | Description
|:-------------:|:----------------
|       `0`     | Normal input __(default)__
|       `1`     | Inverted input
|       `2`     | Normal input with pulse detection. Not available with MCP23017
|       `3`     | Inverted with pulse detection. Not available with MCP23017

The button filter can be set to any integer value between `1` (soft)
and `255` (hard) to avoid interference such as debounce from the input when a button
pressed.

|  Button filter  | Description
|:---------------:|:----------------
|        `4`      | Default GPIO filter value __(default)__
|   `1` to `255`  | Set filter value to avoid bounces and interferences. `1` is the softer value.

Note: pulse detection, inputs from MCP23017 and GPIOs without ISR (hardware interruption), like GPIO 16 from ESP8266, need [Binary Input Continuous Mode](general-configuration#binary-input-continuous-mode) enabled with `"c":1` key into [General Configuration](general-configuration#binary-input-continuous-mode).

max us pulse duration: Maximum pulse duration in us (microseconds) in pulse mode. If pulse duration is higher, it will be treat like LOW GPIO state or not pulse.

| Time us | Description
|:-------------:|:----------------
|       `0`     | Disabled __(default)__
| `0` - `65535` | Time is us

### Modes `7` and `8`. Software PWM options

`[ [ gpios ], mode, pull-up/down, initial value, PWM mode, PWM dithering ]`

|  Initial value  | Description
|:---------------:|:----------------
|       `0`       | Set initial PWM output value to `0` __(default)__
|  `0` to `65535` | Initial PWM output value

By default, trailing mode is used. But some hardware may require to use leading, like TRIACs. This array will specify which channels must be leading:

|  PWM Mode  | Description
|:----------:|:----------------
|     `0`    | Normal Trailing __(default)__
|     `1`    | Inverted Trailing
|     `2`    | Normal Leading
|     `3`    | Inverted Leading

| PWM Dithering | Description
|:-------------:|:----------------
|     `0`       | No PWM Dithering __(default)__
|`0` to `32768` | Deformation of PWM to avoid noises and armonic interferences.

### Mode `9`. Hardware PWM options (Only ESP32)

`[ [ gpios ], mode, pull-up/down, initial value, PWM mode, timer ]`

|  Initial value  | Description
|:---------------:|:----------------
|       `0`       | Set initial PWM output value to `0` __(default)__
|  `0` to `65535` | Initial PWM output value

By default, trailing mode is used. But some hardware may require to use leading, like TRIACs. This array will specify which channels must be leading:

|  PWM Mode  | Description
|:----------:|:----------------
|     `0`    | Normal Trailing __(default)__
|     `1`    | Inverted Trailing
|     `2`    | Normal Leading
|     `3`    | Inverted Leading

| Timer | Description
|:-----:|:----------------
|     `0`       | Timer 0 __(default)__
|  `0` to `3`   | LEDC Timer used by selected GPIO. Each timer can have a different frequency.

### Mode `10`. ADC (Only ESP32)

Configure GPIOs to use as ADC Inputs. It has a 12 bits width, getting raw values from `0` to `4095`.

Check which GPIOs are ADC available, because only ADC unit 1 is supported. ADC unit 2 from some ESP32 chips can not be used because it is attached to WiFi and both are self-exclusive.

ESP8266 has only one ADC pin with 10 bits width (`0` to `1023`) and it doesn't need any configuration.

`[ [ gpios ], mode, pull-up/down, attenuation ]`

|  Attenuation | Description
|:----------:|:----------------
|     `0`    | No input attenuation, ADC can measure up to approx __(default)__
|     `1`    | The input voltage of ADC will be attenuated extending the range of measurement by about 2.5 dB (1.33 x)
|     `2`    | The input voltage of ADC will be attenuated extending the range of measurement by about 6 dB (2 x)
|     `3`    | The input voltage of ADC will be attenuated extending the range of measurement by about 11 dB (3.55 x)

