#lex.yy.c文件分析
1252914 邱尚昭
1252997 严炎

##lex源文件结构
====
lex源文件主要分为三个部分：

* Definition 定义目标文件中的宏定义以及一些选项，如noyywrap
* Rules 定义识别的字符串的正则表达式规则
* C Code 用户自定义代码区

```
/*** Definition section ***/
 
%{
/* C code to be copied verbatim */
#include <stdio.h>
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

由lex源文件生成的目标文件主要分为以下几个部分：

* 预定义
* 自动机状态转移
* 核心部分
* 缓冲区
* 用户定义代码区


##预定义
=====
文件的开头是各种宏定义，例如YY_NULL，以及各种数据类型。如下的几个宏定义值得注意：

```
 #define YY_BUF_SIZE 16384 //定义缓冲区大小
 #define YY_STATE_EOF(state) (YY_END_OF_BUFFER + state + 1) //通过初试状态获取EOF的动作编号 
 #define YY_STATE_BUF_SIZE   ((YY_BUF_SIZE + 2) * sizeof(yy_state_type)) //状态缓冲区的大小必须能够存放每个字符对应的状态
 #define yyless(n) \…  //将前n个字符退回到输入流

```



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
表示DFA的状态转移函数最简单的方法是用二维数组，给出状态和下一个输入的字符，就可以通过数组访问下一个状态或动作，例如，返回token。由于常见的词法分析器会有几百种状态，在一些小型设备中空间不够，因此可以对状态表进行压缩，用四个数组代替：

```
yy_base:base数组是用来决定状态s条目位于next和check数组的位置。

yy_default:当check数组判断base[s]的是无效的时候，default会给出另一个base位置。

yy_nxt:自动机的下一个状态。

yy_chk:检查状态位置是否有效。
```

其他几个数组为：

```
yy_accept:被自动机接受的状态所对应的动作，动作在lex源文件中的Rules中定义。

yy_ec:存储0到127的数字，在检查状态有效性时使用。

yy_meta:待研究
```

##自动机状态转移
=====
要计算状态s输入a的转移函数nextState(s,a),首先检查next和check数组第l＝base[s]+a项，其中a是0到127的数字，可以通过yy_ec获取到。如果check[l]==s，则状态是有效的，那么下一个状态就是next[l]。如果check[s]≠s，我们可以使用t=default[s]作为当前状态，并重复上述步骤。
规范的代码表示如下所示（对应示例代码中的1042行）：


```
int nextState(s,a){
	if(check[base[s]+a] == s) return next[base[s]+a];
	else return nextState(default[s],a);
}

```

##核心部分
======
从637行开始的YY_DECL是整个程序的核心部分，YY_DECL的定义是：

	#define YY_DECL int yylex (void)


该函数在用户定义的main函数中被调用：

	int token = yylex();
	
在函数中，首先定义了几个变量：

yy_current_state 用于存储状态机当前的状态

yy_cp 指向当前字符串的指针

yy_bp 指向yy_ch_buf中字符的指针

yy_act 状态机识别读入的字符串后将会进行的动作

之后是对当前状态进行初始化。
第673行开始进入循环，直到读入到文件末尾。在循环中，首先需要对指针变量和自动机状态初始化。

第686行进入yy_match标签，从缓冲区读入字符，每读入一个字符，在yy_ec数组中，通过字符的ASCII码找到该字符，得到偏移量a。按照前文所讲的自动机状态转移规则，如果下一状态可以被自动机接受，则将当前状态转移为下一状态。循环读入字符，直到状态不能被自动机接受。

第706行进入yy_find_action标签，首先通过yy_accept数组，获取当前状态对应的动作编号yy_act，若状态不能被自动机接受，则yy_act==0，此时要回溯到之前的状态，得到能被自动机接受的状态，重新获取状态编号。

第717行进入do_action标签，在这里通过yy_act进入switch语句找到对应的动作，例如在该文件中，如果读入的是单词，则yy_act==2进入相应的case，执行用户定义的行为：

	{ printf("letter\n"); count++;  return 1;}


若进入YY_STATE_EOF(INITIAL)的case，则调用yyterminate()函数返回YY_NULL结束读入。


##缓冲区
====
缓冲区主要涉及以下几个函数：
	
	YY_BUFFER_STATE yy_create_buffer(FILE * file, int size) //分配并初始化一块缓冲区
	void yy_delete_buffer(YY_BUFFER_STATE b) //删除缓冲区
	static void yy_init_buffer(YY_BUFFER_STATE  b, FILE * file) //对缓冲区初始化
	void yy_flush_buffer(YY_BUFFER_STATE  b) //清空缓冲区
	void yypush_buffer_state (YY_BUFFER_STATE new_buffer) //将新的状态压入栈
	void yypop_buffer_state (void) //将栈顶状态出栈
	YY_BUFFER_STATE yy_scan_buffer(char * base, yy_size_t size) //设置输入缓冲区从用户指定的字符缓冲读入
	YY_BUFFER_STATE yy_scan_string (yyconst char * yystr ) //从缓冲区读入字符串
	YY_BUFFER_STATE yy_scan_bytes  (yyconst char * yybytes, yy_size_t  _yybytes_len ) //从缓冲区读入字节
	static int yy_get_next_buffer (void); //尝试读取一块新的缓冲区
	void yyrestart  (FILE * input_file ); //切换到不同的输入流
	void yy_switch_to_buffer(YY_BUFFER_STATE  new_buffer) //切换到不同的缓冲区

由于文件读入与编译原理关系不大，此处不做分析。

## 用户定义代码区
====
lex.yy.c文件从1754行开始，就是用户自定义的代码，也就是simple-test.l文件中第二个%%以后的内容，在这个区域用户可以定义main函数以及其他需要的函数来处理yylex()返回的token。