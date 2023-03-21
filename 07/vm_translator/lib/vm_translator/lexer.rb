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
          when "constant"
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
