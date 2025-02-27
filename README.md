# mcif-460-generator
MCIF 460 Generator is a Ruby gem that generates files in the MCIF 460 format. It provides an easy-to-use API for defining and exporting data while ensuring compliance with the MCIF 460 standard. Ideal for applications requiring structured file output in this format.

<!-- Com deve se usada a Gem -->

1. instalar a gem 
gem install mcif-460-generator

2. require 'mcif_460_generator'

 client = MCIF460::Client.new (client_attributes)

 generator = MCIF460::Generator.new(path_output_file)

generator.add_client(client)

file_mcif460 = generator.generate_file