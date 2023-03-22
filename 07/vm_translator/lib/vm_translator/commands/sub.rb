# frozen_string_literal: true

module VmTranslator
  module Commands
    class Sub
      def ==(other)
        self.class == other.class
      end

      def accept(visitor)
        visitor.visit_sub(self)
      end
    end
  end
end
