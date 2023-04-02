# frozen_string_literal: true

module VmTranslator
  module Commands
    Push = Struct.new(:segment, :index) do
      def accept(visitor)
        visitor.visit_push(self)
      end
    end
  end
end
