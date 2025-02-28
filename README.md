# MCIF 460 Generator

MCIF 460 Generator is a Ruby gem that generates files in the MCIF 460 format. It provides an easy-to-use API for defining and exporting data while ensuring compliance with the MCIF 460 standard. Ideal for applications requiring structured file output in this format.

## Installation

To install the gem, run:

```sh
gem install mcif-460-generator
```

## Usage

Require the gem in your Ruby script:

```ruby
require 'mcif_460_generator'
```

### Example Usage

```ruby
# Initialize a client with the required attributes
client = MCIF460::Client.new(client_attributes)

# Create a generator instance with the output file path
generator = MCIF460::Generator.new(path_output_file)

# Add client data to the generator
generator.add_client(client)

# Generate the MCIF 460 file
file_mcif460 = generator.generate_file
```

This will create a properly formatted MCIF 460 file at the specified path.
