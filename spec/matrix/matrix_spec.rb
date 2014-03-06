
require_relative '../spec_helper'

describe "Rotation" do
  it "shall rotate squares" do
    square = [
      [0, 1, 0, 0],
      [0, 1, 1, 0],
      [0, 0, 1, 0],
      [0, 0, 0, 0]
    ]

    square_rotated = [
      [0, 0, 0, 0],
      [0, 1, 1, 0],
      [1, 1, 0, 0],
      [0, 0, 0, 0]
    ]

    Matrix.rotate(square).should == square_rotated
  end

  it "shall rotate rectangles" do
    rectangle = [
      [0, 1, 0],
      [1, 1, 1]
    ]

    rectangle_rotated = [
      [0, 1],
      [1, 1],
      [0, 1]
    ]

    Matrix.rotate(rectangle).should == rectangle_rotated
  end
end
