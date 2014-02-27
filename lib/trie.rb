# Inspired by http://www.rubyquiz.com/quiz103.html
# cf. also http://en.wikipedia.org/wiki/Trie

#!/usr/local/bin/ruby -w

require 'pp'

class Hash

  def deep_merge!(second)
    # cf. http://snippets.dzone.com/posts/show/4146
    merger = proc { |key,v1,v2| Hash === v1 && Hash === v2 ? v1.merge(v2, &merger) : v2 }
    self.merge!(second, &merger)
  end

  def nested_hash(array)
    node = self
    array.each do |i|
      node[i]=Hash.new if node[i].nil?
      node = node[i]
    end
    self
  end

  def merge_nested_hash!(nested_hash)
    deep_merge!(nested_hash)
  end

  # code basis taken from: "Find every path and it's value in a Hash" by Florian AÃÅ¸mann,
  # http://snippets.dzone.com/posts/show/3565

  def each_trie_path
    raise ArgumentError unless block_given?
    self.class.each_trie_path(self) { |path, object| yield(path, object) }
  end

  protected
  def self.each_trie_path(object, path = [], &block)

    if object.is_a?(Hash)
      object.each do |key, value|

        if key == true && value == {}
          if path == [:root]  # special case for empty string: [[:root], {true=>{}}]
            yield(path, {true=>{}})
            next
          end
          yield(path, object)
        end

        self.each_trie_path(value, [path , key].flatten, &block)
      end
    else
      yield(path, object)
    end
  end

end


