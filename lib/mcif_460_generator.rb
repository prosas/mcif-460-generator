# frozen_string_literal: true

require "client"
module MCIF460
  class Generator
    require "tempfile"

    def initialize(output_file)
      @output_file = output_file
      @clients = []
    end

    def add_client(client)
      raise "invalid attribute" unless client.is_a?(MCIF460::Client)

      @clients << client
    end

    def generate_file
      file = Tempfile.new(@output_file)

      @clients.each_with_index do |client, _index|
        generate_header(file, client)
        generate_detail(file, client)
      end

      generate_trailer(file, @clients.length, 99) # verificar como fica a qdt de registros. o que é ?
      file.close

      file
    end

    def generate_header(file, client)
      # 000000024022025MCIF460
      file.write "0000000#{Time.now.strftime("%d%m%Y")}MCIF460"
      file.write mci_client_code(client.mci_client_code)
      file.write process_number(client.process_number)
      file.write sequence_number(client.sequence_number)
      file.write layout_version
      file.write relationship_agency(client.relationship_agency)
      file.write dv_relationship_agency(client.dv_relationship_agency)
      file.write acount(client.acount)
      file.write dv_acount(client.dv_acount)
      file.write kit_indicator
      file.write white_spaces(88)

      file
    end

    def generate_detail(file, client)
      file.write white_spaces(5)
      file.write type_detail
      file.write person_type(client.person_type)
      file.write type_cpf_cnpj(client.type_cpf_cnpj)
      file.write cpf_cnpj(client.cpf_cnpj)
      file.write date_of_birth(client.date_of_birth)
      file.write client_name(client.name)
      file.write personal_name_client(client.personal_name_client)
      file.write white_spaces(1)
      file.write free_use(client.free_use)
      file.write agile_management_number(client.agile_management_number)
      file.write client_agency(client.agency)
      file.write dv_client_agency(client.dv_client_agency)
      file.write setex_group(client.setex_group)
      file.write dv_setex_group(client.dv_setex_group)
      file.write legal_nature
      file.write pass_code(client.pass_code)
      file.write program_code(client.program_code)

      file
    end

    def mci_client_code(code)
      mandatory_field(code)
      validate_size(code, 9)
      validate_numeric(code)

      code.rjust(9, "0")
    end

    # Número_Processo
    def process_number(code = "00000")
      mandatory_field(code)
      validate_numeric(code)

      code.rjust(5, "0")
    end

    # Sequencial_Remessa
    def sequence_number(code = "00000")
      mandatory_field(code)
      validate_numeric(code)

      code.rjust(5, "0")
    end

    # Versão_Leiaute - valor fixo
    def layout_version
      "04"
    end

    # Agência_Relacionamento
    def relationship_agency(code = "0000")
      mandatory_field(code)
      validate_numeric(code)

      code.rjust(4, "0")
    end

    # DV_Agência_Relacionamento
    def dv_relationship_agency(code = "0")
      mandatory_field(code)
      validate_numeric(code)

      code.rjust(1, "0")
    end

    # Conta
    def acount(code = "00000000000")
      mandatory_field(code)
      validate_numeric(code)

      code.rjust(11, "0")
    end

    # DV Conta
    def dv_acount(code = "0")
      mandatory_field(code)
      validate_numeric(code)

      code.rjust(11, "0")
    end

    # Indicador_Envio_KIT - fixo 1
    def kit_indicator
      "1"
    end

    def white_spaces(spaces)
      "".rjust(spaces, " ")
    end

    # Detail
    def type_detail
      "01"
    end

    # Tipo_Pessoa - VIDE TABELA
    # 1	Física	E	Soc Economia Mista GDF
    # 2	PJ Privada	F	Fundação Estadual
    # 3	Governo Municipal - Adm Direta (FUNDOS ESTADUAIS)	G	Fundação Municipal
    # 4	Governo Estadual - Adm Direta	H	Fundação Estadual GDF
    # 5	Governo Federal - Adm Direta	I	Governo Estadual GDF - Adm Direta
    # 6	Empresa Pública Federal	J	Autarquia Federal
    # 7	Soc de Economia Mista Federal	K	Autarquia Estadual
    # 8	Fundação Federal	L	Autarquia Estadual GDF
    # 9	Empresa Pública Estadual	M	Autarquia Municipal
    # A	Empresa Pública Municipal	N	Inst/Entidade Publica Municipal
    # B	Empresa Pública GDF	O	Inst/Entidade Publica Estadual
    # C	Soc Economia Mista Estadual   	P	Inst/Entidade Publica Federal
    # D	Soc Economia Mista Municipal
    # E	Soc Economia Mista GDF
    # F	Fundação Estadual
    # G	Fundação Municipal
    # H	Fundação Estadual GDF
    # I	Governo Estadual GDF - Adm Direta
    # J	Autarquia Federal
    # K	Autarquia Estadual
    # L	Autarquia Estadual GDF
    # M	Autarquia Municipal
    # N	Inst/Entidade Publica Municipal
    # O	Inst/Entidade Publica Estadual
    # P	Inst/Entidade Publica Federal

    def person_type(type)
      type_formated = type.to_s.upcase
      return raise "invalide code to person type" if type_formated.match(/\A[A-P1-9]\z/).nil?

      type_formated
    end

    # Tipo de CPF/CNPJ -Fixo "1" para CPF Próprio, ou  "2" para CPF não Próprio, ou "3" para CNPJ
    def type_cpf_cnpj(type)
      return raise "invalide code to person type CPF/CNPJ" unless %w[1 2 3].include?(type.to_s)

      type
    end

    def cpf_cnpj(value)
      return raise "invalide cpf or cnpj" if !validate_numeric(value) || (value.length != 14 && value.length != 11)

      value.rjust(14, "0")
    end

    # Data_de_nascimento
    def date_of_birth(date)
      return raise "invalid date" if !validate_numeric(date) || date.length != 8

      date
    end

    # Nome_Cliente
    def client_name(name)
      name.ljust(60, " ")
    end

    # Nome_Personalizado_Cliente
    def personal_name_client(name)
      name.ljust(25, " ")
    end

    # Uso_Cliente
    def free_use(text)
      text.ljust(8, " ")[0..8]
    end

    # Numero_Programa_Gestão_Agil
    def agile_management_number(num)
      validate_alphanumeric(num)

      num.rjust(9, "0")
    end

    # Agência_Cliente
    def client_agency(ag)
      validate_numeric(ag)
      return raise "Invalid client Agency" if ag.to_s.length > 4

      ag.rjust(4, "0")
    end

    # DV_Agência_Cliente
    def dv_client_agency(code)
      return raise "invalid DV Agency" if code.to_s.length != 1 || !validate_numeric(code)

      code
    end

    # Grupo_Setex
    def setex_group(code)
      validate_numeric(code)
      return raise "Mandatory value. 2 digits" if code.length != 2

      code
    end

    # DV_Grupo Setex
    def dv_setex_group(code)
      validate_numeric(code)
      return raise "Mandatory value. 1 digits" if code.length != 1

      code
    end

    # Natureza_Jurídica
    def legal_nature
      "000"
    end

    # Código_Repasse -  Fixo "01" para Voluntário/Convênio OU "02" para Automático/Fundo a Fundo
    def pass_code(code)
      return raise "Invalide code" unless %w[01 02].include?(code.to_s)

      code
    end

    # Código_Programa
    def program_code(code)
      validate_numeric(code)
      raise "Invalide program code" if code.length > 3

      code.rjust(9, "0")
    end

    def generate_trailer(file, total_clients, quantity_registries)
      return raise "invalid trailer" if !validate_numeric(total_clients) || !validate_numeric(quantity_registries)

      constante = "9999999"
      total = total_clients.to_s.rjust(5, "0")
      # Quantidade_Registros - Total de Registros (inclusive HEADER e TRAILER)
      quantity_registries.to_s.ljust(9, " ")
      file.write "#{constante}#{total}#{quantity_registries}".ljust(129, " ")

      file
    end

    def validate_alphanumeric(string)
      return raise "invalide data" if string.match(/\A[a-zA-Z0-9]*\z/).nil?

      true
    end

    def validate_numeric(string)
      raise "invalide data" if string.to_s.match(/\A[0-9]*\z/).nil?

      true
    end

    def mandatory_field(code)
      raise "mandatory field" if code.nil?
    end

    def validate_size(text, max)
      return true if text.to_s.length <= max

      raise "Size error"
    end
  end
end
