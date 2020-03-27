/*
  cls
  flex lexico.l
  bison -d sintactico.y
  gcc -o PARSER lex.yy.c sintactico.tab.c  -lm
*/

%{
#include <math.h>
#include <stdio.h>
#include <conio.h>
#include <stdlib.h>
#include <ctype.h>
int yylex();
int yyerror();
extern FILE *yyin;
extern FILE *yylineno;
extern FILE *errlx;
%}

%locations


%token

ACCION
ES
FIN_ACCION

AMBIENTE
PROCESO

ASIGNACION

ID
NUMERO
CADENA

ESCRIBIR
LEER

SI
ENTONCES
FIN_SI
SINO

SEGUN
FIN_SEGUN

REPETIR
HASTA_QUE

MIENTRAS
HACER
FIN_MIENTRAS

PARA
HASTA
FIN_PARA

OP_LOGICO
NO

OP_RELACIONAL
OP_ARITMETICO

INCREMENTO
DECREMENTO

TIPO

APAR
CPAR
PTOCOMA
DOSPTO
COMA

ERROR

%start sigma

%%

sigma				:  	ACCION ID ES cuerpoalgoritmo FIN_ACCION;
cuerpoalgoritmo		:  	AMBIENTE cuerpoambiente PROCESO sentencia 
						| PROCESO sentencia;

cuerpoambiente		:	definicionDatos | /*vacio*/ ;
definicionDatos		: 	datosIguales DOSPTO TIPO PTOCOMA | datosIguales DOSPTO TIPO PTOCOMA definicionDatos;
datosIguales		:	ID | ID COMA datosIguales;

sentencia			:   senEscribir PTOCOMA | senEscribir PTOCOMA sentencia
						| senLeer PTOCOMA | senLeer PTOCOMA sentencia
						| senSi | senSi sentencia
						| senMientras | senMientras sentencia
						| senPara | senPara sentencia
						| senRepetir | senRepetir sentencia
						| senAsignacion PTOCOMA | senAsignacion PTOCOMA sentencia;

senAsignacion		:	ID ASIGNACION asignable
						|ID INCREMENTO
						|ID DECREMENTO;
asignable			:	expresionAritmetica | CADENA;

senEscribir			:	ESCRIBIR APAR cosasEscribibles CPAR
						| ESCRIBIR APAR cosasEscribibles masCosasEscribibles CPAR;
cosasEscribibles 	: 	ID | CADENA;
masCosasEscribibles	:	COMA cosasEscribibles | COMA cosasEscribibles masCosasEscribibles;

senLeer				:	LEER APAR ID CPAR;

senSi 				:	SI APAR condicion CPAR ENTONCES sentencia FIN_SI
						| SI APAR condicion CPAR ENTONCES sentencia SINO sentencia FIN_SI;

senMientras			:	MIENTRAS APAR condicion CPAR HACER sentencia FIN_MIENTRAS;

senPara				:	PARA APAR ID ASIGNACION NUMERO CPAR HASTA expresionAritmetica COMA NUMERO HACER sentencia FIN_PARA
						| PARA APAR ID ASIGNACION NUMERO CPAR HASTA expresionAritmetica HACER sentencia FIN_PARA;

senRepetir			:	REPETIR sentencia HASTA_QUE APAR condicion CPAR;


condicion			: 	terminoCondicion OP_RELACIONAL terminoCondicion
						|terminoCondicion OP_RELACIONAL terminoCondicion OP_LOGICO condicion
						| condicionEntrePar;
condicionEntrePar	:	APAR terminoCondicion OP_RELACIONAL terminoCondicion CPAR
						| APAR terminoCondicion OP_RELACIONAL terminoCondicion CPAR OP_LOGICO condicion
						| NO APAR terminoCondicion OP_RELACIONAL terminoCondicion CPAR
						| NO APAR terminoCondicion OP_RELACIONAL terminoCondicion CPAR OP_LOGICO condicion;
terminoCondicion	:	expresionAritmetica | CADENA;


expresionAritmetica :	termino  opcExp	
						| APAR termino opcExp CPAR opcExp;
termino 			:	ID | NUMERO;
opcExp 				:	/*vacio*/ | OP_ARITMETICO expresionAritmetica;







%%

int yyerror(const char *str)
{
	if (errlx) {
	  fprintf(stderr,"Error lexico | Linea: %d\n%s\n",yylineno,str);
	}
	else {
	  fprintf(stderr,"Error sintactico | Linea: %d\n%s\n",yylineno,str);
	}
	 getch(); return(0);
}

int main (int argc, char *argv[])
{
  printf("Parser\n");
  if (argc == 2)
  {
	yyin = fopen (argv[1], "rt");
	if (yyin == NULL)
	{
	  printf ("El archivo %s no se puede abrir\n", argv[1]);
	  exit (-1);
	}
  }
  else yyin = stdin;

  if (!(yyparse()))
  	  {
	  fprintf(stderr, "\nSintacticamente correcto.\n");
	  getch();
	  }

  return 0;
}; 