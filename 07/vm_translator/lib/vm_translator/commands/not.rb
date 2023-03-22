# frozen_string_literal: true

module VmTranslator
  module Commands
    class Not
      def ==(other)
        self.class == other.class
      end

      def accept(visitor)
        visitor.visit_not(self)
      end
    end
  end
end
