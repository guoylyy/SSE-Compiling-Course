%{
#include <stdio.h>
#include <string.h>
#include <stdlib.h>

struct Token
{
   int type;
   char sVal[256];     
};

%}

%option     noyywrap      

digit       [0-9]
number      {digit}+
letter      [_a-zA-Z]
alnum       [_a-zA-Z0-9]
identifier  {letter}{alnum}*
newline     \n
whitespace  [ \t]+
%start      COMMENT

%%
"program"       {return 3;}
"var"           {return 4;}
"procedure"     {return 5;}
"begin"         {return 6;}
"end"           {return 7;}
"if"            {return 8;}
"then"          {return 9;}
"else"          {return 10;}
"while"         {return 11;}
"do"            {return 12;} 
"call"          {return 13;}
"integer"       {return 14;}
"real"          {return 15;}
"+"             {return 16;}
"-"             {return 17;}
"*"             {return 18;}
"/"             {return 19;}
"~"             {return 20;}
":"             {return 21;}
"("             {return 22;}
")"             {return 23;}
"<"             {return 24;}
"<="            {return 25;}
">"             {return 26;}
">="            {return 27;}
":="            {return 28;}
"<>"            {return 29;}
","             {return 30;}
";"             {return 31;}
"."             {return 32;}
"&"             {return 33;}
"|"             {return 34;}
"!"             {return 35;}
"{"             {return 36;}
"}"             {return 37;}
"//"            ;
{identifier}    {return 1;}
{number}        {return 2;}
{newline}       {;} 
{whitespace}    {;}
.               {return 99;}

%%

struct Token getToken()
{ 
  struct Token token;
  token.type = yylex(); //yylex() 是一个识别函数，调用自定义的规则进行匹配
  strcpy(token.sVal,yytext);   // yytext是一个字符串指针,只想识别的字符 
  return token;
}

int main(int argc, char *argv[])
{
    if(argc > 1)
    {
          FILE *file;
          file = fopen(argv[1], "r");
          if(!file)
          {
             fprintf(stderr, "could not open %s\n", argv[1]);
             exit(1);
          }
          yyin = file;
    }

    while(1)
    {
       struct Token t=getToken();
       if(t.type==0) break;
       if(t.type==99){printf("(ERROR:%s)\n", t.sVal);}
       else printf("(%d,%s)\n", t.type,t.sVal);
    }
    return 0;
}
