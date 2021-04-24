# Windows Services Monitor
This extension monitors and reports the state of Windows services on the local machine.
The extension runs every 30 seconds (can be adjusted in bundle.properties).
The "status" metric reports: 0= Stopped, 1= Running, 2= Pending.
If any service name has an ampersand ("&") in the string, it will be replaced with the word "And".