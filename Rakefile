require 'bundler/gem_tasks'

task :test do
	sh 'cucumber'
end

task :docs do
	sh 'rm -rf ./docs'
	sh 'rm README.rdoc'
	sh 'rdoc -f hanna lib'
	sh 'mv doc docs'
	sh 'cp README.md README.rdoc'
end