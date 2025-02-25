# frozen_string_literal: true

require_relative "lib/generator/version"

Gem::Specification.new do |spec|
  spec.name = "mcif-460-generator"
  spec.version = Generator::VERSION
  spec.authors = ["raphael-souza"]
  spec.email = ["raphael3130@gmail.com"]

  spec.summary = "Criar um arquivo com informações compatíveis com o padrão MCIF 460."
  spec.description = "Preencher um arquivo com clientes que desejam criar uma conta bancária em uma instituição financeira que 
  aceito o formato MCIF 460"
  spec.homepage = "https://github.com/prosas/mcif-460-generator"
  spec.required_ruby_version = ">= 3.1.0"

  spec.metadata["allowed_push_host"] = "TODO: Set to your gem server 'https://example.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["changelog_uri"] = spec.homepage

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  gemspec = File.basename(__FILE__)
  spec.files = IO.popen(%w[git ls-files -z], chdir: __dir__, err: IO::NULL) do |ls|
    ls.readlines("\x0", chomp: true).reject do |f|
      (f == gemspec) ||
        f.start_with?(*%w[bin/ test/ spec/ features/ .git appveyor Gemfile])
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  # spec.add_dependency "example-gem", "~> 1.0"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
