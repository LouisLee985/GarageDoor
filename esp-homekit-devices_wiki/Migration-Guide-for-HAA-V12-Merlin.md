HAA V12 Merlin has some breaking changes from v12 Peregrine. These changes are mainly about GPIO definitions, meaning that scripts must be adapted to be compatible with new version.

# GPIO Configuration

Before, GPIOs configurations were taken directly from different parts of the script. Configurations about INPUT, OUTPUT, OPENDRAIN, PULL-UP, PWM, initial state, etc. Now, there is an unique section to do this, avoiding duplicity and confusions.

Since v12, GPIO declarations must be in an array `"io":[...]` into configuration `"c":{...}` section.

See [GPIOs Configuration](GPIOs-Configuration) details.

## Binary Outputs

Declarations of type `"r":[{...}]` into actions, that set a GPIO LOW or HIGH, to activate a relay, or a LED, for example, uses GPIO that must be declared into `"io":[...]` as Output. Same for status LED declared with `"l":` key and IR LED declared with `"t":` key in configuration section.

### Example 1:

`"r":[{"g":12}]` will need the following declaration into `"io"`:

```json
"io":[
  [ [ 12 ], 2 ]
]
```

### Example 2:

`"r":[{"g":12},{"g":13,"v":1}]` will need the following declaration into `"io"`. Note that GPIOs `12` and `13` has same configuration:

```json
"io":[
  [ [ 12, 13 ], 2 ]
]
```

### Example 3:

`"r":[{"g":5,"n":1}]` and other action with `"r":[{"g":4,"v":1}]` will need the following declaration into `"io"`.

`"n":1` used to set GPIO `5` to HIGH __must be removed__, because initial state now is declared in `"io"`:

```json
"io":[
  [ [ 5 ], 2, 0, 1 ],
  [ [ 4 ], 2 ]
]
```

### Example 4:

`"l":13` status LED declaration will need the following declaration into `"io"`:

```json
"io":[
  [ [ 13 ], 3 ]
]
```

### Example 5:

`"t":16` IR LED declaration will need the following declaration into `"io"`:

```json
"io":[
  [ [ 16 ], 2 ]
]
```

## Buttons/Switches

Arrays of types `"b":[...]`, `"f[n]":[...]` and `"g[n]":[...]` used to declare buttons, switches, binary sensors... have removed some options that now must be declared into `"io":` array.

Removed options from `"b":[...]`, `"f[n]":[...]` and `"g[n]":[...]`:

| Option | Description
|:------:|:-----------
| `"p":` | Internal GPIO pull-up resistor
| `"i":` | Inverted input and pulse type
| `"f":` | GPIO Input filter

These options must be removed, and set them into `"io":` array with type `6`.

### Example 1:

`"b":[{"g":0,"t":5}]` will need the following declaration into `"io"`:

```json
"io":[
  [ [ 0 ], 6, 1 ]
]
```

### Example 2:

`"b":[{"g":5,"p":0},{"g":5,"t":0}]` will be `"b":[{"g":5},{"g":5,"t":0}]` (`"p":0` is removed), and needs the following declaration into `"io"`:

```json
"io":[
  [ [ 5 ], 6 ]
]
```

### Example 3:

`"f4":[{"g":5,"p":0,"i":1}]` will be `"f4":[{"g":5}]` (`"p":0` and `"i":1` are removed), and needs the following declaration into `"io"`:

```json
"io":[
  [ [ 5 ], 6, 0, 1 ]
]
```

### Example 4:

`"b":[{"g":3,"f":10}]` will be `"b":[{"g":3}]` (`"f":10` is removed), and needs the following declaration into `"io"`:

```json
"io":[
  [ [ 3 ], 6, 1, 0, 10 ]
]
```

### Example 5:

`"b":[{"g":13,"p":0},{"g":13,"t":0}]` and `"b":[{"g":5,"p":0},{"g":5,"t":0}]` will be `"b":[{"g":13},{"g":13,"t":0}]` and `"b":[{"g":5},{"g":5,"t":0}]` (`"p":0` is removed), and needs the following declaration into `"io"`:

```json
"io":[
  [ [ 5, 13 ], 6 ]
]
```

## PWM

Lightbulb service using PWM has move these GPIOs options to `"io":[...]` array:

- Normal or open-drain output.
- Direct or inverted output.
- Dithering.
- Trailing or leading.

Then, `"ld":` and `"di":` must be removed from Lightbulb service because they are useless, and include their declarations into `"io":` array.

