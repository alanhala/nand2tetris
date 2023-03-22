@17
D = A
@SP
M = M + 1
A = M - 1
M = D
@17
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
@JEQ_9
D;JEQ
@SP
M = M + 1
A = M - 1
M = 0
@END_JEQ_9
0;JMP
(JEQ_9)
@SP
M = M + 1
A = M - 1
M = -1
(END_JEQ_9)
@17
D = A
@SP
M = M + 1
A = M - 1
M = D
@16
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
@JEQ_12
D;JEQ
@SP
M = M + 1
A = M - 1
M = 0
@END_JEQ_12
0;JMP
(JEQ_12)
@SP
M = M + 1
A = M - 1
M = -1
(END_JEQ_12)
@16
D = A
@SP
M = M + 1
A = M - 1
M = D
@17
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
@JEQ_15
D;JEQ
@SP
M = M + 1
A = M - 1
M = 0
@END_JEQ_15
0;JMP
(JEQ_15)
@SP
M = M + 1
A = M - 1
M = -1
(END_JEQ_15)
@892
D = A
@SP
M = M + 1
A = M - 1
M = D
@891
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
@JLT_18
D;JLT
@SP
M = M + 1
A = M - 1
M = 0
@END_JLT_18
0;JMP
(JLT_18)
@SP
M = M + 1
A = M - 1
M = -1
(END_JLT_18)
@891
D = A
@SP
M = M + 1
A = M - 1
M = D
@892
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
@JLT_21
D;JLT
@SP
M = M + 1
A = M - 1
M = 0
@END_JLT_21
0;JMP
(JLT_21)
@SP
M = M + 1
A = M - 1
M = -1
(END_JLT_21)
@891
D = A
@SP
M = M + 1
A = M - 1
M = D
@891
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
@JLT_24
D;JLT
@SP
M = M + 1
A = M - 1
M = 0
@END_JLT_24
0;JMP
(JLT_24)
@SP
M = M + 1
A = M - 1
M = -1
(END_JLT_24)
@32767
D = A
@SP
M = M + 1
A = M - 1
M = D
@32766
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
@JGT_27
D;JGT
@SP
M = M + 1
A = M - 1
M = 0
@END_JGT_27
0;JMP
(JGT_27)
@SP
M = M + 1
A = M - 1
M = -1
(END_JGT_27)
@32766
D = A
@SP
M = M + 1
A = M - 1
M = D
@32767
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
@JGT_30
D;JGT
@SP
M = M + 1
A = M - 1
M = 0
@END_JGT_30
0;JMP
(JGT_30)
@SP
M = M + 1
A = M - 1
M = -1
(END_JGT_30)
@32766
D = A
@SP
M = M + 1
A = M - 1
M = D
@32766
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
@JGT_33
D;JGT
@SP
M = M + 1
A = M - 1
M = 0
@END_JGT_33
0;JMP
(JGT_33)
@SP
M = M + 1
A = M - 1
M = -1
(END_JGT_33)
@57
D = A
@SP
M = M + 1
A = M - 1
M = D
@31
D = A
@SP
M = M + 1
A = M - 1
M = D
@53
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
@112
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
A = M - 1
M = -M
@SP
M = M - 1
A = M
D = M
@SP
M = M - 1
A = M
M = M & D
@SP
M = M + 1
@82
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
M = M | D
@SP
M = M + 1
@SP
A = M - 1
M = !M
