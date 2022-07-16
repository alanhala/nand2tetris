# frozen_string_literal: true

require_relative "assembler/version"
require_relative "assembler/lexer"
require_relative "assembler/parser"
require_relative "assembler/compiler"
require_relative "assembler/symbol_table"

module Assembler
  class Error < StandardError; end

  def self.translate(file_path)
    tokens = Assembler::Lexer.new(File.read(file_path)).tokens
    instructions = Assembler::Parser.new(tokens).parse
    symbol_table = Assembler::SymbolTable.new(instructions)
    symbol_table.build
    Assembler::Compiler.new(instructions, symbol_table).compile.join("\n") << "\n"
  end
  # Your code goes here...
end
