%{
#include <stdio.h>
void yyerror(const char* s);
%}

%union
{
  char* ident_val;
  int num_val;
}

%error-verbose
%start begin

%token <ident_val> IDENT
%token <num_val> NUMBER



%token FUNCTION
%token BEGIN_PARAMS
%token END_PARAMS
%token BEGIN_LOCALS
%token END_LOCALS
%token BEGIN_BODY
%token END_BODY
%token INTEGER
%token ARRAY
%token OF
%token IF
%token THEN
%token ENDIF
%token ELSE
%token WHILE
%token DO
%token FOREACH
%token IN
%token BEGINLOOP
%token ENDLOOP
%token CONTINUE
%token READ
%token WRITE
%left AND
%left OR
%right NOT
%token TRUE
%token FALSE
%token RETURN


%left SUB
%left ADD
%left MULT
%left DIV
%left MOD
%left EQ
%left NEQ
%left LT
%left GT
%left LTE
%left GTE


%token L_PAREN
%token R_PAREN
%token L_SQUARE_BRACKET
%token R_SQUARE_BRACKET
%token COLON
%token SEMICOLON
%token COMMA
%left ASSIGN

%%

begin: functions  {printf("begin->functions\n");}

%%

void yyerror(const char* s)
{
  extern char* yytext;
  printf("Error: %s at symbol \"%s\ \n", s, yytext);
  exit(1);
 }
