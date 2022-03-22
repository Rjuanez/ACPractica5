#include "CacheSim.h"

/* Posa aqui les teves estructures de dades globals
 * per mantenir la informacio necesaria de la cache
 * */

typedef struct {
    char valid;
    int tag0;
    int tag1;
    int LRU; //least recently used, ultima via que hem fet servir
} linea_associativa;

linea_associativa mc[64]; // Creem 64 lineas que son les que tindra la memoria directa ja que es asociatia de dues vies


/* La rutina init_cache es cridada pel programa principal per
 * inicialitzar la cache.
 * La cache es inicialitzada al començar cada un dels tests.
 * */
void init_cache ()
{
    totaltime=0.0;
	/* Escriu aqui el teu codi */
    for (int i = 0; i < 64; ++i) {
        mc[i].valid= 0;
        mc[i].LRU = 0;
    }



}

/* La rutina reference es cridada per cada referencia a simular */ 
void reference (unsigned int address)
{
	unsigned int byte;
	unsigned int bloque_m; 
	unsigned int conj_mc;
	unsigned int via_mc;
	unsigned int tag;
	unsigned int miss;	   // boolea que ens indica si es miss
	unsigned int replacement;  // boolea que indica si es reemplaça una linia valida
	unsigned int tag_out;	   // TAG de la linia reemplaçada
	float t1,t2;		// Variables per mesurar el temps (NO modificar)
	
	t1=GetTime();
	/* Escriu aqui el teu codi */

    byte = address & 0x1F; //Obtenim els ultims 5 bits que inidiquen el byte accedit ja que el tamany de linea es 32bytes
    bloque_m = address >> 5; //treiem els 5 œltims bits per tal d'obtenir quin bloc de 32bytes estem accedint
    conj_mc = bloque_m & 0b111111; //ens quedem amb els 6 primers bits de menys pes de la adrea que ens indicaran a quina linea de la memoria va el bloc
    tag = bloque_m >> 6; //teriem els 6 bits de menys pes de
    miss = false;
    replacement = false;
    
    

    if (mc[conj_mc].valid == 0) { //miss no hi ha res
        mc[conj_mc].tag0 = tag;
        mc[conj_mc].valid = 1;
        mc[conj_mc].LRU = 0;
        via_mc = 0;
        miss = true;
    } else if (mc[conj_mc].valid == 1) { //hi ha una lliure, pero una ocupada
        if (mc[conj_mc].tag0 != tag) {  //si la que esta ocupada no es la que busquem omplim l'altre
            mc[conj_mc].tag1 = tag;
            mc[conj_mc].valid = 2;
            mc[conj_mc].LRU = 1;
            via_mc = 1;
            miss = true;
        } else {
            via_mc = 0;
        }
        
    } else {    //estan totes plenes
        unsigned char via0_hit = mc[conj_mc].tag0 == tag;
        unsigned char via1_hit;
        if (via0_hit == 0) via1_hit = mc[conj_mc].tag1 == tag;
        if (via0_hit || via1_hit) { //acert en alguna de les vies
            if (via0_hit) {
                via_mc = 0;
                mc[conj_mc].LRU = 0;
            } else {
                via_mc = 1;
                mc[conj_mc].LRU = 1;
            }
            
        } else { //no esta en la mc
            replacement = true;
            miss = true;
            if (mc[conj_mc].LRU == 0) { //cambiem via1
                tag_out =mc[conj_mc].tag1;
                mc[conj_mc].LRU = 1;
                mc[conj_mc].tag1 = tag;
            } else { //LRU = 1 cambiem via0
                tag_out =mc[conj_mc].tag0;
                mc[conj_mc].LRU = 0;
                mc[conj_mc].tag0 = tag;
            }
        }
    }

	/* La funcio test_and_print escriu el resultat de la teva simulacio
	 * per pantalla (si s'escau) i comproba si hi ha algun error
	 * per la referencia actual. També mesurem el temps d'execució
	 * */
	t2=GetTime();
	totaltime+=t2-t1;
	test_and_print2 (address, byte, bloque_m, conj_mc, via_mc, tag,
			miss, replacement, tag_out);
}

/* La rutina final es cridada al final de la simulacio */ 
void final ()
{
 	/* Escriu aqui el teu codi */ 
  
  
}
