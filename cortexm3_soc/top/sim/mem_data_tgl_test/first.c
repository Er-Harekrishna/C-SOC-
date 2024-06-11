#include<stdio.h>
typedef unsigned int uint32_t; 

//#define CPU_ID_REG_ADDR (uint32_t *) (0xE000ED00)
//#define GPIO_1 *((uint32_t *) (0x20000ff0))

#define read_addr(addr)     (*(volatile uint32_t *)addr)
#define write_addr(addr, val) ((*(volatile uint32_t *)addr) = (val))


	
#define SRAM_A_base_ADDR (uint32_t ) (0x00000000) //0001FFFF
#define SRAM_S_base_ADDR (uint32_t ) (0x20000000) //2000FFFF
#define APB_base_ADDR (uint32_t ) (0x40000000)    //4000FFFF
#define UART_base_ADDR (uint32_t ) (APB_base_ADDR+0x2000)    //40002FFF
#define I2C_base_ADDR (uint32_t ) (APB_base_ADDR+0x1000)    //40001FFF
#define MEM_base_ADDR (uint32_t ) (APB_base_ADDR+0x0000)    //40000FFF

#define debug_reg0 (uint32_t *) (SRAM_A_base_ADDR+0x0ff0)
#define debug_reg1 (uint32_t *) (SRAM_A_base_ADDR+0x0ff4)
#define debug_reg2 (uint32_t *) (SRAM_A_base_ADDR+0x0ff8)
#define debug_reg3 (uint32_t *) (SRAM_A_base_ADDR+0x0ffC)

int main () 
{ 
	uint32_t i,j;
	
	write_addr(debug_reg0, 0x00000001); 
	
	write_addr(0x40000aaa,0xaaaaaaaa);
	j = read_addr(0x40000aaa);
	
	write_addr(0x40000aa8,0xaaaaaaaa);
	j = read_addr(0x40000aa8);
	
	write_addr(0x40000555,0x55555555);
	j = read_addr(0x40000555);
	
	write_addr(0x40000554,0x55555555);
	j = read_addr(0x40000554);
	
	write_addr(0x40000aaa,0xaaaaaaaa);
	j = read_addr(0x40000aaa);
	
	write_addr(0x40000aa8,0xaaaaaaaa);
	j = read_addr(0x40000aa8);

  write_addr(debug_reg0, 0x00000007); 

	//delay
	for(i=0;i<20;i++);
	
	while(1);
}
