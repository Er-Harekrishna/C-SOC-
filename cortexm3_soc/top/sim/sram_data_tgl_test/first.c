#include<stdio.h>
typedef unsigned int uint32_t; 

//#define CPU_ID_REG_ADDR (uint32_t *) (0xE000ED00)
//#define GPIO_1 *((uint32_t *) (0x20000ff0))

#define read_addr(addr)       (*(volatile uint32_t *)addr)
#define write_addr(addr, val) ((*(volatile uint32_t *)addr) = (val))
	
#define SRAM_A_base_ADDR (uint32_t) (0x00000000)           //0001FFFF
#define SRAM_S_base_ADDR (uint32_t) (0x20000000)           //2000FFFF

#define debug_reg0 (uint32_t *) (SRAM_A_base_ADDR+0x0ff0)
#define debug_reg1 (uint32_t *) (SRAM_A_base_ADDR+0x0ff4)
#define debug_reg2 (uint32_t *) (SRAM_A_base_ADDR+0x0ff8)
#define debug_reg3 (uint32_t *) (SRAM_A_base_ADDR+0x0ffC)

int main () 
{ 
	//Test start
	write_addr(debug_reg0, 0x00000001);
	
	write_addr(0x2000aaa8,0xaaaaaaaa);
	read_addr(0x2000aaa8);
	
	write_addr(0x2000aaaa,0xaaaaaaaa);
	read_addr(0x2000aaaa);
	
	write_addr(0x2000aaa8,0x55555555);
	read_addr(0x2000aaa8);
	
	write_addr(0x2000aaaa,0x55555555);
	read_addr(0x2000aaaa);
	
	write_addr(0x20015554,0xaaaaaaaa);
	read_addr(0x20015554);
	
	write_addr(0x20015555,0xaaaaaaaa);
	read_addr(0x20015555);
	
	write_addr(0x20015554,0x55555555);
	read_addr(0x20015554);
	
	write_addr(0x20015555,0x55555555);
	read_addr(0x20015555);
	
	//Test end
	write_addr(debug_reg0, 0x00000007);  
	
	//delay
	for(long int j=0;j<20;j++);  
	
	while(1);
}
