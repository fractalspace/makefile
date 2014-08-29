########################################################################
#
# Throw this makefile in a direcotry containing one or more .cpp or c
# files.
# Adjust path CPPFLAGS.
# It will pick up all .cpp files and creat an executable with the name
# matching the .cpp filename which has 'main'.
#
########################################################################

#----------------------------------------------------------------------
# Modify below
#----------------------------------------------------------------------
LIST_INC:= 
LIST_LIBPATH:=
LIST_LIB:=z dl rt resolv pthread m ssl
LIST_D:=UNICODE MYSPECIAL_DEFINE
#-- DO NOT modify below -----------------------------------------------

SRC:=$(wildcard *.cpp *.c)
MAIN:=$(shell grep -l '\smain' $(SRC))
PRJ:=$(firstword $(MAIN:.cpp=))

INC:=$(foreach inc, $(LIST_INC),-I $(inc))
INCLIBS:=$(foreach libinc, $(LIST_LIBPATH),-L $(libinc))
LIBS:=$(foreach lib,$(LIST_LIB),-l $(lib))
DEFS:=$(foreach def,$(LIST_D),-D$(def))

CPPFLAGS+=$(CFLAGS) -g $(DEFS)
CPPFLAGS+=$(INC)
CINC_LIB:=$(INCLIBS) $(LIBS)

all:$(PRJ)

$(PRJ):$(PRJ).o 
	$(CXX) $(SRC) $(CPPFLAGS) $(CINC_LIB) -o $@
clean:
	rm -f *.o $(PRJ)

test:
	@echo PRJ=$(PRJ)
	@echo SRC=$(SRC)
	@echo CFLAGS=$(CFLAGS)
	@echo CPPFLAGS=$(CPPFLAGS)
	@echo CINC_LIBS=$(CINC_LIBS)

	@echo --------------------
	@echo $(INC) $(INCLIBS) $(LIBS) $(DEFS) 

