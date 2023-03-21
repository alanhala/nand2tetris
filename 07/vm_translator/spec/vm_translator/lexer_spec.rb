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

  it "skips the line if it is a comment" do
    expect(described_class.new("// This is a comment").tokens).to eq([[]])
  end

  it "does not return token for comments" do
    expect(described_class.new("push // This is a comment").tokens).to eq([[[:push]]])
  end
end
