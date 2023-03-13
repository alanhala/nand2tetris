# frozen_string_literal: true

module VmTranslator
  module Commands
    class Push
      def initialize(segment, index)
        @segment = segment
        @index = index
      end

      def ==(other)
        self.class == other.class && segment == other.segment && index == other.index
      end

      def to_assembly
        <<~ASSEMBLY
          #{store_segment_in_d.strip}
          @SP
          M = M + 1
          A = M - 1
          M = D
        ASSEMBLY
      end

      protected

      attr_reader :segment, :index

      def store_segment_in_d
        case segment
        when "argument"
          "ARG"
        when "local"
          "LCL"
        when "static"
          "Seg.#{index}"
        when "constant"
          <<~ASSEMBLY
            @#{index}
            D = A
          ASSEMBLY
        when "this"
          "THIS"
        when "that"
          "THAT"
        when "pointer"
          "@R3"
        when "temp"
          "R5"
        end
      end
    end
  end
end
