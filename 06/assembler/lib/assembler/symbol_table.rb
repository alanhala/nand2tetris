# frozen_string_literal: true

module Assembler
  class SymbolTable
    def initialize(instructions)
      @instructions = instructions
      @instruction_counter = 0
      @next_ram_address = 16
    end

    def build
      @instructions.each { |instruction| instruction.accept(self) }
    end

    def visit_a_instruction(_)
      @instruction_counter += 1
    end

    def visit_c_instruction(_)
      @instruction_counter += 1
    end

    def visit_symbol_definition(symbol_delcaration)
      hash[symbol_delcaration.symbol] = @instruction_counter
    end

    def visit_destination(_); end

    def visit_literal_expression(_); end

    def visit_unary_expression(_); end

    def visit_binary_expression(_); end

    def visit_jump(_); end

    def fetch(symbol)
      if hash.key?(symbol)
        hash[symbol]
      else
        @next_ram_address.tap do |address|
          hash[symbol] = address
          @next_ram_address += 1
        end
      end
    end

    private

    def hash
      @hash ||= {
        "R0" => 0,
        "R1" => 1,
        "R2" => 2,
        "R3" => 3,
        "R4" => 4,
        "R5" => 5,
        "R6" => 6,
        "R7" => 7,
        "R8" => 8,
        "R9" => 9,
        "R10" => 10,
        "R11" => 11,
        "R12" => 12,
        "R13" => 13,
        "R14" => 14,
        "R15" => 15,
        "SP" => 0,
        "LCL" => 1,
        "ARG" => 2,
        "THIS" => 3,
        "THAT" => 4,
        "SCREEN" => 16_384,
        "KBD" => 24_576
      }
    end
  end
end
