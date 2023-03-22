# frozen_string_literal: true

module VmTranslator
  module Commands
    class And
      def ==(other)
        self.class == other.class
      end

      def accept(visitor)
        visitor.visit_and(self)
      end
    end
  end
end
