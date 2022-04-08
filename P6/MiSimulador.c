#include "CacheSim.h"
#include <stdio.h>

/* Posa aqui les teves estructures de dades globals
 * per mantenir la informacio necesaria de la cache
 * */

typedef struct {
    int tag;         //tag del bloc que ocupa la linea de memoria
    int valid;
 } linea;


linea mc[128]; // Creem 128 lineas que son les que tindra la memoria directa ja que

int hit_count;            
int miss_count;
int write_count;


/* La rutina init_cache es cridada pel programa principal per
 * inicialitzar la cache.
 * La cache es inicialitzada al comen�ar cada un dels tests.
 * */
void init_cache ()
{
    /* Escriu aqui el teu codi */
    int i;
    for (i = 0; i < 128; i++) mc[i].valid = 0; //inicialitzem totes les lineas de la mc com a vuides posant a 0 tots els bits de validaci�
    
    hit_count = miss_count = write_count  = 0;

}

/* La rutina reference es cridada per cada referencia a simular */ 
void reference (unsigned int address, unsigned int LE)
{
	unsigned int byte;
	unsigned int bloque_m; 
	unsigned int linea_mc;
	unsigned int tag;
	unsigned int miss;
	unsigned int lec_mp;
	unsigned int mida_lec_mp;
	unsigned int esc_mp;
	unsigned int mida_esc_mp;
	unsigned int replacement;
	unsigned int tag_out;

	/* Escriu aqui el teu codi */

    
    byte = address & 0x1F; //Obtenim els ultims 5 bits que inidiquen el byte accedit ja que el tamany de linea es 32bytes
    bloque_m = address >> 5; //treiem els 5 �ltims bits per tal d'obtenir quin bloc de 32bytes estem accedint
    linea_mc = bloque_m & 0x7F; //ens quedem amb els 7 primers bits de menys pes de la adre�a que ens indicaran a quina linea de la memoria va el bloc
    tag = bloque_m >> 7; //teriem els 7 bits de menys pes de
    lec_mp = 0;
    esc_mp = 0;
    mida_lec_mp = 0;
    mida_esc_mp = 0;
    replacement = 0;
    miss = 0;

    
    if (mc[linea_mc].valid == false) { //miss perque esta vuida
        miss = true;
        ++miss_count;
        
        if (LE == false) { // Lectura
            lec_mp = true;
            mida_lec_mp = 32;
            mc[linea_mc].tag = tag;
            mc[linea_mc].valid = true;
        }
        else { // Escriptura
            esc_mp = true;
            mida_esc_mp = true;
            ++write_count;
        }
        
        
        
    }
    else if (mc[linea_mc].tag != tag) { //miss perque ja esta ocupada
        
        miss = true;
        ++miss_count;
        if (LE == false) { // Lectura
            replacement = true;
            lec_mp = true;
            mida_lec_mp = 32;
            tag_out = mc[linea_mc].tag;
            mc[linea_mc].tag = tag;
        }
        else { // Escriptura
            esc_mp = 1;
            mida_esc_mp = 1;
            ++write_count;
        }
        
    } else if (mc[linea_mc].tag == tag) { //hit
        miss = false;
        ++hit_count;
        if (LE == true) { // Escriptura
            esc_mp = false;
            mida_esc_mp = true;
            ++write_count;
        }
    }





	/* La funcio test_and_print escriu el resultat de la teva simulacio
	 * per pantalla (si s'escau) i comproba si hi ha algun error
	 * per la referencia actual
	 * */
	test_and_print (address, LE, byte, bloque_m, linea_mc, tag,
			miss, lec_mp, mida_lec_mp, esc_mp, mida_esc_mp,
			replacement, tag_out);
}

/* La rutina final es cridada al final de la simulacio */ 
void final ()
{
 	/* Escriu aqui el teu codi */
    printf("Hits: %d    Misses: %d  Escriptures: %d\n", hit_count, miss_count, write_count);
  
  
}