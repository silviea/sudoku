#!/bin/sh
for i in $(seq 1 100);do 
	printf '' > sudoku_output.dimacs;
	cat sudoku_constraints.dimacs negated_sudokus.dimacs|z3 -dimacs -in|tail -n+2 > sudoku_output.dimacs;
	cat sudoku_output.dimacs|\
	jq -Rr 'split(" ")|map(select(.!="")|tonumber|select(.>0)|.*-1|tostring)|join(" ")+" 0"' >> \
	negated_sudokus.dimacs;
done
