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
        ;
functions: {printf("functions->epsilon\n");}
          | function functions {printf("functions->function functions\n");}
          ;
function:   FUNCTION IDENT SEMICOLON BEGINPARAMS declare ENDPARAMS BEGINLOCALS declare ENDLOCALS BEGINBODY statements ENDBODY {printf("function->FUNCTION IDENT SEMICOLON BEGINPARAMS declare ENDPARAMS BEGINLOCALS declare ENDLOCALS BEGINBODY statements ENDBODY\n");}
          ;
declare: {printf("declare->epsilon\n");}
        | declaration SEMICOLON declare {printf("declare->declaration SEMICOLON declare\n");}
        ;
declaration: id COLON setval {printf("id COLON setval\n");}
        ;
id: IDENT {printf("id->IDENT\n");}
        | IDENT COMMA id {printf("id->IDENT COMMA id\n");}
        ;
setval: INTEGER {printf("setval->INTEGER\n");}
        | ARRAY L_SQUARE_BRACKET NUMBER R_SQUARE_BRACKET OF INTEGER {printf("setval->ARRAY L_SQUARE_BRACKET NUMBER R_SQUARE_BRACKET OF INTEGER\n");}
        ;
statements: statement SEMICOLON statements {printf("statements->statement SEMICOLON statements\n");}
        | statement SEMICOLON {printf("statements->statement SEMICOLON\n");}
        ;
statement: A {printf("statement->A\n");}
        | B {printf("statment->B\n");}
        | C {printf("statment->C\n");}
        | D {printf("statment->D\n");}
        | E {printf("statment->E\n");}
        | F {printf("statment->F\n");}
        | G {printf("statment->G\n");}
        | H {printf("statment->H\n");}
        ;
A: var ASSIGN expression {printf("A->var ASSIGN expression\n");}
        ;
B: IF boolean_expr THEN statements ENDIF {printf("B->IF boolean_expr THEN statements ENDIF\n");}
        | IF boolean_expr THEN statements ELSE statements ENDIF {printf("B->IF boolean_expr THEN statements ELSE statements ENDIF\n");}
        ;
C: WHILE boolean_expr BEGINLOOP statements ENDLOOP {printf("C->WHILE boolean_expr BEGINLOOP statements ENDLOOP\n");}
        ;
D: DO BEGINLOOP statements ENDLOOP WHILE boolean_expr {printf("D->DO BEGINLOOP statements ENDLOOP WHILE boolean_expr\n");}
        ;
E: READ var I {printf("E->READ var I\n");}
        ;
I: {printf("I->epsilon\n");}
        | COMMA var I {printf("I->COMMA var I\n");}
        ;
F: WRITE var I {printf("F->WRITE var I\n");}
        ;
G: CONTINUE {printf("G->CONTINUE\n");}
        ;
H: RETURN expression {printf("H->RETURN expression\n");}
        ;
boolean_expr: 
        
%%

void yyerror(const char* s)
{
  extern char* yytext;
  printf("Error: %s at symbol \"%s\ \n", s, yytext);
  exit(1);
 }
