# alternatovely extend String
class String

    # Returns true for a palindrome, false otherwise.
    
        def palindrome?
          processed_content == processed_content.reverse
        end
    
    # returns  returns true if the string is empty or consists solely of whitespace
    
        def blank?
              self.match(/^\s$/) ? true : false
        end 
    
      private
    # Returns content for palindrome testing.
    
           def processed_content
              downcase
           end
    
    end