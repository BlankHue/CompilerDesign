/* Written by Nikhil Gowda */
/* A flex scanner specification for a MINI-L Language */


/*DECLARATIONS*/
%{
#include<stdio.h>
#include<string.h>
#include "y.tab.h"
int currLine = 1, currPos = 1;
%}


ALPHA  [a-zA-Z]
IDENT  [a-zA-Z](([a-zA-Z]|{NUMBER}|_)*([a-zA-Z]|{NUMBER}))?   
NUMBER [0-9]
COMMENT ##.*
WRONGID1 {IDENT}_+
WRONGID2 {NUMBER}+{IDENT}
WRONGID3 _+{IDENT}



%%
"function"          {currPos += yyleng; return FUNCTION;}
"beginparams"       {currPos += yyleng; return BEGINPARAMS;}
"endparams"         {currPos += yyleng; return ENDPARAMS;}
"beginlocals"		{currPos += yyleng; return BEGINLOCALS;}
"endlocals"			{currPos += yyleng; return ENDLOCALS;}
"beginbody"			{currPos += yyleng; return BEGINBODY;}
"endbody"			{currPos += yyleng; return ENDBODY;}
"integer"			{currPos += yyleng; return INTEGER;}
"array"				{currPos += yyleng; return ARRAY;}
"of"				{currPos += yyleng; return OF;}
"if"				{currPos += yyleng; return IF;}
"then"				{currPos += yyleng; return THEN;}
"endif"				{currPos += yyleng; return ENDIF;}
"else"				{currPos += yyleng; return ELSE;}
"while"				{currPos += yyleng; return WHILE;}
"do"				{currPos += yyleng; return DO;}
"beginloop"			{currPos += yyleng; return BEGINLOOP;}
"endloop"			{currPos += yyleng; return ENDLOOP;}
"continue"			{currPos += yyleng; return CONTINUE;}
"read"				{currPos += yyleng; return READ;}
"write"				{currPos += yyleng; return WRITE;}
"and"				{currPos += yyleng; return AND;}
"or"				{currPos += yyleng; return OR;}
"not"				{currPos += yyleng; return NOT;}
"true"				{currPos += yyleng; return TRUE;}
"false"				{currPos += yyleng; return FALSE;}
"return"			{currPos += yyleng; return RETURN;}
{IDENT}                         {currPos += yyleng; yylval.ident = strdup(yytext); return IDENT;}
{NUMBER}*			{currPos += yyleng; yylval.val = atof(yytext); return NUMBER;}

"-"					{currPos += yyleng; return SUB;}
"+"					{currPos += yyleng; return PLUS;}
"*"					{currPos += yyleng; return MULT;}
"/"					{currPos += yyleng; return DIV;}
"%"					{currPos += yyleng; return MOD;}
"=="				{currPos += yyleng; return EQ;}
"<>"				{currPos += yyleng; return NE;}
"<"					{currPos += yyleng; return LT;}
">"					{currPos += yyleng; return GT;}
"<="				{currPos += yyleng; return LTE;}
">="				{currPos += yyleng; return GTE;}

";"					{currPos += yyleng; return SEMICOLON;}
":"					{currPos += yyleng; return COLON;}
","					{currPos += yyleng; return COMMA;}
"("					{currPos += yyleng; return L_PAREN;}
")"					{currPos += yyleng; return R_PAREN;}
"["					{currPos += yyleng; return L_SQUARE_BRACKET;}
"]"					{currPos += yyleng; return R_SQUARE_BRACKET;}
":="				{currPos += yyleng; return ASSIGN;}



[ \t]+				{currPos += yyleng; }
"\n"				{currLine++; currPos = 1;}
{COMMENT}			{currPos += yyleng;}

{WRONGID2}			{printf("Error at line %d, column %d: identifier starts with number symbol \"%s\"\n", currLine, currPos, yytext); exit(0);}
{WRONGID1}			{printf("Error at line %d, column %d: identifier ends with underscore symbol \"%s\"\n", currLine, currPos, yytext); exit(0);}
{WRONGID3}			{printf("Error at line %d, column %d: identifier begins with underscore symbol \"%s\"\n", currLine, currPos, yytext); exit(0);}
.				{printf("Error at line %d, column %d: unrecognized symbol \"%s\"\n", currLine, currPos, yytext); exit(0);}
%%


int main(int argc, char ** argv)
{
	if (argc >= 2)
	{
		yyin = fopen(argv[1], "r");
		if (yyin == NULL);
		{
			yyin = stdin;
		}
	}
	else
	{
		yyin = stdin;
	}

	yylex();
}

/*END_USER_SUBROUTINES*/
