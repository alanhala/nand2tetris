# frozen_string_literal: true

require_relative "vm_translator/version"
require_relative "vm_translator/lexer"
require_relative "vm_translator/parser"
require_relative "vm_translator/compiler"
require_relative "vm_translator/commands/push"
require_relative "vm_translator/commands/pop"
require_relative "vm_translator/commands/add"
require_relative "vm_translator/commands/sub"
require_relative "vm_translator/commands/and"
require_relative "vm_translator/commands/or"
require_relative "vm_translator/commands/not"
require_relative "vm_translator/commands/neg"
require_relative "vm_translator/commands/eq"
require_relative "vm_translator/commands/lt"
require_relative "vm_translator/commands/gt"
require_relative "vm_translator/commands/label_definition"
require_relative "vm_translator/commands/goto"
require_relative "vm_translator/commands/if_goto"
require_relative "vm_translator/commands/return"
require_relative "vm_translator/commands/function"
require_relative "vm_translator/commands/call"

module VmTranslator
  class Error < StandardError; end
  # Your code goes here...

  def self.translate(vm_file_path)
    expanded_vm_file_path = File.expand_path(vm_file_path)
    lexer = VmTranslator::Lexer.new(File.read(expanded_vm_file_path))
    parser = VmTranslator::Parser.new(lexer.tokens)
    VmTranslator::Compiler.new(expanded_vm_file_path).compile(parser.commands)
  end
end
