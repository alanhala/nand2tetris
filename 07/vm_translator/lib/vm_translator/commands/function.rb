# frozen_string_literal: true

module VmTranslator
  module Commands
    Function = Struct.new(:function_name, :local_variables_number) do
      def accept(visitor)
        visitor.visit_function(self)
      end
    end
  end
end
