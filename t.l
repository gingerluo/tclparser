%{
#include "t.tab.h"

#define LP(type, text) printf("LEX[%s]: %s\n", type, text)

%}

%%

\n 	{yylineno++;}

^#.*$ ;	// comments

[ \t]							;

"if"										{LP("IF", yytext); return IF;}
else									{return ELSE;}
elseif								{return ELSEIF;}
"||"|"&&"|"=="|"!="|"<="|">="|"!"		{return CMP;}

";"|"="|","|"{"|"}"|"("|")"|"*"|"+"|"-"|"/"		{return yytext[0];}

"[".*"]"	{return CMDS;}
	/*
[0-9]+																	{return INT;}
[0-9]+"."[0-9]+													{return FLOAT;}	
	[a-zA-Z_][a-zA-Z_0-9]*			 					  {printf("id: %s\n", yytext); return ID;}*/	
([\$a-zA-Z_][$./a-zA-Z_0-9]*)|(\"(\\.|[^\"])*\")			 				{LP("OPS", yytext); return OPS;}

%%


int yywrap(void) {
  return 1;
}
