# frozen_string_literal: true

require "minitest/autorun"
require "mcif_460_generator"
require "byebug"
require "tempfile"

module MCIF460
  class GeneratorTest < Minitest::Test
    def setup
      data_client = {
        person_type: "A",
        type_cpf_cnpj: "1",
        cpf_cnpj: "12312312344",
        date_of_birth: "01011999",
        name: "Jhon Snow",
        personal_name_client: "Jhon Snow",
        free_use: "hakuna matata",
        agile_management_number: "123",
        agency: "1122",
        dv_client_agency: "2",
        setex_group: "11",
        dv_setex_group: "2",
        pass_code: "02",
        program_code: "123",
        mci_client_code: "12356",
        process_number: "4565",
        sequence_number: "456",
        relationship_agency: "5576",
        dv_relationship_agency: "9",
        acount: "1234567890",
        dv_acount: "1"
      }
      t = Tempfile.new("test_file.txt")
      @generator = MCIF460::Generator.new(t.path)
      @client = MCIF460::Client.new(data_client)
    end

    def test_generate_file_success
      @generator.add_client(@client)
      file = @generator.generate_file
      assert File.exist?(file.path)
      File.delete(file.path)
    end

    def test_valid_person_types
      valid_types = ("A".."P").to_a + (1..9).to_a.map(&:to_s)
      valid_types.each do |type|
        assert_equal type.upcase, @generator.person_type(type)
      end
    end

    def test_invalid_person_types
      invalid_types = ["Q", "0", "@", nil, ""]
      invalid_types.each do |type|
        assert_raises(RuntimeError) { @generator.person_type(type) }
      end
    end

    def test_edge_cases
      assert_raises(RuntimeError) { @generator.person_type(nil) }
      assert_raises(RuntimeError) { @generator.person_type("") }
      assert_raises(RuntimeError) { @generator.person_type(" ") }
    end

    def test_mci_client_code_valid_numeric_code_less_than_9_digits
      code = "123"
      expected_result = "000000123"
      assert_equal expected_result, @generator.mci_client_code(code)
    end

    def test_mci_client_code_valid_numeric_code_exactly_9_digits
      code = "123456789"
      expected_result = "123456789"
      assert_equal expected_result, @generator.mci_client_code(code)
    end

    def test_mci_client_code_invalid_numeric_code_more_than_9_digits
      assert_raises(RuntimeError) { @generator.mci_client_code(" ") }
    end

    def test_process_number_valid
      code = "1234"
      expected_result = "01234"
      assert(expected_result) { @generator.process_number(code) }
    end

    def test_white_spaces
      assert("000") { @generator.white_spaces(3) }
    end

    def test_valid_inputs
      assert_equal "1", @generator.type_cpf_cnpj("1")
      assert_equal "2", @generator.type_cpf_cnpj("2")
      assert_equal "3", @generator.type_cpf_cnpj("3")
    end

    def test_invalid_inputs_type_cpf_cnpj
      assert_raises RuntimeError do
        @generator.type_cpf_cnpj("4")
      end
      assert_raises RuntimeError do
        @generator.type_cpf_cnpj("a")
      end
      assert_raises RuntimeError do
        @generator.type_cpf_cnpj("")
      end
      assert_raises RuntimeError do
        @generator.type_cpf_cnpj(nil)
      end
    end

    def test_valid_cpf
      assert_equal "00012345678901", @generator.cpf_cnpj("12345678901")
    end

    def test_valid_cnpj
      assert_equal "12345678901234", @generator.cpf_cnpj("12345678901234")
    end

    def test_invalid_cpf_cnpj
      assert_raises(RuntimeError) { @generator.cpf_cnpj("123456789012345") }
    end

    def test_non_integer_value_cpf_cnpj
      assert_raises(RuntimeError) { @generator.cpf_cnpj("abc123") }
    end

    def test_free_use
      assert_equal "ola foo ", @generator.free_use("ola foo")
    end

    def test_valid_alphanumeric_string
      assert_equal true, @generator.validate_alphanumeric("abc123")
    end

    def test_invalid_string_with_special_characters
      assert_raises(RuntimeError) { @generator.validate_alphanumeric("abc!23") }
    end

    def test_invalid_string_with_whitespace
      assert_raises(RuntimeError) { @generator.validate_alphanumeric("abc 23") }
    end

    def test_pass_code_valid_01
      assert_equal "01", @generator.pass_code("01")
    end

    def test_pass_code_valid_02
      assert_equal "02", @generator.pass_code("02")
    end

    def test_pass_code_invalid_03
      assert_raises(RuntimeError) { @generator.pass_code("03") }
    end

    def test_generate_trailer_valid_input
      total_clients = 10
      quantity_registries = 20
      const = "9999999"
      file = Tempfile.new('')
      expected_output = "#{const}#{"10".rjust(5, "0")}#{"20".ljust(9, " ")}".ljust(129, " ")
 

      # ajustar teste
      assert_equal expected_output, File.read(@generator.generate_trailer(file, total_clients, quantity_registries).path)
    end

    def test_generate_trailer_invalid_input
      total_clients = "abc"
      quantity_registries = "def"
      file = Tempfile.new('')
      assert_raises(RuntimeError) { @generator.generate_trailer(file, total_clients, quantity_registries) }
    end
  end
end
