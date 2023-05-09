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
require_relative "vm_translator/commands/bootstrap"
require "pry-byebug"

module VmTranslator
  class Error < StandardError; end
  # Your code goes here...

  def self.translate(vm_program_directory)
    bootstrap_code = Compiler.new("Sys").compile([Commands::Bootstrap.new])
    compiled_files = Dir[vm_program_directory + "/*.vm"].map do |vm_file_path|
      expanded_vm_file_path = File.expand_path(vm_file_path)
      lexer = Lexer.new(File.read(expanded_vm_file_path))
      parser = Parser.new(lexer.tokens)
      vm_file_name = File.basename(vm_file_path, ".vm")
      Compiler.new(vm_file_name).compile(parser.commands)
    end
    compiled_assembly = ([bootstrap_code] + compiled_files).join
    asm_file_name = File.basename(vm_program_directory) + ".asm"
    File.write("#{vm_program_directory}/#{asm_file_name}", compiled_assembly)
  end
end
