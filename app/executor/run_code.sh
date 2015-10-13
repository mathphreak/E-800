#!/bin/bash
cd /var/code
g++ -std=c++11 -O2 -lm main.cpp -o main
cat main.in | tee -a main.out | ./main >> main.out
