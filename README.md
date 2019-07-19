# nasm_win_x86_entry
Basic entry point for win x86 program built with nasm without linking to C library. (ref)

#Reason: 
Possibly when designing a small binary file (shellcode) and you need it to work and still be able to call winapi functions from itself. 
This compiles to be ~6KB and can probably stripped further by merging sections further reducing the size. But that's for another topic.
