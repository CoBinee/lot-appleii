#! make -f
#
# makefile - start
#


# directory
#

# source file directory
SRCDIR			=	sources

# include file directory
INCDIR			=	sources

# object file directory
OBJDIR			=	objects

# config file directory
CFGDIR			=	.

# binary file directory
BINDIR			=	bin

# output file directory
OUTDIR			=	disk

# vpath search directories
VPATH			=	$(SRCDIR):$(INCDIR):$(OBJDIR):$(BINDIR)

# assembler
#

# assembler command
AS				=	ca65

# assembler flags
ASFLAGS			=	-t none -I $(SRCDIR) -I $(INCDIR) -I .

# c compiler
#

# c compiler command
CC				=	cc65

# c compiler flags
CFLAGS			=	-t none -I $(SRCDIR) -I $(INCDIR) -I .

# linker
#

# linker command
LD				=	ld65

# linker flags
LDFLAGS			=	

# apple commander
#

# apple commander
AC				=	tools/AppleCommander-ac-1.9.0.jar

# suffix rules
#
.SUFFIXES:			.s .c .o

# assembler source suffix
.s.o:
	$(AS) $(ASFLAGS) -o $(OBJDIR)/$@ $<

# c source suffix
.c.o:
	$(CC) $(CFLAGS) -o $(OBJDIR)/$@ -c $<

# project files
#

# target name
TARGET			=	lot

# hello name
HELLO			=	hello

# config name
CONFIG			=	apple2

# assembler source files
ASSRCS			=	crt0.s iocs.s app.s game.s lot.s

# c source files
CSRCS			=	

# object files
OBJS			=	$(ASSRCS:.s=.o) $(CSRCS:.c=.o)

# build project disk
#
$(TARGET).dsk:		$(HELLO) $(OBJS)
	$(LD) $(LDFLAGS) -o $(BINDIR)/$(TARGET) -m $(BINDIR)/$(TARGET).map --config $(CFGDIR)/$(CONFIG).cfg --obj $(foreach file,$(OBJS),$(OBJDIR)/$(file))
	@rm -f $(OUTDIR)/$(TARGET).dsk
	@cp $(OUTDIR)/origin/init.dsk $(OUTDIR)/$(TARGET).dsk
	@java -jar $(AC) -bas $(OUTDIR)/$(TARGET).dsk $(HELLO) < $(SRCDIR)/$(HELLO)
	@java -jar $(AC) -as $(OUTDIR)/$(TARGET).dsk boot < $(BINDIR)/boot
	@java -jar $(AC) -p $(OUTDIR)/$(TARGET).dsk app B 0x4000 < $(BINDIR)/app

##  $(LD) $(LDFLAGS) -o $(BINDIR)/$(TARGET) -m $(BINDIR)/$(TARGET).map --config $(CFGDIR)/$(CONFIG).cfg --obj $(foreach file,$(OBJS),$(OBJDIR)/$(file))

# clean project
#
clean:
	@rm -f $(OBJDIR)/*
	@rm -f $(BINDIR)/*
##	@rm -f makefile.depend

# build depend file
#
##	depend:
##	ifneq ($(strip $(CSRCS)),)
##		$(CC) $(CFLAGS) -MM $(foreach file,$(CSRCS),$(SRCDIR)/$(file)) > makefile.depend
##	endif

# phony targets
#
##	.PHONY:				clean depend
.PHONY:				clean

# include depend file
#
-include makefile.depend


# makefile - end
