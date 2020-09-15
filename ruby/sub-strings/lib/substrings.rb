# frozen_string_literal: true

dictionary = %w[
  below down go going horn how howdy it i low own part partner sit
] # all the words

def substrings(word, dictionary)
  lowercase_word = word.downcase
  puts lowercase_word
  counts = {}
  dictionary.sort.each do |key|
    found = lowercase_word.scan(key).length
    counts[key] = lowercase_word.scan(key).length if found.positive
  end
  puts counts
end
substrings("Howdy partner, sit down! How's it going?", dictionary)
