require 'bundler/gem_tasks'

task :test do
	sh 'cucumber'
end

task :docs do
	sh 'rm -rf ./docs'
	sh 'rm README.rdoc'
	sh 'cp README.md README.rdoc'
	sh 'rdoc --format=hanna --all lib'
	sh 'mv doc docs'
end