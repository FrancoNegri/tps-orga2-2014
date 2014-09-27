#!/bin/bash
# declare STRING variable

DIR="testing"
DIR1="crop"
DIR2="mbl"
DIR3="ban"
DIR4="sie"

echo "Borrando carpeta "$DIR

rm -r $DIR
mkdir $DIR
mkdir $DIR/$DIR1
mkdir $DIR/$DIR2
mkdir $DIR/$DIR3
mkdir $DIR/$DIR4


echo "Compilando Codigo con -O0"
make clean >> $DIR/logDeCompilacion.txt
make OPTLVL=-O0 >> $DIR/logDeCompilacion.txt
echo "Corriendo los tests "
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


echo "Compilando Codigo con -O1"
make clean >> $DIR/logDeCompilacion.txt
make OPTLVL=-O1 >> $DIR/logDeCompilacion.txt
echo "Corriendo los tests"
for VARIABLE1 in {1..10}
do
   ./tp2 cropflip -i c lena.bmp 64 120 16 15 >> $DIR/$DIR1/cr_C_O1.txt
   ./tp2 mblur -i c lena.bmp 64 120 16 15 >> $DIR/$DIR2/mbl_C_O1.txt
   ./tp2 bandas -i c lena.bmp 64 120 16 15 >> $DIR/$DIR3/ban_C_O1.txt
   ./tp2 sierpinski -i c lena.bmp 64 120 16 15 >> $DIR/$DIR4/sie_C_O1.txt
done

echo "Compilando con -O2"
make clean >> $DIR/logDeCompilacion.txt
make OPTLVL=-O2 >> $DIR/logDeCompilacion.txt
echo "Corriendo los tests"
for VARIABLE1 in {1..10}
do
   ./tp2 cropflip -i c lena.bmp 64 120 16 15 >> $DIR/$DIR1/cr_C_O2.txt
   ./tp2 mblur -i c lena.bmp 64 120 16 15 >> $DIR/$DIR2/mbl_C_O2.txt
   ./tp2 bandas -i c lena.bmp 64 120 16 15 >> $DIR/$DIR3/ban_C_O2.txt
   ./tp2 sierpinski -i c lena.bmp 64 120 16 15 >> $DIR/$DIR4/sie_C_O2.txt
done

echo "Compilando con -O3"
make clean >> $DIR/logDeCompilacion.txt
make OPTLVL=-O3 >> $DIR/logDeCompilacion.txt
echo "Corriendo los tests"
for VARIABLE1 in {1..10}
do
   ./tp2 cropflip -i c lena.bmp 64 120 16 15 >> $DIR/$DIR1/cr_C_O3.txt
   ./tp2 mblur -i c lena.bmp 64 120 16 15 >> $DIR/$DIR2/mbl_C_O3.txt
   ./tp2 bandas -i c lena.bmp 64 120 16 15 >> $DIR/$DIR3/ban_C_O3.txt
   ./tp2 sierpinski -i c lena.bmp 64 120 16 15 >> $DIR/$DIR4/sie_C_O3.txt
done
echo "Limpiando Binarios"
make clean >> $DIR/logDeCompilacion.txt
echo "Limpiando bmps"
rm lena.bmp.*
echo "Fin!"



