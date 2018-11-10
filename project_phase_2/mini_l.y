%{
#include <stdio.h>
#include <stdlib.h>
void yyerror(const char* s);
extern int currLine;
extern int currPos;
FILE * yyin;
%}

%union
{
  char* ident;
  int val;
}

%error-verbose
%start begin

%token <ident> IDENT
%token <val> NUMBER

%token FUNCTION
%token BEGINPARAMS
%token ENDPARAMS
%token BEGINLOCALS
%token ENDLOCALS
%token BEGINBODY
%token ENDBODY
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
%left PLUS
%left MULT
%left DIV
%left MOD
%left EQ
%left NE
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
boolean_expr: relation_exprr {printf("boolean_expr->relational_exprr\n");}
        | boolean_expr OR relation_exprr {printf("boolean_expr->boolean_expr OR relation_exprr\n");}
        ;
relation_exprr: relation_expr {printf("relation_exprr->relation_expr\n");}
        | relation_exprr AND relation_expr {printf("relation_exprr->relation_exprr AND relation_expr\n");}
        ;
relation_expr: rexpr {printf("relation_expr->rexpr\n");}
	| NOT rexpr {printf("relation_expr->NOT rexpr\n");}
	;
	
rexpr:		expression comp expression {printf("rexpr -> expression comp expression\n");}
		| TRUE {printf("rexpr -> TRUE\n");}
		| FALSE {printf("rexpr -> FALSE\n");}
		| L_PAREN boolean_expr R_PAREN {printf("rexpr -> L_PAREN boolean_expr R_PAREN\n");}
		;

comp:		EQ {printf("comp -> EQ\n");}
		| NEQ {printf("comp -> NEQ\n");}
		| LT {printf("comp -> LT\n");}
		| GT {printf("comp -> GT\n");}
		| LTE {printf("comp -> LTE\n");}
		| GTE {printf("comp -> GTE\n");}
		;

expression:	mul_expr expradd {printf("expression -> mult-expr expradd\n");}
		;

expradd:	{printf("expradd -> epsilon\n");}
		| PLUS mul_expr expradd {printf("expradd -> PLUS mul_expr expradd\n");}
		| SUB mul_expr expradd {printf("expradd -> SUB mul_expr expradd\n");}
		;

mul_expr:	term multi_term {printf("mul_expr -> term multi_term\n");}
		;

multi_term:	{printf("multi_term -> epsilon\n");}
		| MULT term multi_term {printf("multi_term -> MULT term multi_term\n");} 
		| DIV term multi_term {printf("multi_term -> DIV term multi_term\n");}
		| MOD term multi_term {printf("multi_term -> MOD term multi_term\n");}
		;



term:           posterm {printf("term -> posterm\n");}
                | SUB posterm {printf("term -> SUB posterm\n");}
                | IDENT term_iden {printf("term -> IDENT term_iden\n");}
                ;



posterm:        var {printf("posterm -> var\n");}
                | NUMBER {printf("posterm -> NUMBER\n");}
                | L_PAREN expression R_PAREN {printf("posterm -> L_PAREN expression R_PAREN\n");}
                ;



term_iden:      L_PAREN term_ex R_PAREN {printf("term_iden -> L_PAREN term_ex R_PAREN\n");}
                | L_PAREN R_PAREN {printf("term_iden -> L_PAREN R_PAREN\n");}
                ;
term_ex:        expression {printf("term_ex -> expression\n");}
                | expression COMMA term_ex {printf("term_ex -> expression COMMA term_ex\n");}
                ;

var:            IDENT {printf("var -> IDENT \n");}
                | IDENT L_SQUARE_BRACKET expression R_SQUARE_BRACKET {printf("var -> IDENT L_SQUARE_BRACKET expression R_SQUARE_BRACKET\n");} 
                ;
%%

int main(int argc, char **argv) {
   if (argc > 1) {
      yyin = fopen(argv[1], "r");
      if (yyin == NULL){
         printf("syntax: %s filename\n", argv[0]);
      }//end if
   }//end if
   yyparse(); // Calls yylex() for tokens.
   return 0;
}

void yyerror(const char* s)
{
  extern char* yytext;
  extern int currLine;
  printf("Error LINE %d: %s\n", currLine, s);
  exit(0);
 }
