#include<stdio.h>
typedef unsigned int uint32_t; 

#define read_addr(addr)     (*(volatile uint32_t *)addr)
#define write_addr(addr, val) ((*(volatile uint32_t *)addr) = (val))

#define SRAM_A_base_ADDR (uint32_t ) (0x00000000) //0001FFFF
#define SRAM_S_base_ADDR (uint32_t ) (0x20000000) //2000FFFF

#define debug_reg0 (uint32_t *) (SRAM_A_base_ADDR+0x0ff0)
#define debug_reg1 (uint32_t *) (SRAM_A_base_ADDR+0x0ff4)
#define debug_reg2 (uint32_t *) (SRAM_A_base_ADDR+0x0ff8)
#define debug_reg3 (uint32_t *) (SRAM_A_base_ADDR+0x0ffC)

int main () 
{ 
	
	uint32_t uart_read_store;
	uint32_t i,j;
	
	write_addr(debug_reg0, 0x00000001);
 
	write_addr(0x40002003, 0x00008000); //LCR
  write_addr(0x40002001, 0x00000000); //DLM
	write_addr(0x40002000, 0x00000007); //DLL
	write_addr(0x40002003, 0x00000000); //Disable bit
  write_addr(0x40002003, 0x00000300); //LCR
	write_addr(0x40002002, 0x00010000); //FCR
	write_addr(0x40002001, 0x00000000); //IER
	write_addr(0x40002005, 0x00000000); //LSR

  // UART write 
  for(j=0;j<16;j++) {
	 write_addr(0x40002000,(j+1)); //THR
	}
	
	//Delay
	for(i=0;i<100;i++);
	
	// UART Read
	for(j=0;j<16;j++) {
	  uart_read_store=read_addr(0x40002000);
	}
	
	write_addr(debug_reg0, 0x00000007); 

	//delay
	for(i=0;i<20;i++);

	while(1);
}
