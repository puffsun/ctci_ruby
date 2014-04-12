
require "pry"
require "pry-debugger"

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

  def self.permutation(str)
    return nil unless str
    return str if str.length == 1
    return permute_with_prefix("", str)
  end

  def self.permute_with_prefix(prefix, str)
    result = []
    len = str.length
    if len == 0
      return result << prefix
    else
      0.upto(len - 1) do |i|
        left = str.slice(0...i)
        right = str.slice((i+1)...len)
        result <<  permute_with_prefix(prefix + str[i], left + right)
      end
    end
    result.flatten
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

  # basic string compression using the counts of repeated characters.
  # For example, the string aabcccccaaa would become a2blc5a3.
  # If the "compressed" string would not become smaller than
  # the original string, your method should return the original string.
  def self.compress(str)
    return nil if str.nil?
    str_arr = str.split("")
    return str if count_compression(str_arr) >= str.length
    prev = str_arr[0]
    count = 0
    res = str_arr.inject("") do |r, e|
      if e.eql?(prev)
        count += 1
      else
        r += "#{prev}#{count}"
        count = 1
      end
      prev = e
      r
    end
    res += "#{prev}#{count}"
  end

  private

  def self.count_compression(arr)
    return 0 if arr.length == 0
    prev = arr[0]
    # + 2 in the end or the last one of more elements will be missed
    arr.inject(0) do |r, e|
      r += 2 unless e.eql?(prev)
      prev = e
      r
    end + 2
  end

  public

  # Assume you have a method substring? which checks if one word
  # is a substring of another. Given two strings, s1 and s2, write code
  # to check if s2 is a rotation of s1 using only one call to substring?
  # (e.g.,"waterbottle"is a rotation of"erbottlewat")
  #
  # PS. in Ruby, there's an instance method call include? in string
  # we can use it as alternative of substring?
  def self.rotation?(str1, str2)
    return false if str1.nil? or str2.nil?
    return false unless str1.length == str2.length
    return true if (str1 + str1).include?(str2)
    false
  end
end
