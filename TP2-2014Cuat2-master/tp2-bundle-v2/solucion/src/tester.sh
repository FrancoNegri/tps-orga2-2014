#!/bin/bash
# declare STRING variable

DIR="testing"
DIR1="crop"
DIR2="mbl"
DIR3="ban"
DIR4="sie"

rm -r $DIR
mkdir $DIR
mkdir $DIR/$DIR1
mkdir $DIR/$DIR2
mkdir $DIR/$DIR3
mkdir $DIR/$DIR4


echo "Corriendo los tests con -O0"
make clean
make OPTLVL=-O0
for VARIABLE1 in {1..10}
do
   ./tp2 cropflip -i c lena.bmp 64 120 16 15 >> $DIR/$DIR1/cr_C_O0.txt
   ./tp2 mblur -i c lena.bmp 64 120 16 15 >> $DIR/$DIR2/mbl_C_O0.txt
   ./tp2 bandas -i c lena.bmp 64 120 16 15 >> $DIR/$DIR3/ban_C_O0.txt
   ./tp2 sierpinski -i c lena.bmp 64 120 16 15 >> $DIR/$DIR4/sie_C_O0.txt
   
   ./tp2 cropflip -i asm lena.bmp 64 120 16 15 >> $DIR/$DIR1/cr_AMS.txt
   ./tp2 mblur -i asm lena.bmp 64 120 16 15 >> $DIR/$DIR2/mbl_ASM.txt
   ./tp2 bandas -i asm lena.bmp 64 120 16 15 >> $DIR/$DIR3/ban_ASM.txt
   ./tp2 sierpinski -i asm lena.bmp 64 120 16 15 >>$DIR/$DIR4/sie_ASM.txt
done

echo "Corriendo los tests con -O1"

make clean
make OPTLVL=-O1
for VARIABLE1 in {1..10}
do
   ./tp2 cropflip -i c lena.bmp 64 120 16 15 >> $DIR/$DIR1/cr_C_O1.txt
   ./tp2 mblur -i c lena.bmp 64 120 16 15 >> $DIR/$DIR2/mbl_C_O1.txt
   ./tp2 bandas -i c lena.bmp 64 120 16 15 >> $DIR/$DIR3/ban_C_O1.txt
   ./tp2 sierpinski -i c lena.bmp 64 120 16 15 >> $DIR/$DIR4/sie_C_O1.txt
done

echo "Corriendo los tests con -O2"

make clean
make OPTLVL=-O2
for VARIABLE1 in {1..10}
do
   ./tp2 cropflip -i c lena.bmp 64 120 16 15 >> $DIR/$DIR1/cr_C_O2.txt
   ./tp2 mblur -i c lena.bmp 64 120 16 15 >> $DIR/$DIR2/mbl_C_O2.txt
   ./tp2 bandas -i c lena.bmp 64 120 16 15 >> $DIR/$DIR3/ban_C_O2.txt
   ./tp2 sierpinski -i c lena.bmp 64 120 16 15 >> $DIR/$DIR4/sie_C_O2.txt
done

echo "Corriendo los tests con -O3"

make clean
make OPTLVL=-O3
for VARIABLE1 in {1..10}
do
   ./tp2 cropflip -i c lena.bmp 64 120 16 15 >> $DIR/$DIR1/cr_C_O3.txt
   ./tp2 mblur -i c lena.bmp 64 120 16 15 >> $DIR/$DIR2/mbl_C_O3.txt
   ./tp2 bandas -i c lena.bmp 64 120 16 15 >> $DIR/$DIR3/ban_C_O3.txt
   ./tp2 sierpinski -i c lena.bmp 64 120 16 15 >> $DIR/$DIR4/sie_C_O3.txt
done

echo "Fin!"



