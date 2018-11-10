lex: mini_ll.y mini_ll.lex
	bison -v -d --file-prefix=y mini_ll.y
	flex mini_ll.lex
	gcc -o parser y.tab.c lex.yy.c -lfl
