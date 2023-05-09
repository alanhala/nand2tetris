(SimpleFunction.test)
@2
D = A
@i
M = D
(SimpleFunction.test$LOCAL_VARIABLES_INIT_LOOP)
@i
D = M
@SimpleFunction.test$END_LOCAL_VARIABLES_INIT_LOOP
D;JEQ
@SP
M = M + 1
A = M - 1
M = 0
@i
M = M - 1
@SimpleFunction.test$LOCAL_VARIABLES_INIT_LOOP
0;JMP
(SimpleFunction.test$END_LOCAL_VARIABLES_INIT_LOOP)
@0
D = A
@LCL
A = M + D
D = M
@SP
M = M + 1
A = M - 1
M = D
@1
D = A
@LCL
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
A = M - 1
M = !M
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
@SP
M = M - 1
A = M
M = M + D
@SP
M = M + 1
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
@SP
M = M - 1
A = M
M = M - D
@SP
M = M + 1
@LCL
D = M
@SimpleFunction.test$END_FRAME
M = D
@SP
M = M - 1
A = M
D = M
@ARG
A = M
M = D
@ARG
D = M
@SP
M = D + 1
@SimpleFunction.test$END_FRAME
M = M - 1
A = M
D = M
@THAT
M = D
@SimpleFunction.test$END_FRAME
M = M - 1
A = M
D = M
@THIS
M = D
@SimpleFunction.test$END_FRAME
M = M - 1
A = M
D = M
@ARG
M = D
@SimpleFunction.test$END_FRAME
M = M - 1
A = M
D = M
@LCL
M = D
@SimpleFunction.test$END_FRAME
M = M - 1
A = M
A = M
0;JMP