And most important, GPIOs into `"g":[...]` array must be declared into `"io":` array as PWM type.

Example 1:

`"g":[15,13,12]` will need the following declaration into `"io"`:

```json
"io":[
  [ [ 15, 13, 12 ], 7 ]
]
```

Example 2:

`"g":[15,13,12,4],"ld":[0,1,0,1]` will be only `"g":[15,13,12,4]` (`"ld":[0,1,0,1]` is removed), and needs the following declaration into `"io"`:

```json
"io":[
  [ [ 15, 12 ], 7,
  [ [ 13, 4 ], 7, 0, 0, 2 ]
]
```


## NRZ

[Lightbulb Service](Lightbulb) using [NRZ protocol](Lightbulb#nrz-protocol) uses a GPIO declared in `"g":[...]` array. This GPIO must be declared as output into `"io":[...]` array.

### Example 1:

A Lightbulb Service `{"t":30,"ty":8,"g":[5,1,6]}` needs the following declaration into `"io"`, declaring GPIO `5` as output:

```json
"io":[
  [ [ 5 ], 2 ]
]
```

## Binary Inputs

Some Services use special drivers with GPIO, and now they need to declare them into `"io":[...]` array.

### Power Measure Service with HLW8012/BL0937

`"dt" : [ CF, CF1, Sel ]`: Power Measure service with `"n":1` or `"n":2` needs to declare used CF and CF1 GPIOs as Input into "io":[...] array, and Sel GPIO as Output. See [GPIOs Configuration](https://github.com/RavenSystem/esp-homekit-devices/wiki/Migration-Guide-for-HAA-V12-Merlin/GPIOs-Configuration)

For example:

`"dt" : [ 12, 13, 15 ]` will need:

```json
"io":[
  [ [ 12, 13 ], 1 ],
  [ [ 15 ], 2 ]
]
```

### Free Monitor Service with Pulse

GPIOs from `"g" : [ GPIO, Type, Pull-up, Trigger GPIO ]` must be declared into `"io":`array.

Because `Pull-up` is declared into `"io"` array, it must be removed from `"g":[...]` array from Free Monitor, because in v12, declaration is `"g" : [ GPIO, Type, Trigger GPIO ]`.

`GPIO` must be Input. If Pull-up is missing or `0`, remove it from following declaration: `[ [ GPIO ], 1, Pull-up ]`

`Trigger GPIO` must be Output: `[ [ Trigger GPIO ], 2 ]`

For example:

`"g" : [ 12, 1, 1, 16 ]` will be `"g" : [ 12, 1, 16 ]`, and needs:

```json
"io":[
  [ [ 12 ], 1, 1],
  [ [ 16 ], 2 ]
]
```

# Logs

In V12 Merlin, there are more [log types](General-Configuration#log-output) to allow use of ESP32 UART2. Then, some old log types have a different value that must be modified as follow:

|  v11  |   v12  |
|:-----:|:------:|
|`"o":3`| `"o":4`|
|`"o":4`| `"o":5`|
|`"o":5`| `"o":6`|
|`"o":6`| `"o":8`|
|`"o":7`| `"o":9`|
|`"o":8`|`"o":10`|

# UART

## UART Logs

If UART logs are enabled in configuration section, like `"o":1`, in V12 Merlin it is needed to activate UART explicitly with an [UART declaration](General-Configuration#UART-Configuration).

### Example 1:

A `"c":{"o":1, ...}` setting will be:

```
"c":{"o":1, "r":[{"n":0}], ...}
```

### Example 2:

A `"c":{"o":2, ...}` setting will be:

```
"c":{"o":2, "r":[{"n":1}], ...}
```

## Free Monitor UART Receiver

Free Monitor Service using [UART Receiver](Free-Monitor#23-24-and-25-uart-receiver) must activate receiver mode in [UART configuration](General-Configuration#UART-Configuration).

To activate UART receiver mode, simply change UART number `"n":` from `"r":[{...}]` [UART configuration](General-Configuration#UART-Configuration) array according to this table:

|  v11  |   v12  |
|:-----:|:------:|
|`"n":0`|`"n":10`|
|`"n":2`|`"n":12`|

If `"ul:[min,Max]` is used, remove it, and declare it into UART declaration with `"l":` key.

### Example 1:

`"c":{"ul":[15,20],"r":[{"n":0,"s":9600}]}` will be:

```json
"c":{"r":[{"n":10,"s":9600,"l":[15,20]}]}
```