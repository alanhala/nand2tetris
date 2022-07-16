# frozen_string_literal: true

RSpec.describe Assembler do
  it "compiles Add" do
    file_path = File.expand_path("../../add/Add.asm", __dir__)
    compiled_hack_program = File.read(File.expand_path("../../add/Add.hack", __dir__))
    expect(Assembler.translate(file_path)).to eq compiled_hack_program
  end

  it "compiles Max" do
    file_path = File.expand_path("../../max/Max.asm", __dir__)
    compiled_hack_program = File.read(File.expand_path("../../max/Max.hack", __dir__))
    expect(Assembler.translate(file_path)).to eq compiled_hack_program
  end

  it "compiles MaxL" do
    file_path = File.expand_path("../../max/MaxL.asm", __dir__)
    compiled_hack_program = File.read(File.expand_path("../../max/MaxL.hack", __dir__))
    expect(Assembler.translate(file_path)).to eq compiled_hack_program
  end

  it "compiles Rect" do
    file_path = File.expand_path("../../rect/Rect.asm", __dir__)
    compiled_hack_program = File.read(File.expand_path("../../rect/Rect.hack", __dir__))
    expect(Assembler.translate(file_path)).to eq compiled_hack_program
  end

  it "compiles RectL" do
    file_path = File.expand_path("../../rect/RectL.asm", __dir__)
    compiled_hack_program = File.read(File.expand_path("../../rect/RectL.hack", __dir__))
    expect(Assembler.translate(file_path)).to eq compiled_hack_program
  end

  it "compiles Pong" do
    file_path = File.expand_path("../../pong/Pong.asm", __dir__)
    compiled_hack_program = File.read(File.expand_path("../../pong/Pong.hack", __dir__))
    expect(Assembler.translate(file_path)).to eq compiled_hack_program
  end

  it "compiles PongL" do
    file_path = File.expand_path("../../pong/PongL.asm", __dir__)
    compiled_hack_program = File.read(File.expand_path("../../pong/PongL.hack", __dir__))
    expect(Assembler.translate(file_path)).to eq compiled_hack_program
  end

  it "has a version number" do
    expect(Assembler::VERSION).not_to be nil
  end
end
