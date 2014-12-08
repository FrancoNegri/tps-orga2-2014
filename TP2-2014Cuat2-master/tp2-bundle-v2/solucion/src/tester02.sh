#!/bin/bash
# declare STRING variable
# sudo nano /sys/devices/system/cpu/cpu3/cpufreq/scaling_governor
DIR="DATA"

echo "Compilando Codigo asm"
make clean >> $DIR/logDeCompilacion.txt
make OPTLVL=-O1 >> $DIR/logDeCompilacion.txt
echo "Corriendo los tests"
for VARIABLE1 in {1..1000}
do
   ./tp2 bandas -i c lena.bmp 512 512 0 0 >> $DIR/Sier16Memo.txt
done

echo "Limpiando Binarios"
make clean >> $DIR/logDeCompilacion.txt
echo "Limpiando bmps"
rm lena.bmp.*
echo "Fin!"



