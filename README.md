# nasm_win_x86_entry
Basic entry point for win x86 program built with nasm without linking to C library. (ref)

####Reason: 
Possibly when designing a small binary file (shellcode) and you need it to work and still be able to call winapi functions from itself. 
This compiles to be ~6KB and can probably stripped further by merging sections further reducing the size. But that's for another topic.

####Features:
Launches multiple processes of itself to grant security from debuggers and reverse engineers
Runs self-modyfying code
Can edit any memory permissions of itself.
When started runs 2 separate processes which in turn check on each other to make sure it is not possible to terminted them.
(better way is to corrupt the process handle but I don't know how)

More things to come, if I find them .
