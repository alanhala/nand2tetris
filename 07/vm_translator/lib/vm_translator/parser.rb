# frozen_string_literal: true

module VmTranslator
  class Parser
    def initialize(tokens_per_line)
      @tokens_per_line = tokens_per_line
    end

    def commands
      @tokens_per_line.filter_map do |tokens|
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
        end
      end
    end
  end
end
