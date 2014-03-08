
require_relative '../spec_helper'

describe "String related algorithms" do
  describe "determine if string has unique characters" do

    it "should return true if nil passed in" do
      Ch1::unique?(nil).should be_true
    end

    it "should return true if all characters are unique" do
      str = "abc"
      Ch1::unique?(str).should be_true
    end

    it "should return false if not unique" do
      str = "abca"
      Ch1::unique?(str).should be_false
    end
  end

  describe "determine if one string is permutation of another" do

    it "should return true if both of them are nil" do
      Ch1::permutation?(nil, nil).should be_true
    end

    it "should return false if only one of them is nil" do
      Ch1::permutation?(nil, "").should be_false
    end

    it "should return true if one is permutation of the other" do
      Ch1::permutation?("abc", "cba").should be_true
    end

    it "should return false otherwise" do
      Ch1::permutation?("abc", "abb").should be_false
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
end
