# Makefile

Q ?= @

APP=helloworld

.PHONY:
all:
	/bin/echo "*** Creating (prebuilt) platform... ***"
	$(Q) sds++ -sds-pf $(FIRST_PLATFORM) $(APP).cpp -c -o $(APP).o
	$(Q) sds++ -sds-pf $(FIRST_PLATFORM) $(APP).o -o $(APP).elf
	#g++ helloworld.cpp -o helloworld

clean:
	$(Q) -rm -r _sds sd_card
	$(Q) -rm *.o *.elf *.bit