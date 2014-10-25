#!/bin/bash

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
for VARIABLE1 in {1..1000}
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
for VARIABLE1 in {1..1000}
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
for VARIABLE1 in {1..1000}
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
for VARIABLE1 in {1..1000}
do
   ./tp2 cropflip -i c lena.bmp 64 120 16 15 >> $DIR/$DIR1/cr_C_O3.txt
   ./tp2 mblur -i c lena.bmp 64 120 16 15 >> $DIR/$DIR2/mbl_C_O3.txt
   ./tp2 bandas -i c lena.bmp 64 120 16 15 >> $DIR/$DIR3/ban_C_O3.txt
   ./tp2 sierpinski -i c lena.bmp 64 120 16 15 >> $DIR/$DIR4/sie_C_O3.txt
done

mkdir $DIR/resultados

echo "Procesando resultados..."
#lo que hace esto es ordenarme todos los valores y reunirlos en un unico .txt
#asi solo corriendo un comando genero todo la planilla de calculos
sort $DIR/$DIR1/cr_AMS.txt -o $DIR/$DIR1/cr_AMS.txt
sort $DIR/$DIR1/cr_C_O0.txt -o $DIR/$DIR1/cr_C_O0.txt
sort $DIR/$DIR1/cr_C_O1.txt -o $DIR/$DIR1/cr_C_O1.txt
sort $DIR/$DIR1/cr_C_O2.txt -o $DIR/$DIR1/cr_C_O2.txt
sort $DIR/$DIR1/cr_C_O3.txt -o $DIR/$DIR1/cr_C_O3.txt

sort $DIR/$DIR2/mbl_ASM.txt -o $DIR/$DIR2/mbl_ASM.txt
sort $DIR/$DIR2/mbl_C_O0.txt -o $DIR/$DIR2/mbl_C_O0.txt
sort $DIR/$DIR2/mbl_C_O1.txt -o $DIR/$DIR2/mbl_C_O1.txt
sort $DIR/$DIR2/mbl_C_O2.txt -o $DIR/$DIR2/mbl_C_O2.txt
sort $DIR/$DIR2/mbl_C_O3.txt -o $DIR/$DIR2/mbl_C_O3.txt

sort $DIR/$DIR3/ban_ASM.txt -o $DIR/$DIR3/ban_ASM.txt
sort $DIR/$DIR3/ban_C_O0.txt -o $DIR/$DIR3/ban_C_O0.txt
sort $DIR/$DIR3/ban_C_O1.txt -o $DIR/$DIR3/ban_C_O1.txt
sort $DIR/$DIR3/ban_C_O2.txt -o $DIR/$DIR3/ban_C_O2.txt
sort $DIR/$DIR3/ban_C_O3.txt -o $DIR/$DIR3/ban_C_O3.txt

sort $DIR/$DIR4/sie_ASM.txt -o $DIR/$DIR4/sie_ASM.txt
sort $DIR/$DIR4/sie_C_O0.txt -o $DIR/$DIR4/sie_C_O0.txt
sort $DIR/$DIR4/sie_C_O1.txt -o $DIR/$DIR4/sie_C_O1.txt
sort $DIR/$DIR4/sie_C_O2.txt -o $DIR/$DIR4/sie_C_O2.txt
sort $DIR/$DIR4/sie_C_O3.txt -o $DIR/$DIR4/sie_C_O3.txt

paste $DIR/$DIR1/cr_AMS.txt $DIR/$DIR1/cr_C_O0.txt > $DIR/$DIR1/aux1.txt
paste $DIR/$DIR1/aux1.txt $DIR/$DIR1/cr_C_O1.txt > $DIR/$DIR1/aux2.txt
paste $DIR/$DIR1/aux2.txt $DIR/$DIR1/cr_C_O2.txt > $DIR/$DIR1/aux3.txt
paste $DIR/$DIR1/aux3.txt $DIR/$DIR1/cr_C_O3.txt > $DIR/resultados/cr.txt

paste $DIR/$DIR2/mbl_ASM.txt $DIR/$DIR2/mbl_C_O0.txt > $DIR/$DIR2/aux1.txt
paste $DIR/$DIR2/aux1.txt $DIR/$DIR2/mbl_C_O1.txt > $DIR/$DIR2/aux2.txt
paste $DIR/$DIR2/aux2.txt $DIR/$DIR2/mbl_C_O2.txt > $DIR/$DIR2/aux3.txt
paste $DIR/$DIR2/aux3.txt $DIR/$DIR2/mbl_C_O3.txt > $DIR/resultados/mbl.txt

paste $DIR/$DIR3/ban_ASM.txt $DIR/$DIR3/ban_C_O0.txt > $DIR/$DIR3/aux1.txt
paste $DIR/$DIR3/aux1.txt $DIR/$DIR3/ban_C_O1.txt > $DIR/$DIR3/aux2.txt
paste $DIR/$DIR3/aux2.txt $DIR/$DIR3/ban_C_O2.txt > $DIR/$DIR3/aux3.txt
paste $DIR/$DIR3/aux3.txt $DIR/$DIR3/ban_C_O3.txt > $DIR/resultados/ban.txt

paste $DIR/$DIR4/sie_ASM.txt $DIR/$DIR4/sie_C_O0.txt > $DIR/$DIR4/aux1.txt
paste $DIR/$DIR4/aux1.txt $DIR/$DIR4/sie_C_O1.txt > $DIR/$DIR4/aux2.txt
paste $DIR/$DIR4/aux2.txt $DIR/$DIR4/sie_C_O2.txt > $DIR/$DIR4/aux3.txt
paste $DIR/$DIR4/aux3.txt $DIR/$DIR4/sie_C_O3.txt > $DIR/resultados/sie.txt

echo "Limpiando Binarios"
make clean >> $DIR/logDeCompilacion.txt
echo "Limpiando bmps"
rm lena.bmp.*
echo "Fin!"



