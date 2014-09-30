#!/bin/bash
# declare STRING variable

DIR="test3.1"

echo "Compilando Codigo con -O1"
make clean >> $DIR/logDeCompilacion.txt
make OPTLVL=-O1 >> $DIR/logDeCompilacion.txt
echo "Corriendo los tests"
for VARIABLE1 in {1..10}
do
   ./tp2 bandas -i c lena.bmp >> $DIR/bandas.txt
done

echo "Limpiando Binarios"
make clean >> $DIR/logDeCompilacion.txt
echo "Limpiando bmps"
rm lena.bmp.*
echo "Fin!"



