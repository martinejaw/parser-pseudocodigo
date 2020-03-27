%{
#include <stdio.h>
#include <conio.h>
#include "sintactico.tab.h"
int errlx=0;
%}

%option noyywrap
%option yylineno
%x COMENTARIOLINEA
%x COMENTARIOMULTILINEA

TKN_ACCION [Aa][Cc][Cc][Ii][Oo][Nn]
TKN_ES [_][Ee][Ss]
TKN_FIN_ACCION [Ff][Ii][Nn][_][Aa][Cc][Cc][Ii][Oo][Nn]
TKN_AMBIENTE [Aa][Mm][Bb][Ii][Ee][Nn][Tt][Ee]
TKN_PROCESO [Pp][Rr][Oo][Cc][Ee][Ss][Oo]

TKN_ASIGNACION (":=")

TKN_SI [Ss][Ii]
TKN_SINO [Ss][Ii][Nn][Oo]
TKN_ENTONCES [Ee][Nn][Tt][Oo][Nn][Cc][Ee][Ss]
TKN_FIN_SI [Ff][Ii][Nn][_][Ss][Ii]

TKN_SEGUN [Ss][Ee][Gg][Uu][Nn]
TKN_FIN_SEGUN [Ff][Ii][Nn][_][Ss][Ee][Gg][Uu][Nn]

TKN_MIENTRAS [Mm][Ii][Ee][Nn][Tt][Rr][Aa][Ss]
TKN_FIN_MIENTRAS [Ff][Ii][Nn][_][Mm][Ii][Ee][Nn][Tt][Rr][Aa][Ss]

TKN_REPETIR [Rr][Ee][Pp][Ee][Tt][Ii][Rr]
TKN_HASTA_QUE [Hh][Aa][Ss][Tt][Aa][_][Qq][Uu][Ee]

TKN_PARA [Pp][Aa][Rr][Aa]
TKN_HASTA [Hh][Aa][Ss][Tt][Aa]
TKN_FIN_PARA [Ff][Ii][Nn][_][Pp][Aa][Rr][Aa]

TKN_HACER [Hh][Aa][Cc][Ee][Rr]

TKN_ESCRIBIR [Ee][Ss][Cc][Rr][Ii][Bb][Ii][Rr]
TKN_LEER [Ll][Ee][Ee][Rr]

TKN_Y [_][Yy]
TKN_O [_][Oo]
TKN_NO [_][Nn][Oo]

TKN_MENORIGUAL ("<=")
TKN_MAYORIGUAL (">=")
TKN_DISTINTO ("<>")
TKN_MAYOR \>
TKN_MENOR \<
TKN_IGUAL \=

TKN_SUMA \+
TKN_RESTA \-
TKN_MULTIPLICACION \*
TKN_COCIENTE \/
TKN_MOD [_][Mm][Oo][Dd]
TKN_DIV [_][Dd][Ii][Vv]
TKN_POTENCIA ("**")
TKN_INCREMENTO  ("++")
TKN_DECREMENTO ("--")

TKN_STRING [Aa][Ll][Ff][Aa][Nn][Uu][Mm][Ee][Rr][Ii][Cc][Oo]
TKN_NUMBER [Nn][Uu][Mm][Ee][Rr][Ii][Cc][Oo]

TKN_APAR \(
TKN_CPAR \)
TKN_PTOCOMA \;
TKN_COMA \,
TKN_PTO \.
TKN_DOSPTO \:
TKN_COMSIM \' 
TKN_COMDOB (\"|\“|\”)
TKN_NUMERAL \#
TKN_ARROBA \@

digito [0-9]
NUMERO -?{digito}+(","{digito}+)?
ID [A-Za-z]{v2}*|[A-Za-z]
v2 _?[A-Za-z0-9]+

CADENA ({TKN_COMDOB}(\\.|[^"\\])*{TKN_COMDOB})

salto (\n|(.)|\t|" ")


ignora (" "|\t|\n)*


%%



{CADENA} {return CADENA;}

{ignora}	{}

{TKN_ACCION}	{return ACCION;}
{TKN_ES}	{return ES;}
{TKN_FIN_ACCION}	{return FIN_ACCION;}
{TKN_AMBIENTE}	{return AMBIENTE;}
{TKN_PROCESO}	{return PROCESO;}

{TKN_ASIGNACION}	{return ASIGNACION;}

{TKN_SI}	{return SI;}
{TKN_SINO}	{return SINO;}
{TKN_ENTONCES}	{return ENTONCES;}
{TKN_FIN_SI}	{return FIN_SI;}

{TKN_MIENTRAS}	{return MIENTRAS;}
{TKN_FIN_MIENTRAS}	{return FIN_MIENTRAS;}

{TKN_REPETIR}	{return REPETIR;}
{TKN_HASTA_QUE}	{return HASTA_QUE;}

{TKN_PARA}	{return PARA;}
{TKN_HASTA}	{return HASTA;}
{TKN_FIN_PARA}	{return FIN_PARA;}

{TKN_HACER}	{return HACER;}

{TKN_LEER}	{return LEER;}
{TKN_ESCRIBIR}	{return ESCRIBIR;}

{TKN_SEGUN}	{return SEGUN;}
{TKN_FIN_SEGUN}	{return FIN_SEGUN;}

{TKN_Y}	{return OP_LOGICO;}
{TKN_O}	{return OP_LOGICO;}
{TKN_NO}	{return NO;}

{TKN_APAR}	{return APAR;}
{TKN_CPAR}	{return CPAR;}
{TKN_PTOCOMA}	{return PTOCOMA;}
{TKN_COMA}	{return COMA;}
{TKN_PTO}	{}
{TKN_DOSPTO}	{return DOSPTO;}
{TKN_COMSIM}		{}
{TKN_COMDOB}		{}

{TKN_MAYORIGUAL}	{return OP_RELACIONAL;}
{TKN_MENORIGUAL}	{return OP_RELACIONAL;}
{TKN_DISTINTO}	{return OP_RELACIONAL;}
{TKN_MENOR}	{return OP_RELACIONAL;}
{TKN_MAYOR}	{return OP_RELACIONAL;}
{TKN_IGUAL}	{return OP_RELACIONAL;}

{TKN_SUMA}	{return OP_ARITMETICO;}
{TKN_RESTA}	{return OP_ARITMETICO;}
{TKN_MULTIPLICACION}	{return OP_ARITMETICO;}
{TKN_COCIENTE}	{return OP_ARITMETICO;}
{TKN_DIV}	{return OP_ARITMETICO;}
{TKN_MOD}	{return OP_ARITMETICO;}
{TKN_POTENCIA}	{return OP_ARITMETICO;}

{TKN_INCREMENTO}	{return INCREMENTO;}
{TKN_DECREMENTO}	{return DECREMENTO;}

{TKN_NUMBER}		{return TIPO;}
{TKN_STRING}		{return TIPO;}

{ID}		{return ID;}
{NUMERO}	{return NUMERO;}

"#"            			{ BEGIN(COMENTARIOMULTILINEA);}
<COMENTARIOMULTILINEA>#  { BEGIN(INITIAL);}

"@"            { BEGIN(COMENTARIOLINEA);}
<COMENTARIOLINEA>\n  { BEGIN(INITIAL);}

<COMENTARIOLINEA>.  {}
<COMENTARIOMULTILINEA>.  {}


.			{printf("Caracter no reconocido: %s\n", yytext); ++errlx; return ERROR;}
