# frozen_string_literal: true

module VmTranslator
  module Commands
    class Add
      def ==(other)
        self.class == other.class
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
          M = M + D
          @SP
          M = M + 1
        ASSEMBLY
      end
    end
  end
end
