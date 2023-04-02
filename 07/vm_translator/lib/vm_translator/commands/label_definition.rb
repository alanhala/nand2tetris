# frozen_string_literal: true

module VmTranslator
  module Commands
    LabelDefinition = Struct.new(:label_name) do
      def accept(visitor)
        visitor.visit_label_definition(self)
      end
    end
  end
end
