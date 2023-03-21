# frozen_string_literal: true

module VmTranslator
  module Commands
    class Or
      def ==(other)
        self.class == other.class
      end

      def to_assembly
        Binary.new("|").to_assembly
      end
    end
  end
end
