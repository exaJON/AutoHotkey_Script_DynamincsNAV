# Navision 2015 AutoHotkey Script

This repository contains AutoHotkey scripts designed specifically for the Navision 2015 development environment. These scripts provide a variety of hotkeys and hotstrings to enhance productivity and automate repetitive tasks.

## Files

- **`Navision2015.ahk`**: Main script with hotkeys and hotstrings for the Navision development environment.
- **`Standard.ahk`**: Script for processing Excel data and creating Navision filters.
- **`README.md`**: This documentation.

---

## Features in `Navision2015.ahk`

### Hotkeys
Hotkeys are key combinations that perform specific actions in the Navision development environment. Here are some of the key hotkeys:

- **`CTRL + o`**: Opens options and navigates to the tenant selection.
- **`CTRL + ALT + d`**: Adds a documentation trigger line and increments the numbering.
- **`CTRL + g`**: Opens global variables.
- **`CTRL + l`**: Opens local variables.
- **`CTRL + #`**: Inserts a documentation section based on the user's initials.
- **`CTRL + d`**: Copies the current line and pastes it below.
- **`CTRL + SHIFT + f`**: Searches using the term under the cursor.
- **`CTRL + SHIFT + h`**: Searches and replaces using the term under the cursor.

### Hotstrings
Hotstrings are text shortcuts that automatically expand into longer commands or code. Examples:

- **`d#`**: Inserts today's date in the format `dd.MM.yyyy`.
- **`vl#`**: Expands to `VALIDATE();` and positions the cursor inside the parentheses.
- **`if#`**: Inserts an `IF` condition with placeholders.
- **`sr#`**: Expands to `SETRANGE();` and positions the cursor inside the parentheses.
- **`doc#`**: Inserts a documentation trigger line based on the last version number in the clipboard.

---

## Features in `Standard.ahk`

This script is used for processing Excel data and creating Navision filters:

- **`CTRL + ALT + c`**: Copies selected text from Excel, replaces spaces and line breaks with pipes (`|`), and removes duplicate pipes.
- **`CTRL + WIN + c`**: Similar to the above but also prepends `@*` to each value.

---

## Requirements

- **AutoHotkey v2.0**: These scripts are written for AutoHotkey version 2.0. Ensure this version is installed.

---

## Installation

1. Download the files and save them in a folder.
2. Ensure AutoHotkey v2.0 is installed.
3. Start the desired scripts by double-clicking them or running them via the command line.

---

## Notes

- The hotkeys and hotstrings are optimized specifically for the Navision development environment (`finsql.exe`).
- Some functions require the username to be in the format `Firstname.Lastname` to generate initials correctly.

---

## License

This project is released under the MIT License. For more details, refer to the `LICENSE` file (if available).

---