lex: mini_l.y mini_l.lex
	bison -v -d --file-prefix=y mini_l.y
	flex mini_l.lex
	g++ -o parser y.tab.c lex.yy.c -lfl
