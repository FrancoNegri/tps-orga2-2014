
#include "tp2.h"

#define MIN(x,y) ( x < y ? x : y )
#define MAX(x,y) ( x > y ? x : y )

#define P 2

void mblur_c    (
    unsigned char *src,
    unsigned char *dst,
    int cols,
    int filas,
    int src_row_size,
    int dst_row_size)
{
    unsigned char (*src_matrix)[src_row_size] = (unsigned char (*)[src_row_size]) src;
    unsigned char (*dst_matrix)[dst_row_size] = (unsigned char (*)[dst_row_size]) dst;
	
	for (int i = 0; i < filas; i++)
    	{
        	for (int j = 0; j < cols; j++)
        	{
	        	bgra_t *p_d = (bgra_t*) &dst_matrix[i][j * 4];

			if(i < 2 || j < 2 || i + 2 >= filas || j + 2 >= cols)
			{
				bgra_t zero = {0, 0, 0, 0};
            			*p_d = zero;
			}
			else
			{
			//dst(i,j) = 0,2 · src(i−2,j−2) + 0,2 · src(i−1,j−1) + 0,2 · src(i,j) + 0,2 · src(i+1,j+1) + 0,2 · src(i+2,j+2)
			bgra_t *diag_mas_2 = (bgra_t*) &src_matrix[i+2][(j+2) * 4];		
			bgra_t *diag_mas_1 = (bgra_t*) &src_matrix[i+1][(j+1) * 4];
			bgra_t *diag_menos_1 = (bgra_t*) &src_matrix[i-1][(j-1) * 4];
			bgra_t *diag_menos_2 = (bgra_t*) &src_matrix[i-2][(j-2) * 4];
			bgra_t *punto_mod = (bgra_t*) &src_matrix[i][j * 4];

			bgra_t nuevo_valor = { 0.2 *(punto_mod->b + diag_mas_2->b + diag_mas_1->b + diag_menos_1->b + diag_menos_2->b), 
					       0.2 *(punto_mod->g + diag_mas_2->g + diag_mas_1->g + diag_menos_1->g + diag_menos_2->g), 
					       0.2 *(punto_mod->r + diag_mas_2->r + diag_mas_1->r + diag_menos_1->r + diag_menos_2->r), 
					       punto_mod->a};
            		*p_d = nuevo_valor;
				
	


			}  	
		}
    	}	
 
}


