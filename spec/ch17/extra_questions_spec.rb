
require_relative '../spec_helper'
require_relative '../../lib/extra_questions'

describe "Modest questions" do
  describe "number of trailing zeros of factorial" do
    it "should return correct result" do
      # 15! = 1307674368000
      Ch17::count_fact_zeros(15).should == 3
    end
  end

  describe "max number of two without comparing" do
    it "should return the max number" do
      Ch17::get_max(10, 20).should == 20
      Ch17::get_max(-10, 20).should == 20
      Ch17::get_max(10, -20).should == 10
    end
  end
end
