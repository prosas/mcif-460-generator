# frozen_string_literal: true

# Classe Client
# -------------------
# Esta classe define um modelo simples com atributos acessíveis.
# Ela utiliza `attr_accessor` para permitir leitura e escrita dos atributos.
#
module MCIF460
  class Client
    attr_accessor :person_type,
                  :type_cpf_cnpj,
                  :cpf_cnpj,
                  :date_of_birth,
                  :name,
                  :personal_name_client,
                  :free_use,
                  :agile_management_number,
                  :agency,
                  :dv_client_agency,
                  :setex_group,
                  :dv_setex_group,
                  :pass_code,
                  :program_code,
                  :mci_client_code,
                  :process_number,
                  :sequence_number,
                  :relationship_agency,
                  :dv_relationship_agency,
                  :acount,
                  :dv_acount,
                  :person_type,
                  :type_cpf_cnpj,
                  :cpf_cnpj,
                  :date_of_birth,
                  :name,
                  :personal_name_client,
                  :free_use,
                  :agile_management_number,
                  :agency,
                  :dv_client_agency,
                  :setex_group,
                  :dv_setex_group,
                  :legal_nature,
                  :pass_code,
                  :program_code

    def initialize(options)
      self.person_type = options[:person_type]
      self.type_cpf_cnpj = options[:type_cpf_cnpj]
      self.cpf_cnpj = options[:cpf_cnpj]
      self.date_of_birth = options[:date_of_birth]
      self.name = options[:name]
      self.personal_name_client = options[:personal_name_client]
      self.free_use = options[:free_use]
      self.agile_management_number = options[:agile_management_number]
      self.agency = options[:agency]
      self.dv_client_agency = options[:dv_client_agency]
      self.setex_group = options[:setex_group]
      self.dv_setex_group = options[:dv_setex_group]
      self.pass_code = options[:pass_code]
      self.program_code = options[:program_code]
      self.mci_client_code = options[:mci_client_code]
      self.process_number = options[:process_number]
      self.sequence_number = options[:sequence_number]
      self.relationship_agency = options[:relationship_agency]
      self.dv_relationship_agency = options[:dv_relationship_agency]
      self.acount = options[:acount]
      self.dv_acount = options[:dv_acount]
      # Details
      self.person_type = options[:person_type]
      self.type_cpf_cnpj = options[:type_cpf_cnpj]
      self.cpf_cnpj = options[:cpf_cnpj]
      self.date_of_birth = options[:date_of_birth]
      self.name = options[:name]
      self.personal_name_client = options[:personal_name_client]
      self.free_use = options[:free_use]
      self.agile_management_number = options[:agile_management_number]
      self.agency = options[:agency]
      self.dv_client_agency = options[:dv_client_agency]
      self.setex_group = options[:setex_group]
      self.dv_setex_group = options[:dv_setex_group]
      self.legal_nature = options[:legal_nature]
      self.pass_code = options[:pass_code]
      self.program_code = options[:program_code]
    end
  end
end
