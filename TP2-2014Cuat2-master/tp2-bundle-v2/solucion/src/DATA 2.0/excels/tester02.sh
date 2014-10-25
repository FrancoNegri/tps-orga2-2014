#!/bin/bash

DIR="testing"
DIR1="crop"
DIR2="mbl"
DIR3="ban"
DIR4="sie"

#acá tengo que pasar los anteriores txt a un archivo nuevo

rm $DIR/ban_ASM.txt
rm $DIR/cr_AMS.txt
rm $DIR/sie_ASM.txt

echo "Compilando Codigo con -O0"
make clean >> $DIR/logDeCompilacion.txt
make OPTLVL=-O0 >> $DIR/logDeCompilacion.txt
echo "Corriendo los tests "
for VARIABLE1 in {1..1000}
do 
	./tp2 bandas -i asm lena.bmp 64 120 16 15 >> $DIR/ban_ASM.txt

   ./tp2 cropflip -i asm lena.bmp 64 120 16 15 >> $DIR/cr_AMS.txt
   ./tp2 sierpinski -i asm lena.bmp 64 120 16 15 >>$DIR/sie_ASM.txt
done

#acá los appendeo con copy

echo "Limpiando Binarios"
make clean >> $DIR/logDeCompilacion.txt
echo "Limpiando bmps"
rm lena.bmp.*
echo "Fin!"




