@256
D = A
@SP
M = D
@LCL
MD = -1
@ARG
MD = D - 1
@THIS
MD = D - 1
@THAT
MD = D - 1
@call_return_4901ccfa941747df8d4c1e0c640b0cfd
D = A
@SP
M = M + 1
A = M - 1
M = D
@LCL
D = M
@SP
M = M + 1
A = M - 1
M = D
@ARG
D = M
@SP
M = M + 1
A = M - 1
M = D
@THIS
D = M
@SP
M = M + 1
A = M - 1
M = D
@THAT
D = M
@SP
M = M + 1
A = M - 1
M = D
D = A + 1
@5
D = D - A
@0
D = D - A
@ARG
M = D
@SP
D = M
@LCL
M = D
@Sys.init
0;JMP
(call_return_4901ccfa941747df8d4c1e0c640b0cfd)
(Main.fibonacci)
@0
D = A
@i
M = D
(Main.fibonacci$LOCAL_VARIABLES_INIT_LOOP)
@i
D = M
@Main.fibonacci$END_LOCAL_VARIABLES_INIT_LOOP
D;JEQ
@SP
M = M + 1
A = M - 1
M = 0
@i
M = M - 1
@Main.fibonacci$LOCAL_VARIABLES_INIT_LOOP
0;JMP
(Main.fibonacci$END_LOCAL_VARIABLES_INIT_LOOP)
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
D = M - D
@JLT_13
D;JLT
@SP
M = M + 1
A = M - 1
M = 0
@END_JLT_13
0;JMP
(JLT_13)
@SP
M = M + 1
A = M - 1
M = -1
(END_JLT_13)
@SP
M = M - 1
A = M
D = M
@Main.Main.fibonacci$IF_TRUE
D;JNE
@Main.Main.fibonacci$IF_FALSE
0;JMP
(Main.Main.fibonacci$IF_TRUE)
@0
D = A
@ARG
A = M + D
D = M
@SP
M = M + 1
A = M - 1
M = D
@LCL
D = M
@END_FRAME
M = D
@5
D = D - A
A = D
D = M
@return_address
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
@END_FRAME
M = M - 1
A = M
D = M
@THAT
M = D
@END_FRAME
M = M - 1
A = M
D = M
@THIS
M = D
@END_FRAME
M = M - 1
A = M
D = M
@ARG
M = D
@END_FRAME
M = M - 1
A = M
D = M
@LCL
M = D
@return_address
A = M
0;JMP
(Main.Main.fibonacci$IF_FALSE)
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
@call_return_39675b3da12c41b29381a96b11441fa7
D = A
@SP
M = M + 1
A = M - 1
M = D
@LCL
D = M
@SP
M = M + 1
A = M - 1
M = D
@ARG
D = M
@SP
M = M + 1
A = M - 1
M = D
@THIS
D = M
@SP
M = M + 1
A = M - 1
M = D
@THAT
D = M
@SP
M = M + 1
A = M - 1
M = D
D = A + 1
@5
D = D - A
@1
D = D - A
@ARG
M = D
@SP
D = M
@LCL
M = D
@Main.fibonacci
0;JMP
(call_return_39675b3da12c41b29381a96b11441fa7)
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
@call_return_76f62357c0ae4cbe81a13564458eb071
D = A
@SP
M = M + 1
A = M - 1
M = D
@LCL
D = M
@SP
M = M + 1
A = M - 1
M = D
@ARG
D = M
@SP
M = M + 1
A = M - 1
M = D
@THIS
D = M
@SP
M = M + 1
A = M - 1
M = D
@THAT
D = M
@SP
M = M + 1
A = M - 1
M = D
D = A + 1
@5
D = D - A
@1
D = D - A
@ARG
M = D
@SP
D = M
@LCL
M = D
@Main.fibonacci
0;JMP
(call_return_76f62357c0ae4cbe81a13564458eb071)
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
@LCL
D = M
@END_FRAME
M = D
@5
D = D - A
A = D
D = M
@return_address
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
@END_FRAME
M = M - 1
A = M
D = M
@THAT
M = D
@END_FRAME
M = M - 1
A = M
D = M
@THIS
M = D
@END_FRAME
M = M - 1
A = M
D = M
@ARG
M = D
@END_FRAME
M = M - 1
A = M
D = M
@LCL
M = D
@return_address
A = M
0;JMP
(Sys.init)
@0
D = A
@i
M = D
(Sys.init$LOCAL_VARIABLES_INIT_LOOP)
@i
D = M
@Sys.init$END_LOCAL_VARIABLES_INIT_LOOP
D;JEQ
@SP
M = M + 1
A = M - 1
M = 0
@i
M = M - 1
@Sys.init$LOCAL_VARIABLES_INIT_LOOP
0;JMP
(Sys.init$END_LOCAL_VARIABLES_INIT_LOOP)
@4
D = A
@SP
M = M + 1
A = M - 1
M = D
@call_return_cec95b45bb1045c8803fc3d1ed3b7715
D = A
@SP
M = M + 1
A = M - 1
M = D
@LCL
D = M
@SP
M = M + 1
A = M - 1
M = D
@ARG
D = M
@SP
M = M + 1
A = M - 1
M = D
@THIS
D = M
@SP
M = M + 1
A = M - 1
M = D
@THAT
D = M
@SP
M = M + 1
A = M - 1
M = D
D = A + 1
@5
D = D - A
@1
D = D - A
@ARG
M = D
@SP
D = M
@LCL
M = D
@Main.fibonacci
0;JMP
(call_return_cec95b45bb1045c8803fc3d1ed3b7715)
(Sys.Sys.init$WHILE)
@Sys.Sys.init$WHILE
0;JMP
