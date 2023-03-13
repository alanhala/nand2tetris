# frozen_string_literal: true

module VmTranslator
  module Commands
    class Pop
      def initialize(segment, index)
        @segment = segment
        @index = index
      end

      def ==(other)
        self.class == other.class && segment == other.segment && index == other.index
      end

      def to_assembly
      end

      protected

      attr_reader :segment, :index
    end
  end
end
