
module Ch1
  # determine if a string has all unique characters
  # without using additional data structures?
  #
  # You should check with the interviewer if all of characters
  # are ASCII characters or Unicode, it important, here
  # we assume we're dealing with ASCII characters
  def self.unique?(str)
    return true if str.nil?
    # we only have 256 ASCII characters
    return false if str.length > 256
    b_arr = {}
    str.each_char do |c|
      return false if b_arr[c]
      b_arr[c] = true
    end
    true
  end

  # One solution is to sort both of them, then check if they are equal
  # another solution is to count each characters
  # below code implement the last one
  def self.permutation?(str1, str2)
    return true if str1.nil? and str2.nil?
    return false if str1.nil? or str2.nil?
    return false unless str1.length == str2.length
    counter = Hash.new(0)
    str1.each_char {|c| counter[c] += 1}
    str2.each_char do |c|
      counter[c] -= 1
      return false if counter[c] < 0
    end
    true
  end

  # Write a method to replace all spaces in a string with'%20'.
  def self.convert(str)
    return nil if str.nil?
    new_str = str.strip
    new_str.length.times do |i|
      new_str[i] = "%20" if new_str[i].eql?(' ')
    end
    new_str
  end
end
