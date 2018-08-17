
t: t.l t.y
	bison -r all -d t.y
	flex --header-file=lex.yy.h t.l
	gcc -c lex.yy.c -o lex.yy.o
	gcc -c t.tab.c -o t.tab.o
	gcc lex.yy.o t.tab.o -o t
	./t test.tcl


clean:
	rm -f lex.yy.c  lex.yy.h  lex.yy.o  t  t.tab.c  t.tab.h  t.tab.o

