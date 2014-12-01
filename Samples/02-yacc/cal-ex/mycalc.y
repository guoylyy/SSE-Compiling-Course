%{
#include <stdio.h>
#include <stdlib.h>
#define YYDEBUG 1  //DEBUG 模式
int yylex();
int yyerror();
%}
%union { //定义非终结符类型
    int          int_value;
    double       double_value;
}
%token <double_value>      DOUBLE_LITERAL
%token ADD SUB MUL DIV LP RP CR 
%type <double_value> expression term primary_expression
%%
line_list //多行规则
    : line //单行
    | line_list line //多行接单行
    ;
line //单行规则
    : expression CR 
    {
        printf(">>%lf\n", $1);
    }
expression //基础表达式规则
    : term
    | expression ADD term
    {
        $$ = $1 + $3;
    }
    | expression SUB term
    {
        $$ = $1 - $3;
    }
    ;
term //高级表达式规则
    : primary_expression
    | term MUL primary_expression 
    {
        $$ = $1 * $3;
    }
    | term DIV primary_expression
    {
        $$ = $1 / $3;
    }
    ;
primary_expression //扩展规则
    : DOUBLE_LITERAL
    | LP expression RP
    {
        $$ = $2;
    }
    | SUB primary_expression
    {
        $$ = -$2;
    }
    | ADD primary_expression
    {
        $$ = $2;
    }
    ;                 
%%
int
yyerror(char const *str)
{
    extern char *yytext;
    fprintf(stderr, "parser error near %s\n", yytext);
    return 0;
}

int main(void)
{
    extern int yyparse(void);
    extern FILE *yyin;

    yyin = stdin;
    if (yyparse()) {
        fprintf(stderr, "Error ! Error ! Error !\n");
        exit(1);
    }
}
