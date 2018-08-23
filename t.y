
%{
#include <stdio.h>
#include <stdlib.h>
#include "lex.yy.h"

#define YYSTYPE char*

#define YP(type, text) printf("YACC[%s]: %s\n", type, text)

extern FILE *fp;

int yyerror(char *s);

%}

%token IF
%token ELSE ELSEIF CMP CMDS OPS
%start Prog

%nonassoc LOWER_THAN_ELSE
%nonassoc ELSE
%%

Prog: Stmt
	;

Stmt: 	
	  CmdStmt	{printf("YACC[stmt.cmd]: %s\n", yytext);}
  |  IfStmt	{printf("YACC[stmt.if]: %s\n", yytext);}
	|
  ;

CmdStmt:
		OPS	{printf("YACC[cmd.ops]: %s\n", yytext);}	
  | CmdStmt OPS 	{printf("YACC[cmd.iter]: %s\n", yytext);}
	;


IfStmt: 
    IF '{' BoolCond '}' '{' Stmt '}' {YP("IF", yytext);}
	;

	/* %prec LOWER_THAN_ELSE
	| IF '{' BoolCond '}' ELSEIF '{' BoolCond '}'  ELSE '{' Stmt '}'
	| IF '{' BoolCond '}' ELSE '{' Stmt '}'
	;
*/

/*
IfStmt : 
		IfBranch
	| ElseifBranch
	| ElseBranch
	;

IfBranch:
	IF '{' BoolCond '}' %prec LOWER_THAN_ELSE '{' Stmt '}'
	;

ElseifBranch:
  ELSEIF '{' BoolCond '}' '{' Stmt '}'
	;

ElseBranch:
  ELSE '{' Stmt '}'
	;
*/

BoolCond: '(' BoolCond ')'
	| Bool3
	| Bool1
	;

Bool1:
	CMP CMDS
	;

Bool3:
	OPS CMP OPS
	;

%%

extern int yylex (void);

int main(int argc, char *argv[])
{
	yylineno = 1;
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
	fprintf( stderr, "Unmatched token: %s\n", yytext );
	exit(-1);
}
