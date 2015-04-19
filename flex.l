%{
	#include "string.h"
	#include "stdio.h"
        #include "global.h"
        #include "bison.tab.h"
//[0-9\".a-zA-Z\-\_]+             { strcat(inputBuff, yytext); return STRING;}
%}



%%

"<"                     	{ strcat(inputBuff, "<"); return '<';}
">"          			{ strcat(inputBuff, ">"); return '>';}
"&"          			{ strcat(inputBuff, "&"); return '&';}
[ \t]        			{ strcat(inputBuff, yytext); }
\n          			{ return 0;}
[^ \t\n]+			{ strcat(inputBuff, yytext); return STRING; }

%%

int yywrap()
{
    return 1;
}
