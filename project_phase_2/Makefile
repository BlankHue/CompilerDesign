lex: mini_ll.y mini_l.lex
	bison -v -d --file-prefix=y mini_ll.y
	flex mini_l.lex
	g++ -o parser y.tab.c lex.yy.c -lfl
