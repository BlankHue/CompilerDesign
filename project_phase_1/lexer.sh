#!/bin/bash

echo "testing fibonacci.min with lexer---------------------"
cat fibonacci.min | lexer
echo "testing mytest.min with lexer-------------------------"
cat mytest.min | lexer
echo "testing primes.min with lexer--------------------------"
cat primes.min | lexer
