Stack_Size EQU 0x00000401
               AREA STACK,NOINIT,READWRITE,ALIGN=3
__stack_limit
Stack_Mem       SPACE Stack_Size
__initial_sp

; Vector Table Mapped to Address 0 at Reset
 AREA RESET, DATA, READONLY
 EXPORT __Vectors
 EXPORT __Vectors_End
 EXPORT __Vectors_Size
__Vectors DCD __initial_sp       ; Top of Stack
          DCD Reset_Handler      ; Reset Handler
		  DCD NMI_Handler        ; -14 NMI Handler
		  DCD HardFault_Handler  ; -13 Hard Fault Handler
		  DCD MemManage_Handler  ; -12 MPU Fault Handler
		  DCD BusFault_Handler   ; -11 Bus Fault Handler
		  DCD UsageFault_Handler ; -10 Usage Fault Handler
		  DCD 0                  ; Reserved
		  DCD 0                  ; Reserved
		  DCD 0                  ; Reserved
		  DCD 0                  ; Reserved
		  DCD SVC_Handler        ; SVCall Handler
		  DCD DebugMon_Handler   ; Debug Monitor Handler
		  DCD 0                  ; Reserved
		  DCD PendSV_Handler     ; PendSV Handler
		  DCD SysTick_Handler    ; SysTick Handler
		  ;Interrupts 
		  DCD Interrupt0_Handler ; 0 Interrupt 0
       
__Vectors_End

__Vectors_Size EQU __Vectors_End - __Vectors
                AREA |.text|, CODE, READONLY
Reset_Handler   PROC
                                EXPORT Reset_Handler [Weak]
                                IMPORT __main
                                LDR R0, =__main
                                BX  R0
                                ENDP
									
NMI_Handler        PROC
                                ENDP

HardFault_Handler  PROC
                                ENDP
									
MemManage_Handler  PROC
                                ENDP
									
BusFault_Handler   PROC
                                ENDP
									
UsageFault_Handler PROC
                                ENDP

SVC_Handler        PROC
                                ENDP
									
DebugMon_Handler   PROC
                                ENDP
									
PendSV_Handler     PROC
                                ENDP
									
SysTick_Handler    PROC
                                ENDP
									
Interrupt0_Handler PROC
                                EXPORT Interrupt0_Handler [Weak]
								;IMPORT Interrupt0
								;LDR R0, = Interrupt0
                                BX  LR
                                ENDP
																	
                EXPORT   __stack_limit
                EXPORT   __initial_sp

                                END

