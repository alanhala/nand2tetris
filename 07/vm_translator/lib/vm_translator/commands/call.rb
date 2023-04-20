# frozen_string_literal: true

module VmTranslator
  module Commands
    Call = Struct.new(:function_name, :arguments_number) do
      def accept(visitor)
        visitor.visit_call(self)
      end
    end
  end
end
