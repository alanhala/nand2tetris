# frozen_string_literal: true

module VmTranslator
  module Commands
    class Binary
      def initialize(operation)
        @operation = operation
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
          M = M #{@operation} D
          @SP
          M = M + 1
        ASSEMBLY
      end
    end
  end
end
