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

  it "parses sub command" do
    commands = described_class.new(VmTranslator::Lexer.new("sub").tokens).commands
    expect(commands).to eq([VmTranslator::Commands::Sub.new])
  end

  it "parses and command" do
    commands = described_class.new(VmTranslator::Lexer.new("and").tokens).commands
    expect(commands).to eq([VmTranslator::Commands::And.new])
  end

  it "parses or command" do
    commands = described_class.new(VmTranslator::Lexer.new("or").tokens).commands
    expect(commands).to eq([VmTranslator::Commands::Or.new])
  end

  it "parses not command" do
    commands = described_class.new(VmTranslator::Lexer.new("not").tokens).commands
    expect(commands).to eq([VmTranslator::Commands::Not.new])
  end

  it "parses neg command" do
    commands = described_class.new(VmTranslator::Lexer.new("neg").tokens).commands
    expect(commands).to eq([VmTranslator::Commands::Neg.new])
  end

  it "parses eq command" do
    commands = described_class.new(VmTranslator::Lexer.new("eq").tokens).commands
    expect(commands).to eq([VmTranslator::Commands::Eq.new(0)])
  end

  it "parses gt command" do
    commands = described_class.new(VmTranslator::Lexer.new("gt").tokens).commands
    expect(commands).to eq([VmTranslator::Commands::Gt.new(0)])
  end

  it "parses lt command" do
    commands = described_class.new(VmTranslator::Lexer.new("lt").tokens).commands
    expect(commands).to eq([VmTranslator::Commands::Lt.new(0)])
  end
end
