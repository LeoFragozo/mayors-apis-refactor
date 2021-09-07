states = [ "Rio Grande do Norte", "Rio Grande do Sul", "Santa Catarina", "Tocantins"]

def find_rio_grande(states)
  states.select { |state| state.include? "Rio Grande" }
end

p find_rio_grande(states)