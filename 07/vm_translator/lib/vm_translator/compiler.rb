module VmTranslator
  class Compiler
    def initialize(vm_file_path)
      @vm_file_path = vm_file_path
    end

    def compile(commands)
      compiled_assembly = commands.map { |command| command.accept(self) }.join
      File.write(@vm_file_path.gsub(".vm", ".asm"), compiled_assembly)
    end

    def visit_add(_command)
      binary("+")
    end

    def visit_and(_command)
      binary("&")
    end

    def visit_eq(command)
      conditional("JEQ", command.line)
    end

    def visit_gt(command)
      conditional("JGT", command.line)
    end

    def visit_lt(command)
      conditional("JLT", command.line)
    end

    def visit_neg(_command)
      unary("-")
    end

    def visit_not(_command)
      unary("!")
    end

    def visit_or(_command)
      binary("|")
    end

    def visit_pop(command)
      <<~ASSEMBLY
        @SP
        M = M - 1
        #{store_value_in_segment(command.segment, command.index).strip}
      ASSEMBLY
    end

    def visit_push(command)
      <<~ASSEMBLY
        #{store_segment_in_d(command.segment, command.index).strip}
        @SP
        M = M + 1
        A = M - 1
        M = D
      ASSEMBLY
    end

    def visit_sub(_command)
      binary("-")
    end

    private

    def binary(operator)
      <<~ASSEMBLY
        @SP
        M = M - 1
        A = M
        D = M
        @SP
        M = M - 1
        A = M
        M = M #{operator} D
        @SP
        M = M + 1
      ASSEMBLY
    end

    def conditional(jump_condition, line)
      <<~ASSEMBLY
        @SP
        M = M - 1
        A = M
        D = M
        @SP
        M = M - 1
        A = M
        D = M - D
        @#{jump_condition}_#{line}
        D;#{jump_condition}
        @SP
        M = M + 1
        A = M - 1
        M = 0
        @END_#{jump_condition}_#{line}
        0;JMP
        (#{jump_condition}_#{line})
        @SP
        M = M + 1
        A = M - 1
        M = -1
        (END_#{jump_condition}_#{line})
      ASSEMBLY
    end

    def unary(operator)
      <<~ASSEMBLY
        @SP
        A = M - 1
        M = #{operator}M
      ASSEMBLY
    end

    def store_value_in_segment(segment, index)
      case segment
      when "argument"
        store_value_in_array("ARG", index)
      when "local"
        store_value_in_array("LCL", index)
      when "static"
        store_value_in_pointer("#{File.basename(@vm_file_path, ".vm")}.#{index}")
      when "constant"
        raise("Can't pop value to constant")
      when "this"
        store_value_in_array("THIS", index)
      when "that"
        store_value_in_array("THAT", index)
      when "pointer"
        raise("Overflow") if index > 1

        store_value_in_pointer("R#{3 + index}")
      when "temp"
        raise("Overflow") if index > 8

        store_value_in_pointer("R#{5 + index}")
      end
    end

    def store_segment_in_d(segment, index)
      case segment
      when "argument"
        fetch_value_from_array("ARG", index)
      when "local"
        fetch_value_from_array("LCL", index)
      when "static"
        fetch_value_from_pointer("#{File.basename(@vm_file_path, ".vm")}.#{index}")
      when "constant"
        <<~ASSEMBLY
          @#{index}
          D = A
        ASSEMBLY
      when "this"
        fetch_value_from_array("THIS", index)
      when "that"
        fetch_value_from_array("THAT", index)
      when "pointer"
        raise("Overflow") if index > 1

        fetch_value_from_pointer("R#{3 + index}")
      when "temp"
        raise("Overflow") if index > 8

        fetch_value_from_pointer("R#{5 + index}")
      end
    end

    def store_value_in_array(pointer_ram_location, array_index)
      <<~ASSEMBLY
        @#{array_index}
        D = A
        @#{pointer_ram_location}
        D = M + D
        @R13
        M = D
        @SP
        A = M
        D = M
        @R13
        A = M
        M = D
      ASSEMBLY
    end

    def store_value_in_pointer(pointer_ram_location)
      <<~ASSEMBLY
        A = M
        D = M
        @#{pointer_ram_location}
        M = D
      ASSEMBLY
    end

    def fetch_value_from_array(pointer_ram_location, array_index)
      <<~ASSEMBLY
        @#{array_index}
        D = A
        @#{pointer_ram_location}
        A = M + D
        D = M
      ASSEMBLY
    end

    def fetch_value_from_pointer(pointer_ram_location)
      <<~ASSEMBLY
        @#{pointer_ram_location}
        D = M
      ASSEMBLY
    end
  end
end
