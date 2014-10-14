digit [0-9]
letter [A-Za-z]
whitespace  [ \t]+
%{
int count;
%}
%option noyywrap
%%
"begin" {return 0;}
{letter}* { printf("letter\n"); count++;  return 1;}
{digit}* { printf("num\n"); count++; return 2;}
{whitespace}  {return 3;}
%%

int main(void){
    while(1){
        int token = yylex();
        printf("(%s,%d)\n",yytext,token);
        printf("count:%d\n",count); //打印出全局变量的变化情况
        if (token==3) break;
    }
    return 0;
}
