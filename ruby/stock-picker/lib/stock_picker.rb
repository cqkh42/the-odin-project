# frozen_string_literal: true

prices = [17, 3, 6, 9, 15, 8, 6, 1, 10]

def stock_picker(prices)
  max_returns = prices.map.with_index do |item, index|
    prices[index..].max - item
  end
  buy = max_returns.each_with_index.max[1]
  sell = prices[buy..].each_with_index.max[1] + buy
  [buy, sell]
end
puts stock_picker(prices)
