# frozen_string_literal: true

module VmTranslator
  module Commands
    Gt = Struct.new(:line) do
      def accept(visitor)
        visitor.visit_gt(self)
      end
    end
  end
end
