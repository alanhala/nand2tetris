# frozen_string_literal: true

module VmTranslator
  module Commands
    Lt = Struct.new(:line) do
      def accept(visitor)
        visitor.visit_lt(self)
      end
    end
  end
end
