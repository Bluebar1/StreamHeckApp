# StreamHeck
StreamHeck is a Macro Keyboard app and server based on Elgato’s ["StreamDeck"](https://www.elgato.com/en/stream-deck)  
Made using Dart/Flutter


## Overview
StreamHeck allows me to use a mobile device (iOS or Android) to control my computer. I mainly use it for storing and pasting boilerplate code for the languages I use, but it has many other functionalities such as running any AutoHotKey script, running a command in terminal, opening/closing applications, and changing the volume. 

## How it works
On app startup, it will connect to the specified computer on your local network. The computer must be running a StreamHeckServer instance.
This "server" is actually two servers. HTTP is used for accessing data such as saved pages and macros, while the socket server handles
signals to execute these macros. [Further explanation and source code found here](https://github.com/Bluebar1/StreamHeckServer). 

After successfully connecting to the server and fetching data from the HTTP server, the pages are loaded, each with a different set of macros.
The user has the ability to create new pages and macros. For example, I created a "Flutter" page with macros to paste boilerplate code.

## Macro Design
It was important to make each macro distinguishable, so I added the ability to change many aspects of its appearance.  
Each macro's appearance can be changed by:
* Background supports any solid color, any gradient of two colors, or any image/gif.
* Change the text label (e.g. "paste stateful widget")
* The labels font can be changed by style, size, color, and orientation.

## Macro Functionality
The first functionality I added was triggering any AutoHotKey script. By adding this, I adopted the limitless
possibilities provided by AHK and it's community. But I realized that many users may not use AHK, so I added 
basic functionality to perform other tasks as well. Currently StreamHeck also supports running a command in commandline,
pasting a given string, pasting the contents of a txt file, and trigger any of Windows' default key-combination shortcuts.

## Notes
This project was started years ago when I was first learning flutter, and contains many mistakes I would not make today.
For example, I use Provider for state management in a way that rebuilds widgets far too often.
