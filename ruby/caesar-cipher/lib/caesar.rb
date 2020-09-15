# frozen_string_literal: true

def caesar_cipher(string, jumps)
  ords = string.chars.map(&:ord)
  ords.map! do |o|
    case o
    when 97..122 then ((o + jumps + 26 - 97) % 26 + 97)
    when 65..90 then ((o + jumps + 26 - 65) % 26 + 65)
    else o
    end
  end
  ords.map(&:chr).join('')
end

puts 'enter a string'
to_do = gets.chomp
puts 'step size?'
step = gets.chomp.to_i
puts caesar_cipher(to_do, step)
