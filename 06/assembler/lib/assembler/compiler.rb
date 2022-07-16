# frozen_string_literal: true

module Assembler
  class Compiler
    def initialize(instructions, symbols_table)
      @instructions = instructions
      @symbols_table = symbols_table
    end

    def compile
      @instructions.filter_map do |instruction|
        instruction.accept(self)
      end
    end

    def visit_a_instruction(a_instruction)
      value = Integer(a_instruction.value)
      format("%016b", value)
    rescue ArgumentError
      value = @symbols_table.fetch(a_instruction.value)
      format("%016b", value)
    end

    def visit_c_instruction(c_instruction)
      destination = c_instruction.destination.accept(self)
      computation = c_instruction.computation.accept(self)
      jump = c_instruction.jump.accept(self)
      "111#{computation}#{destination}#{jump}"
    end

    def visit_symbol_definition(_); end

    def visit_destination(destination)
      case destination.register
      when "M"
        "001"
      when "D"
        "010"
      when "MD"
        "011"
      when "A"
        "100"
      when "AM"
        "101"
      when "AD"
        "110"
      when "AMD"
        "111"
      when nil
        "000"
      else
        raise("Invalid destination")
      end
    end

    def visit_literal_expression(literal_expression)
      case literal_expression.value
      when "0"
        "0101010"
      when "1"
        "0111111"
      when "D"
        "0001100"
      when "A"
        "0110000"
      when "M"
        "1110000"
      else
        raise("Invalid literal expression")
      end
    end

    def visit_unary_expression(unary_expression)
      case "#{unary_expression.operator}#{unary_expression.operand}"
      when "-1"
        "0111010"
      when "!D"
        "0001101"
      when "!A"
        "0110001"
      when "!M"
        "1110001"
      else
        raise("Invalid unary expression")
      end
    end

    def visit_binary_expression(binary_expression)
      case "#{binary_expression.left_operand}#{binary_expression.operator}#{binary_expression.right_operand}"
      when "D+1"
        "0011111"
      when "A+1"
        "0110111"
      when "M+1"
        "1110111"
      when "D-1"
        "0001110"
      when "A-1"
        "0110010"
      when "M-1"
        "1110010"
      when "D+A"
        "0000010"
      when "D+M"
        "1000010"
      when "D-A"
        "0010011"
      when "D-M"
        "1010011"
      when "A-D"
        "0000111"
      when "M-D"
        "1000111"
      when "D&A"
        "0000000"
      when "D&M"
        "1000000"
      when "D|A"
        "0010101"
      when "D|M"
        "1010101"
      else
        raise("Invalid binary expression")
      end
    end

    def visit_jump(jump)
      case jump.condition
      when nil
        "000"
      when "JGT"
        "001"
      when "JEQ"
        "010"
      when "JGE"
        "011"
      when "JLT"
        "100"
      when "JNE"
        "101"
      when "JLE"
        "110"
      when "JMP"
        "111"
      else
        raise("Invalid jump")
      end
    end
  end
end
