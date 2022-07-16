# frozen_string_literal: true

module Assembler
  class Parser
    AInstruction = Struct.new(:value) do
      def accept(visitor)
        visitor.visit_a_instruction(self)
      end
    end
    CInstruction = Struct.new(:destination, :computation, :jump) do
      def accept(visitor)
        visitor.visit_c_instruction(self)
      end
    end
    Destination = Struct.new(:register) do
      def accept(visitor)
        visitor.visit_destination(self)
      end
    end
    LiteralExpression = Struct.new(:value) do
      def accept(visitor)
        visitor.visit_literal_expression(self)
      end
    end
    UnaryExpression = Struct.new(:operator, :operand) do
      def accept(visitor)
        visitor.visit_unary_expression(self)
      end
    end
    BinaryExpression = Struct.new(:left_operand, :operator, :right_operand) do
      def accept(visitor)
        visitor.visit_binary_expression(self)
      end
    end
    Jump = Struct.new(:condition) do
      def accept(visitor)
        visitor.visit_jump(self)
      end
    end
    SymbolDeclaration = Struct.new(:symbol) do
      def accept(visitor)
        visitor.visit_symbol_definition(self)
      end
    end

    def initialize(tokens)
      @tokens = tokens
    end

    def parse
      @tokens.map do |line|
        case line
        in [[:"@", _], [:number | :identifier | :pointer, value]]
          AInstruction.new(value)
        in [[:"(", _], [:identifier, symbol], [:")", _]]
          SymbolDeclaration.new(symbol)
        else
          destination, maybe_computation_and_jump =
            case line
            in [[:register, destination_register], [:"=", _], *maybe_computation_and_jump]
              [Destination.new(destination_register), maybe_computation_and_jump]
            else
              [Destination.new(nil), line]
            end
          computation, maybe_jump =
            case maybe_computation_and_jump
            in [[:! | :-, operator], [:register | :number, operand], *maybe_jump]
              [UnaryExpression.new(operator, operand), maybe_jump]
            in [
              [:register | :number, left_operand],
              [:+ | :- | :| | :&, operator],
              [:register | :number, right_operand],
              *maybe_jump
            ]
              [BinaryExpression.new(left_operand, operator, right_operand), maybe_jump]
            in [[:register | :number, literal], *maybe_jump]
              [LiteralExpression.new(literal), maybe_jump]
            end
          jump =
            case maybe_jump
            in [[:";", _], [:jump, jump_value]]
              Jump.new(jump_value)
            in []
              Jump.new(nil)
            end
          CInstruction.new(destination, computation, jump)
        end
      end
    end
  end
end
