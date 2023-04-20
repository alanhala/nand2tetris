# frozen_string_literal: true

module VmTranslator
  module Commands
    class Return
      def ==(other)
        self.class == other.class
      end

      def accept(visitor)
        visitor.visit_return(self)
      end
    end
  end
end
