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

  it "returns token for constant" do
    expect(described_class.new("constant").tokens).to eq([[[:segment, "constant"]]])
  end

  it "returns token for number" do
    expect(described_class.new("123").tokens).to eq([[[:number, 123]]])
  end

  it "skips the line if it is a comment" do
    expect(described_class.new("// This is a comment").tokens).to eq([[]])
  end

  it "does not return token for comments" do
    expect(described_class.new("push // This is a comment").tokens).to eq([[[:push]]])
  end
end
