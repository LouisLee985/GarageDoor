Since version 1.5.0 HAA has been able to control infra-red (IR) devices.
In order to do this the HAA accessory must have an infra-red transmitter.

Examples of devices that have infra-red transmitters are:

- [Universal IR Remote example](https://github.com/crankyoldgit/IRremoteESP8266/issues/701)

Alternatively look at some examples on the Web of how to add an IR transmitter
to an accessory.

- [Build your own IR transmitter](https://www.letscontrolit.com/wiki/index.php/IRTX)
- [Tasmota IR Remote](https://tasmota.github.io/docs/IR-Remote/)

To understand more about infra-red transmissions and how they are used to
control devices around the home refer to the following sites for more
information:

- [Consumer IR](https://en.wikipedia.org/wiki/Consumer_IR)
- [IR Protocol Waveforms](https://www.techdesign.be/projects/011/011_waves.htm)
- [Remote Central](http://www.remotecentral.com)

# How HAA supports infra-red control

All IR commands consist of groups of infra-red light pulses sent sequentially.
These pulses are split into `marks` and `spaces`. With `marks` being the period
where infra-red light is transmitted and `spaces` being the period where no
infra-red light is transmitted.
A `mark` consists of an alternating burst of infra-red light where the
light is pulsed on & off at a particular frequency.
The most common frequency used by IR transmitters is 38KHz.

Manufacturers often define an IR protocol for their equipment.
This protocol defines the duration of `marks` & `spaces` as well as the commands
that can be sent and what those commands mean.
Sony TV remotes use the Sony Control-S protocol for instance.
For more details on IR data formats checkout this
[Vishay](http://www.vishay.com/docs/80071/dataform.pdf) document or this
[IR Remote Control Theory](https://www.sbprojects.net/knowledge/ir/index.php)
document.

HAA supports IR control by enabling the specification of either `RAW`
or `Protocol` formats for the data to be transmitted.
A `RAW` format defines the code to send as an exact replica of a captured signal.
HAA Setup mode is provided for enabling the capture of remote control codes using an IR
receiver hooked up to an HAA accessory.
A `Protocol` format defines the infra-red sequence exactly how the manufacturer
intended the codes to be sent.

[**HAA IR/RF Capture Tool**](Setup-Mode#IRRF-Capture-GPIO), available into HAA Setup Mode.

## RAW Mode

In `RAW` mode the IR codes are sent exactly as captured using the [HAA IR/RF Capture Tool](Setup-Mode#IRRF-Capture-GPIO).
Transmitting the raw captured data is not recommended because you are using a
copy of the signal and the quality of the captured signal may be degraded. Use
it only if you are unable to decipher the protocol being used by the equipment.
`RAW` mode also uses a lot more flash storage to hold the definition of the
codes, requiring 2 characters for each `mark` or `space` sequence.

Below is a sample output from using the tool.
The table shows the sequential codes that have been captured by the tool.
![RAW Capture Image](https://raw.githubusercontent.com/RavenSystem/ravensystem-media/master/ir_capture_raw.png)

In order to re-transmit these codes using `RAW` mode the numeric values need to
be translated into a `RAW` code string.
This can be done using the [IR Encoder Table](HAA-IR-Encoder-Table).
From the table you can convert the integer code stream into a series of HAA
`RAW` codes.
Round the integers output by the tool to the nearest 0 or 5 and
then find this value in the `N` column of the [IR Encoder Table](HAA-IR-Encoder-Table).
The corresponding value in the `C` column can then be used to create a `RAW`
code sequence to be transmitted by your HAA accessory.

In the above table the `RAW` code string can be constructed as follows:

- The integer `3550` is represented by the code `Ht`
- The integer `1677`, rounded down to `1675`, is represented by the code `DC`
- The integer `500` is represented by the code `AQ`
- The integer `362`, rounded down to `- 360` is represented by the code `0=`
etc...

The RAW code string can then be constructed as
<!-- spellchecker: disable -->
`"w" : "HtDCAQ0=A5B>AP0=AR0=AR0=AR0=AR0=AR0=AR0=AR0?AR0A50=AR0ARCDAK0=AR0=AR0=AR0=AR0=AR0=AR0?AR0?AR0=ARB>AQ0=A50=AR0=AR0-AK0-AL0=AR0=AR0=AR0>AP0?ARCDAKB>APB>APB>AP0=AR0=ARB>AP0?ARCDAKCDAKC0APB>AP0?ARCDAK"`
<!-- spellchecker: enable -->

**Note: see how long the string becomes when using RAW codes!**

## Protocol Mode

In `Protocol` mode the format and sequence is defined as a fixed pattern
consisting of a header, the data and a footer.
Almost all IR receivers for devices support defined protocols.
Unfortunately different manufacturers have different protocols.
There is no single IR protocol that is able to control all IR enabled devices.

Using the [HAA IR/RF Capture Tool](Setup-Mode#IRRF-Capture-GPIO), accessible from Setup Mode,
it is possible to capture an IR sequence and decode that sequence into an IR protocol.
Once the protocol has been defined it is then possible to encode IR commands in
much shorter data strings than trying to re-transmit a `RAW` code sequence.

In HAA the `Protocol` is defined as having four fields:

1. `Header`: the first mark (+), space (-) sequence
2. `Bit 0`: a mark (+), space (-) sequence defining a bit 0 value
3. `Bit 1`: a mark (+), space (-) sequence defining a bit 1 value
4. `Footer`: the last mark (+) transmitted in the sequence

To define the `Protocol` the captured `RAW` sequence must be analysed and decoded.
The captured code sequence below consists of a press of the power on/off button
from a Panasonic TV remote.

![RAW Capture Image](https://raw.githubusercontent.com/RavenSystem/ravensystem-media/master/ir_capture_protocol.png)

In this captured sequence the four fields are colour coded as
<span style="color: blue;">Header</span>, <span style="color: red;">Bit 0</span>,
<span style="color: green;">Bit 1</span>, <span style="color: purple;">Footer</span>

Breaking down the code sequence and using the [IR Encoder Table](HAA-IR-Encoder-Table)
we start with the <span style="color: blue;">Header</span>.
This has a mark (+) value of 3550, translated to `Ht` and a space (-) value
of 1677, rounded to 1675 and translated to `DC`.

Examining the <span style="color: red;">Bit 0</span> values.
Marks are in the range 490 to 510, so we can use a value of 500, translated to `AQ`.
Spaces are in the range 360 to 365, so we use a value of 365, translated to `0?`

Examining the <span style="color: green;">Bit 1</span> values.
Marks are in the range 490 to 510, so we can use a value of 500, translated to `AQ`.
Spaces are in the range 1240 to 1260, so we use a value of 1250, translated to `CA`

Finally, we can see the <span style="color: purple;">Footer</span> value of 473,
rounded to the value of 470 and translated to `AK`.

Referring to the details within the [IR Action](Accessory-Configuration#Send-IR-Code-Actions)
definition we need to combine the results of the above into a `Protocol` string `"p"`.
This is done using the format: `"p": "HHHH00001111FF"` where

| Field | Description |
|:-----:|:------------|
| HHHH | Header mark & space
| 0000 | Bit 0 mark & space
| 1111 | Bit 1 mark & space
| FF | Footer mark

<!-- spellchecker: disable -->
Resulting in a `Protocol` definition of `"p": "HtDCAQ0?AQCAAK"`.
<!-- spellchecker: enable -->

Defining the pattern for all IR commands that can be used to control the
Panasonic TV.

### IR Commands

All IR commands will be sent using a defined IR protocol.
Within HAA the default protocol can be set in the [General Configuration](General-Configuration#Infra-red-Configuration)
section of the device setup, but can be overridden at any time by adding a
protocol `"p"` key within an Accessory (in this case, protocol will be used
for all IR Actions inside accessory), or even within an [IR Action](Accessory-Configuration#Send-IR-Code-Actions).

Continuing with our captured data from above we can decode the IR command by
analysing the sequence of <span style="color: red;">Bit 0</span> and
<span style="color: green;">Bit 1</span> patterns then use the
[IR Protocol Multiplier Table](HAA-IR-Protocol-Multiplier-Table) to translate
the number of times each bit must be sent into an IR command code.

The captured IR sequence shows a single <span style="color: red;">Bit 0</span>
(`a`), followed by a single <span style="color: green;">Bit 1</span> (`A`),
followed by 11 <span style="color: red;">Bit 0s</span> (`k`), then  a single
<span style="color: green;">Bit 1</span> (`A`) etc.

The resultant IR command within the [IR Action](Accessory-Configuration#Send-IR-Code-Actions)
becomes `"c" : "aAkAiAhAaDbAaDaA"`

Using the technique above any IR device can be captured and translated into
an HAA IR `Protocol` and set of IR commands.

[HAA IR ToolKit](https://github.com/RavenSystem/haairtoolkit)