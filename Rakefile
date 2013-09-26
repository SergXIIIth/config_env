require "bundler/gem_tasks"

pattern = '{**/*.rb,**/*.slim,**/*.coffee}'

task 'test' do
  system %Q(bundle exec rerun --pattern '#{pattern}' -cx rspec)
end
