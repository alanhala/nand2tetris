# frozen_string_literal: true

module Assembler
  class Lexer
    ONE_CHAR_LEXEME = ["@", ";", "=", "-", "+", "|", "&", "(", ")", "!"].freeze
    WHITESPACE = [" ", "\r", "\t"].freeze
    POINTERS = %w[R0 R1 R2 R3 R4 R5 R6 R7 R8 R9 R10 R11 R12 R13 R14 R15 SP LCL ARG THIS THAT SCREEN KBD].freeze
    REGISTERS = %w[A D M MD AM AD AMD].freeze
    JUMPS = %w[JGT JEQ JGE JLT JNE JLE JMP].freeze
    Token = Struct.new(:type, :lexeme) do
      def deconstruct
        [type, lexeme]
      end
    end

    def initialize(source)
      @source = source
    end

    def tokens
      @source.each_line(chomp: true).filter_map do |line|
        i = 0
        tokens = []
        while i < line.size
          char = line[i]
          case char
          when *WHITESPACE
            next i += 1
          when *ONE_CHAR_LEXEME
            tokens << Token.new(char.to_sym, char)
          when "/"
            break
          when /\d/
            digits = [char]
            while line[i + 1]&.match?(/\d/)
              digits << line[i + 1]
              i += 1
            end
            tokens << Token.new(:number, digits.join)
          when /[a-zA-Z.:$_]/
            letters = [char]
            while line[i + 1]&.match?(/[\w.:$]/)
              letters << line[i + 1]
              i += 1
            end
            word = letters.join
            type =
              if POINTERS.include?(word)
                :pointer
              elsif REGISTERS.include?(word)
                :register
              elsif JUMPS.include?(word)
                :jump
              else
                :identifier
              end
            tokens << Token.new(type, word)
          else
            raise("Unexpected character #{char}")
          end

          i += 1
        end
        tokens.empty? ? nil : tokens
      end
    end
  end
end
