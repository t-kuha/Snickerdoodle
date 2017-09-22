# Makefile

Q ?= @

APP=helloworld

.PHONY:
all:
	$(Q) /bin/echo "*** Creating (prebuilt) platform... ***"
	$(Q) sds++ -sds-pf $(FIRST_PLATFORM) $(APP).cpp -c -o $(APP).o
	$(Q) sds++ -sds-pf $(FIRST_PLATFORM) $(APP).o -o $(APP).elf
	#g++ helloworld.cpp -o helloworld

clean:
	$(Q) -rm -rf _sds sd_card
	$(Q) -rm -f *.o *.elf *.bit
