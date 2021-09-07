uf = ["Bahia", "Parana", "Rio Grande do Sul", "Sao Paulo"]

def urlify(string)
  string.downcase.split.join('-')
end

def functional_urls(uf)
  uf.map { |uf| "https://example.com/#{urlify(uf)}"}
end

puts functional_urls(uf).inspect