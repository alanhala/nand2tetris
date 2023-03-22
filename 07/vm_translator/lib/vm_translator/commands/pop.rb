# frozen_string_literal: true

module VmTranslator
  module Commands
    class Pop
      attr_reader :segment, :index

      def initialize(segment, index)
        @segment = segment
        @index = index
      end

      def ==(other)
        self.class == other.class && segment == other.segment && index == other.index
      end

      def accept(visitor)
        visitor.visit_pop(self)
      end
    end
  end
end
