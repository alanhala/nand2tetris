# frozen_string_literal: true

module VmTranslator
  module Commands
    IfGoto = Struct.new(:label_name) do
      def accept(visitor)
        visitor.visit_if_goto(self)
      end
    end
  end
end
