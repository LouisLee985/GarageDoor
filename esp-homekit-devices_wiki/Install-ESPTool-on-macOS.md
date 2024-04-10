Open a Terminal, and launch following command to install Python3 from Apple:

```shell
xcode-select --install
```

If system asks about install Developer Tools for macOS, do it.

Next, update pip (Python package manager) and install ESPTool:
```shell
python3 -m pip install --upgrade pip
python3 -m pip install esptool
```

In order to launch `esptool.py`, exec directly with this:
```shell
python3 -m esptool
```

### Optional

Alternatively, but not needed, you can add Python binaries directory to `PATH`:
```shell
~/Library/Python/3.9/bin
```

## Updating ESPTool

To update a current installation of ESPTool to last version:
```shell
python3 -m pip install --upgrade esptool
```