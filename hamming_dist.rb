require 'rspec'

class HammingDistance
  class InvalidInputs < RuntimeError; end
  def initialize(arg1, arg2)
    raise InvalidInputs unless [arg1, arg2].all? { |arg| arg.is_a?(String)}

    @string1 = arg1
    @string2 = arg2
  end

  def calculate
    count = 0

    (0...max_length).each do |i|
      count += 1 unless equivalent_at?(i)
    end

    count
  end

  private

  def equivalent_at?(i)
    equivalent?(@string1[i], @string2[i])
  end

  def equivalent?(char1, char2)
    return false if char1.nil? || char2.nil?
    char1.downcase == char2.downcase
  end

  def max_length
    [@string1.length, @string2.length].max
  end
end



RSpec.describe HammingDistance do
  it "solves the given example correctly" do
    expect(HammingDistance.new("GAGCCTACTAACGGGAT", "GAGCCTGCTAACAGGATT").calculate).to eq(3)
  end

  it "should work when both strings are empty" do
    expect(HammingDistance.new("", "").calculate).to eq(0)
  end

  it "should work when the characters are not just alpha" do
    expect(HammingDistance.new("12341234", "1234").calculate).to eq(4)
  end

  it "should raise an error when there is an invalid input" do
    expect { HammingDistance.new(12, 34) }.to raise_exception(HammingDistance::InvalidInputs)
  end
end
