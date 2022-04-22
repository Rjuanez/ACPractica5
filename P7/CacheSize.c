// (c) FIBerHub, https://fiberhub.tk

#include <stdio.h>

#define N 200000
#define tam 16*1024*1024

#define LINE_SIZE 128	//Cambiar por el tamaño de la cache

int i, j, limite;
unsigned char v[tam];

void InitCache(int cod);
void Referencia(unsigned char *dir);
int Referencias();
int Fallos();
 
int refs, misses;

int main() 
{  int i, j;
   

  for (limite=256; limite <= 204800; limite+=5120) {	//Cambiar número máximo y incremento hasta que veamos que llega al máximo de errores

    InitCache(0xf51b74cf);  	//Cambiar por el código de la cache

    i = 0;
    for (j=0; j<N; j++) {
      Referencia((unsigned char *)&v[i]);     // acceso a v[i] 
      i=i+LINE_SIZE;
      if (i >= limite) i=0;
    }

    refs = Referencias();
    misses = Fallos(); 

    printf("CacheSize? limite=%6d ; fallos=%6d ; referencias=%6d\n", limite, misses, refs);

  }

  return 0;
}

