#!/bin/bash
# declare STRING variable

for VARIABLE1 in {1..10}
do
   ./tp2 cropflip -i c lena.bmp 64 120 16 15 >> testing.txt	
done
