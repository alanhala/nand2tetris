# frozen_string_literal: true

module VmTranslator
  module Commands
    class Add
      def ==(other)
        self.class == other.class
      end

      def accept(visitor)
        visitor.visit_add(self)
      end
    end
  end
end
