#lex.yy.c文件分析

##lex源文件结构
====
lex源文件主要分为三个部分：

* Definition
* Rules
* C Code

```

/*** Definition section ***/
 
%{
/* C code to be copied verbatim */
#include <stdio.h>
%}
 
/* This tells flex to read only one input file */
%option noyywrap
 
%%
    /*** Rules section ***/
 
    /* [0-9]+ matches a string of one or more digits */
[0-9]+  {
            /* yytext is a string containing the matched text. */
            printf("Saw an integer: %s\n", yytext);
        }
 
.|\n    {   /* Ignore all other characters. */   }
 
%%
/*** C Code section ***/
 
int main(void)
{
    /* Call the lexer, then quit. */
    yylex();
    return 0;
}

```

##目标文件结构

======

文件主要分为以下几个部分：

* 定义
* 自动机状态转移
* 将字符读入缓冲区（待续）
* 用户定义代码区（待续）


##定义
=====


以simple-test.l生成的lex.yy.c为例，第375行开始定义了几个数组，用于表示DFA的状态转移函数

```
static yyconst flex_int16_t yy_accept[17];
static yyconst flex_int32_t yy_ec[256];
static yyconst flex_int32_t yy_meta[10];
static yyconst flex_int16_t yy_base[18];
static yyconst flex_int16_t yy_def[18];
static yyconst flex_int16_t yy_nxt[30];
static yyconst flex_int16_t yy_chk[30];

```
表示DFA的状态转移函数最简单的方法是用二维数组，给出状态和下一个输入的字符，就可以通过数组访问下一个状态或动作，例如，返回token。由于常见的词法分析器会有几百种状态，在一些小型设备中空间不够，因此可以对状态表进行压缩。

yy_base:base数组是用来决定状态s条目位于next和check数组的位置。

yy_default:当check数组判断base[s]的是无效的时候，default会给出另一个base位置。

yy_nxt:自动机的下一个状态。

yy_chk:检查状态位置是否有效。

yy_accept:被自动机接受的状态所对应的动作，动作在lex源文件中的Rules中定义。

yy_ec:存储0到127的数字，在检查状态有效性时使用。

yy_meta:待研究

##自动机状态转移
=====
要计算状态s输入a的转移函数nextState(s,a),我们会查看next和check数组第l＝base[s]+a项，其中a是0到127的数字。如果check[l]＝s则是有效的，并且下一个状态就是next[l]。如果check[s]≠s，我们可以使用t=default[s]作为当前状态，并重复上述步骤。
规范的代码表示如下所示（对应示例代码中的1042行）：


```
int nextState(s,a){
	if(check[base[s]+a] == s) return next[base[s]+a];
	else return nextState(default[s],a);
}

```

未完待续O_o o_O

