# Makefile

.PHONY:
all:
	sds++ -sds-pf $(FIRST_PLATFORM) helloworld.cpp -c -o helloworld.o
	sds++ -sds-pf $(FIRST_PLATFORM) helloworld.o -o helloworld.elf
	#g++ helloworld.cpp -o helloworld
	/bin/echo "Built platform..."

clean:
	/bin/rm -r _sds sd_card
	/bin/rm *.o *.elf

