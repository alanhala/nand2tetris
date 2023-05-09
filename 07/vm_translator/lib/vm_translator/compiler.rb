# frozen_string_literal: true
require "securerandom"

module VmTranslator
  class Compiler
    def initialize(vm_file_name)
      @vm_file_name = vm_file_name
    end

    def compile(commands)
      compiled_assembly = commands.map { |command| command.accept(self) }.join
    end

    def visit_bootstrap(_command)
      <<~ASSEMBLY
        @256
        D = A
        @SP
        M = D
        @LCL
        MD = -1
        @ARG
        MD = D - 1
        @THIS
        MD = D - 1
        @THAT
        MD = D - 1
        #{visit_call(Commands::Call.new("Sys.init", 0)).strip}
      ASSEMBLY
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

    def visit_label_definition(command)
      full_label_name =
        if @current_function.nil?
          "#{@vm_file_name}$#{command.label_name}"
        else
          "#{@vm_file_name}.#{@current_function}$#{command.label_name}"
        end
      <<~ASSEMBLY
        (#{full_label_name})
      ASSEMBLY
    end

    def visit_goto(command)
      full_label_name =
        if @current_function.nil?
          "#{@vm_file_name}$#{command.label_name}"
        else
          "#{@vm_file_name}.#{@current_function}$#{command.label_name}"
        end
      <<~ASSEMBLY
        @#{full_label_name}
        0;JMP
      ASSEMBLY
    end

    def visit_if_goto(command)
      full_label_name =
        if @current_function.nil?
          "#{@vm_file_name}$#{command.label_name}"
        else
          "#{@vm_file_name}.#{@current_function}$#{command.label_name}"
        end
      <<~ASSEMBLY
        @SP
        M = M - 1
        A = M
        D = M
        @#{full_label_name}
        D;JNE
      ASSEMBLY
    end

    def visit_call(command)
      return_address = "call_return_#{SecureRandom.uuid.split('-').join}"
      push_return_address = <<~ASSEMBLY
        @#{return_address}
        D = A
        @SP
        M = M + 1
        A = M - 1
        M = D
      ASSEMBLY
      push_lcl = <<~ASSEMBLY
        @LCL
        D = M
        @SP
        M = M + 1
        A = M - 1
        M = D
      ASSEMBLY
      push_arg = <<~ASSEMBLY
        @ARG
        D = M
        @SP
        M = M + 1
        A = M - 1
        M = D
      ASSEMBLY
      push_this = <<~ASSEMBLY
        @THIS
        D = M
        @SP
        M = M + 1
        A = M - 1
        M = D
      ASSEMBLY
      push_that = <<~ASSEMBLY
        @THAT
        D = M
        @SP
        M = M + 1
        A = M - 1
        M = D
      ASSEMBLY
      set_arg_for_function_call = <<~ASSEMBLY
        D = A + 1
        @5
        D = D - A
        @#{command.arguments_number}
        D = D - A
        @ARG
        M = D
      ASSEMBLY
      set_lcl_for_function_call = <<~ASSEMBLY
        @SP
        D = M
        @LCL
        M = D
      ASSEMBLY
      go_to_function = <<~ASSEMBLY
        @#{command.function_name}
        0;JMP
      ASSEMBLY
      declare_return_address = <<~ASSEMBLY
        (#{return_address})
      ASSEMBLY
      [
        push_return_address,
        push_lcl,
        push_arg,
        push_this,
        push_that,
        set_arg_for_function_call,
        set_lcl_for_function_call,
        go_to_function,
        declare_return_address
      ].join
    end

    def visit_return(command)
      end_frame_label = "END_FRAME"
      store_end_frame_location = <<~ASSEMBLY
        @LCL
        D = M
        @#{end_frame_label}
        M = D
      ASSEMBLY
      store_return_address = <<~ASSEMBLY
        @5
        D = D - A
        A = D
        D = M
        @return_address
        M = D
      ASSEMBLY
      store_return_value = <<~ASSEMBLY
        @SP
        M = M - 1
        A = M
        D = M
        @ARG
        A = M
        M = D
      ASSEMBLY
      restore_sp_for_caller = <<~ASSEMBLY
        @ARG
        D = M
        @SP
        M = D + 1
      ASSEMBLY
      retore_that_for_caller = <<~ASSEMBLY
        @#{end_frame_label}
        M = M - 1
        A = M
        D = M
        @THAT
        M = D
      ASSEMBLY
      retore_this_for_caller = <<~ASSEMBLY
        @#{end_frame_label}
        M = M - 1
        A = M
        D = M
        @THIS
        M = D
      ASSEMBLY
      retore_arg_for_caller = <<~ASSEMBLY
        @#{end_frame_label}
        M = M - 1
        A = M
        D = M
        @ARG
        M = D
      ASSEMBLY
      retore_lcl_for_caller = <<~ASSEMBLY
        @#{end_frame_label}
        M = M - 1
        A = M
        D = M
        @LCL
        M = D
      ASSEMBLY
      go_to_return_address = <<~ASSEMBLY
        @return_address
        A = M
        0;JMP
      ASSEMBLY
      [
        store_end_frame_location,
        store_return_address,
        store_return_value,
        restore_sp_for_caller,
        retore_that_for_caller,
        retore_this_for_caller,
        retore_arg_for_caller,
        retore_lcl_for_caller,
        go_to_return_address
      ].join
    end

    def visit_function(command)
      @current_function = command.function_name
      <<~ASSEMBLY
        (#{command.function_name})
        @#{command.local_variables_number}
        D = A
        @i
        M = D
        (#{command.function_name}$LOCAL_VARIABLES_INIT_LOOP)
        @i
        D = M
        @#{command.function_name}$END_LOCAL_VARIABLES_INIT_LOOP
        D;JEQ
        @SP
        M = M + 1
        A = M - 1
        M = 0
        @i
        M = M - 1
        @#{command.function_name}$LOCAL_VARIABLES_INIT_LOOP
        0;JMP
        (#{command.function_name}$END_LOCAL_VARIABLES_INIT_LOOP)
      ASSEMBLY
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
        store_value_in_pointer("#{@vm_file_name}.#{index}")
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
        fetch_value_from_pointer("#{@vm_file_name}.#{index}")
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
