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
        in [[:label_definition], [:identifier, label]]
          Commands::LabelDefinition.new(label)
        in [[:goto], [:identifier, label]]
          Commands::Goto.new(label)
        in [[:return]]
          Commands::Return.new
        in [[:function], [:identifier, function_name], [:number, local_variables_number]]
          Commands::Function.new(function_name, local_variables_number)
        in [[:call], [:identifier, function_name], [:number, arguments_number]]
          Commands::Call.new(function_name, arguments_number)
        in [[:if_goto], [:identifier, label]]
          Commands::IfGoto.new(label)
        end
      end
    end
  end
end
