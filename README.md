This program is an analog to the standard Elf/OS utility minimon but for manipulating I/O ports instead of memory. It re-purposes basically the same syntax as minimon, here are some examples:

To read port 7:  
>?7  
7: C0  

To write to port 6:  
>!6 41  

To exit:  
>/  

A difference from minimon is that multiple byte values given on a write statement do not write to successive ports, rather they write repeatedly to the same port:

To write "ABC" to port 6:  
>!6 41 42 43  

This was a bit of a quick and dirty program, I did not take much care to make it pretty, but it has proven useful to me in troubleshooting hardware, so I'll publish it as-is for now in case it's useful to others as well.

David Madole

