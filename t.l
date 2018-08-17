%{
#include "t.tab.h"

%}

%%

^.*\n {REJECT; yylineno++;}

"if"																										{return IF;}
"else"																										{return ELSE;}
"elseif"																										{return ELSEIF;}
"for"																										{return FOR;}
"while"																										{return WHILE;}
"||"|"&&"|"=="|"!="|"<="|">="|"!"		{return COMPARES;}

";"|"="|","|"{"|"}"|"("|")"|"*"|"+"|"-"|"/"		{return yytext[0];}

"[".*"]"	{return CMDS;}
[0-9]+																									{return INT;}
[0-9]+"."[0-9]+																						{return FLOAT;}	
[a-zA-z_][a-zA-z_0-9]*			 																			{return ID;}
[$a-zA-z_][$./a-zA-z_0-9]*			 																			{return OPS;}
\"(\\.|[^\"])*\"																							{return STRING;}
[ \t\n]																							;

%%


int yywrap(void) {
  return 1;
}
