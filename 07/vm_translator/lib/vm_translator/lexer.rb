# frozen_string_literal: true

module VmTranslator
  class Lexer
    def initialize(source)
      @source = source
    end

    def tokens
      @source.each_line(chomp: true).filter_map do |line|
        tokens = line.split.lazy.map do |word|
          case word
          when "//"
            [:comment]
          when "push"
            [:push]
          when "pop"
            [:pop]
          when "constant", "local", "argument", "this", "that", "pointer", "temp", "static"
            [:segment, word]
          when "add"
            [:add]
          when "sub"
            [:sub]
          when "and"
            [:and]
          when "or"
            [:or]
          when "neg"
            [:neg]
          when "not"
            [:not]
          when "eq"
            [:eq]
          when "lt"
            [:lt]
          when "gt"
            [:gt]
          when "label"
            [:label_definition]
          when "goto"
            [:goto]
          when "if-goto"
            [:if_goto]
          when "return"
            [:return]
          when "function"
            [:function]
          when "call"
            [:call]
          when /[a-zA-Z_:.][a-zA-Z0-9_:.]*/
            [:identifier, word]
          when /\d/
            [:number, word.to_i]
          else
            raise("Invalid token #{word}")
          end
        end
        tokens.take_while { |token| token != [:comment] }.to_a
      end
    end
  end
end
