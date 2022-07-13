# frozen_string_literal: true

module Assembler
  class Parser
    AInstruction = Struct.new(:value)
    CInstruction = Struct.new(:destination, :computation, :jump)
    Destination = Struct.new(:destination)
    LiteralExpression = Struct.new(:value)
    UnaryExpression = Struct.new(:operator, :operand)
    BinaryExpression = Struct.new(:left_operand, :operator, :right_operand)
    Jump = Struct.new(:jump)
    SymbolDeclaration = Struct.new(:symbol)

    def initialize(tokens)
      @tokens = tokens
    end

    def parse
      @tokens.map do |line|
        case line
        in [[:"@", _], [:number | :identifier | :pointer, number]]
          AInstruction.new(number)
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
            in [[:register | :number, left_operand], [:+ | :- | :| | :&, operator], [:register | :number, right_operand], *maybe_jump]
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
