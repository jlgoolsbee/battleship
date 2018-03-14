require 'rake'
require 'rspec/core/rake_task'

desc 'Run the tests'
RSpec::Core::RakeTask.new('test') do |t|
  t.pattern = Dir.glob(File.join('spec', '*_spec.rb'))
  t.rspec_opts = '--format documentation'
  t.rspec_opts += ' --format RspecJunitFormatter --out ./test_reports/rspec/junit.xml' if ENV['CI']
end

desc 'Default task runs the test task'
task default: [:test]
