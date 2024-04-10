To configure your device, it is necessary to declare all functions using a **MEPLHAA** script.

**MEPLHAA**, _Marvelous Esoteric Programming Language for Home Accessory Architect_: is a declarative script language that uses JSON syntax to setup and configure all information about accessories, GPIOs, buttons, relays, sensors, LEDs... that device will use, and how. Data is in `"key":value` pairs, and they are separated by commas. Curly braces `{...}` hold objects and square brackets `[...]` hold arrays.

The MEPLHAA script has two sections:

| Section | Key | Description |
|---------|:-----:|-------------|
| [Config](general-configuration) | `"c"` | Section containing all the objects & name / value pairs for configuration of the device |
| [Accessories](accessory-configuration) | `"a"` | Section containing all the accessory objects controlled by the device |

## MEPLHAA Layout

The MEPLHAA script is made of up two distinct sections:

```json
{
  "c": {
    // Configuration options
  },
  "a": [
    // Accessories
  ]
}
```

Refer to the [Config](general-configuration) and [Accessories](accessory-configuration)
for details on the options available for each of these sections.

_**MEPLHAA script can be written in multiple lines, but it is highly recommended to use
only a single line because it will result in a smaller in size and use less
device memory.**_

**NOTE: _If you make changes in your MEPLHAA script that involve accessory types,
number of used accessories or change the order of them, you must check
[Reset HomeKit ID](setup-mode#reset-homeKit-id) from within setup mode
and remove your device from HomeKit; and then you must pair it again._**

**[See here some examples and templates](haa-templates)**

Also, you can use the deprecated tool [Maximilian Beck](https://github.com/glumb) developed:

**[MEPLHAA Configurator Tool (Deprecated)](https://github.com/glumb/haa-configurator)**

Not all keys are mandatory, and default values will be applied when optional
keys are not present. You can use a [JSON validator](https://codebeautify.org/jsonvalidator)
to check your MEPLHAA script.

