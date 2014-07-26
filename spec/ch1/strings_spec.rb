
require_relative '../spec_helper'

describe "String related algorithms" do
  describe "determine if string has unique characters" do

    it "should return true if nil passed in" do
      Ch1::unique?(nil).should == true
    end

    it "should return true if all characters are unique" do
      str = "abc"
      Ch1::unique?(str).should == true
    end

    it "should return false if not unique" do
      str = "abca"
      Ch1::unique?(str).should == false
    end
  end

  describe "determine if one string is permutation of another" do

    it "should return true if both of them are nil" do
      Ch1::permutation?(nil, nil).should == true
    end

    it "should return false if only one of them is nil" do
      Ch1::permutation?(nil, "").should == false
    end

    it "should return true if one is permutation of the other" do
      Ch1::permutation?("abc", "cba").should == true
    end

    it "should return false otherwise" do
      Ch1::permutation?("abc", "abb").should == false
    end
  end

  describe "get all permutation of a string" do
    it "should return nil if passed in nil" do
      Ch1::permutation(nil).should be_nil
    end

    it "should get the same str if single character passed in" do
      Ch1::permutation('a').should eql('a')
    end

    it "should get all of permutation" do
      Ch1::permutation('ab').should include("ab")
      Ch1::permutation('ab').should include("ba")
    end
  end

  describe "convert all spaces into %20" do

    it "should return nil with nil argument" do
      Ch1::convert(nil).should be_nil
    end

    it "should convert correctly" do
      Ch1::convert("Mr John Smith   ").should eql("Mr%20John%20Smith")
    end
  end

  describe "basic string compression" do

    it "should return nil if nil passed in" do
      Ch1::compress(nil).should be_nil
    end

    it "should return original string if compressed one is not smaller than original" do
      Ch1::compress("a").should eql("a")
      Ch1::compress("ab").should eql("ab")
    end

    it "should return compressed string if it is smaller than original one" do
      Ch1::compress("aabcccccaaa").should eql("a2b1c5a3")
    end
  end

  describe "check if str2 is rotation of str1" do

    it "should return false if nil passed in as arguments" do
      Ch1::rotation?(nil, nil).should == false
      Ch1::rotation?(nil, "").should == false
      Ch1::rotation?("", nil).should == false
    end

    it "should return false if not" do
      str1 = "abc"
      str2 = "cde"
      Ch1::rotation?(str1, str2).should == false
    end

    it "should return true if yes" do
      str1 = "erbottlewat"
      str2 = "waterbottle"
      Ch1::rotation?(str1, str2).should == true
    end
  end
end
