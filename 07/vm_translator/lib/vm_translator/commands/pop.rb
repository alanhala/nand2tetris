# frozen_string_literal: true

module VmTranslator
  module Commands
    Pop = Struct.new(:segment, :index) do
      def accept(visitor)
        visitor.visit_pop(self)
      end
    end
  end
end
