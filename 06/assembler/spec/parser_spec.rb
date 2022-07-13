# frozen_string_literal: true

RSpec.describe Assembler::Parser do
  describe("A-Instructions") do
    it "parses it with number" do
      source = "@2"

      expect(Assembler::Parser.new(Assembler::Lexer.new(source).tokens).parse).to eq(
        [Assembler::Parser::AInstruction.new("2")]
      )
    end

    it "parses it with symbol" do
      source = "@OUTPUT_FIRST"

      expect(Assembler::Parser.new(Assembler::Lexer.new(source).tokens).parse).to eq(
        [Assembler::Parser::AInstruction.new("OUTPUT_FIRST")]
      )
    end

    it "parses it with pointer" do
      source = "@R0"

      expect(Assembler::Parser.new(Assembler::Lexer.new(source).tokens).parse).to eq(
        [Assembler::Parser::AInstruction.new("R0")]
      )
    end
  end

  describe("C-Instruction") do
    describe("binary expressions") do
      it("parses only computations") do
        source = "D+1"

        expect(Assembler::Parser.new(Assembler::Lexer.new(source).tokens).parse).to eq(
          [
            Assembler::Parser::CInstruction.new(
              Assembler::Parser::Destination.new(nil),
              Assembler::Parser::BinaryExpression.new("D", "+", "1"),
              Assembler::Parser::Jump.new(nil)
            )
          ]
        )
      end

      it("parses computation with destination") do
        source = "A=D+1"

        expect(Assembler::Parser.new(Assembler::Lexer.new(source).tokens).parse).to eq(
          [
            Assembler::Parser::CInstruction.new(
              Assembler::Parser::Destination.new("A"),
              Assembler::Parser::BinaryExpression.new("D", "+", "1"),
              Assembler::Parser::Jump.new(nil)
            )
          ]
        )
      end

      it("parses computation with jump") do
        source = "D+1;JMP"

        expect(Assembler::Parser.new(Assembler::Lexer.new(source).tokens).parse).to eq(
          [
            Assembler::Parser::CInstruction.new(
              Assembler::Parser::Destination.new(nil),
              Assembler::Parser::BinaryExpression.new("D", "+", "1"),
              Assembler::Parser::Jump.new("JMP")
            )
          ]
        )
      end

      it("parses computation with destination and jump") do
        source = "A=D+1;JMP"

        expect(Assembler::Parser.new(Assembler::Lexer.new(source).tokens).parse).to eq(
          [
            Assembler::Parser::CInstruction.new(
              Assembler::Parser::Destination.new("A"),
              Assembler::Parser::BinaryExpression.new("D", "+", "1"),
              Assembler::Parser::Jump.new("JMP")
            )
          ]
        )
      end
    end

    describe("unary expressions") do
      it("parses only computations") do
        source = "-D"

        expect(Assembler::Parser.new(Assembler::Lexer.new(source).tokens).parse).to eq(
          [
            Assembler::Parser::CInstruction.new(
              Assembler::Parser::Destination.new(nil),
              Assembler::Parser::UnaryExpression.new("-", "D"),
              Assembler::Parser::Jump.new(nil)
            )
          ]
        )
      end

      it("parses computation with destination") do
        source = "A=-D"

        expect(Assembler::Parser.new(Assembler::Lexer.new(source).tokens).parse).to eq(
          [
            Assembler::Parser::CInstruction.new(
              Assembler::Parser::Destination.new("A"),
              Assembler::Parser::UnaryExpression.new("-", "D"),
              Assembler::Parser::Jump.new(nil)
            )
          ]
        )
      end

      it("parses computation with jump") do
        source = "-D;JMP"

        expect(Assembler::Parser.new(Assembler::Lexer.new(source).tokens).parse).to eq(
          [
            Assembler::Parser::CInstruction.new(
              Assembler::Parser::Destination.new(nil),
              Assembler::Parser::UnaryExpression.new("-", "D"),
              Assembler::Parser::Jump.new("JMP")
            )
          ]
        )
      end

      it("parses computation with destination and jump") do
        source = "A=-D;JMP"

        expect(Assembler::Parser.new(Assembler::Lexer.new(source).tokens).parse).to eq(
          [
            Assembler::Parser::CInstruction.new(
              Assembler::Parser::Destination.new("A"),
              Assembler::Parser::UnaryExpression.new("-", "D"),
              Assembler::Parser::Jump.new("JMP")
            )
          ]
        )
      end
    end

    describe("literal expressions") do
      it("parses only computations") do
        source = "D"

        expect(Assembler::Parser.new(Assembler::Lexer.new(source).tokens).parse).to eq(
          [
            Assembler::Parser::CInstruction.new(
              Assembler::Parser::Destination.new(nil),
              Assembler::Parser::LiteralExpression.new("D"),
              Assembler::Parser::Jump.new(nil)
            )
          ]
        )
      end

      it("parses computation with destination") do
        source = "A=D"

        expect(Assembler::Parser.new(Assembler::Lexer.new(source).tokens).parse).to eq(
          [
            Assembler::Parser::CInstruction.new(
              Assembler::Parser::Destination.new("A"),
              Assembler::Parser::LiteralExpression.new("D"),
              Assembler::Parser::Jump.new(nil)
            )
          ]
        )
      end

      it("parses computation with jump") do
        source = "D;JMP"

        expect(Assembler::Parser.new(Assembler::Lexer.new(source).tokens).parse).to eq(
          [
            Assembler::Parser::CInstruction.new(
              Assembler::Parser::Destination.new(nil),
              Assembler::Parser::LiteralExpression.new("D"),
              Assembler::Parser::Jump.new("JMP")
            )
          ]
        )
      end

      it("parses computation with destination and jump") do
        source = "A=D;JMP"

        expect(Assembler::Parser.new(Assembler::Lexer.new(source).tokens).parse).to eq(
          [
            Assembler::Parser::CInstruction.new(
              Assembler::Parser::Destination.new("A"),
              Assembler::Parser::LiteralExpression.new("D"),
              Assembler::Parser::Jump.new("JMP")
            )
          ]
        )
      end
    end
  end

  describe("Symbol declaration") do
    it("parses the declaration") do
      source = "(OUTPUT_FIRST)"

      expect(Assembler::Parser.new(Assembler::Lexer.new(source).tokens).parse).to eq(
        [Assembler::Parser::SymbolDeclaration.new("OUTPUT_FIRST")]
      )
    end
  end
end
