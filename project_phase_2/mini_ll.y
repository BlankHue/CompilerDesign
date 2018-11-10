/* cs152 fall2018 second project*/
%{
 #include <stdio.h>
 #include <stdlib.h>
 void yyerror(const char* msg);
 extern int currLine;
 extern int currPos;
 FILE * yyin;
%}

%union{
  double dval;
  int val;
  char* ident;
}

%start Prog_start
%token FUNCTION BEGIN_PARAMS END_PARAMS BEGIN_LOCALS END_LOCALS ARRAY BEGIN_BODY END_BODY OF IF THEN ENDIF ELSE WHILE BEGINLOOP ENDLOOP DO READ WRITE CONTINUE RETURN INTEGER TRUE FALSE ASSIGN COLON SEMICOLON COMMA  
%token <val> NUMBERS
%token <ident> IDENT
%right ASSIGN
%left OR
%left AND
%right NOT
%left EQ NE LTE GTE LT GT
%left ADD SUB
%left MULT DIV MOD
%nonassoc UMINUS
%left L_SQUARE_BRACKET R_SQUARE_BRACKET
%left L_PAREN R_PAREN

%%

Prog_start:      Functions  {printf("Prog_start -> Functions\n");}
                  ;
                  
Functions:	      /*empty*/ {printf("Function -> epsilon\n");} 
		              | Function Functions {printf("Functions -> Function Functions\n");}
		              ;
                                
Function:	        FUNCTION IDENT SEMICOLON BEGIN_PARAMS Declarations END_PARAMS BEGIN_LOCALS Declarations END_LOCALS BEGIN_BODY Statements END_BODY  {printf("FUNCTION  IDENT %s SEMICOLON BEGIN_PARAMS Declarations END_PARAMS BEGIN_LOCALS Declarations END_LOCALS BEGIN_BODY Statements END_BODY\n", $2);}
		              ; 
                  
Declarations:	    /*empty*/  {printf("Declarations->epsilon\n");}
		              | Declaration SEMICOLON Declarations   {printf("Declarations -> Declaration SEMICOLON Declarations\n");}
		              ; 
                                
Declaration:	    Identifiers COLON ARRAY L_SQUARE_BRACKET NUMBERS R_SQUARE_BRACKET OF  INTEGER  {printf("Declaration -> Identifiers COLON ARRAY L_SQUARE_BRACKET NUMBERS %d R_SQUARE_BRACKET OF INTEGER\n", $5);}
                  | Identifiers COLON INTEGER  {printf("Declaration -> Identifiers COLON INTEGER\n");}
		              ;

                                
Identifiers:		  IDENT  {printf("Identifiers -> IDENT %s\n", $1);}
		              | IDENT COMMA Identifiers    {printf("Identifiers -> IDENT %s COMMA Identifiers\n", $1);}
		              ;
                  
                  
Statements:	      Statement SEMICOLON Statements      {printf("Statements -> Statement SEMICOLON Statements\n");} 
		              | Statement SEMICOLON               {printf("Statements -> Statement SEMICOLON\n");}
		              ;
                  
Statement:	      Sa     {printf("Statement -> Sa\n");}
                  | Sb   {printf("Statement -> Sb\n");}
                  | Sc   {printf("Statement -> Sc\n");}
                  | Sd   {printf("Statement -> Sd\n");}
		              | Se   {printf("Statement -> Se\n");}
		              | Sf   {printf("Statement -> Sf\n");}
		              | Sg   {printf("Statement -> Sg\n");}
		              | Sh   {printf("Statement -> Sh\n");}
		              ;  
                  
Sa:		            Var ASSIGN Expression    {printf("Sa -> Var ASSIGN Expression\n");}
		              ; 
                                                                
Sb:		           IF Bool-Expr THEN Statements ENDIF     {printf("Sb -> IF Bool-Expr THEN Statements ENDIF\n");}
                 | IF Bool-Expr THEN Statements ELSE Statements ENDIF  {printf("Sb -> IF Bool-Expr THEN Statements ELSE Statements ENDIF\n");}
	              	;   
                  
Sc:	            	WHILE Bool-Expr BEGINLOOP Statements ENDLOOP     {printf("Sc  -> WHILE Boolean-Expr BEGINLOOP Statements ENDLOOP\n");}
		              ; 
                                
Sd:		            DO BEGINLOOP Statements ENDLOOP WHILE Bool-Expr     {printf("DO BEGINLOOP Statements ENDLOOP WHILE Bool-expr\n");}
	              	;     
                  
Se:		            READ Vars {printf("Se- > READ Vars\n");}
		              ;    
                  
Sf:		            WRITE Vars {printf("Sf -> WRITE Vars\n");}
		              ; 
                  
Sg:		            CONTINUE {printf("Sg -> CONTINUE\n");}
		              ;                                       
                  
