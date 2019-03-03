
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "ulidtools/version"

Gem::Specification.new do |spec|
  spec.name          = "ulidtools"
  spec.version       = ULIDTools::VERSION
  spec.authors       = ["Justin Piotroski"]
  spec.email         = ["justin.piotroski@gmail.com"]

  spec.summary       = %q{A Feature-Rich ULID Implementation}
  spec.homepage      = "https://github.com/jtp184/ulidtools"
  spec.license       = "MIT"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "base32-crockford", "~> 0.1.0"

  spec.add_development_dependency "bundler", "~> 1.17"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "cucumber", "~> 3.1.2"
  spec.add_development_dependency "factory_bot", "~> 5.0.2"
  spec.add_development_dependency "rubocop"
  spec.add_development_dependency "timecop"
  spec.add_development_dependency "rdoc"
end
