require 'rake/testtask'

Rake::TestTask.new(:spec) do |t|
  t.libs << 'spec'
  t.pattern = 'spec/**/*_spec.rb'
end
task :default => :spec

task :coverage do
  `open coverage/index.html`
end
