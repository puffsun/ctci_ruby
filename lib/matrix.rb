
module Matrix

  def self.rotate(matrix)
    self.rotate_counterclockwise(matrix)
  end

  def self.rotate_counterclockwise(matrix)
    n = []
    height = matrix.size
    width = matrix[0].size
    (width - 1).downto(0) { |i|
      line = []
      height.times { |j|
        line << matrix[j][i]
      }
      n << line
    }
    n
  end

  def self.rotate_clockwise(matrix)
    n = []
    height = matrix.size
    width = matrix[0].size
    width.times { |i|
      line = []
      height.times { |j|
        line << matrix[j][i]
      }
      n << line
    }
    n
  end

  # Given an image represented by an NxN matrix, where each pixel
  # in the image is 4 bytes, write a method to rotate the image
  # by 90 degrees. Can you do this in place?
  def self.rotate_inplace(matrix)
    raise ArgumentError unless matrix
    length = matrix.length
    for layer in 0...length/2
      first = layer
      last = length - 1 - layer
      for i in first...last
        offset = i - first
        top = matrix[first][i]
        matrix[first][i] = matrix[last - offset][first]
        matrix[last - offset][first] = matrix[last][last - offset]
        matrix[last][last - offset] = matrix[i][last]
        matrix[i][last] = top
      end
    end
  end

  # Write an algorithm such that if an element in an MxN matrix is 0,
  # its entire row and column are set to 0.
  def self.set_zero!(matrix)
    rows = []
    cols = []
    matrix.each_with_index do |a, i|
      a.each_with_index do |e, j|
        if e == 0
          rows[i] = true
          cols[j] = true
        end
      end
    end

    matrix.each_with_index do |a, i|
      a.each_with_index do |e, j|
        matrix[i][j] = 0 if rows[i] or cols[j]
      end
    end
    matrix
  end
end
