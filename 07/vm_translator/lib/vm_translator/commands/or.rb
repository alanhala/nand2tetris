# frozen_string_literal: true

module VmTranslator
  module Commands
    class Or
      def ==(other)
        self.class == other.class
      end

      def accept(visitor)
        visitor.visit_or(self)
      end
    end
  end
end
