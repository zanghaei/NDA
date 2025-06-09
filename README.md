# NDA
Pease First use ExampleNDA1.m
This file contains an example.

For Usinig NDA For Your Own Data Please Use one of the dollowing forms:
NDAResult=NDA(X,Y)
or
NDAResult=NDA(X,Y)

Bothe the X and Y MUST be Column vectors.

If you want to measure the dependency of column of Y on Columns of X, Please Use NDAResult=NDA(X,Y)  
If you want to measure the dependency of one column of X to another column of X, Please Use NDAResult=NDA(X)
The NDAResult Matrix is a square matrix. The rows are independent variables and columns are dependent variables.
In other words, if you want to measure the dependency of variable i to variable j use NDAResult(j,i).
Or if you want to measure the effect of variable i on the variable j use NDAResult(j,i).
