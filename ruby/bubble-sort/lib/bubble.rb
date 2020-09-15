# frozen_string_literal: true

array = [5, 4, 3, 2, 1]
iterations = 0

indices = (array.length - 1).downto(1)
indices.each do |i|
  0.upto i - 1 do |ii|
    iterations += 1
    array[ii, ii + 2] = array[ii, ii + 2].reverse if array[ii] > array[ii + 1]
  end
end
print array
print("\n")
print(iterations)
print("\n")
