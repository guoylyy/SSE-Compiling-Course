lex mycalc.l
yacc -dv mycalc.y
gcc y.tab.c lex.yy.c -ly -ll
