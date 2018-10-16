/*  cs 152 fall2018 the first project */
%{
#include<stdio.h>
int yyerror(char* s);
int currLine = 1, currPos = 1;
extern int yylineno;
int numIntegers = 0;
int numOperators = 0;
int numParens = 0;
int numEquals = 0;
%}

LETTER  [a-zA-Z]
DIGIT   [0-9]
NUMBER  {DIGIT}+
IDENTIFIER  {LETTER}({LETTER}|{DIGIT}|([_]({LETTER}|{DIGIT})))*

%%

function    {printf("FUNCTION\n");currPos += yyleng;}
beginparams {printf("BEGINPARAM\n");currPos += yyleng;}
endparams   {printf("ENDPARAM\n");currPos += yyleng;}
beginlocals {printf("BEGINLOCALS\n");currPos += yyleng;}
endlocals   {printf("ENDLOCALS\n");currPos += yyleng;}
array       {printf("ARRAY\n");currPos += yyleng;}
of          {printf("OF\n");currPos += yyleng;}
:=          {printf("ASSIGN\n");currPos += yyleng;}
if          {printf("IF\n");currPos += yyleng;}
then        {printf("THEN\n");currPos += yyleng;}
endif       {printf("ENDIF\n");currPos += yyleng;}
else        {printf("ELSE\n");currPos += yyleng;}
while       {printf("WHILE\n");currPos += yyleng;}
beginloop   {printf("BEGINLOOP\n");currPos += yyleng;}
endloop     {printf("ENDLOOP\n");currPos += yyleng;}
do          {printf("DO\n");currPos += yyleng;}
read        {printf("READ\n");currPos += yyleng;}
write       {printf("WRITE\n");currPos += yyleng;}
continue    {printf("CONTINUE\n");currPos += yyleng;}
return      {printf("RETURN\n");currPos += yyleng;}
integer     {printf("INTEGER\n");currPos += yyleng;}
or          {printf("OR\n");currPos += yyleng;}
and         {printf("AND\n");currPos += yyleng;}
not         {printf("NOT\n");currPos += yyleng;}
true        {printf("TRUE\n");currPos += yyleng;}
false       {printf("FALSE\n");currPos += yyleng;}
"=="         {printf("EQ\n");currPos += yyleng;}
"<>"          {printf("NE\n");currPos += yyleng;}
"<="          {printf("LE\n");currPos += yyleng;}
">="          {printf("GE\n");currPos += yyleng;}
"<"          {printf("LESS\n");currPos += yyleng;}
">"          {printf("GREAT\n");currPos += yyleng;}
"+"          {printf("PLUS\n");currPos += yyleng;}
"-"          {printf("MINUS\n");currPos += yyleng;}
"*"          {printf("MULT\n");currPos += yyleng;}
"/"          {printf("DIV\n");currPos += yyleng;}
"%"          {printf("PERCENT\n");currPos += yyleng;}
":"          {printf("COLON\n");currPos += yyleng;}
";"          {printf("SEMICOLON\n");currPos += yyleng;}
"("            {printf("L_PAREN\n"); currPos += yyleng;currPos += yyleng;}
")"            {printf("R_PAREN\n"); currPos += yyleng;currPos += yyleng;}


(\.{DIGIT}+)|({DIGIT}+(\.{DIGIT}*)?([eE][+-]?{DIGIT}+)?)       {printf("NUMBER %s\n", yytext); currPos += yyleng; }

{IDENTIFIER} {printf("ID %s\n", yytext);currPos += yyleng;}

[ \t]+         {/* ignore spaces */ currPos += yyleng;}

"\n"           {currLine++; currPos = 1;}

.         {printf(" Error at line %d, column %d: unrecognized symbol \"%s\"\n", currLine, currPos, yytext);}



%%

int main(int argc, char ** argv)
{
   if(argc >= 2)
   {
      yyin = fopen(argv[1], "r");
      if(yyin == NULL)
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