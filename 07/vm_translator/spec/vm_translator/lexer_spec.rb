# frozen_string_literal: true

require "spec_helper"

RSpec.describe VmTranslator::Lexer do
  it "returns token for push" do
    expect(described_class.new("push").tokens).to eq([[[:push]]])
  end

  it "returns token for pop" do
    expect(described_class.new("pop").tokens).to eq([[[:pop]]])
  end

  it "returns token for add" do
    expect(described_class.new("add").tokens).to eq([[[:add]]])
  end

  it "returns token for sub" do
    expect(described_class.new("sub").tokens).to eq([[[:sub]]])
  end

  it "returns token for and" do
    expect(described_class.new("and").tokens).to eq([[[:and]]])
  end

  it "returns token for or" do
    expect(described_class.new("or").tokens).to eq([[[:or]]])
  end

  it "returns token for constant" do
    expect(described_class.new("constant").tokens).to eq([[[:segment, "constant"]]])
  end

  it "returns token for local" do
    expect(described_class.new("local").tokens).to eq([[[:segment, "local"]]])
  end

  it "returns token for argument" do
    expect(described_class.new("argument").tokens).to eq([[[:segment, "argument"]]])
  end

  it "returns token for this" do
    expect(described_class.new("this").tokens).to eq([[[:segment, "this"]]])
  end

  it "returns token for that" do
    expect(described_class.new("that").tokens).to eq([[[:segment, "that"]]])
  end

  it "returns token for pointer" do
    expect(described_class.new("pointer").tokens).to eq([[[:segment, "pointer"]]])
  end

  it "returns token for temp" do
    expect(described_class.new("temp").tokens).to eq([[[:segment, "temp"]]])
  end

  it "returns token for static" do
    expect(described_class.new("static").tokens).to eq([[[:segment, "static"]]])
  end

  it "returns token for number" do
    expect(described_class.new("123").tokens).to eq([[[:number, 123]]])
  end

  it "returns token for eq" do
    expect(described_class.new("eq").tokens).to eq([[[:eq]]])
  end

  it "returns token for not" do
    expect(described_class.new("not").tokens).to eq([[[:not]]])
  end

  it "returns token for neg" do
    expect(described_class.new("neg").tokens).to eq([[[:neg]]])
  end

  it "returns token for gt" do
    expect(described_class.new("gt").tokens).to eq([[[:gt]]])
  end

  it "returns token for lt" do
    expect(described_class.new("lt").tokens).to eq([[[:lt]]])
  end

  it "returns token for label_definition" do
    expect(described_class.new("label").tokens).to eq([[[:label_definition]]])
  end

  it "returns token for identifier" do
    expect(described_class.new("asd123").tokens).to eq([[[:identifier, "asd123"]]])
  end

  it "returns token for goto" do
    expect(described_class.new("goto").tokens).to eq([[[:goto]]])
  end

  it "returns token for if_goto" do
    expect(described_class.new("if-goto").tokens).to eq([[[:if_goto]]])
  end

  it "returns token for return" do
    expect(described_class.new("return").tokens).to eq([[[:return]]])
  end

  it "returns token for function" do
    expect(described_class.new("function").tokens).to eq([[[:function]]])
  end

  it "returns token for call" do
    expect(described_class.new("call").tokens).to eq([[[:call]]])
  end

  it "skips the line if it is a comment" do
    expect(described_class.new("// This is a comment").tokens).to eq([[]])
  end

  it "does not return token for comments" do
    expect(described_class.new("push // This is a comment").tokens).to eq([[[:push]]])
  end
end
