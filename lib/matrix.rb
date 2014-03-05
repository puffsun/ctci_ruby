
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
end
