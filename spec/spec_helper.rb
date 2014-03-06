
Pathname.glob("#{File.dirname(__FILE__)}/../lib/**/*.rb").each do |f|
  require_relative f
end

module Helper
  def build_bst(ary)
    raise ArgumentError unless ary

  end

  def build_singular_linked_list(ary)
    raise ArgumentError unless ary
    root = Ch2::Node.new(ary.shift, nil)
    ary.each do |e|
      cur_node = Node.new(e, nil)
    end
  end
end
