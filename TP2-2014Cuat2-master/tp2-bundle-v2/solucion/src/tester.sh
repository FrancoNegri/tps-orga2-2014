#!/bin/bash
# declare STRING variable

ASM = nasm
DBG = gdb
CFLAGS64 = -ggdb -Wall -std=c99 -pedantic -m64
ASMFLAGS64 = -felf64 -g -F dwarf
CFLAGS   = $(CFLAGS64)
ASMFLAGS = $(ASMFLAGS64)


UBUNTU = $(shell lsb_release -sd)

OPENCV_LIB = `pkg-config --cflags --libs opencv`

BIN = tp2
BIN_DIR = ../bin



COBJS = tp2.o cli.o utils.o opencv_wrapper.o \
	cropflip_c.o cropflip.o \
	sierpinski_c.o sierpinski.o \
	mblur_c.o mblur.o \
	bandas_c.o bandas.o

ASMOBJS = cropflip_asm.o \
	sierpinski_asm.o \
	mblur_asm.o \
	bandas_asm.o

OBJS = $(COBJS) $(ASMOBJS)
# OBJS = $(COBJS) tmp.o


echo "Corriendo los tests con -O0"

$(OBJS)
$(CC) $(CFLAGS) -O0 $(OBJS) -o $@ $(OPENCV_LIB) -lm
cp $(BIN) $(BIN_DIR)/$(BIN)
for VARIABLE1 in {1..10}
do
   ./tp2 cropflip -i c lena.bmp 64 120 16 15 >> cr_C_O0.txt
   ./tp2 mblur -i c lena.bmp 64 120 16 15 >> mbl_C_O0.txt
   ./tp2 bandas -i c lena.bmp 64 120 16 15 >> ban_C_O0.txt
   ./tp2 sierpinski -i c lena.bmp 64 120 16 15 >> sie_C_O0.txt
   
   ./tp2 cropflip -i asm lena.bmp 64 120 16 15 >> cr_AMS.txt
   ./tp2 mblur -i asm lena.bmp 64 120 16 15 >> mbl_ASM.txt
   ./tp2 bandas -i asm lena.bmp 64 120 16 15 >> ban_ASM.txt
   ./tp2 sierpinski -i asm lena.bmp 64 120 16 15 >> sie_ASM.txt
done

echo "Corriendo los tests con -O1"

$(OBJS)
$(CC) $(CFLAGS) -O1 $(OBJS) -o $@ $(OPENCV_LIB) -lm
cp $(BIN) $(BIN_DIR)/$(BIN)
for VARIABLE1 in {1..10}
do
   ./tp2 cropflip -i c lena.bmp 64 120 16 15 >> cr_C_O1.txt
   ./tp2 mblur -i c lena.bmp 64 120 16 15 >> mbl_C_O1.txt
   ./tp2 bandas -i c lena.bmp 64 120 16 15 >> ban_C_O1.txt
   ./tp2 sierpinski -i c lena.bmp 64 120 16 15 >> sie_C_O1.txt
done

echo "Corriendo los tests con -O2"

$(OBJS)
$(CC) $(CFLAGS) -O2 $(OBJS) -o $@ $(OPENCV_LIB) -lm
cp $(BIN) $(BIN_DIR)/$(BIN)
for VARIABLE1 in {1..10}
do
   ./tp2 cropflip -i c lena.bmp 64 120 16 15 >> cr_C_O2.txt
   ./tp2 mblur -i c lena.bmp 64 120 16 15 >> mbl_C_O2.txt
   ./tp2 bandas -i c lena.bmp 64 120 16 15 >> ban_C_O2.txt
   ./tp2 sierpinski -i c lena.bmp 64 120 16 15 >> sie_C_O2.txt
done

echo "Corriendo los tests con -O3"

$(OBJS)
$(CC) $(CFLAGS) -O3 $(OBJS) -o $@ $(OPENCV_LIB) -lm
cp $(BIN) $(BIN_DIR)/$(BIN)
for VARIABLE1 in {1..10}
do
   ./tp2 cropflip -i c lena.bmp 64 120 16 15 >> cr_C_O3.txt
   ./tp2 mblur -i c lena.bmp 64 120 16 15 >> mbl_C_O3.txt
   ./tp2 bandas -i c lena.bmp 64 120 16 15 >> ban_C_O3.txt
   ./tp2 sierpinski -i c lena.bmp 64 120 16 15 >> sie_C_O3.txt
done

echo "Fin!"



