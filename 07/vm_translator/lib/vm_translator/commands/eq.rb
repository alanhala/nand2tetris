# frozen_string_literal: true

module VmTranslator
  module Commands
    Eq = Struct.new(:line) do
      def accept(visitor)
        visitor.visit_eq(self)
      end
    end
  end
end
