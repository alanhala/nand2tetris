# frozen_string_literal: true

RSpec.describe Assembler::Lexer do
  describe "#tokens" do
    it "ignores comments" do
      source = <<~SOURCE
        // @2
        // A=2;JMP
      SOURCE

      expect(Assembler::Lexer.new(source).tokens).to be_empty
    end

    it "ignores whitespaces" do
      source = " @ \r ; \t +"

      expect(Assembler::Lexer.new(source).tokens).to eq(
        [
          [
            Assembler::Lexer::Token.new(:"@", "@"),
            Assembler::Lexer::Token.new(:";", ";"),
            Assembler::Lexer::Token.new(:+, "+")
          ]
        ]
      )
    end

    describe "one character lexeme" do
      it "returns token for @" do
        source = "@"

        expect(Assembler::Lexer.new(source).tokens).to eq([[Assembler::Lexer::Token.new(:"@", "@")]])
      end

      it "returns token for ;" do
        source = ";"

        expect(Assembler::Lexer.new(source).tokens).to eq([[Assembler::Lexer::Token.new(:";", ";")]])
      end

      it "returns token for =" do
        source = "="

        expect(Assembler::Lexer.new(source).tokens).to eq([[Assembler::Lexer::Token.new(:"=", "=")]])
      end

      it "returns token for +" do
        source = "+"

        expect(Assembler::Lexer.new(source).tokens).to eq([[Assembler::Lexer::Token.new(:+, "+")]])
      end

      it "returns token for -" do
        source = "-"

        expect(Assembler::Lexer.new(source).tokens).to eq([[Assembler::Lexer::Token.new(:-, "-")]])
      end

      it "returns token for |" do
        source = "|"

        expect(Assembler::Lexer.new(source).tokens).to eq([[Assembler::Lexer::Token.new(:|, "|")]])
      end

      it "returns token for &" do
        source = "&"

        expect(Assembler::Lexer.new(source).tokens).to eq([[Assembler::Lexer::Token.new(:&, "&")]])
      end

      it "returns token for (" do
        source = "("

        expect(Assembler::Lexer.new(source).tokens).to eq([[Assembler::Lexer::Token.new(:"(", "(")]])
      end

      it "returns token for )" do
        source = ")"

        expect(Assembler::Lexer.new(source).tokens).to eq([[Assembler::Lexer::Token.new(:")", ")")]])
      end

      it "returns token for !" do
        source = "!"

        expect(Assembler::Lexer.new(source).tokens).to eq([[Assembler::Lexer::Token.new(:!, "!")]])
      end
    end

    describe "numbers" do
      it "returns a token for the whole number" do
        source = "123 34"

        expect(Assembler::Lexer.new(source).tokens).to eq(
          [
            [Assembler::Lexer::Token.new(:number, "123"), Assembler::Lexer::Token.new(:number, "34")]
          ]
        )
      end
    end

    describe "keywords" do
      it "returns tokens for all of them" do
        source = <<~SOURCE
          R0 R1 R2 R3 R4 R5 R6 R7 R8 R9 R10 R11 R12 R13 R14 R15
          SP LCL ARG THIS THAT SCREEN KBD
          A D M MD AM AD AMD
          JGT JEQ JGE JLT JNE JLE JMP
        SOURCE

        expect(Assembler::Lexer.new(source).tokens).to eq(
          [
            [
              Assembler::Lexer::Token.new(:pointer, "R0"),
              Assembler::Lexer::Token.new(:pointer, "R1"),
              Assembler::Lexer::Token.new(:pointer, "R2"),
              Assembler::Lexer::Token.new(:pointer, "R3"),
              Assembler::Lexer::Token.new(:pointer, "R4"),
              Assembler::Lexer::Token.new(:pointer, "R5"),
              Assembler::Lexer::Token.new(:pointer, "R6"),
              Assembler::Lexer::Token.new(:pointer, "R7"),
              Assembler::Lexer::Token.new(:pointer, "R8"),
              Assembler::Lexer::Token.new(:pointer, "R9"),
              Assembler::Lexer::Token.new(:pointer, "R10"),
              Assembler::Lexer::Token.new(:pointer, "R11"),
              Assembler::Lexer::Token.new(:pointer, "R12"),
              Assembler::Lexer::Token.new(:pointer, "R13"),
              Assembler::Lexer::Token.new(:pointer, "R14"),
              Assembler::Lexer::Token.new(:pointer, "R15")
            ],
            [
              Assembler::Lexer::Token.new(:pointer, "SP"),
              Assembler::Lexer::Token.new(:pointer, "LCL"),
              Assembler::Lexer::Token.new(:pointer, "ARG"),
              Assembler::Lexer::Token.new(:pointer, "THIS"),
              Assembler::Lexer::Token.new(:pointer, "THAT"),
              Assembler::Lexer::Token.new(:pointer, "SCREEN"),
              Assembler::Lexer::Token.new(:pointer, "KBD")
            ],
            [
              Assembler::Lexer::Token.new(:register, "A"),
              Assembler::Lexer::Token.new(:register, "D"),
              Assembler::Lexer::Token.new(:register, "M"),
              Assembler::Lexer::Token.new(:register, "MD"),
              Assembler::Lexer::Token.new(:register, "AM"),
              Assembler::Lexer::Token.new(:register, "AD"),
              Assembler::Lexer::Token.new(:register, "AMD")
            ],
            [
              Assembler::Lexer::Token.new(:jump, "JGT"),
              Assembler::Lexer::Token.new(:jump, "JEQ"),
              Assembler::Lexer::Token.new(:jump, "JGE"),
              Assembler::Lexer::Token.new(:jump, "JLT"),
              Assembler::Lexer::Token.new(:jump, "JNE"),
              Assembler::Lexer::Token.new(:jump, "JLE"),
              Assembler::Lexer::Token.new(:jump, "JMP")
            ]
          ]
        )
      end
    end

    describe "literals" do
      it "returns identifier starting with a character" do
        source = "asd"

        expect(Assembler::Lexer.new(source).tokens).to eq(
          [
            [Assembler::Lexer::Token.new(:identifier, "asd")]
          ]
        )
      end

      it "returns identifier starting with a _" do
        source = "_asd"

        expect(Assembler::Lexer.new(source).tokens).to eq(
          [
            [Assembler::Lexer::Token.new(:identifier, "_asd")]
          ]
        )
      end

      it "returns identifier starting with ." do
        source = ".asd"

        expect(Assembler::Lexer.new(source).tokens).to eq(
          [
            [Assembler::Lexer::Token.new(:identifier, ".asd")]
          ]
        )
      end

      it "returns identifier starting with $" do
        source = "$asd"

        expect(Assembler::Lexer.new(source).tokens).to eq(
          [
            [Assembler::Lexer::Token.new(:identifier, "$asd")]
          ]
        )
      end

      it "returns identifier starting with :" do
        source = ":asd"

        expect(Assembler::Lexer.new(source).tokens).to eq(
          [
            [Assembler::Lexer::Token.new(:identifier, ":asd")]
          ]
        )
      end

      it "returns identifier containing digits not in the beginning" do
        source = "asd123"

        expect(Assembler::Lexer.new(source).tokens).to eq(
          [
            [Assembler::Lexer::Token.new(:identifier, "asd123")]
          ]
        )
      end

      it "returns identifier with any letter, number and special characters" do
        source = ":ad23_.$"

        expect(Assembler::Lexer.new(source).tokens).to eq(
          [
            [Assembler::Lexer::Token.new(:identifier, ":ad23_.$")]
          ]
        )
      end
    end
  end
end
