# frozen_string_literal: true
# Classe Client
# -------------------
# Esta classe define um modelo simples com atributos acessíveis.
# Ela utiliza `attr_accessor` para permitir leitura e escrita dos atributos.
# 
class Client
  attr_accessor :type_detail,
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
                :codigo_programa
end
