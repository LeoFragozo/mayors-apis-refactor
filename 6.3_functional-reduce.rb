states = ["Kansas", "Nebraska", "North Dakota", "South Dakota"]

#Returns a URL-friendly version of a string.
# Example: "North Dakota" -> "north-dakota"
def urlify(string)
  string.downcase.split.join("-")
end

#urls: Imperative version
def imperative_urls(states)
  urls = []
  states.each do |state|
    urls << urlify(state)
  end
  urls
end
p imperative_urls(states)

#urls: Functional version
def functional_urls(states)
  states.collect { |state| urlify(state) }
end
puts functional_urls(states).inspect

# def example_urls(states)
#   states.collect { |state| "https://example.com/#{urlify(state)}"}
# end
# p example_urls(states)

# singles: Imperative version
def imperative_singles(states)
  singles = []
  states.each do |state|
    if state.split.length == 1
      singles << state
    end
  end
  singles
end
puts imperative_singles(states).inspect

# singles: Functional version
def functional_singles(states)
  states.select { |state| state.split.length == 1 }
end

p functional_singles(states)

def dakota_finder_1(states)
  states.select { |state| state.include?("Dakota") }
end
p dakota_finder_1(states)

def dakota_finder_2(states)
  states.select { |state| state.split.length == 2 }
end
p dakota_finder_2(states)

numbers = 1..10

# sum: Imperative solution
def imperative_sum(numbers)
  total = 0
  numbers.each do |n|
    total += n
  end
  total
end
puts imperative_sum(numbers)

#sum: Functional solution
def functional_sum(numbers)
  numbers.inject { |total, n| total += n }
end
puts functional_sum(numbers)


# lengths: Imperative function
def imperative_lengths(states)
  lengths = {}
  states.each do |state|
    lengths[state] = state.length
  end
  lengths
end
puts imperative_lengths(states)

# lengths: Functional version
def functional_lengths(states)
  states.inject({}) { |lengths, state| lengths[state] = state.length; lengths } 
end
puts functional_lengths(states)

number_array = [1, 2, 3, 4, 5]

# product: functional solution
def array_product(number_array)
  number_array.inject(1) { |total, n| total *= n }
end
p array_product(number_array)