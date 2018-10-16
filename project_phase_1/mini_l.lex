/* Written by Nikhil Gowda */
/* A flex scanner specification for a MINI-L Language */


/*DECLARATIONS*/
%{
int currLine = 1, currPos = 1;
%}
/*END_DECLARATIONS*/



/*DEFINITIONS*/

/*END_DEFINITIONS*/

%%
/*RULES*/
"function"          {printf("FUNCTION\n"); currPos += yyleng;}
"beginparams"       {printf("BEGIN_PARAMS\n"); currPos += yyleng;}
"endparams"         {printf("END_PARAMS\n"); currPos += yyleng;}

/*END_RULES*/
%%

/*USER_SUBROUTINES*/

/*END_USER_SUBROUTINES*/
