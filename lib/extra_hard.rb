
module Ch18

  # write a function that adds two numbers.
  # you should not use + or any arithmetic operators
  def self.add(num1, num2)
    # end of resursion
    return num1 if num2 == 0
    xor = num1 ^ num2
    carry = (num1 & num2) << 1
    add(xor, carry)
  end

  # Write a method to shuffle a deck of cards.
  # It must be a perfect shuffle—in other words,
  # each of the 52! permutations of the deck has
  # to be equally likely. Assume that you are given
  # a random number generator which is perfect.
  def self.shuffle(cards)
    raise ArgumentError unless cards
    rand = Random.new
    cards.each_index do |i|
      k = rand.rand(cards.length)
      cards[i], cards[k] = cards[k], cards[i]
    end
  end
end
