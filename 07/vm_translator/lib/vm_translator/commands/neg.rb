# frozen_string_literal: true

module VmTranslator
  module Commands
    class Neg
      def ==(other)
        self.class == other.class
      end

      def to_assembly
        Unary.new("-").to_assembly
      end
    end
  end
end
