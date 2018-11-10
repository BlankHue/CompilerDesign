/*  cs 152 fall2018 the second project */

%{
#include<stdio.h>
#include<string.h>
#include "y.tab.h"
int currLine = 1, currPos = 1;
%}

LETTER  [a-zA-Z]
DIGIT   [0-9]
NUMBER  {DIGIT}+
IDENTIFIER  {LETTER}({LETTER}|{DIGIT}|([_]({LETTER}|{DIGIT})))*
UNIDENTIFIER11 {NUMBER}({LETTER}|{DIGIT}|([_]({LETTER}|{DIGIT})))*{LETTER}+({LETTER}|{DIGIT}|([_]({LETTER}|{DIGIT})))*
UNIDENTIFIER22 [_]({LETTER}|{DIGIT}|([_]({LETTER}|{DIGIT})))+
UNIDENTIFIER1 {UNIDENTIFIER11}|{UNIDENTIFIER22}
UNIDENTIFIER2 {LETTER}({LETTER}|{DIGIT}|([_]({LETTER}|{DIGIT})))*([_][_])({LETTER}|{DIGIT}|([_]({LETTER}|{DIGIT})))+
UNIDENTIFIER3 {LETTER}({LETTER}|{DIGIT}|([_]({LETTER}|{DIGIT})))*[_]

%%

function    {currPos += yyleng; return FUNCTION;}
beginparams {currPos += yyleng; return BEGIN_PARAMS;}
endparams   {currPos += yyleng; return END_PARAMS;}
beginlocals {currPos += yyleng; return BEGIN_LOCALS;}
endlocals   {currPos += yyleng; return END_LOCALS;}
array       {currPos += yyleng; return ARRAY;}
beginbody    {currPos += yyleng; return BEGIN_BODY;}
endbody     { currPos += yyleng; return END_BODY;}
of          {currPos += yyleng; return OF;}
if          {currPos += yyleng; return IF;}
then        {currPos += yyleng; return THEN;}
endif       {currPos += yyleng; return ENDIF;}
else        {currPos += yyleng; return ELSE;}
while       {currPos += yyleng; return WHILE;}
beginloop   {currPos += yyleng; return BEGINLOOP;}
endloop     {currPos += yyleng; return ENDLOOP;}
do          {currPos += yyleng; return DO;}
read        {currPos += yyleng; return READ;}
write       {currPos += yyleng; return WRITE;}
continue    {currPos += yyleng; return CONTINUE;}
return      {currPos += yyleng; return RETURN;}
integer     {currPos += yyleng; return INTEGER;}
or          {currPos += yyleng; return OR;}
and         {currPos += yyleng; return AND;}
not         {currPos += yyleng; return NOT;}
true        {currPos += yyleng; return TRUE;}
false       {currPos += yyleng;return FALSE;}

"=="         {currPos += yyleng; return EQ;}
"<>"          {currPos += yyleng; return NE;}
"<="          {currPos += yyleng; return LTE;}
">="          {currPos += yyleng; return GTE;}
"<"          {currPos += yyleng; return LT;}
">"          {currPos += yyleng; return GT;}

"+"          {currPos += yyleng; return ADD;}
"-"          {currPos += yyleng; return SUB;}
"*"          {currPos += yyleng; return MULT;}
"/"          {currPos += yyleng; return DIV;}
"%"          {currPos += yyleng; return MOD;}

:=          {currPos += yyleng; return ASSIGN;}
":"          {currPos += yyleng; return COLON;}
";"          {currPos += yyleng; return SEMICOLON;}
","          {currPos += yyleng; return COMMA;}
"("            { currPos += yyleng; return L_PAREN;}
")"            { currPos += yyleng; return R_PAREN;}
"["           { currPos += yyleng; return L_SQUARE_BRACKET;}
"]"           { currPos += yyleng; return R_SQUARE_BRACKET;}
"##"[^\n]*    {/* comments */ currPos += yyleng;}


(\.{DIGIT}+)|({DIGIT}+(\.{DIGIT}*)?([eE][+-]?{DIGIT}+)?)       {currPos += yyleng; yylval.val = atof(yytext); return NUMBERS;}

{IDENTIFIER} {currPos += yyleng; yylval.ident = strdup(yytext); return IDENT;}

{UNIDENTIFIER1} {printf(" Error at line %d, column %d: identifier %s must begin with a letter\n", currLine, currPos, yytext);currPos += yyleng; }

{UNIDENTIFIER2} {printf(" Error at line %d, column %d: identifier %s can not have two adjoint underscore\n", currLine, currPos, yytext);currPos += yyleng; }

{UNIDENTIFIER3} {printf(" Error at line %d, column %d: identifier %s can not end with an underscore\n", currLine, currPos, yytext);currPos += yyleng;}
[ \t]+         {/* ignore spaces */ currPos += yyleng;}

"\n"           {currLine++; currPos = 1;}

"="       {printf(" Syntax error at line %d: \":=\" expected\n", currLine); exit(0);}      

[a][ ]"integer"  {printf(" Syntax error at line %d: invalid declaration\n", currLine); exit(0);} 

.         {printf(" Error at line %d, column %d: unrecognized symbol \"%s\", then exit\n", currLine, currPos, yytext); exit(0);}


%%

