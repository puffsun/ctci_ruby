

require_relative 'spec_helper'
require_relative '../../lib/hanoi'

describe Ch3::HanoiTower do
  let(:hanoi) {Ch3::HanoiTower.new(0)}

  it "should support move operations" do
    hanoi.should be_an_instance_of Ch3::HanoiTower
    hanoi.should respond_to(:move_disk)
    hanoi.should respond_to(:move_top_to)
  end
end
