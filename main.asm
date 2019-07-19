SECTION .data		; data section

s_zero_zone dd 'Zero_Zone', 0
s_shell32 dd 'Shell32.dll', 0
s_kernel dd 'kernel32.dll', 0

s_CreateProcessA dd 'CreateProcessA', 0
s_WriteConsole dd 'WriteConsoleA', 0
s_GetStdHandle dd 'GetStdHandle', 0
s_Sleep dd 'Sleep', 0
GetModuleHandle: dd 0 
CreateProcessA: dd 0 
WriteConsole: dd 0
GetStdHandle: dd 0
Sleep: dd 0

get_proc_addr: dd 0 
kernel_module: dd 0 
std_handle: dd 0


SECTION .text		; code section	
	global main ;make main: label be the global entry point
	main:
	mov eax, [esp]
	xor al, al
	
	continue:
	sub eax, 0x4
	cmp dword [eax], 0x00905A4D ;M
	jne continue
	
	mov dword [kernel_module], eax
	add eax, 0x10000

	add eax, 0xB28
	mov dword [get_proc_addr], eax
	
;	sub eax, 0x1C
;	mov eax, [eax]
;	mov dword [GetModuleHandle], eax	
	
;	push kernel ;
;	call [GetModuleHandle]
;	mov dword [kernel_module], eax
	
	mov eax, [get_proc_addr]
	push s_CreateProcessA
	push dword [kernel_module]
	call [eax]
	mov dword [CreateProcessA], eax
	
	mov eax, [get_proc_addr]
	push s_Sleep
	push dword [kernel_module]
	call [eax]
	mov dword [Sleep], eax	
	
	mov eax, [get_proc_addr]
	push s_WriteConsole
	push dword [kernel_module]
	call [eax]
	mov dword [WriteConsole], eax	
	
	mov eax, [get_proc_addr]
	push s_GetStdHandle
	push dword [kernel_module]
	call [eax]
	mov dword [GetStdHandle], eax	

	push -11
	call eax
	mov dword [std_handle], eax
	
	push 0x0
	push 0x0
	push 0x9
	push s_zero_zone
	push dword [std_handle]
	call [WriteConsole]
	
	push 0xFFFFFFFF
	call [Sleep]
	
;	add eax, 0xB3C ;load library
;	push 0x00000010
;	push 0x0
;	push shell32
;	call [eax]
	
	
	
	
	int3