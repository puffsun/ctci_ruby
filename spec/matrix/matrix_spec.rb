
require_relative '../spec_helper'

describe "Dealing matrix" do
  describe "rotate matrix" do
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

=begin
    it "should rotate matrix in place" do
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

      Matrix.rotate_inplace(square)
      square.should == square_rotated

    end
=end

    describe "set each row and column as 0 if one of elements in it is 0" do
      it "should process matrix correctly" do
        square = [
          [2, 1, 4, 9],
          [9, 1, 1, 0],
          [7, 3, 1, 0],
          [8, 6, 5, 3]
        ]

        zeros = [
          [2, 1, 4, 0],
          [0, 0, 0, 0],
          [0, 0, 0, 0],
          [8, 6, 5, 0]
        ]

        Matrix::set_zero!(square).should == zeros
      end
    end
  end
end
