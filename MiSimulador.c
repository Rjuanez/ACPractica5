#include "CacheSim.h"

/* Posa aqui les teves estructures de dades globals
 * per mantenir la informacio necesaria de la cache
 * */

typedef struct {
    int tag;         //tag del bloc que ocupa la linea de memoria
    int valid;
 } linea;

int fallos;
int aciertos;


linea mc[128]; // Creem 128 lineas que son les que tindra la memoria directa ja que



/* La rutina init_cache es cridada pel programa principal per
 * inicialitzar la cache.
 * La cache es inicialitzada al començar cada un dels tests.
 * */
void init_cache ()
{
    totaltime=0.0;
	/* Escriu aqui el teu codi */
    int i;
    for (i = 0; i < 128; i++) mc[i].valid = 0; //inicialitzem totes les lineas de la mc com a vuides posant a 0 tots els bits de validaci—
    fallos = 0;
    aciertos = 0;


}

/* La rutina reference es cridada per cada referencia a simular */ 
void reference (unsigned int address)
{
	unsigned int byte;
	unsigned int bloque_m; 
	unsigned int linea_mc;
	unsigned int tag;
	unsigned int miss;	   // boolea que ens indica si es miss
	unsigned int replacement;  // boolea que indica si es reemplaça una linia valida
	unsigned int tag_out;	   // TAG de la linia reemplaçada,
	float t1,t2;		// Variables per mesurar el temps (NO modificar)
	
	t1=GetTime();
	/* Escriu aqui el teu codi */


    byte = address & 0x1F; //Obtenim els ultims 5 bits que inidiquen el byte accedit ja que el tamany de linea es 32bytes
    bloque_m = address >> 5; //treiem els 5 œltims bits per tal d'obtenir quin bloc de 32bytes estem accedint
    linea_mc = bloque_m & 0x7F; //ens quedem amb els 7 primers bits de menys pes de la adrea que ens indicaran a quina linea de la memoria va el bloc
    tag = bloque_m >> 7; //teriem els 7 bits de menys pes de
    miss = false;
    replacement = false;
    
    if (mc[linea_mc].valid == 0) { //miss perque esta vuida
        mc[linea_mc].tag = tag;
        mc[linea_mc].valid = 1;
        miss = true;
    }
    else if (mc[linea_mc].tag != tag) { //miss perque ja esta ocupada
        tag_out = mc[linea_mc].tag;
        mc[linea_mc].tag = tag;
        miss = true;
        replacement = true;
        
    }
    if (miss) ++fallos;
    else ++aciertos;
    
	/* La funcio test_and_print escriu el resultat de la teva simulacio
	 * per pantalla (si s'escau) i comproba si hi ha algun error
	 * per la referencia actual. També mesurem el temps d'execució
	 * */
	t2=GetTime();
	totaltime+=t2-t1;
	test_and_print (address, byte, bloque_m, linea_mc, tag,
			miss, replacement, tag_out);
}

/* La rutina final es cridada al final de la simulacio */ 
void final ()
{
    Printf("Aciertos: %d Fallos: %d \n", aciertos, fallos);
  
  
}
