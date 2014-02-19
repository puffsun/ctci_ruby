require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:spec) do |t|
  t.verbose = true
  t.pattern = Dir['./spec/*_spec.rb'].sort
  #task.rspec_opts = Dir.glob("[0-9][0-9][0-9]_*").collect { |x| "-I#{x}" }
  t.rspec_opts = '--color'
  #t.rspec_opts << ' -f d'
end

task :default => :spec
