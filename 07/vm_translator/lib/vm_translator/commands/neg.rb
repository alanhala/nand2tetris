# frozen_string_literal: true

module VmTranslator
  module Commands
    class Neg
      def ==(other)
        self.class == other.class
      end

      def accept(visitor)
        visitor.visit_neg(self)
      end
    end
  end
end