Sh:		            RETURN Expression {printf("Sh -> RETURN Expression\n");}
		              ;   
                                
Vars:             Var         {printf("Vars -> Var\n");}
                  | Var COMMA Vars   {printf("Vars -> Var COMMA Vars\n");}
                  ;
                  
Var:              IDENT       {printf("Var -> IDENT %s\n", $1);}
                  | IDENT L_SQUARE_BRACKET Expression R_SQUARE_BRACKET    {printf("Var -> IDENT %s L_SQUARE_BRACKET Expression R_SQUARE_BRACKET\n", $1);}
                  ;
                  
Bool-Expr:	      Relation-And-Expr   {printf("Bool-Expr -> Relation-And-Expr\n");}
		              | Bool-Expr OR Relation-And-Expr   {printf("Bool-Expr -> Bool-Expr OR Relation-And-Expr\n");}
                  ; 
                  
Relation-And-Expr:	  Relation-Expr    {printf("Relation-And-Expr -> Relation-Expr\n");} 
		              | Relation-Expr AND Relation-And-Expr    {printf("Relation-And-Expr -> Relation-Expr AND Relation-And-Expr\n");}
		              ;     
                  
Relation-Expr:	  Relation-Expr-Copy{printf("Relation-Expr -> Relation-Expr-Copy\n");}
	              	| NOT Relation-Expr-Copy {printf("Relation-Expr -> NOT Relation-Expr-Copy\n");}
		              ;                                                
                      
Relation-Expr-Copy: Expression Comp Expression {printf("Relation-Expr-Copy -> Expression Comp Expression\n");}
		              | TRUE      {printf("Relation-Expr-Copy -> TRUE\n");}
            		  | FALSE     {printf("Relation-Expr-Copy -> FALSE\n");}
		              | L_PAREN Bool-Expr R_PAREN {printf("Relation-Expr-Copy -> L_PAREN Bool-Expr R_PAREN\n");}
		              ;   
                  
Comp:		          EQ     {printf("Comp -> EQ\n");}
		            | NE   {printf("Comp -> NE\n");}
		            | LT     {printf("Comp -> LT\n");}
		            | GT     {printf("Comp -> GT\n");}
		            | LTE    {printf("Comp -> LTE\n");}
		            | GTE    {printf("Comp -> GTE\n");}
          		  ;  
                
Expressions:    /*empty*/  {printf("Expressions -> epsilon\n");}
                | Expression COMMA Expressions    {printf("Expressions -> Expression COMMA Expressions\n");}  
                | Expression      {printf("Expressions -> Expression\n");} 
                ;                                      

Expression:	    Multipicative-Expr Expr-Ex  {printf("Expression -> Multipicative-Expr Expr-Ex\n");} 
                ;
                
Expr-Ex:        /*empty*/  {printf("Expr-Ex -> epsilon\n");}
                | ADD  Multipicative-Expr Expr-Ex {printf("Expr-Ex -> ADD  Multipicative-Expr Expr-Ex\n");}
                | SUB  Multipicative-Expr Expr-Ex  {printf("Expr-Ex -> SUB  Multipicative-Expr Expr-Ex\n");}
		            ;                                                         
                
Multipicative-Expr:	 Term Multipicative-Ex    {printf("Multipicative-Expr -> Term Multipicative-Ex\n");}
                    ;

Multipicative-Ex:   /*empty*/  {printf("Multipicative-Ex -> epsilon\n");} 
                    | MULT Term Multipicative-Ex {printf("Multipicative-Ex -> MULT Term Multipicative-Ex\n");}
                    | DIV Term Multipicative-Ex {printf("Multipicative-Ex -> DIV Term Multipicative-Ex\n");}
                    | MOD Term Multipicative-Ex {printf("Multipicative-Ex -> MOD Term Multipicative-Ex\n");}
                ;
                                      
Term:           Pos-Term  {printf("Term -> Pos-Term\n");}
                | SUB Pos-Term %prec UMINUS {printf("Term -> SUB Pos-Term\n");}
                | IDENT L_PAREN Expressions R_PAREN {printf("Term -> IDENT %s L_PAREN Expressions R_PAREN\n", $1);}
                ;                                      

		                                              
Pos-Term:        Var {printf("Pos-Term -> Var\n");}
                | NUMBERS {printf("Pos-Term -> NUMBERS  %d\n", $1);}
                | L_PAREN Expression R_PAREN {printf("Pos-Term -> L_PAREN Expression R_PAREN\n");}
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

void yyerror(const char *msg) {
   printf("** Line %d, position %d: %s\n", currLine, currPos, msg);
}                              
                                
                                
                                
                                
                                
                                
                                
                                
                                
                                
                                
                                
                                
                                
  

