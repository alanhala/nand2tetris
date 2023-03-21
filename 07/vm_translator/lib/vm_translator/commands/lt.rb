# frozen_string_literal: true

module VmTranslator
  module Commands
    class Lt
      def initialize(line)
        @line = line
      end

      def ==(other)
        self.class == other.class && @line == other.line
      end

      def to_assembly
        Conditional.new(@line, "JLT").to_assembly
      end

      protected

      attr_reader :line
    end
  end
end
