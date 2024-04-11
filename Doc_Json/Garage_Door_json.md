

```json
{"c":{"io":[[[2,13],2],[[0],6],[[15],6,1]],"l":2,"b":[[0,5]]},"a":[{"0":{"r":[[13]]},"1":{"r":[[13,1]]},"b":[[0],[15],[15,0]]}]}
```	

```json
{"c":{"io":[[[2,13],2],[[15],6,1]],"l":2},"a":[{"0":{"r":[[13]]},"1":{"r":[[13,1]]},"b":[[15],[15,0]]}]}
```

```json
{"c":{"io":[[[2,13],2],[[15],6,1]],"l":2},"a":[{"0":{"r":[[13]]},"1":{"r":[[13,1]]},"b":[[15]]}]}
```	


| Key | Action | Description |
|:------:|:------|:------------|
| `"0"` | Close an open door | Handle request to close an open door
| `"1"` | Open a closed door | Handle request to open a closed door
| `"2"` | Close an opening door | Handle changing direction of opening action
| `"3"` | Open a closing door | Handle changing direction of closing action
| `"4"` | Opened door detected | Handle door has opened
| `"5"` | Closed door detected | Handle door has closed
| `"6"` | Opening door detected | Handle door opening
| `"7"` | Closing door detected | Handle door closing
| `"8"` | Obstruction removed | Handle the removal of an obstruction
| `"9"` | Obstruction detected | Handle the detection of an obstruction
| `"10"` | Emergency stop | Handle an emergency stop
| `"11"` | Obstruction detected by time | Handle the detection of an obstruction by [Obstruction Detection Time](https://github.com/LouisLee985/GarageDoor/blob/main/esp-homekit-devices-wiki-12.12.4/Garage-Door.md#Obstruction-Detection-Time)
| `"12"` | Close a stopped door | Handle request to close a middle open stopped door
| `"13"` | Open a stopped door | Handle request to open a middle open stopped door



| Key | Required State |
|:------:|:-----|
| `"f0"` | Set garage door to open
| `"f1"` | Set garage door to close
| `"f2"` | Indicates that garage door is open
| `"f3"` | Indicates that garage door is closed
| `"f4"` | Indicates that garage door is opening
| `"f5"` | Indicates that garage door is closing
| `"f6"` | Indicates that there is not obstruction
| `"f7"` | Indicates that there is obstruction
| `"f8"` | Emergency stop

Closes either after 5 min when inching switch goes off, or 15 sec (another inching switch) after gate’s photoelectronic motion sensor triggered.

```json
{
  "c":{"l":13,"b":[{"g":0,"t":5}],"o":0},
	"a":[
	   {"0":{"r":[{"g":12,"v":1,"i":0.3}]},
		"1":{"a":0},
		"2":{"r":[{"g":12,"i":1.5},{"g":12,"v":1,"i":0.3},{"g":12,"v":1,"i":2}]},
		"3":{"a":2},
		"4":{"m":[{"g":6,"v":1},{"g":6,"v":-1}]},
		"5":{"m":[{"g":6,"v":0}]},
		"t":40,"d":26,
		"f3":[{"g":14,"t":1,"p":1}],
		"f4":[{"g":14,"p":1,"t":0}],
		"s":1,"b":[],
		"f2":[{"g":4,"t":1}],
		"f5":[{"g":4,"t":0}],
		"f7":[],
		"f6":[]},
		{"1":{"s":[{"a":1}]},"b":[],"s":0},
		{"1":{"s":[{"a":2}]},"b":[],"s":0},
		{"0":{"m":[{"g":5,"v":1},{"g":5,"v":-1}]},"t":12,"s":0,"f0":[{"g":5,"t":0}],"f1":[{"g":5,"t":1}]},
		{"0":{"m":[{"g":1,"v":1}]},"xa":0,"t":1,"b":[],"s":0,"d":15},
		{"0":{"m":[{"g":1,"v":1}]},"xa":0,"t":1,"b":[],"s":0,"d":300},
		{"0":{"m":[{"g":1,"v":3}]},"1":{"m":[{"g":1,"v":4}]},"t":1,"b":[],"s":0}
	]
} 
```

| IO | Pin |
|:------|:-----|
|LEDIO|2
|OPENRELAYIO|12
|CLOSERELAYIO|13
|LAMPRELAYIO|14
|OBSTRUCTIONSENSOR_SWIO|15

| IO | Pin |
|:------|:-----|
|OPENIO|19
|STOPIO|22
|CLOSEIO|21

| IO | Pin |
|:------|:-----|
|OBSTRUCTIONSENSORIO|25
|OPENSENSORIO|26
|CLOSESENSORIO|27/18

```json
{"c":{"io":[[[2,12,13,14,15],2],[[19,22,21,25,26,18],6,1,1],[[0],6],[[33]]],
	"o":1,"l":2,"m":10,"b":[[0,5]]},
	"a":[{
		"0":{"r":[[12],[13,1,25]]},
		"1":{"r":[[13],[12,1,25]]},
		"2":{"a":0},
		"3":{"a":1},
		"4":{"r":[[14,1]]},
		"5":{"r":[[14,1,5],[15]]},
		"6":{"a":4},
		"7":{"r":[[14,1],[15,1]]},
		"8":{"a":0},
		"9":{"r":[[12,1,2],[13]]},
		"10":{"r":[[12],[13]]},
		"12":{"a":0},
		"13":{"a":1},
		"t":40,"s":1,"d":25,"c":25,"vs":1,
		"f0":[[19]],
		"f1":[[21]],
		"f6":[[25,0]],
		"f7":[[25]],
		"f8":[[22]],
		"f3":[[18]],
		"f4":[[18,0]],
		"f2":[[26]],
		"f5":[[26,0]]
		}]
}
```

```json
{"c":{"io":[[[2,12,13,14,15],2],[[19,22,21,25,26,18],6,1,1],[[0],6],[[33]]],"o":1,"l":2,"m":10,"b":[[0,5]]},"a":[{"0":{"r":[[12],[13,1,25]]},"1":{"r":[[13],[12,1,25]]},"2":{"a":0},"3":{"a":1},"4":{"r":[[14,1]]},"5":{"r":[[14,1,5],[15]]},"6":{"a":4},"7":{"r":[[14,1],[15,1]]},"8":{"a":0},"9":{"r":[[12,1,2],[13]]},"10":{"r":[[12],[13]]},"12":{"a":0},"13":{"a":1},"t":40,"s":1,"d":25,"c":25,"vs":1,"f0":[[19]],"f1":[[21]],"f6":[[25,0]],"f7":[[25]],"f8":[[22]],"f3":[[18]],"f4":[[18,0]],"f2":[[26]],"f5":[[26,0]]}]}
```
