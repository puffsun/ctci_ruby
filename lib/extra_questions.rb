
require 'pry'
require 'pry-debugger'

module Ch17

  def self.count_fact_zeros(num)
    raise ArgumentError if num <= 0
    count = 0
    2.upto(num) do |i|
      count += count_fact_5(i)
    end
    count
  end

  private

  def self.count_fact_5(num)
    count = 0
    while num % 5 == 0
      count += 1
      num /= 5
    end
    count
  end

  public

  def self.get_max(x, y)
  end
end
