# frozen_string_literal: true

module VmTranslator
  module Commands
    Goto = Struct.new(:label_name) do
      def accept(visitor)
        visitor.visit_goto(self)
      end
    end
  end
end
