#!/bin/bash
# declare STRING variable

DIR="test3.1"

echo "Borrando carpeta "$DIR

rm -r $DIR
mkdir $DIR

echo "Compilando Codigo con -O1"
make clean >> $DIR/logDeCompilacion.txt
make OPTLVL=-O1 >> $DIR/logDeCompilacion.txt
echo "Corriendo los tests"
for VARIABLE1 in {1..10}
do
   ./tp2 bandas -i c lena.bmp 64 120 16 15 >> $DIR/ban_C_O1.txt
done

echo "Limpiando Binarios"
make clean >> $DIR/logDeCompilacion.txt
echo "Limpiando bmps"
rm lena.bmp.*
echo "Fin!"



