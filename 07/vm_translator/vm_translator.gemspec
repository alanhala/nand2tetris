# frozen_string_literal: true

require_relative "lib/vm_translator/version"

Gem::Specification.new do |spec|
  spec.name = "vm_translator"
  spec.version = VmTranslator::VERSION
  spec.authors = ["Alan Halatian"]
  spec.email = ["alanhalatian@gmail.com"]

  spec.summary = "VM Translator to Hack machine."
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.2.1"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:bin|test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  # spec.add_dependency "example-gem", "~> 1.0"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
  spec.metadata["rubygems_mfa_required"] = "true"
end
