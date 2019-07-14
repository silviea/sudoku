#!/bin/sh
jq -nr 'include "sudoku";cells[][],rows[][],cols[][],sqrs[][]|dimacsify2_clause'
