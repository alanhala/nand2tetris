@1
D = A
@ARG
A = M + D
D = M
@SP
M = M + 1
A = M - 1
M = D
@SP
M = M - 1
A = M
D = M
@R4
M = D
@0
D = A
@SP
M = M + 1
A = M - 1
M = D
@SP
M = M - 1
@0
D = A
@THAT
D = M + D
@R13
M = D
@SP
A = M
D = M
@R13
A = M
M = D
@1
D = A
@SP
M = M + 1
A = M - 1
M = D
@SP
M = M - 1
@1
D = A
@THAT
D = M + D
@R13
M = D
@SP
A = M
D = M
@R13
A = M
M = D
@0
D = A
@ARG
A = M + D
D = M
@SP
M = M + 1
A = M - 1
M = D
@2
D = A
@SP
M = M + 1
A = M - 1
M = D
@SP
M = M - 1
A = M
D = M
@SP
M = M - 1
A = M
M = M - D
@SP
M = M + 1
@SP
M = M - 1
@0
D = A
@ARG
D = M + D
@R13
M = D
@SP
A = M
D = M
@R13
A = M
M = D
(FibonacciSeries$MAIN_LOOP_START)
@0
D = A
@ARG
A = M + D
D = M
@SP
M = M + 1
A = M - 1
M = D
@SP
M = M - 1
A = M
D = M
@FibonacciSeries$COMPUTE_ELEMENT
D;JNE
@FibonacciSeries$END_PROGRAM
0;JMP
(FibonacciSeries$COMPUTE_ELEMENT)
@0
D = A
@THAT
A = M + D
D = M
@SP
M = M + 1
A = M - 1
M = D
@1
D = A
@THAT
A = M + D
D = M
@SP
M = M + 1
A = M - 1
M = D
@SP
M = M - 1
A = M
D = M
@SP
M = M - 1
A = M
M = M + D
@SP
M = M + 1
@SP
M = M - 1
@2
D = A
@THAT
D = M + D
@R13
M = D
@SP
A = M
D = M
@R13
A = M
M = D
@R4
D = M
@SP
M = M + 1
A = M - 1
M = D
@1
D = A
@SP
M = M + 1
A = M - 1
M = D
@SP
M = M - 1
A = M
D = M
@SP
M = M - 1
A = M
M = M + D
@SP
M = M + 1
@SP
M = M - 1
A = M
D = M
@R4
M = D
@0
D = A
@ARG
A = M + D
D = M
@SP
M = M + 1
A = M - 1
M = D
@1
D = A
@SP
M = M + 1
A = M - 1
M = D
@SP
M = M - 1
A = M
D = M
@SP
M = M - 1
A = M
M = M - D
@SP
M = M + 1
@SP
M = M - 1
@0
D = A
@ARG
D = M + D
@R13
M = D
@SP
A = M
D = M
@R13
A = M
M = D
@FibonacciSeries$MAIN_LOOP_START
0;JMP
(FibonacciSeries$END_PROGRAM)
