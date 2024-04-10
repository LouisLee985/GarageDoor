### [MEPLHAA Script Devices Database](Devices-Database)


#### EXAMPLE TO LEARN: HomeKit Switch with UART output, inverted status LED, relay on GPIO 12, button connected to GPIO 0 and toggle connected to GPIO 14:
* `{"c":{"io":[[[12,13],2],[[0],6],[[14],6,1]],"o":0,"l":13,"i":1},"a":[{"t":1,"0":{"r":[[12,0]]},"1":{"r":[[12,1]]},"b":[[0,1],[14,1],[14,0]]}]}`

* Simplified version, removing all default values:
`{"c":{"io":[[[12,13],2],[[0],6],[[14],6,1]],"l":13},"a":[{"0":{"r":[[12]]},"1":{"r":[[12,1]]},"b":[[0],[14],[14,0]]}]}`

```json
{                 <- Start of MEPLHAA Script
  "c": {          <- General config section
    "io": [...],  <- GPIOS Configuration
    "o": 0,       <- Disable UART log output
    "l": 13,      <- Enable status LED at GPIO 13
    "i": 1        <- Set status LED to inverted mode
  },              <- End of general config section
  "a": [          <- Accessory section. Must be an array
    {             <- First accessory, and the only
      "t": 1,     <- Accessory type 1 (Switch)
      "0": {      <- Actions triggered when HomeKit switch is set to OFF
        "r": [    <- Digital outputs. Must be an array
          [       <- First digital output (a relay), and the only
            12,   <- Relay connected to GPIO 12
            0     <- Value assigned to the relay
          ]       <- End of first relay
        ]         <- End of relays array
      },
      "1": {      <- Actions triggered when HomeKit switch is set to ON
        "r": [    <- Digital outputs. Must be an array
          [       <- First digital output (a relay), and the only
            12,   <- Relay connected to GPIO 12
            1     <- Value assigned to the relay
          ]       <- End of first relay
        ]         <- End of relays array
      },
      "b": [      <- Buttons. Must be an array
        [         <- First button
          0,      <- First button at GPIO 0
          1       <- Set button to single press type
        ],        <- End of first button
        [         <- Second button
          14,     <- Second button at GPIO 14
          1       <- Set button to single press type
        ],        <- End of second button
        [         <- Third button
          14,     <- Third button at GPIO 14, same as second button
          0       <- Set button to single press opposite to 1 type
        ]         <- End of third button
      ]           <- End of buttons array
    }             <- End of first accessory
  ]               <- End of accessories array
}                 <- End of MEPLHAA Script
```

#### EXAMPLE TO LEARN: Dummy Switch and Dummy Outlet, and nothing more:
* `{"a":[{"t":1},{"t":2}]}`

```json
{                 <- Start of MEPLHAA Script
  "a": [          <- Accessory section. Must be an array
    {             <- First accessory
      "t": 1      <- Accessory type Switch
    },            <- End of first accessory
    {             <- Second accessory
      "t": 2      <- Accessory type Outlet
    }             <- End of second accessory
  ]               <- End of accessories array
}                 <- End of MEPLHAA Script
```
