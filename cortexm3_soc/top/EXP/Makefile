TARGET_DIR = ..\EXP\TD1 ..\EXP\TD2
SOURCE_FILES = ..\EXP\S1\image.hex ..\EXP\S2\image.hex

#move:
#	@$(shell) copy $(SOURCE_FILE) $(TARGET_DIR)

all:
	@for (f in $(SOURCE_FILES)); do\
		@$(shell) copy $(f) $(TARGET_DIR)\
	#	vsim -coverage -novopt cortexm3_soc_tb -c -do "coverage save -onexit -directive -cvg -codeall Test_01.ucdb; run -all;exit"
		done
