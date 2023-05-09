# frozen_string_literal: true

module VmTranslator
  module Commands
    class Bootstrap
      def ==(other)
        self.class == other.class
      end

      def accept(visitor)
        visitor.visit_bootstrap(self)
      end
    end
  end
end
