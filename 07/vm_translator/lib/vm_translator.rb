# frozen_string_literal: true

require_relative "vm_translator/version"
require_relative "vm_translator/lexer"
require_relative "vm_translator/parser"
require_relative "vm_translator/commands/push"
require_relative "vm_translator/commands/pop"
require_relative "vm_translator/commands/add"
require_relative "vm_translator/commands/sub"

module VmTranslator
  class Error < StandardError; end
  # Your code goes here...

  def self.translate(vm_file_path)
    vm_source = File.read(File.expand_path(vm_file_path))
    lexer = VmTranslator::Lexer.new(vm_source)
    parser = VmTranslator::Parser.new(lexer.tokens)
    compiled_assembly = parser.commands.map(&:to_assembly).join
    File.write(File.expand_path(vm_file_path.gsub(".vm", ".asm")), compiled_assembly)
  end
end
