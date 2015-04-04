require 'pathname'

RSpec.configure do |config|
  config.expect_with :rspec do |c|
    c.syntax = [:should, :expect]
  end
end

Pathname.glob("#{File.dirname(__FILE__)}/../lib/**/*.rb").each do |f|
  require_relative f
end

module Helper
  def build_bst(ary)
    raise ArgumentError unless ary
  end
end