class Trie

  @hash = Hash.new.merge_nested_hash!(Hash.new)
  #@hash = Hash.new.merge_nested_hash!({:root=>{}})
  #@hash = Hash.new.merge_nested_hash!(Hash.new.nested_hash([:root]))
  class << self; attr_accessor :hash; end    # Trie.hash

  def initialize
    Trie.hash.merge_nested_hash!({:root=>{}})
  end


  def add_int(int)   # for int >= 0
    ia = int.to_s.scan(/[[:digit:]]/).map { |i| i.to_i }  # integer array; ex: [4,6,2]
    ia.unshift(:root).push(true)
    Trie.hash.merge_nested_hash!(Hash.new.nested_hash(ia))
  end

  def matchi(int)  # match integer
    ia = int.to_s.scan(/[[:digit:]]/).map { |i| i.to_i }
    node = Trie.hash.fetch(:root,nil)
    ia.each do |digit|
      node = node[digit]
      #node = node.fetch(digit,nil)
      return false unless node
    end
    node.fetch(true,nil) ? true : false
  end

  def mfpi(int)   # match first part of integer
    ia = int.to_s.scan(/[[:digit:]]/).map { |i| i.to_i }
    node = Trie.hash.fetch(:root,nil)
    ia.each do |digit|
      node = node[digit]
      return false unless node
    end
    return true
  end


  def add_word(word)
    ca = word.split(//u)    # UTF-8 aware character array
    ca.unshift(:root).push(true)
    Trie.hash.merge_nested_hash!(Hash.new.nested_hash(ca))
  end

  def match(word)   # match entire word
    ca = word.split(//u)
    node = Trie.hash.fetch(:root,nil)
    ca.each do |char|
      node = node[char]
      #node = node.fetch(char,nil)
      return false unless node
    end
    node.fetch(true,nil) ? true : false
  end

  def mfpw(word)   # match first part of word
    ca = word.split(//u)
    node = Trie.hash.fetch(:root,nil)
    ca.each do |char|
      node = node[char]
      return false unless node
    end
    return true
  end

end


trie = Trie.new
p Trie.hash

trie.add_word("word")
pp Trie.hash
p trie.match("word")
p trie.match("word2")
trie.add_word("word2")
p trie.match("word2")
pp Trie.hash            # {:root=>{"w"=>{"o"=>{"r"=>{"d"=>{true=>{}, "2"=>{true=>{}}}}}}}}

trie.add_word("")
p trie.match("")
pp Trie.hash

puts

p trie.match("word")
p trie.mfpw("wor")     # match first part of word

puts

trie.add_int(12345)
p Trie.hash

trie.add_int(12980345)
pp Trie.hash

trie.add_int(8512)
pp Trie.hash
p trie.matchi(8512)
p trie.matchi(85)
p trie.mfpi(85)     # match first part of integer
p trie.matchi(51)

puts

puts
pp Trie.hash
paths = []
Trie.hash.each_trie_path { |path, value| paths.push([ path ]) }
#Trie.hash.each_trie_path { |path, value| paths.push([ path, value ]) }
#pp paths
puts
paths.each { |x| p x }
puts


#------------------------------------------------------


require 'pp'

class Hash
  def Hash.new_nested_hash
    Hash.new{|h,k| h[k]=Hash.new(&h.default_proc) }
  end
end


class Trie

  @hash = Hash.new_nested_hash
  #@hash = Hash.new_nested_hash.update(true=>{})  # add empty string by default
  class << self; attr_accessor :hash; end    # Trie.hash

  def <<(word)
    ca = word.split(//u)    # UTF-8 aware character array
    wl = ca.size            # word length
    str = ""
    wl.times { |x| str << "[ca.at(#{x})]" }
    str = "Trie.hash" << str << "[true]"
    #p str     # example: "Trie.hash[ca.at(0)][ca.at(1)][ca.at(2)][ca.at(3)][true]"
    eval(str)
  end


  def match(word)
    ca = word.split(//u)    # UTF-8 aware character array
    wl = ca.size            # word length
    str = ""

    wl.times { |x| str << ".fetch(ca.at(#{x}),nil)" }
    str = "Trie.hash" << str << ".fetch(true,nil)"
    #p str   # example: "Trie.hash.fetch(ca.at(0),nil).fetch(ca.at(1),nil).fetch(ca.at(2),nil).fetch(true,nil)"
    ret = eval(str) rescue nil

=begin
      # alternative
      wl.times { |x| str << ".fetch(ca.at(#{x}),{})" }
      str = "Trie.hash" << str << ".fetch(true,nil)"
      #p str   # example: "Trie.hash.fetch(ca.at(0),{}).fetch(ca.at(1),{}).fetch(ca.at(2),{}).fetch(true,nil)"
      ret = eval(str)
=end

    ret == {} ? true : false   # {} is the default value created by Trie.hash or Hash.new_nested_hash respectively
  end

end


trie = Trie.new
trie << "word"
pp Trie.hash
p trie.match("word")
p trie.match("word2")
trie << "word2"
p trie.match("word2")
pp Trie.hash            # {"w"=>{"o"=>{"r"=>{"d"=>{true=>{}, "2"=>{true=>{}}}}}}}

trie << ""
p trie.match("")
pp Trie.hash


#------------------------------------------


# alternative with default :root element

require 'pp'

class Hash
  def Hash.new_nested_hash
    Hash.new{|h,k| h[k]=Hash.new(&h.default_proc) }
  end
end


class Hash

  # code basis taken from: "Find every path and it's value in a Hash" by Florian AÃÅ¸mann,
  # http://snippets.dzone.com/posts/show/3565

  def each_trie_path
    raise ArgumentError unless block_given?
    self.class.each_trie_path(self) { |path, object| yield(path, object) }
  end

  protected
  def self.each_trie_path(object, path = [], &block)

    if object.is_a?(Hash)
      object.each do |key, value|

        if key == true && value == {}
          if path == [:root]  # special case for empty string: [[:root], {true=>{}}]
            yield(path, {true=>{}})
            next
          end
          yield(path, object)
        end

        self.each_trie_path(value, [path , key].flatten, &block)
      end
    else
      yield(path, object)
    end
  end

end


class Trie

  @hash = Hash.new_nested_hash
  class << self; attr_accessor :hash; end    # Trie.hash

  def initialize
    Trie.hash[:root]
  end


  def add_int(int)   # for int >= 0
    ia = int.to_s.scan(/[[:digit:]]/).map { |i| i.to_i }  # integer array; ex: [4,6,2]
    ia.unshift(:root)
    str = ""
    ia.size.times { |x| str << "[ia.at(#{x})]" }
    str = "Trie.hash" << str << "[true]"
    eval(str)
  end

  def matchi(int)  # match integer
    ia = int.to_s.scan(/[[:digit:]]/).map { |i| i.to_i }
    node = Trie.hash.fetch(:root,nil)
    ia.each do |digit|
      node = node.fetch(digit,nil)
      return false unless node
    end
    node.fetch(true,nil) ? true : false
  end

  def mfpi(int)   # match first part of integer
    ia = int.to_s.scan(/[[:digit:]]/).map { |i| i.to_i }
    node = Trie.hash.fetch(:root,nil)
    ia.each do |digit|
      node = node.fetch(digit,nil)
      return false unless node
    end
    return true
  end


  def <<(word)
    ca = word.split(//u)    # UTF-8 aware character array
    ca.unshift(:root)
    #ca = [:root, *word.split(//u)]
    #ca = [:root].concat(word.split(//u))
    str = ""
    ca.size.times { |x| str << "[ca.at(#{x})]" }
    str = "Trie.hash" << str << "[true]"
    #p str     # example: "Trie.hash[ca.at(0)][ca.at(1)][ca.at(2)][ca.at(3)][true]"
    eval(str)
  end

  def match(word)
    ca = word.split(//u)
    ca.unshift(:root)
    #ca = [:root, *word.split(//u)]
    #ca = [:root].concat(word.split(//u))
    str = ""
    ca.size.times { |x| str << ".fetch(ca.at(#{x}),nil)" }
    str = "Trie.hash" << str << ".fetch(true,nil)"
    #p str   # example: "Trie.hash.fetch(ca.at(0),nil).fetch(ca.at(1),nil).fetch(ca.at(2),nil).fetch(true,nil)"
    ret = eval(str) rescue nil

=begin
      # alternative
      ca.size.times { |x| str << ".fetch(ca.at(#{x}),{})" }
      str = "Trie.hash" << str << ".fetch(true,nil)"
      #p str   # example: "Trie.hash.fetch(ca.at(0),{}).fetch(ca.at(1),{}).fetch(ca.at(2),{}).fetch(true,nil)"
      ret = eval(str)
=end

    ret == {} ? true : false   # {} is the default value created by Trie.hash or Hash.new_nested_hash respectively
  end

  def match2(word)   # match entire word
    ca = word.split(//u)
    node = Trie.hash.fetch(:root,nil)
    ca.each do |char|
      node = node.fetch(char,nil)
      return false unless node
    end
    node.fetch(true,nil) ? true : false
  end

  def mfpw(word)   # match first part of word
    ca = word.split(//u)
    node = Trie.hash.fetch(:root,nil)
    ca.each do |char|
      node = node.fetch(char,nil)
      return false unless node
    end
    return true
  end

end


trie = Trie.new
trie << "word"
pp Trie.hash
p trie.match("word")
p trie.match("word2")
trie << "word2"
p trie.match("word2")
pp Trie.hash            # {:root=>{"w"=>{"o"=>{"r"=>{"d"=>{true=>{}, "2"=>{true=>{}}}}}}}}

trie << ""
p trie.match("")
pp Trie.hash

puts

p trie.match2("word")
p trie.mfpw("wor")     # match first part of word

puts

trie.add_int(8512)
pp Trie.hash
p trie.matchi(8512)
p trie.matchi(85)
p trie.mfpi(85)     # match first part of integer
p trie.matchi(51)

puts

puts
pp Trie.hash
paths = []
Trie.hash.each_trie_path { |path, value| paths.push([ path ]) }
#Trie.hash.each_trie_path { |path, value| paths.push([ path, value ]) }
#pp paths
puts
paths.each { |x| p x }
puts
