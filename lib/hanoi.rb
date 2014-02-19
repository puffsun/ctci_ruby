
require_relative 'stack'

module Ch3
  class HanoiTower
    attr_reader :index

    def initialize(index)
      @index = index
      @disks = Ch3::Stack.new
    end

    # n     the number n disk
    # dst   destination tower
    # buff  buffer tower
    def move_disk(n, dst, buff)
      if n > 0
        move_disk(n - 1, buff, dst)
        move_top_to(dst)
        buff.move_disk(n - 1, dst, self)
      end
    end

    # t   tower
    def move_top_to(t)
      top = @disks.pop
      t.add(top)
      puts "Move disk #{top} from #{index} to #{t.index}"
    end

    def add(disk)
      if !@disks.empty? and @disks.peek < disk
        raise StandardError, "You cannot put larger disk above small one"
      else
        @disks.push(disk)
      end
      self
    end
  end
end

if __FILE__ == $0
  towers = []
  # 3 disks total
  3.times do |i|
    towers << Ch3::HanoiTower.new(i)
  end
  towers[0].add(2).add(1).add(0)
  towers[0].move_disk(3, towers[2], towers[1])
end
