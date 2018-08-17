
%{
#include <stdio.h>
#include <stdlib.h>
#include "lex.yy.h"

#define YYSTYPE char*

extern FILE *fp;

int yyerror(char *s);

%}

%token INT FLOAT ID OPS STRING CMDS
%token FOR WHILE
%token IF ELSE ELSEIF COMPARES
%start Prog

%%

Prog : Stmt
	;

Stmt :
  IfStmt
	| ID Params
  ;

Params :
  Params OPS
  | OPS
	;

IfStmt : BoolCond;
/*
IfStmt : IF '{' BoolCond '}' '{' Stmt '}'
  | ELSEIF '{' BoolCond '}' '{' Stmt '}'
  | ELSE '{' Stmt '}'
	;
*/
BoolCond : '(' BoolCond ')'
	| BoolCond COMPARES BoolCond
	| CMDS
	| COMPARES CMDS
	|
	;



%%

extern int yylex (void);

int main(int argc, char *argv[])
{
	yyin = fopen(argv[1], "r");
	
   if(!yyparse())
		printf("\nParsing complete\n");
	else
		printf("\nParsing failed\n");
	
	fclose(yyin);
    return 0;
}

int yyerror( char *msg ) {
	fprintf( stderr, "*** Error at line %d\n", yylineno);
	fprintf( stderr, "\n" );
	fprintf( stderr, "Unmatched token: %s\n", yytext );
	fprintf( stderr, "*** syntax error\n");
	exit(-1);
}
