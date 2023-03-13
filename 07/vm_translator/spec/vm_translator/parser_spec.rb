# frozen_string_literal: true

require "spec_helper"

RSpec.describe VmTranslator::Parser do
  it "parses push command" do
    commands = described_class.new(VmTranslator::Lexer.new("push constant 7").tokens).commands
    expect(commands).to eq([VmTranslator::Commands::Push.new("constant", 7)])
  end

  it "parses pop command" do
    commands = described_class.new(VmTranslator::Lexer.new("pop constant 7").tokens).commands
    expect(commands).to eq([VmTranslator::Commands::Pop.new("constant", 7)])
  end

  it "parses add command" do
    commands = described_class.new(VmTranslator::Lexer.new("add").tokens).commands
    expect(commands).to eq([VmTranslator::Commands::Add.new])
  end
end
