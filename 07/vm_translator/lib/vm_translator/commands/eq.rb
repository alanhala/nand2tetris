# frozen_string_literal: true

module VmTranslator
  module Commands
    class Eq
      attr_reader(:line)

      def initialize(line)
        @line = line
      end

      def ==(other)
        self.class == other.class && @line == other.line
      end

      def accept(visitor)
        visitor.visit_eq(self)
      end
    end
  end
end
