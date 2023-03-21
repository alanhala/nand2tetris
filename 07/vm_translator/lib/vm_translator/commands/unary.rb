# frozen_string_literal: true

module VmTranslator
  module Commands
    class Unary
      def initialize(operation)
        @operation = operation
      end

      def to_assembly
        <<~ASSEMBLY
          @SP
          A = M - 1
          M = #{@operation}M
        ASSEMBLY
      end
    end
  end
end
