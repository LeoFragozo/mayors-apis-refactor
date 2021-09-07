# Defines a Phrase class.
class Phrase < String

    # Returns true for a palindrome, false otherwise.
    def palindrome?
      processed_content = downcase
      processed_content == processed_content.reverse
    end
  
  end