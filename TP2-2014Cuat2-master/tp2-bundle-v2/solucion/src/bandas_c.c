
#include "tp2.h"

void bandas_c (
	unsigned char *src,
	unsigned char *dst,
	int m,
	int n,
	int src_row_size,
	int dst_row_size
) {
	unsigned char (*src_matrix)[src_row_size] = (unsigned char (*)[src_row_size]) src;
	unsigned char (*dst_matrix)[dst_row_size] = (unsigned char (*)[dst_row_size]) dst;

	for(int i = 0; i < n; i++)
	{
		for(int j = 0; j < m*4; j +=4)
		{
			int b = src_matrix[i][j] + src_matrix[i][j+1] + src_matrix[i][j+2];
			unsigned char rgb = 0;			
			// if(b < 96)
			// {
			// 	rgb = 0;
			// }
			if(96 <= b && b < 288)
			{
				rgb = 64;
			}
			// if(288 <= b && b < 480)
			// {
			// 	rgb = 128;
			// }
			// if(480 <= b && b < 672)
			// {
			// 	rgb = 192;
			// }	
			// if(672 <= b && b < 766)
			// {
			// 	rgb = 255;
			// }
			dst_matrix[i][j] = rgb;
			dst_matrix[i][j+1] = rgb;
			dst_matrix[i][j+2] = rgb;
			dst_matrix[i][j+3] = src_matrix[i][j+3]; 
			
		}
	}	

}
