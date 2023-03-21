# frozen_string_literal: true

module VmTranslator
  module Commands
    class Conditional
      def initialize(line, jump_condition)
        @line = line
        @jump_condition = jump_condition
      end

      def to_assembly
        <<~ASSEMBLY
          @SP
          M = M - 1
          A = M
          D = M
          @SP
          M = M - 1
          A = M
          D = M - D
          @#{@jump_condition}_#{@line}
          D;#{@jump_condition}
          @SP
          M = M + 1
          A = M - 1
          M = 0
          @END_#{@jump_condition}_#{@line}
          0;JMP
          (#{@jump_condition}_#{@line})
          @SP
          M = M + 1
          A = M - 1
          M = -1
          (END_#{@jump_condition}_#{@line})
        ASSEMBLY
      end
    end
  end
end
