# frozen_string_literal: true

module VmTranslator
  class Parser
    def initialize(tokens_per_line)
      @tokens_per_line = tokens_per_line
    end

    def commands
      @tokens_per_line.each_with_index.filter_map do |tokens, line|
        case tokens
        in []
          nil
        in [[:push], [:segment, segment], [:number, number]]
          Commands::Push.new(segment, number)
        in [[:pop], [:segment, segment], [:number, number]]
          Commands::Pop.new(segment, number)
        in [[:add]]
          Commands::Add.new
        in [[:sub]]
          Commands::Sub.new
        in [[:and]]
          Commands::And.new
        in [[:or]]
          Commands::Or.new
        in [[:not]]
          Commands::Not.new
        in [[:neg]]
          Commands::Neg.new
        in [[:eq]]
          Commands::Eq.new(line)
        in [[:lt]]
          Commands::Lt.new(line)
        in [[:gt]]
          Commands::Gt.new(line)
        end
      end
    end
  end
end
